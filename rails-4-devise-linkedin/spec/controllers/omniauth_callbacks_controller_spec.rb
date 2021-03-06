require 'rails_helper'

# confira o do Akita: https://github.com/cidadedemocratica/cidadedemocratica/blob/master/spec/controllers/omniauth_callbacks_controller_spec.rb

RSpec.describe Users::OmniauthCallbacksController, :type => :controller do

  describe "facebook: login" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
                                                                        :provider => 'facebook',
                                                                        :uid => '123545',
                                                                        :info => { :email => 'igordeoliveirasa@gmail.com',  :name => 'Igor de Oliveira Sá', :image => "image"},
                                                                    })

      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      get :facebook
    end

    it {
      user = User.first
      expect(user.name).to eq("Igor de Oliveira Sá")
      expect(user.image).not_to be_nil
    }

    it { should be_user_signed_in }
    it { expect(response).to redirect_to(dashboard_index_path) }
  end

  describe "facebook: do not login unregistered authorization" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
                                                                        :provider => 'facebook',
                                                                        :uid => '123545',
                                                                        :info => { :name => '', },
                                                                    })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      get :facebook
    end

    it { should_not be_user_signed_in }
    it { expect(response).to redirect_to(new_user_registration_path) }

  end

  # ========================================================

  describe "google_oauth2: login" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                             :provider => 'google_oauth2',
                                                                             :uid => '123545',
                                                                             :info => { :email => 'igordeoliveirasa@gmail.com',  :name => 'Igor de Oliveira Sá', :image => "https://lh4.googleusercontent.com/-pyJtgUgrocI/AAAAAAAAAAI/AAAAAAAACDY/tcnl5uSQi4I/photo.jpg?sz=50" },
                                                                         })

      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      get :google_oauth2
    end

    it {
      user = User.first
      expect(user.name).to eq("Igor de Oliveira Sá")
      expect(user.image).not_to be_nil
    }

    it { should be_user_signed_in }
    it { expect(response).to redirect_to(dashboard_index_path) }
  end

  describe "google_oauth2: do not login unregistered authorization" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                             :provider => 'google_oauth2',
                                                                             :uid => '123545',
                                                                             :info => { :name => '', },
                                                                         })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
      get :google_oauth2
    end

    it { should_not be_user_signed_in }
    it { expect(response).to redirect_to(new_user_registration_path) }

  end


  # ========================================================

  describe "linkedin: login" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
                                                                             :provider => 'linkedin',
                                                                             :uid => '123545',
                                                                             :info => { :email => 'igordeoliveirasa@gmail.com', :first_name => 'Igor', :last_name => 'de Oliveira Sá', :image => "https://media.licdn.com/mpr/mprx/0_mLnj-OHag98vU9bKukqm-yW701tLRPBK2bCC-gZlhvQzXc8rGiQAyj2xAO-VZNny76NijVogTUnE" },
                                                                         })

      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:linkedin]
      get :linkedin
    end

    it {
      user = User.first
      expect(user.name).to eq("Igor de Oliveira Sá")
      expect(user.image).not_to be_nil
    }

    it { should be_user_signed_in }
    it { expect(response).to redirect_to(dashboard_index_path) }
  end

  describe "linkedin: do not login unregistered authorization" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
                                                                        :provider => 'linkedin',
                                                                        :uid => '123545',
                                                                        :info => { :first_name => '', :last_name => '' },
                                                                    })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:linkedin]
      get :linkedin
    end

    it { should_not be_user_signed_in }
    it { expect(response).to redirect_to(new_user_registration_path) }

  end

  # ========================================================

  describe "twitter: login" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                                       :provider => 'twitter',
                                                                       :uid => '123545',
                                                                       :info => { :name => 'Igor de Oliveira Sá', :image => "http://pbs.twimg.com/profile_images/481374675625574401/Xs8PuVmT_normal.jpeg" },
                                                                   })

      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      get :twitter
    end

    it {
      user = User.first
      expect(user.name).to eq("Igor de Oliveira Sá")
      expect(user.image).not_to be_nil
    }

    it { should be_user_signed_in }
    it { expect(response).to redirect_to(dashboard_index_path) }
  end


  describe "twitter: do not login unregistered authorization" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                                       :provider => 'twitter',
                                                                       :uid => nil,
                                                                       :info => { :name => '', },
                                                                       :extra => {:raw_info => {}}
                                                                   })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      get :twitter
    end

    it { should_not be_user_signed_in }
    it { expect(response).to redirect_to(new_user_registration_path) }

  end

  # ========================================================

  describe "github: login" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                                                             :provider => 'github',
                                                                             :uid => '123545',
                                                                             :info => { :email => 'igordeoliveirasa@gmail.com',  :name => 'Igor de Oliveira Sá', :image => "https://avatars.githubusercontent.com/u/2123428?v=3"},
                                                                         })

      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      get :github
    end


    it {
      user = User.first
      expect(user.name).to eq("Igor de Oliveira Sá")
      expect(user.image).not_to be_nil
    }

    it { should be_user_signed_in }
    it { expect(response).to redirect_to(dashboard_index_path) }
  end

  describe "github: do not login unregistered authorization" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                                                             :provider => 'google_oauth2',
                                                                             :uid => '123545',
                                                                             :info => { :name => '', },
                                                                         })
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      get :github
    end

    it { should_not be_user_signed_in }
    it { expect(response).to redirect_to(new_user_registration_path) }

  end

end
