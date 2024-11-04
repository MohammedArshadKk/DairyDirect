// void _subscribeToTableChanges() {
//     // Set up a real-time channel for listening to changes on the 'countries' table
//     supabase
//         .channel('public:countries')
//         .onPostgresChanges(
//           event: PostgresChangeEvent.all,
//           schema: 'public',
//           table: 'countries',
//           callback: (payload) {
//             print('Change received: ${payload.toString()}');
            
//           },
//         )
//         .subscribe();
//   }