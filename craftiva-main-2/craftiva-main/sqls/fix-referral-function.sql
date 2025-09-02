-- Fix the generate_referral_code function to resolve ambiguous column reference
-- Run this in your Supabase SQL editor

-- Drop the existing function first
DROP FUNCTION IF EXISTS generate_referral_code();

-- Create the fixed function with a different variable name
CREATE OR REPLACE FUNCTION generate_referral_code()
RETURNS TEXT AS $$
DECLARE
    generated_code TEXT;
    exists_already BOOLEAN;
BEGIN
    LOOP
        -- Generate a 8-character alphanumeric code
        generated_code := upper(substring(md5(random()::text) from 1 for 8));
        
        -- Check if code already exists
        SELECT EXISTS(SELECT 1 FROM referral_codes WHERE referral_codes.code = generated_code) INTO exists_already;
        
        -- If code doesn't exist, return it
        IF NOT exists_already THEN
            RETURN generated_code;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Success message
SELECT 'Referral function fixed successfully!' as status;



