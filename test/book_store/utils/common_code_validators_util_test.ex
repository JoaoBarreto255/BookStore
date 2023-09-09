
defmodule Test.BookStore.Utils.CommonCodeValidatorsUtilTest do
  use ExUnit.Case
  alias BookStore.Utils.CommonCodeValidatorsUtil

  test "sucess in validate isbn" do
    assert CommonCodeValidatorsUtil.validate_isbn("978-0-306-40615-7") == {:success, "9780306406157"}
    assert CommonCodeValidatorsUtil.validate_isbn("978-0+306T40615a7") == {:success, "9780306406157"}
    assert CommonCodeValidatorsUtil.validate_isbn("9780306406157") == {:success, "9780306406157"}
  end

  test "fail when ISBN input is no 13 digits enough" do
    assert CommonCodeValidatorsUtil.validate_isbn("") == {:fail, "ISBN must have only 13 digits [0-9], got 0"}
    assert CommonCodeValidatorsUtil.validate_isbn("97803") == {:fail, "ISBN must have only 13 digits [0-9], got 5"}
    assert CommonCodeValidatorsUtil.validate_isbn("978030640615747") == {:fail, "ISBN must have only 13 digits [0-9], got 15"}
    assert CommonCodeValidatorsUtil.validate_isbn("978-030-6406-157-47") == {:fail, "ISBN must have only 13 digits [0-9], got 15"}
  end

  test "fail to validate input when ISBN is invalid" do
    assert CommonCodeValidatorsUtil.validate_isbn("978-0-306-40615-4") == {:success, "9780306406157"}
  end
end
