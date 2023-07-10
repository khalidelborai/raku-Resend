use v6.d;
unit class Resend::Emails;

has $.client;


method get($id) {
	my $res = $!client.get("/emails/$id");
	return $res;
}

method send(
		Str :$from!,
		Str :$to!,
		Str :$subject!,
		Any :$bcc,
		Any :$cc,
		Any :$reply_to,
		Str :$html,
		Str :$text,
		:%headers,
		:@attachments,
		:@tags,

            ) {
	my %data = (
	:$from,
	:$to,
	:$subject,
	);
	%data<bcc> = $bcc if $bcc;
	%data<cc> = $cc if $cc;
	%data<reply_to> = $reply_to if $reply_to;
	%data<html> = $html if $html;
	%data<text> = $text if $text;
	%data<headers> = %headers if %headers;
	%data<attachments> = @attachments if @attachments;
	%data<tags> = @tags if @tags;
	say $!client.headers;
	my $res = await $!client.post("/emails", body => %data);
	return $res;
}

