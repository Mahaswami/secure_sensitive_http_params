module CryptUtil
    
    def encrypt(value)
        if value.nil? || value.to_s.empty?
            value
        else
            SecureSensitiveHttpParams::CIPHER_HEADER + value.encrypt(:symmetric, :key => SecureSensitiveHttpParams::KEY).chomp
        end
    end 
   
    def decrypt(value)
        if encrypted?(value)
            value = value.gsub(SecureSensitiveHttpParams::CIPHER_HEADER, '')
            String.new(value.decrypt(:symmetric, :key => SecureSensitiveHttpParams::KEY))
        else
            value
        end
    end
    
    def encrypted?(value)
        value.nil? == false && value.kind_of?(String) && 
			value.starts_with?(SecureSensitiveHttpParams::CIPHER_HEADER)
    end
    
    def matches_pattern?(str)
        SecureSensitiveHttpParams.pattern_list.any? {|x|
            str =~ x
        }
    end
end
