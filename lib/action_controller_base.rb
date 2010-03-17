class ActionController::Base
    include CryptUtil
    ENCRYPT = 'encrypt'
    DECRYPT = 'decrypt'

    before_filter :decrypt_params
    
    alias_method :url_before_encryption, :url_for
    def url_for(options = {}, *parameters_for_method_reference)
        return url_before_encryption(options, *parameters_for_method_reference) unless options.kind_of?(Hash)
        new_options = process_hash(options, ENCRYPT)
        url_before_encryption(new_options, *parameters_for_method_reference)
    end
    
    def decrypt_params
        new_params = process_hash(params, DECRYPT)
        instance_variable_set("@_params", new_params)
    end
    
    def process_hash(hash, encrypt_or_decrypt)
        processed_hash = HashWithIndifferentAccess.new
        hash.each_pair {|k, v|
            if v.kind_of?(Hash)
                processed_hash[k] = process_hash(v, encrypt_or_decrypt)
            elsif matches_pattern?(k.to_s)
                processed_hash[k] = encrypt_or_decrypt == ENCRYPT ? encrypt(v.to_s)  : decrypt(v) 
            else
                processed_hash[k] = v
            end
        }
        processed_hash
    end
end