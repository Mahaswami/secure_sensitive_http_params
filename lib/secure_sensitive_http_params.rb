class SecureSensitiveHttpParams
    KEY = "LATEST1234FIRST5678SOFT0"
    CIPHER_HEADER = "{DES}"
    @@pattern_list = []
    
    def self.pattern_list
        @@pattern_list
    end
    
    def self.add_pattern(pattern)
        @@pattern_list << pattern
    end
end

