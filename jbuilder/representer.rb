require "./jbuilder/jbuilder_ext"

module JbuilderRepresenter

  def self.new(&block)
    Class.new(Representer).tap do |klass|
      klass.class_eval(&block)
      klass.class_eval do
        define_method(:representation) do
          klass.representation
        end
      end
    end
  end

  class Representer < ::ActiveSupport::ProxyObject
    def self.representation(&block)
      @representation = block if block
      @representation
    end

    def initialize(object, options={})
      @object = object
      @options = options
    end

    def method_missing(method, *args, &block)
      @object.__send__(method, *args, &block)
    end

    def to_hash
      to_builder.attributes!
    end

    def to_json
      to_builder.target!
    end

    def to_builder
      ::JbuilderExt.new do |json|
        instance_exec json, @options, &representation
      end
    end

  end
end
