class Identity < ApplicationRecord
    belongs_to :user
    validates_presence_of :uid, :provider
    validates_uniqueness_of :uid, :scope => :provider

    def self.find_for_oauth(auth)
        identity = find_or_create_by(
            uid: auth.uid,
            provider: auth.provider
        )

        # out of the guides

        identity.update(
            name: "#{auth.info.name}",
            nickname: "#{auth.provider == 'kakao' ? auth.info.name.gsub(' ','_') : auth.info.email.split('@').first}",
            email: "#{auth.info.email unless auth.provider == 'kakao'}",
            profile_img: "#{auth.info.image}"
        )

        identity
    end
end


# omniauth hash structure

# Google ~> https://github.com/zquestz/omniauth-google-oauth2
# Kakao ~> https://github.com/shaynekang/omniauth-kakao