From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] More DDR2 data for decode-dimms.pl
Date: Wed, 19 Mar 2008 14:16:09 +0100
Message-ID: <20080319141609.338c19b1@hyperion.delvare>
References: <Pine.LNX.4.58.0802281401020.14140@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0802281401020.14140-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Trent,

On Thu, 28 Feb 2008 14:19:02 -0800 (PST), Trent Piepho wrote:
> This lets decode-dimms.pl decode almost all of the SPD data for DDR2 dimms.
> Including all the detailed timing parameters with their standard tXXX
> names, useful if one is trying to program a DDR memory controller for
> example.

Thanks for doing this. Review:

> Index: decode-dimms.pl
> ===================================================================
> --- i2c-tools/eeprom/decode-dimms.pl	(revision 5132)
> +++ i2c-tools/eeprom/decode-dimms.pl	(working copy)
> @@ -834,6 +834,20 @@
>  	return $atime;
>  }
> 
> +sub ddrx_sdram_rtime($$$)
> +{
> +	my ($t, $b1, $b2) = @_;
> +	my $rtime = $b1;

Please add a blank line here for a better readability.

> +	if($t == 2) {
> +		$rtime += ($b2 & 1) * 256;
> +		my @table = (0, .250, .330, .500, .660, .750);

Not sure why you specify 3 decimal places when the last one is always 0?

> +		$rtime += $table[($b2>>1)&7];

Coding style: spaces around >> and &. Same in many places below.

> +	}
> +	return $rtime;
> +}

I don't understand the point of the first parameter ($t). The function
is always called with $t = 2. If you ever needed to ignore $b2, rather
than calling this function with $t = 1, you could simply pass $b2 = 0.
Or even better, you wouldn't call ddrx_sdram_rtime() at all, as it
would return $b1 directly.

Please also name this function ddr2_sdram_rtime rather than
ddrx_sdram_rtime. "x" in names adds to confusion, as the reader doesn't
know what are the "valid values" of "x".

> +
> +sub tns($) { return sprintf("%3.2f ns", $_[0]); }

Please unfold. This function should probably come earlier in the
script, as we may want to use it for other memory module types in the
future.

> +
>  # Parameter: bytes 0-63
>  sub decode_ddr2_sdram($)
>  {
> @@ -875,6 +889,40 @@
>  				       $bytes->[5] . "," . $bytes->[17];
>  	}
> 
> +	printl "Banks x Rows x Columns x Bits",
> +	       join(' x ', $bytes->[17], $bytes->[3], $bytes->[4], $bytes->[6]);
> +	printl "Ranks", ($bytes->[5]&7) + 1;
> +
> +	printl "SDRAM Device Width", $bytes->[13]." bits";
> +
> +	my @heights = ("< 25.4", "25.4", "25.4 - 30.0", "30.0", "30.5", "> 30.5");
> +	printl "Module Height", $heights[$bytes->[5]>>5]." mm";
> +	my @types = ("RDIMM", "UDIMM", "SO-DIMM", "Micro-DIMM",
> +		     "Mini-RDIMM", "Mini-UDIMM");
> +	my @widths = (133.35, 133.25, 67.6, 45.5, 82.0, 82.0);
> +	my @suptypes;
> +	foreach $ii (0..5) {
> +		push @suptypes, "$types[$ii] ($widths[$ii] mm)"
> +			if($bytes->[20] & (1<<$ii));
> +	}
> +	printl "Module Type".(@suptypes>1?'s':''),  join(', ', @suptypes);

Coding style: doubled space.

Maybe this could go to a subfunction for clarity?

> +	printl "DRAM Package", $bytes->[5]&0x10 ? "Stack" : "Planar";
> +
> +	my @volts = ("TTL/5V Tolerant", "LVTTL", "HSTL 1.5V",
> +		     "SSTL 3.3V", "SSTL 2.5V", "SSTL 1.8V", "TBD");
> +	printl "Voltage Interface Level", $volts[$bytes->[8]];

Not sure what sense it makes to have "TBD" in the list. Presumably all
the values above 6 are "to be defined", not just 6.

> +
> +	my @refresh = qw(Normal Reduced Reduced Extended Extended Extended);
> +	my @refresht = (15.625,3.9,7.8,31.3,62.5,125);

Coding style: space after commas please, it is unreadable otherwise.

> +	printl "Refresh Rate",
> +	       "$refresh[$bytes->[12]&0x7f] ($refresht[$bytes->[12]&0x7f] us)".
> +	       ($bytes->[12]&0x80 ? " - Self Refresh" : "");

This too could go to a subfunction?

> +
> +	my @burst;
> +	push @burst, 4 if ($bytes->[16] & 4);
> +	push @burst, 8 if ($bytes->[16] & 8);
> +	printl "Burst lengths supported", join(', ', @burst);

Should be "Supported Burst Lengths" to look like the other items.

> +
>  	my $highestCAS = 0;
>  	my %cas;
>  	for ($ii = 2; $ii < 7; $ii++) {
> @@ -899,31 +947,59 @@
>  		ceil($tras/$ctime);
> 
>  # latencies
> -	if (keys %cas) { $temp = join ', ', sort { $b <=> $a } keys %cas; }
> +	if (keys %cas) { $temp = join ', ', map("${_}T",sort { $b <=> $a } keys %cas); }

Coding style: space after comma.

Fine with me, but then we should probably do the same for SDR and DDR
types (in a later patch), for consistency.

>  	else { $temp = "None"; }
> -	printl "Supported CAS Latencies", $temp;
> +	printl "Supported CAS Latencies (tCL)", $temp;
> 
>  # timings
>  	if (exists $cas{$highestCAS}) {
> -		printl "Minimum Cycle Time (CAS $highestCAS)",
> -		       "$ctime ns";
> -		printl "Maximum Access Time (CAS $highestCAS)",
> -		       ddr2_sdram_atime($bytes->[10]) . " ns";
> +		printl "Minimum Cycle Time @ CAS $highestCAS (tCK min)",
> +		       tns($ctime);
> +		printl "Maximum Access Time @ CAS $highestCAS (tAC)",
> +		       tns(ddr2_sdram_atime($bytes->[10]));
>  	}

s/@/at/ please. This too is a change that should be done for SDR and
DDR types as well, for consistency.

> 
>  	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[23..24])) {
> -		printl "Minimum Cycle Time (CAS ".($highestCAS-1).")",
> -		       ddr2_sdram_ctime($bytes->[23]) . " ns";
> -		printl "Maximum Access Time (CAS ".($highestCAS-1).")",
> -		       ddr2_sdram_atime($bytes->[24]) . " ns";
> +		printl "Minimum Cycle Time @ CAS ".($highestCAS-1),
> +		       tns(ddr2_sdram_ctime($bytes->[23]));
> +		printl "Maximum Access Time @ CAS ".($highestCAS-1),
> +		       tns(ddr2_sdram_atime($bytes->[24]));
>  	}
> 
>  	if (exists $cas{$highestCAS-2} && spd_written(@$bytes[25..26])) {
> -		printl "Minimum Cycle Time (CAS ".($highestCAS-2).")",
> -		       ddr2_sdram_ctime($bytes->[25]) . " ns";
> -		printl "Maximum Access Time (CAS ".($highestCAS-2).")",
> -		       ddr2_sdram_atime($bytes->[26]) . " ns";
> +		printl "Minimum Cycle Time @ CAS ".($highestCAS-2),
> +		       tns(ddr2_sdram_ctime($bytes->[25]));
> +		printl "Maximum Access Time @ CAS ".($highestCAS-2),
> +		       tns(ddr2_sdram_atime($bytes->[26]));
>  	}
> +	printl "Maximim Device Cycle Time (tCK max)",

Typo: Maximum. I would also remove "Device" for consistency.

> +	       tns(ddr2_sdram_ctime($bytes->[43]));
> +
> +	# Some timing information
> +	prints("Timing Parameters");
> +	printl "Address/Command Setup Time Before Clock (tIS)",
> +	       tns(ddr2_sdram_atime($bytes->[32]));
> +	printl "Address/Command Hold Time After Clock (tIH)",
> +	       tns(ddr2_sdram_atime($bytes->[33]));
> +	printl "Data Input Setup Time Before Strobe (tDS)",
> +	       tns(ddr2_sdram_atime($bytes->[34]));
> +	printl "Data Input Hold Time After Strobe (tDH)",
> +	       tns(ddr2_sdram_atime($bytes->[35]));
> +	printl "Minimum Row Precharge Delay (tRP)", tns($trp);
> +	printl "Minimum Row Active to Row Active Delay (tRRD)",
> +	       tns($bytes->[28]/4);
> +	printl "Minimum RAS# to CAS# Delay (tRCD)", tns($trcd);
> +	printl "Minimum RAS# Pulse Width (tRAS)", tns($tras);
> +	printl "Write Recovery Time (tWR)", tns($bytes->[36]/4);
> +	printl "Minimum Write to Read CMD Delay (tWTR)", tns($bytes->[37]/4);
> +	printl "Minimum Read to Pre-charge CMD Delay (tRTP)", tns($bytes->[38]/4);
> +	printl "Minimum Active to Auto-refresh Delay (tRC)",
> +	       tns(ddrx_sdram_rtime(2, $bytes->[41], ($bytes->[40]>>3)&0xe));

As far as I can see, the masking isn't needed, as you do it again in
ddrx_sdram_rtime(). That being said, it would probably make sense to do
all the shifting and masking on the caller's side. Doing half of the
shifting outside and the other half inside the function is pretty
confusing.

> +	printl "Minimum Recovery Delay (tRFC)",
> +	       tns(ddrx_sdram_rtime(2, $bytes->[42], $bytes->[40]));
> +	printl "Maximum DQS to DQ Skew (tDQSQ)", tns($bytes->[44]/100);
> +	printl "Maximum Read Data Hold Skew (tQHS)", tns($bytes->[45]/100);
> +	printl "PLL Relock Time", $bytes->[46] . " us" if ($bytes->[46]);
>  }
> 
>  # Parameter: bytes 0-63

Please respin the patch to address my comments, and I'll apply it to
i2c-tools SVN.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
