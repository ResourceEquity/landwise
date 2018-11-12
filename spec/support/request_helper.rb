module RequestHelper

  include Warden::Test::Helpers

  def self.included(base)
    base.before(:each) { Warden.test_mode! }
    base.after(:each) { Warden.test_reset! }
  end

  def sign_in(resource)
    login_as(resource, scope: warden_scope(resource))
  end

  def sign_out(resource)
    logout(warden_scope(resource))
  end

  def get_json(*args)
    get *args
    JSON.parse(response.body)
  end

  def post_json(*args)
    post *args
    JSON.parse(response.body)
  end

  def patch_json(*args)
    patch *args
    JSON.parse(response.body)
  end

  def delete_json(*args)
    delete *args
    JSON.parse(response.body)
  end

  private

    def warden_scope(resource)
      resource.class.name.underscore.to_sym
    end

end
