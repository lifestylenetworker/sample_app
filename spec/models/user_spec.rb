require 'spec_helper'

describe User do

  before { @user = User.new(name: "Example User", email: "user@example.com",
  													password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "Password should not be blank" do
  	before { @user.password = @user.password_confirmation = ""}
  	it { should_not be_valid }
  end

  describe "Password should match" do
  	before { @user.password_confirmation = "" }
  	it { should_not be_valid }
  end

  describe "When password confirmation is nil" do
  	before { @user.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "with a password that's too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }
  	it { should be_invalid }
	end

  describe "Blank user should fail" do
  	before { @user.name = "" }
  	it { should_not be_valid }
  end

  describe "blank email should fail" do
  	before { @user.email = "" }
  	it { should_not be_valid}
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51}
  	it { should_not be_valid}
  end

  describe "when email address is invalid" do
  	it "should be invalid" do
  		addresses = %w[foo@bar,com user_at_foo.org example.user.net foo@bar+baz]
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			@user.should_not be_valid
  		end
  	end
  end

  describe "when email is valid" do 
  	it "should be valid" do
  		valid_emails = %w[n_m-A@nick.com	n+m@me.com f.l@name.co yes@f.g.com]
  		valid_emails.each do |valid_email|
  			@user.email = valid_email
  			@user.should be_valid
  		end
  	end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

end