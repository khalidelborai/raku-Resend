use v6.d;

use Cro::HTTP::Client;
use Resend::Domains;
use Resend::Emails;
use Resend::Keys;



unit class Resend;

has Str $.api_key;
has Cro::HTTP::Client $.client;
has Resend::Domains $.domains;
has Resend::Emails $.emails;
has Resend::Keys $.keys;



multi method new($api_key) {

	my $client = Cro::HTTP::Client.new(
			headers => [
				"Accept" => "application/json",
				"Authorization" => "Bearer $api_key",
				"User-Agent" => "Resend-Raku-SDK",
				'Content-Type' => 'application/json',

			],
			base-uri => "https://api.resend.com",
	);
	return self.new(
			:$api_key,
			:$client,
		:domains(Resend::Domains.new(:$client)),
		:emails(Resend::Emails.new(:$client)),
		:keys(Resend::Keys.new(:$client)),
	);
}







=begin pod

=head1 NAME

Resend - Raku SDK for Resend

=head1 SYNOPSIS

=begin code :lang<raku>

use Resend;

=end code

=head1 DESCRIPTION

Raku SDK for Resend

=head1 AUTHOR

khalidelborai <elboraikhalid@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2023 khalidelborai

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
