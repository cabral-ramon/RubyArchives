class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|

      #method names are basically strings?
      define_method("#{name}=") do |value|
        #cannot pass in @ + symbol => newname == string
        newname = '@' + name.to_s
        self.instance_variable_set(newname, value)
      end

      define_method("#{name}") do
        self.instance_variable_get('@' + name.to_s)
      end
    end

  end


end
