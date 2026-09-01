import { createBrowserClient } from "@supabase/ssr";

export const createClient = () => {
  // Fallback for build time when env vars might not be set
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://placeholder.supabase.co';
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'placeholder-key';

  return createBrowserClient(
    supabaseUrl,
    supabaseAnonKey,
  );
};
