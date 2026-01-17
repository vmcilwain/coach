module Coach
  module JsonParser
    REQUIRED_BODY_STATS_FIELDS = ['current_weight', 'body_fat_mass', 'body_fat_percentage', 
                                   'muscle_mass', 'muscle_percentage', 'summary', 'details', 'macro_goals']
    REQUIRED_MACRO_FIELDS = ['calories', 'carbs', 'fats', 'protein']
    
    REQUIRED_MEAL_ANALYSIS_FIELDS = ['total_calories', 'total_protein', 'total_carbs', 'total_fats',
                                      'calories_remaining', 'protein_remaining', 'carbs_remaining', 
                                      'fats_remaining', 'summary', 'details', 'progress_status']
    
    REQUIRED_MEAL_ITEM_FIELDS = ['item', 'calories', 'protein', 'carbs', 'fats']

    def self.parse(content, validation_type: :body_stats)
      return nil if content.nil? || content.strip.empty?
      
      cleaned = clean_content(content)
      
      begin
        parsed = JSON.parse(cleaned)
        
        case validation_type
        when :body_stats
          validate_body_stats(parsed)
        when :meal_analysis
          validate_meal_analysis(parsed)
        when :meal_item
          validate_meal_item(parsed)
        when :none
          parsed
        else
          puts "WARNING: Unknown validation type '#{validation_type}', skipping validation"
          parsed
        end
        
      rescue JSON::ParserError => e
        puts "Failed to parse JSON: #{e}"
        puts "Attempted to parse: #{cleaned[0..500]}..."
        puts "="*80
        nil
      end
    end

    private

    def self.validate_body_stats(parsed)
      missing_fields = REQUIRED_BODY_STATS_FIELDS - parsed.keys
      if missing_fields.any?
        puts "ERROR: Missing required body stats fields: #{missing_fields.join(', ')}"
        return nil
      end
      
      if parsed['macro_goals']
        missing_macro_fields = REQUIRED_MACRO_FIELDS - parsed['macro_goals'].keys
        if missing_macro_fields.any?
          puts "ERROR: Missing macro_goals fields: #{missing_macro_fields.join(', ')}"
          return nil
        end
      end
      
      parsed
    end
    
    def self.validate_meal_analysis(parsed)
      missing_fields = REQUIRED_MEAL_ANALYSIS_FIELDS - parsed.keys
      if missing_fields.any?
        puts "ERROR: Missing required meal analysis fields: #{missing_fields.join(', ')}"
        return nil
      end
      
      parsed
    end
    
    def self.validate_meal_item(parsed)
      missing_fields = REQUIRED_MEAL_ITEM_FIELDS - parsed.keys
      if missing_fields.any?
        puts "ERROR: Missing required meal item fields: #{missing_fields.join(', ')}"
        return nil
      end
      
      parsed
    end

    def self.clean_content(content)
      cleaned = content.gsub(/```json\s*/, '').gsub(/```\s*$/, '')
      cleaned = cleaned.strip
      
      if cleaned.match?(/\{.*\}/m)
        start_pos = cleaned.index('{')
        end_pos = cleaned.rindex('}')
        cleaned = cleaned[start_pos..end_pos] if start_pos && end_pos
      end
      
      cleaned = fix_newlines_in_strings(cleaned)
      cleaned = cleaned.gsub(/("\s*)\n(\s*"[^"]+":)/, "\\1,\n\\2")
      cleaned = cleaned.gsub(/,(\s*[}\]])/, '\1')
      
      cleaned
    end

    def self.fix_newlines_in_strings(json_str)
      result = []
      in_string = false
      escape_next = false
      
      json_str.chars.each do |char|
        if escape_next
          result << char
          escape_next = false
          next
        end
        
        if char == '\\'
          result << char
          escape_next = true
          next
        end
        
        if char == '"'
          in_string = !in_string
          result << char
          next
        end
        
        if in_string && (char == "\n" || char == "\r")
          result << '\\n' if char == "\n"
          next
        end
        
        result << char
      end
      
      result.join
    end
  end
end
