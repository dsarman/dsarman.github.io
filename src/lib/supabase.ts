import { createClient } from "@supabase/supabase-js";

export const supabase = (url: string, key: string) => createClient(url, key);
