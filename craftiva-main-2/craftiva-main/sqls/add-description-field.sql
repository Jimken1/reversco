-- Add description field to profiles table for user bios
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS description TEXT DEFAULT '';

-- Add an index for better performance when searching descriptions
CREATE INDEX IF NOT EXISTS idx_profiles_description ON profiles USING gin(to_tsvector('english', description));


