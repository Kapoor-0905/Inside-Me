import 'package:supabase/supabase.dart';

class SupabaseCredentials {
  static const APIKEY =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1obXFyb29qdHN3d256YXJzcXBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODE2NTU5MTMsImV4cCI6MTk5NzIzMTkxM30.K-_-3tNGM40kTGrfVoakPIdLc8oTrxeyeplsgjuoT_o';
  static const URL = 'https://mhmqroojtswwnzarsqpg.supabase.co';

  static SupabaseClient supabaseClient = SupabaseClient(APIKEY, URL);
}
