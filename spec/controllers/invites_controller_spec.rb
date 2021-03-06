require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe InvitesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Invite. As you add validations to Invite, be sure to
  # adjust the attributes here as well.
  let(:new_member_params){
    {email: "validEmailNewMember@mail.com", email_confirmation: "validEmailNewMember@mail.com", name: "New Member",
      password: "password", password_confirmation: "password"}
  }

  let(:new_member){
    create :user, new_member_params
  }

  let(:owner){
    create :user
  }

  let(:book){
    create :book, user: owner
  }

  let(:valid_attributes) {
    {email: new_member.email, recipient: new_member, book_id: book.id, book: book, sender_id: book.user.id, sender: book.user}
  }

  let(:invalid_attributes) {
    {email: "invalidEmail@email.com", book_id: book.id, book: book, sender_id: book.user.id, sender: book.user}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InvitesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all invites as @invites" do
      @token = AuthenticateUser.call(new_member.email, new_member.password)
      request.headers["Authorization"] = @token.result

      invite = Invite.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:invites)).to eq([invite])
    end
  end

  describe "GET #show" do
    it "assigns the requested invite as @invite" do
      @token = AuthenticateUser.call(new_member.email, new_member.password)
      request.headers["Authorization"] = @token.result

      invite = Invite.create! valid_attributes
      get :show, params: {id: invite.to_param}, session: valid_session
      expect(assigns(:invite)).to eq(invite)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Invite" do
        @token = AuthenticateUser.call(new_member.email, new_member.password)
        request.headers["Authorization"] = @token.result

        expect {
          post :create, params: {invite: valid_attributes}, session: valid_session
        }.to change(Invite, :count).by(1)
      end

      it "assigns a newly created invite as @invite" do
        @token = AuthenticateUser.call(new_member.email, new_member.password)
        request.headers["Authorization"] = @token.result

        post :create, params: {invite: valid_attributes}, session: valid_session
        expect(assigns(:invite)).to be_a(Invite)
        expect(assigns(:invite)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved invite as @invite" do
        @token = AuthenticateUser.call(new_member.email, new_member.password)
        request.headers["Authorization"] = @token.result

        post :create, params: {invite: invalid_attributes}, session: valid_session
        expect(assigns(:invite)).to be_a_new(Invite)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested invite" do
      @token = AuthenticateUser.call(new_member.email, new_member.password)
      request.headers["Authorization"] = @token.result

      invite = Invite.create! valid_attributes
      expect {
        delete :destroy, params: {id: invite.to_param}, session: valid_session
      }.to change(Invite, :count).by(-1)
    end
  end

end
