        require 'edgecase'

class AboutMessagePassing < EdgeCase::Koan
  
  class MessageCatcher
    def caught?
      true
    end
  end
    
  def test_methods_can_be_called_directly
    mc = MessageCatcher.new
    
    assert mc.caught?    
  end
  
  def test_methods_can_be_invoked_by_sending_the_message
    mc = MessageCatcher.new
    
    assert mc.send(:caught?)
  end
  
  def test_methods_can_be_invoked_more_dynamically
    mc = MessageCatcher.new
    
    assert mc.send("caught?")
    assert mc.send("caught" + "?")    # What do you need to add to the first string?
    assert mc.send("CAUGHT?".downcase)      # What would you need to do to the string?
  end

  def test_send_with_underscores_will_also_send_messages
    mc = MessageCatcher.new

    assert_equal true, mc.__send__(:caught?)

    # THINK ABOUT IT:
    #
    # Why does Ruby provide both send and __send__ ?
  end

  def test_classes_can_be_asked_if_they_know_how_to_respond
    mc = MessageCatcher.new
    
    assert_equal true, mc.respond_to?(:caught?)
    assert_equal false, mc.respond_to?(:does_not_exist)
  end
  
  # ------------------------------------------------------------------

  class MessageCatcher
    def add_a_payload(*args)
      args
    end
  end
  
  def test_sending_a_message_with_arguments
    mc = MessageCatcher.new
    
    assert_equal [], mc.add_a_payload
    assert_equal [], mc.send(:add_a_payload)

    assert_equal [3, 4, nil, 6], mc.add_a_payload(3, 4, nil, 6)
    assert_equal [3, 4, nil, 6], mc.send(:add_a_payload, 3, 4, nil, 6)
  end

  # ------------------------------------------------------------------

  class TypicalObject
  end


  # ------------------------------------------------------------------

  class AllMessageCatcher
    def method_missing(method_name, *args, &block)
      "Someone called #{method_name} with <#{args.join(", ")}>"
    end
  end

  def test_all_messages_are_caught
    catcher = AllMessageCatcher.new

    assert_equal "Someone called foobar with <>", catcher.foobar
    assert_equal "Someone called foobaz with <1>", catcher.foobaz(1)
    assert_equal "Someone called sum with <1, 2, 3, 4, 5, 6>", catcher.sum(1,2,3,4,5,6)
  end

  def test_catching_messages_makes_respond_to_lie
    catcher = AllMessageCatcher.new

    assert_nothing_raised(NoMethodError) do
      catcher.any_method
    end
    assert_equal false, catcher.respond_to?(:any_method)
  end

  # ------------------------------------------------------------------

  class WellBehavedFooCatcher
    def method_missing(method_name, *args, &block)
      if method_name.to_s[0,3] == "foo"
        "Foo to you too"
      else
        super(method_name, *args, &block)
      end
    end
  end

  def test_foo_method_are_caught
    catcher = WellBehavedFooCatcher.new

    assert_equal "Foo to you too", catcher.foo_bar
    assert_equal "Foo to you too", catcher.foo_baz
  end

  def test_non_foo_messages_are_treated_normally
    catcher = WellBehavedFooCatcher.new

    assert_raise(NoMethodError) do
      catcher.normal_undefined_method
    end
  end

  # ------------------------------------------------------------------

  # (note: just reopening class from above)
  class WellBehavedFooCatcher
    def respond_to?(method_name)
      if method_name.to_s[0,3] == "foo"
        true
      else
        super(method_name)
      end
    end
  end

  def test_explicitly_implementing_respond_to_lets_objects_tell_the_truth
    catcher = WellBehavedFooCatcher.new

    assert_equal true, catcher.respond_to?(:foo_bar)
    assert_equal false, catcher.respond_to?(:something_else)
  end

end

    