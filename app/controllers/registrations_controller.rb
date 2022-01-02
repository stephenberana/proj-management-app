class RegistrationsController < Devise::RegistrationsController
    
skip_before_action :authenticate_organization!, :only => [:new, :create, :cancel]

def create

    organization_params = sign_up_params_organization
    user_params = sign_up_params_user

    sign_out_session!

    prep_signup_view(organization_params, user_params)

    organization.transaction do
        @organization = organization.create_new_organization(organization_params, user_params)
        if @organization.errors.empty? #organization created
            
            if @organization.plan == 'premium'
                @payment = Payment.new({email: user_params["email"],
                    token: params[:payment]["token"],
                    organization: @organization})
                flash[:error] = "Please review your payment information." unless @payment.valid?   
            
                begin
                    @payment.process_payment
                    @payment.save
                rescue Exception => e
                    flash[:error] = e.message
                    @organization.destroy
                    log_action("Payment failed")
                    render :new and return
                end
            end
        else
            resource.valid?
            log_action("organization creation failed.", @organization)
            render :new
        end

        if flash[:error].blank? || flash[:error].empty? #payment successful

            initiate_organization (@organization)

            devise_create(user_params) #devise resource (user) creation

            if resource.errors.empty? #SUCCESS!

                log_action ("signup user/organization success," resource)

                organization.organization_signup(resource, @organization, coupon_params)

            else
                log_action("Signup user failed.", resource)
                raise ActiveRecord::Rollback
            end
        else
            resource.valid?
            log_action("Payment processing failed.", @organization)
            render :new and return
        end
    end    

end