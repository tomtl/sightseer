require "spec_helper"

describe ForgotPasswordsController do
  describe "POST create" do
    context "with existing email" do
      let(:user1) { Fabricate(:user) }
      before { post :create, email: user1.email }
      after { ActionMailer::Base.deliveries.clear }

      it "generates a random token" do
        expect(User.first.token).to be_present
      end

      it "sends an email to the email address" do
        expect(ActionMailer::Base.deliveries.last.to).to eq([user1.email])
      end

      it "redirects to the forgot password confirmation page" do
        expect(response).to redirect_to(forgot_password_confirmation_path)
      end
    end

    context "with non-existing email" do
      before { post :create, email: "abc@email.com" }

      it "redirects to the forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        expect(flash[:danger]).to be_present
      end
    end
  end
end
