require "ostruct"
require "jbuilder"

class JbuilderExt < ::Jbuilder

  def set!(name, object = BLANK, *args)
    options = args.first

    if args.one? && _with_options?(options)
      _set_with_builder name, object, options.dup
    else
      super
    end
  end

  def method_missing(*args)
    if ::Kernel.block_given?
      set! *args, &::Proc.new
    else
      set! *args
    end
  end

  private

  def _with_options?(options)
    ::Hash === options && options.key?(:with)
  end

  def _set_with_builder(name, object, options)
    klass = options.delete(:with)
    value = if _is_collection?(object)
      collection = object.map do |elem|
        klass.new(elem, options).to_hash
      end
      _scope{ array! collection }
    else
      klass.new(object, options).to_hash
    end

    _set_value name, value
  end

end
