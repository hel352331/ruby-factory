# * Here you must define your `Factory` class.
# * Each instance of Factory could be stored into variable. The name of this variable is the name of created Class
# * Arguments of creatable Factory instance are fields/attributes of created class
# * The ability to add some methods to this class must be provided while creating a Factory
# * We must have an ability to get/set the value of attribute like [0], ['attribute_name'], [:attribute_name]
#
# * Instance of creatable Factory class should correctly respond to main methods of Struct
# - each
# - each_pair
# - dig
# - size/length
# - members
# - select
# - to_a
# - values_at
# - ==, eql?


class Factory
  class << self
    def new(*args, &block)
      if args.first.is_a? String
        const_set(args.shift.capitalize, new_class(*args, &block))
      end
      new_class(*args, &block)
    end
     def new_class(*args, &block)
      Class.new do
        attr_accessor(*args)
        define_method :initialize do |*args_value|
          raise ArgumentError unless args.length == args_value.length

          args.zip(args_value).each do |instance_key, instance_value|
            instance_variable_set("@#{instance_key}", instance_value)
          end
        end
        class_eval(&block) if block_given?
      end
    end
  end
end
