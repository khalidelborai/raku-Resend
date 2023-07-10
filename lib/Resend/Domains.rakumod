use v6.d;
unit class Resend::Domains;

has $.client;

method list() {
	my $res = await $!client.get('/domains');
	return $res;
}

subset Region of Str where 'us-east-1' | 'eu-west-1' | 'sa-east-1';

method add(:$name!, Region :$region = 'us-east-1') {
	my $res = await $!client.post('/domains', :body({ :$name, :$region }));
	return $res;
}

method get(Str $id) {
	my $res = await $!client.get("/domains/$id");
	return $res;
}

method delete(Str $id) {
	my $res = await $!client.delete("/domains/$id");
	return $res.body;
}

method verify(Str $id) {
	my $res = await $!client.post("/domains/$id/verify");
	return $res;
}


