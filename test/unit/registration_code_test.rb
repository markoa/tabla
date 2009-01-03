require File.dirname(__FILE__) + '/../test_helper'

class RegistrationCodeTest < ActiveSupport::TestCase

  def test_used_flag
    regcode = RegistrationCode.new
    assert !regcode.used?

    regcode = RegistrationCode.generate(users(:djura))
    assert !regcode.used?

    regcode.assign_to(users(:lee))
    assert regcode.used?
    assert_equal regcode.user, users(:lee)
  end

end
