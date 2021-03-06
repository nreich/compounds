require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }
    before :each do
        @attr = {
            email: "user@example.com",
            name: "Johnn Doe",
            password: "password",
            password_confirmation: "password"
        }
    end

    describe 'roles' do
      context 'when a new user is created' do
        it 'should have the "user" role by default' do
          expect(user.has_role? :user).to be_true
        end
      end
      context 'after user creation' do
        it 'should be possible to add a new role' do
          user.add_role :admin
          expect(user.has_role? :admin).to be_true
        end
      end
    end

    it "should create a new instance given valid attributes" do
        User.create!(@attr)
    end

    it "should require an email address" do
        no_email_user = User.new(@attr.merge(email: ""))
        no_email_user.should_not be_valid
    end

    it "should require a name" do
      no_name_user = User.new(@attr.merge(name: ""))
      no_name_user.should_not be_valid
    end

    it "should not allow long names" do
      long = "a" * 51
      long_name_user = User.new(@attr.merge(name: long))
      long_name_user.should_not be_valid
    end

    it "should except a valid email addresses" do
        addresses = %w[user@example.com the_user@example.site.com the.user@example.com user@example.jp]
        addresses.each do |address|
            valid_email_user = User.new(@attr.merge(email: address))
            valid_email_user.should be_valid
        end
    end

    it "should reject invalid email addresses" do
        addresses = %w[user@example,com user_at_example.com user@example.]
        addresses.each do |address|
            invalid_email_user = User.new(@attr.merge(email: address))
            invalid_email_user.should_not be_valid
        end
    end

    it "should reject duplicate email addresses" do
        User.create!(@attr)
        user_with_duplicate_email = User.new(@attr)
        user_with_duplicate_email.should_not be_valid
    end

    it "should reject email addresses identical up to case" do
        upcase_email = @attr[:email].upcase
        User.create!(@attr.merge(email: upcase_email))
        user_with_duplicate_email = User.new(@attr)
        user_with_duplicate_email.should_not be_valid
    end

    describe "passwords" do

        before :each do
            @user = User.new(@attr)
        end

        it "should have a password attribute" do
            @user.should respond_to :password
        end

        it "should have a password confirmation" do
            @user.should respond_to :password_confirmation
        end

        it "should require a matching password confirmation" do
            User.new(@attr.merge(password_confirmation: "invalid")).should_not be_valid
        end

        it "should reject short passwords" do
            short = "a" * 5
            hash = @attr.merge(password: short, password_confirmation: short)
            User.new(hash).should_not be_valid
        end

    end

    describe "password encryption" do

        before :each do
            @user = User.create!(@attr)
        end

        it "should have an encrypted password attribute" do
            @user.should respond_to :encrypted_password
        end

        it "should set the encrypted password attribute" do
            @user.encrypted_password.should_not be_blank
        end
    end

    describe "assosciations" do

      describe "with transactions" do

        before :each do
          @user = User.create(@attr)
          @batch = FactoryGirl.create(:batch)
        end

        it "should have a relationship with transactions" do
          @user.should respond_to :transactions
        end

        it "should have the right transactions" do
          @transaction = FactoryGirl.create(:transaction,
                                              user_id: @user.id,
                                              batch_id: @batch.id)
          @user.transactions.first.should == @transaction
        end
      
      end

    end

end
