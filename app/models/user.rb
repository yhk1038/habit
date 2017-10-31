class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :kakao]

    has_many :identities, dependent: :destroy
    has_many :projects, -> { order(created_at: :desc).includes(:ddays) }

    def delete_clearly
        self.identities.destroy_all
        self.projects.destroy_all
        self.destroy!
    end

    # Omniauth Settings
    # following => https://hcn1519.github.io/articles/2016-12/omniauth_devise_configuration

    def self.find_for_oauth(auth, signed_in_resource = nil)

        # user와 identity가 nil이 아니라면 받는다

        identity = Identity.find_for_oauth(auth)
        user = signed_in_resource ? signed_in_resource : identity.user

        # user가 nil이라면 새로 만든다.

        if user.nil?

            # Identity에 이미 있는 계정인지 확인한다.

            user = User.find_user_through_identity_with auth

            unless user
                # 없다면 새로운 데이터를 생성한다.

                if user.nil?
                    # 카카오는 email을 제공하지 않음

                    email = auth.info.email ? auth.info.email : nil
                    if email.nil? # auth.provider == "kakao"
                        # provider(회사)별로 데이터를 제공해주는 hash의 이름이 다릅니다.

                        # 각각의 omnaiuth별로 auth hash가 어떤 경로로, 어떤 이름으로 제공되는지 확인하고 설정해주세요.

                        user = User.new(
                            profile_img: auth.info.image,
                            # 이 부분은 AWS S3와 연동할 때 프로필 이미지를 저장하기 위해 필요한 부분입니다.

                            # remote_profile_img_url: auth.info.image.gsub('http://','https://'),

                            password: Devise.friendly_token[0,20]
                        )

                    else
                        user = User.new(
                            email: auth.info.email,
                            profile_img: auth.info.image,
                            # remote_profile_img_url: auth.info.image.gsub('http://','https://'),

                            password: Devise.friendly_token[0,20]
                        )
                    end
                    user.save!
                end
            end

            user.update(name: identity.name)                if user.name.nil?
            user.update(nickname: identity.nickname)        if user.nickname.nil?
            user.update(email: identity.email)              if user.email.nil? && identity.email
            user.update(profile_img: identity.profile_img)  if user.profile_img.nil?
        end

        sth_wrong = nil
        if identity.user.nil? || identity.user.id != user.id
            sth_wrong = identity.provider.split('_')[0].capitalize+' 계정은 이미 가입된 사용자가 존재합니다.' if identity.user

            if sth_wrong.nil?
                identity.user = user
                identity.save!
            end
        end
        [user, sth_wrong]

    end

    def self.find_user_through_identity_with auth
        user = User.where(email: auth.info.email).take
        user ||= Identity.where(uid: auth.uid, provider: auth.provider).take&.user
        user
    end

    # email이 없어도 가입이 되도록 설정

    def email_required?
        false
    end
end
