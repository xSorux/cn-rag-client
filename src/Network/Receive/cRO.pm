#########################################################################
#  OpenKore - Network subsystem
#  Copyright (c) 2006 OpenKore Team
#
#  This software is open source, licensed under the GNU General Public
#  License, version 2.
#  Basically, this means that you're allowed to modify and distribute
#  this software. However, if you distribute modified versions, you MUST
#  also distribute the source code.
#  See http://www.gnu.org/licenses/gpl.html for the full license.
#########################################################################
package Network::Receive::cRO;

use strict;
use Log qw(message warning error debug);
use base 'Network::Receive::ServerType0';
use Globals;
use Translation;
use Misc;
use Utils::RSK;
use Data::Dumper;

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new(@_);
	
	my %packets = (
	
		'0097' => ['private_message', 'v Z24 V Z*', [qw(len privMsgUser flag privMsg)]],
		'07FA' => ['inventory_item_removed', 'v3', [qw(reason index amount)]],
		
		'088A' => ['sync_request_ex'],
		'0888' => ['sync_request_ex'],
		'095B' => ['sync_request_ex'],
		'0868' => ['sync_request_ex'],
		'0802' => ['sync_request_ex'],
		'0880' => ['sync_request_ex'],
		'0950' => ['sync_request_ex'],
		'095E' => ['sync_request_ex'],
		'0861' => ['sync_request_ex'],
		'0437' => ['sync_request_ex'],
		'0946' => ['sync_request_ex'],
		'08A5' => ['sync_request_ex'],
		'0436' => ['sync_request_ex'],
		'0929' => ['sync_request_ex'],
		'089D' => ['sync_request_ex'],
		'089A' => ['sync_request_ex'],
		'0917' => ['sync_request_ex'],
		'088E' => ['sync_request_ex'],
		'0368' => ['sync_request_ex'],
		'0838' => ['sync_request_ex'],
		'087E' => ['sync_request_ex'],
		'0882' => ['sync_request_ex'],
		'0896' => ['sync_request_ex'],
		'089B' => ['sync_request_ex'],
		'0948' => ['sync_request_ex'],
		'0870' => ['sync_request_ex'],
		'08AD' => ['sync_request_ex'],
		'0957' => ['sync_request_ex'],
		'0367' => ['sync_request_ex'],
		'088B' => ['sync_request_ex'],
		'0881' => ['sync_request_ex'],
		'095A' => ['sync_request_ex'],
		'0955' => ['sync_request_ex'],
		'094E' => ['sync_request_ex'],
		'0862' => ['sync_request_ex'],
		'0874' => ['sync_request_ex'],
		'0952' => ['sync_request_ex'],
		'093A' => ['sync_request_ex'],
		'087F' => ['sync_request_ex'],
		'08AC' => ['sync_request_ex'],
		'088F' => ['sync_request_ex'],
		'094D' => ['sync_request_ex'],
		'093E' => ['sync_request_ex'],
		'08A4' => ['sync_request_ex'],
		'094B' => ['sync_request_ex'],
		'0878' => ['sync_request_ex'],
		'08A7' => ['sync_request_ex'],
		'08A0' => ['sync_request_ex'],
		'0877' => ['sync_request_ex'],
		'085F' => ['sync_request_ex'],
		'0964' => ['sync_request_ex'],
		'0943' => ['sync_request_ex'],
		'0364' => ['sync_request_ex'],
		'0960' => ['sync_request_ex'],
		'086E' => ['sync_request_ex'],
		'0281' => ['sync_request_ex'],
		'0898' => ['sync_request_ex'],
		'0895' => ['sync_request_ex'],
		'086D' => ['sync_request_ex'],
		'086F' => ['sync_request_ex'],
		'0869' => ['sync_request_ex'],
		'08A1' => ['sync_request_ex'],
		'023B' => ['sync_request_ex'],
		'091B' => ['sync_request_ex'],
		'0935' => ['sync_request_ex'],
		'0363' => ['sync_request_ex'],
		'092F' => ['sync_request_ex'],
		'087D' => ['sync_request_ex'],
		'086B' => ['sync_request_ex'],
		'091E' => ['sync_request_ex'],
		'0921' => ['sync_request_ex'],
		'0871' => ['sync_request_ex'],
		'0361' => ['sync_request_ex'],
		'0872' => ['sync_request_ex'],
		'0947' => ['sync_request_ex'],
		'0892' => ['sync_request_ex'],
		'0951' => ['sync_request_ex'],
		'094C' => ['sync_request_ex'],
		'092C' => ['sync_request_ex'],
		'0860' => ['sync_request_ex'],
		'0876' => ['sync_request_ex'],
		'0954' => ['sync_request_ex'],
		'095C' => ['sync_request_ex'],
		'0967' => ['sync_request_ex'],
	);

	foreach my $switch (keys %packets) {
		$self->{packet_list}{$switch} = $packets{$switch};
	}

	return $self;
}

sub sync_request_ex {
	my ($self, $args) = @_;
	# Debug Recv
	#message "Recv Ex : 0x" . $args->{switch} . "\n";

	my $PacketID = $args->{switch};

	my $tempValues = RSK::GetReply(hex($PacketID));
	$tempValues = sprintf("0x%04x\n",$tempValues);
	$tempValues =~ s/^0+//;
	# Debug Send
	#message "Send Ex: 0x" . uc($tempValues) . "\n";
	$tempValues = hex($tempValues);
	sleep(0.2);
	# Dispatching Sync Ex Reply
	$messageSender->sendReplySyncRequestEx($tempValues);
}

1;
