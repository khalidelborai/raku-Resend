use v6.d;
use Cro::HTTP::Client;
unit module Resend::Exceptions;

class X::Resend::Error is Exception {
	has Str $.code is required;
	has Str $.error_type is required;
	has Str $.message is required;
	has Str $.suggested_action;

	method message() {
		"Resend Error: $.code ($.error_type) - $.message" ~
				($.suggested_action ?? "\n\t $.suggested_action" !! "");
	}
}

class X::Resend::MissingApiKey is X::Resend::Error {
	multi method new(
			:$code,
			:$error_type,) {
		self.bless(
				:message("Missing API key in the authorization header."),
				:suggested_action("include the following header Authorization: Bearer YOUR_API_KEY in the request."),
				:$code,
				:$error_type,
				);
	}
}

class X::Resend::InvalidApiKey is X::Resend::Error {
	multi method new(
			:$code,
			:$error_type,) {
		self.bless(
				:message("The API key is not valid."),
				:suggested_action("Generate a new API key in the dashboard."),
				:$code,
				:$error_type,
				);
	}
}

class X::Resend::ValidationError is X::Resend::Error {
	multi method new(
			:$code,
			:$error_type,
			:$message = "The request body is missing one or more required fields.",
	                 ) {
		self.bless(
				:$message,
				:suggested_action("Check the error message to see the list of missing fields."),
				:$code,
				:$error_type,
				);
	}
}

class X::Resend::MissingRequiredFields is X::Resend::Error {
	multi method new(
			:$code,
			:$error_type,
			:$message = "The request body is missing one or more required fields.",
	                 ) {
		self.bless(
				:$message,
				:suggested_action("Check the error message to see the list of invalid fields."),
				:$code,
				:$error_type,
				);
	}
}

constant ERRORS = {
	"400" => X::Resend::ValidationError,
	"422" => X::Resend::MissingRequiredFields,
	"401" => X::Resend::MissingApiKey,
	"403" => X::Resend::InvalidApiKey,
}

sub throw-error($code, $error_type, $message) is export {
	my $error = ERRORS{$code}.new(
			:$code,
			:$error_type,
			:$message,
			);
	die $error;
}
