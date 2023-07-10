use v6.d;
unit class Resend::Keys;

has $.client;

subset Permission of Str where 'full_access' | 'sending_access';

method list {
	my $res = await $!client.get('/api-keys');
	return $res;
}

method create(
		Str :$name,
		Str :$permission,
		Str :$domain_id
              ) {
	my $res = await $!client.post('/api-keys', body => {
		:$name,
		:$permission,
		:$domain_id
	});
	return $res;
}

method delete(Str $id) {
	say "Deleting $id";
	my $res = await $!client.delete("/api-keys/$id");
	say "Deleted $id";
	return $res;
}