require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase

  def test_should_not_save_empty_user
    user = User.new
    assert !user.save, "Saved a blank user"
  end

  def test_should_create_user
    assert_difference 'User.count' do
      user = User.new(:email => "alan@ford.com", :nickname => "alan")
      assert user.save
      assert !user.new_record?
      assert_not_nil user.salt
    end
  end

  def test_nickname_uniqueness
    user = User.new(:email => "alan@ford.com", :nickname => "alan")
    assert user.save
    another_user = User.new(:email => "boss@ford.com", :nickname => "alan")
    assert !another_user.save
  end

  def test_email_uniqueness
    user = User.new(:email => "alan@ford.com", :nickname => "alan")
    assert user.save
    another_user = User.new(:email => "alan@ford.com", :nickname => "alan2")
    assert !another_user.save
  end

end
