From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Preliminary support for DDR3 in decode-dimms (fwd)
Date: Mon, 8 Dec 2008 14:59:02 +0100
Message-ID: <20081208145902.5962408c@hyperion.delvare>
References: <Pine.NEB.4.64.0811230659540.29668@quicky.whooppee.com>
	<20081125103039.2f14bac7@hyperion.delvare>
	<Pine.NEB.4.64.0811250408050.29070@quicky.whooppee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.NEB.4.64.0811250408050.29070-j58mV80z1I3O+KjX/08HYEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Goyette <paul-3orOWTcw9wBWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Paul,

Sorry for the delay, I wanted to get i2c-tools 3.0.2 released before
making significant changes to decode-dimms.

On Tue, 25 Nov 2008 04:10:02 -0800 (PST), Paul Goyette wrote:
> The attached diffs provide some preliminary decode of the DDR3 SPD...
> This work is based on the recently-published Appendix K to JESD21-C
> (see http://www.jedec.org/download/search/4_01_02_11R18.pdf).
>
> Warning:  I'm no perl expert.  The code I've written is probably ugly to
> most of the readers of this list.  But it does work!
> (...)
> This version includes some additional decoding of bytes 60-76 for both 
> unregistered and registered DIMMs, and module physical dimensions.

This patch is relatively large and I admit I have a hard time reviewing
it, especially due to the lack of a detailed checklist of what you had
to change and why, and lack of comments in your code. I don't care
about the ddr3-specific functions (ddr3_manufacturer and
decode_ddr3_sdram), this is brand new code so it can't cause a
regression. What worries me are the changes to the common code.

Apparently you had to make some changes because assumptions which were
correct up to DDR2 are no longer correct for DDR3. Some of these
changes look like hacks to me (for example, the readfullspd function
and the conditionals it adds to the common code). I really would prefer
that we first clean up the script to get rid of improper assumptions,
and only after this is done, add support for DDR3. That way I will have
two medium patches to review rather than a single large one, and the
second patch should be pretty straightforward. This will be way easier
for me.

For example, if the manufacturing information is no longer common to
all memory types, then let's move it to a separate function. If
checksum handling is type-specific, then let's move it to a separate
function as well. I really don't want the main loop to grow
indefinitely.

Random comments and questions on your code:

> --- decode-dimms.orig	2008-05-23 07:18:37.000000000 -0700
> +++ decode-dimms	2008-11-25 04:02:44.000000000 -0800
> @@ -408,7 +408,7 @@
>  
>  sub tns($) # print a time in ns
>  {
> -	return sprintf("%3.2f ns", $_[0]);
> +	return sprintf("%.3f ns", $_[0]);
>  }
>  
>  # Parameter: bytes 0-63
> @@ -870,6 +870,251 @@
>  	       ($byte & 0x80 ? " - Self Refresh" : "");
>  }
>  
> +sub ddr3_manufacturer(@)
> +{
> +	my @info = @_;
> +	my @mfg_bytes = (0, 0, 0, 0, 0, 0, 0, 0);
> +	my $i;
> +	my $count = $info[0] & 127;
> +	# We'll just ignore the high-order odd-parity bit in the count byte
> +	for ($i = 0; $i < $count; $i++) {
> +		$mfg_bytes[$i] = 0x7f;
> +	}
> +	$mfg_bytes[$count] = $info[1];
> +	(my $mfg, my $extra) = manufacturer(@mfg_bytes);
> +	return $mfg;
> +}

Here you reformat the manufacturer code from the new (compact) to the
old (stupid) format. A comment explaining this would have been welcome.
But actually, this looks a bit artificial to me. Don't you think it
would be easier and more efficient to decode the new format directly?

> +
> +# Parameter: bytes 0-127
> +sub decode_ddr3_sdram($)
> +{
> +	my $bytes = shift;
> +	my $l;
> +	my $temp;
> +	my $ctime;
> +
> +	my @module_types = ("Undefined", "RDIMM", "UDIMM", "SO-DIMM",
> +			    "Micro-DIMM", "Mini-RDIMM", "Mini-UDIMM");
> +
> +	printl "Module Type", ($bytes->[3] <= $#module_types) ?
> +					$module_types[$bytes->[3]] :
> +					sprint("Reserved (0x%.2X)", $bytes->[3]);
> +
> +# speed
> +	prints "Memory Characteristics";
> +
> +	$l = "Fine time base";
> +	my $dividend = ($bytes->[9] >> 4) & 15;
> +	my $divisor  = $bytes->[9] & 15;
> +	printl $l, sprintf("%.3f", $dividend / $divisor) . " ps";
> +
> +	$l = "Medium time base";
> +	$dividend = $bytes->[10];
> +	$divisor  = $bytes->[11];
> +	my $mtb = $dividend / $divisor;
> +	printl $l, tns($mtb);
> +
> +	$l = "Maximum module speed";
> +	$ctime = $bytes->[12] * $mtb;
> +	my $ddrclk = 2 * (1000 / $ctime);
> +	my $tbits = 1 << (($bytes->[8] & 7) + 3);
> +	my $pcclk = int ($ddrclk * $tbits / 8);
> +	$ddrclk = int ($ddrclk);
> +	printl $l, "${ddrclk}MHz (PC3-${pcclk})";
> +
> +# Size computation
> +
> +	my $cap =  ($bytes->[4]       & 15) + 28;
> +	$cap   +=  ($bytes->[8]       & 7)  + 3;
> +	$cap   -=  ($bytes->[7]       & 7)  + 2;
> +	$cap   -= 20 + 3;
> +	my $k   = (($bytes->[7] >> 3) & 31) + 1;
> +	printl "Size", ((1 << $cap) * $k) . " MB";
> +
> +	printl "Banks x Rows x Columns x Bits",
> +	       join(' x ', 1 << ((($bytes->[4] >> 4) &  7) +  3),
> +			   ((($bytes->[5] >> 3) & 31) + 12),
> +			   ( ($bytes->[5]       &  7) +  9),
> +			   ( 1 << (($bytes->[8] &  7) + 3)) );
> +	printl "Ranks", $k;
> +
> +	printl "SDRAM Device Width", (1 << (($bytes->[7] & 7) + 2))." bits";
> +
> +	my $taa;
> +	my $trcd;
> +	my $trp;
> +	my $tras;
> +
> +	$taa  = int($bytes->[16] / $bytes->[12]);
> +	$trcd = int($bytes->[18] / $bytes->[12]);
> +	$trp  = int($bytes->[20] / $bytes->[12]);
> +	$tras = int((($bytes->[21] >> 4) * 256 + $bytes->[22]) / $bytes->[12]);
> +
> +	printl "tCL-tRCD-tRP-tRAS", join("-", $taa, $trcd, $trp, $tras);
> +
> +# latencies
> +	my $highestCAS = 0;
> +	my %cas;
> +	my $ii;
> +	my $cas_sup = ($bytes->[15] << 8) + $bytes->[14];
> +	for ($ii = 0; $ii < 15; $ii++) {
> +		if ($cas_sup & (1 << $ii)) {
> +			$highestCAS = $ii + 4;
> +			$cas{$highestCAS}++;
> +		}
> +	}
> +	printl "Supported CAS Latencies (tCL)", cas_latencies(keys %cas);
> +
> +# more timing information
> +	prints "Timing Parameters" ;
> +
> +	printl "Minimum Write Recovery time (tWR)", tns($bytes->[17] * $mtb);
> +	printl "Minimum Row Active to Row Active Delay (tRRD)",
> +		tns($bytes->[19] * $mtb);
> +	printl "Minimum Active to Auto-Refresh Delay (tRC)",
> +		tns((((($bytes->[21] >> 4) & 15) << 8) + $bytes->[23]) * $mtb);
> +	printl "Minimum Recovery Delay (tRFC)", 
> +		tns((($bytes->[25] << 8) + $bytes->[24]) * $mtb);
> +	printl "Minimum Write to Read CMD Delay (tWTR)",
> +		tns($bytes->[26] * $mtb);
> +	printl "Minimum Read to Pre-charge CMD Delay (tRTP)",
> +		tns($bytes->[27] * $mtb);
> +	printl "Minimum Four Activate Window Delay (tFAW)",
> +		tns(((($bytes->[28] & 15) << 8) + $bytes->[29]) * $mtb);
> +
> +# miscellaneous stuff
> +	prints "Optional Features";
> +
> +	my $volts = "1.5V";
> +	if ($bytes->[6] & 1) {
> +		$volts .= " tolerant";
> +	}
> +	if ($bytes->[6] & 2) {
> +		$volts .= ", 1.35V ";
> +	}
> +	if ($bytes->[6] & 4) {
> +		$volts .= ", 1.2X V";
> +	}
> +	printl "Operable voltages", $volts;
> +	printl "RZQ/6 supported?", ($bytes->[30] & 1) ? "Yes" : "No";
> +	printl "RZQ/7 supported?", ($bytes->[30] & 2) ? "Yes" : "No";
> +	printl "DLL-Off Mode supported?", ($bytes->[30] & 128) ? "Yes" : "No";
> +	printl "Operating temperature range", sprintf "0-%dC",
> +		($bytes->[31] & 1) ? 95 : 85;
> +	printl "Refresh Rate in extended temp range",
> +		($bytes->[31] & 2) ? "2X" : "1X";
> +	printl "Auto Self-Refresh?", ($bytes->[31] & 4) ? "Yes" : "No";
> +	printl "On-Die Thermal Sensor readout?",
> +		($bytes->[31] & 8) ? "Yes" : "No";
> +	printl "Partial Array Self-Refresh?",
> +		($bytes->[31] & 128) ? "Yes" : "No";
> +	printl "Thermal Sensor Accuracy",
> +		($bytes->[32] & 128) ? sprintf($bytes->[32] & 127) :
> +					"Not implemented";
> +	printl "SDRAM Device Type",
> +		($bytes->[33] & 128) ? sprintf($bytes->[33] & 127) :
> +					"Standard Monolithic";
> +	if ($bytes->[3] >= 1 && $bytes->[3] <= 6) {
> +
> +		prints "Physical Characteristics";
> +		printl "Module Height (mm)", ($bytes->[60] & 31) + 15;
> +		printl "Module Thickness (mm)", sprintf("%d front, %d back",
> +						($bytes->[61] & 15) + 1, 
> +						(($bytes->[61] >> 4) & 15) +1);
> +		printl "Module Width (mm)", ($bytes->[3] <= 2) ? 133.5 :
> +					($bytes->[3] == 3) ? 67.6 : "TBD";
> +
> +		my @alphabet = ("A", "B", "C", "D", "E", "F", "G", "H", "J",
> +				"K", "L", "M", "N", "P", "R", "T", "U", "V",
> +				"W", "Y" );
> +
> +		my $ref = $bytes->[62] & 31;
> +		my $ref_card;
> +		if ($ref == 31) {
> +			$ref_card = "ZZ";
> +		} else {
> +			if ($bytes->[62] & 128) {
> +				$ref += 31;
> +			}
> +			if ($ref < $#alphabet) {
> +				$ref_card = $alphabet[$ref];
> +			} else {
> +				my $ref1 = int($ref / $#alphabet);
> +				$ref -= $#alphabet * $ref1;
> +				$ref_card = $alphabet[$ref1] . $alphabet[$ref];
> +			}
> +		}
> +		printl "Module Reference Card", $ref_card;
> +	}
> +	if ($bytes->[3] == 1 || $bytes->[3] == 5) {
> +		prints "Registered DIMM";
> +
> +		my @rows = ("Undefined", 1, 2, 4);
> +		printl "# DRAM Rows", $rows[($bytes->[63] >> 2) & 3];
> +		printl "# Registers", $rows[$bytes->[63] & 3];
> +		my @m_data = ($bytes->[65], $bytes->[66]);
> +		printl "Register manufacturer", ddr3_manufacturer(@m_data[0..1]);
> +		printl "Register device type",
> +				(($bytes->[68] & 7) == 0) ? "SSTE32882" :
> +					"Undefined";
> +		printl "Register revision", sprintf("0x%.2X", $bytes->[67]);
> +		printl "Heat spreader characteristics",
> +				($bytes->[64] < 128) ? "Not incorporated" :
> +					sprintf("%.2X", ($bytes->[64] & 127));
> +		my $regs;
> +		for (my $i = 0; $i < 8; $i++) {
> +			$regs = sprintf("SSTE32882 RC%d/RC%d",
> +					$i * 2, $i * 2 + 1);
> +			printl $regs, sprintf("%.2X", $bytes->[$i + 69]);
> +		}
> +	}
> +
> +	prints "Manufacturer Data";
> +
> +	my @m_data = ($bytes->[117], $bytes->[118]);
> +	printl "Module Manufacturer", ddr3_manufacturer(@m_data[0..1]);
> +
> +	@m_data = ($bytes->[148], $bytes->[149]);
> +	printl "DRAM Manufacturer Code", ddr3_manufacturer(@m_data[0..1]);
> +
> +	$l = "Manufacturing Location";
> +	$temp = (chr($bytes->[8]) =~ m/^[\w\d]$/) ? chr($bytes->[8])
> +	      : sprintf("0x%.2X", $bytes->[8]);
> +	printl $l, $temp;
> +
> +	$l = "Part Number";
> +	$temp = "";
> +	for (my $i = 128; $i <= 145; $i++) {
> +		$temp .= chr($bytes->[$i]);
> +	};
> +	printl $l, $temp;
> +
> +	$l = "Revision";
> +	$temp = sprintf("0x%02X%02X\n", $bytes->[146], $bytes->[147]);
> +	printl $l, $temp;
> +
> +	$l = "Manufacturing Date";
> +	# In theory the year and week are in BCD format, but
> +	# this is not always true in practice :(
> +	if (($bytes->[120] & 0xf0) <= 0x90
> +	 && ($bytes->[120] & 0x0f) <= 0x09
> +	 && ($bytes->[121] & 0xf0) <= 0x90
> +	 && ($bytes->[121] & 0x0f) <= 0x09) {
> +		# Note that this heuristic will break in year 2080
> +		$temp = sprintf("%d%02X-W%02X\n",
> +				$bytes->[120] >= 0x80 ? 19 : 20,
> +				$bytes->[120], $bytes->[121]);
> +	} else {
> +		$temp = sprintf("0x%02X%02X\n", $bytes->[120], $bytes->[121]);
> +	}
> +	printl $l, $temp;
> +
> +	$l = "Assembly Serial Number";
> +	$temp = sprintf("0x%02X%02X%02X%02X\n", $bytes->[122], $bytes->[123],
> +		$bytes->[124], $bytes->[125]);
> +	printl $l, $temp;
> +}

I won't comment on this function, as it is new it can't break anything,
and it can be improved / fixed over time. Just one thing though:
placing this function in the middle of ddr2-specific functions is quite
confusing, it you have been much clearer to put it afterwards.

> +
>  # Parameter: bytes 0-63
>  sub decode_ddr2_sdram($)
>  {
> @@ -1061,6 +1306,7 @@
>  	"DDR2 SDRAM"	=> \&decode_ddr2_sdram,
>  	"Direct Rambus"	=> \&decode_direct_rambus,
>  	"Rambus"	=> \&decode_rambus,
> +	"DDR3 SDRAM"	=> \&decode_ddr3_sdram,
>  );
>  
>  # Parameter: bytes 64-127
> @@ -1179,6 +1425,32 @@
>  	return @bytes;
>  }
>  
> +sub readfullspd($$) # reads all bytes from SPD-EEPROM
> +{
> +	my ($size, $dimm_i) = @_;
> +	my @bytes;
> +	if ($use_hexdump) {
> +		@bytes = read_hexdump($dimm_i);
> +		return @bytes[0..$size];
> +	} elsif ($use_sysfs) {
> +		# Kernel 2.6 with sysfs
> +		sysopen(HANDLE, "/sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom", O_RDONLY)
> +			or die "Cannot open /sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom";
> +		binmode HANDLE;
> +		sysseek(HANDLE, 0, SEEK_SET);
> +		sysread(HANDLE, my $eeprom, $size);
> +		close HANDLE;
> +		@bytes = unpack(sprintf("C%d", $size), $eeprom);
> +	} else {
> +		# Kernel 2.4 with procfs
> +		for my $i (0 .. $size/16) {
> +			my $hexoff = sprintf('%02x', $i * 16);
> +			push @bytes, split(" ", `cat /proc/sys/dev/sensors/$dimm_i/$hexoff`);
> +		}
> +	}
> +	return @bytes;
> +}

As written above, I don't like this hack. This is fundamentally
duplicating the code of readspd64. If you can handle the DDR3 with
readspd64, please just do that. If not, then let's have a more generic
function which can handle all cases. But please do not duplicate the
code.

> +
>  # Parse command-line
>  foreach (@ARGV) {
>  	if ($_ eq '-h' || $_ eq '--help') {
> @@ -1271,9 +1543,6 @@
>  		$dimm_checksum += $bytes[$_] foreach (0 .. 62);
>  		$dimm_checksum &= 0xff;
>  
> -		next unless $bytes[63] == $dimm_checksum || $opt_igncheck;
> -		$dimm_count++;
> -

That's not OK. You let the script print things when the checksum is
invalid, while it did not before. Your patch should not change the
behavior of the script!

>  		print "<b><u>" if $opt_html;
>  		printl2 "\n\nDecoding EEPROM",
>  		        $use_hexdump ? $dimm_list[$i] : ($use_sysfs ?
> @@ -1292,32 +1561,87 @@
>  # Decode first 3 bytes (0-2)
>  		prints "SPD EEPROM Information";
>  
> -		my $l = "EEPROM Checksum of bytes 0-62";
> -		printl $l, ($bytes[63] == $dimm_checksum ?
> -			sprintf("OK (0x%.2X)", $bytes[63]):
> -			sprintf("Bad\n(found 0x%.2X, calculated 0x%.2X)\n",
> -				$bytes[63], $dimm_checksum));
> -
>  		# Simple heuristic to detect Rambus

This comment...

> -		my $is_rambus = $bytes[0] < 4;
> +		my $spdsize;
> +		my $written;
> +		my @used = ( 0, 128, 176, 256);
> +		my @sizes = ( "Undefined", 256);
> +		my $is_rambus = ($bytes[0] < 4 && $bytes[0] >= 0);

... if now far away from the code it applied to; confusing. I also do
not understand why you added this second condition... $bytes[0] is a
value between 0 and 255, how could it NOT be >= 0?

> +
> +		if ($is_rambus || $bytes[2] <= 8) {

The second condition needs clarification.

> +			my $l = "EEPROM Checksum of bytes 0-62";
> +			printl $l, ($bytes[63] == $dimm_checksum ?
> +				sprintf("OK (0x%.2X)", $bytes[63]):
> +				sprintf("Bad\n(found 0x%.2X, calculated 0x%.2X)\n",
> +					$bytes[63], $dimm_checksum));
> +			next unless $bytes[63] == $dimm_checksum ||
> +				    $opt_igncheck;
> +			$dimm_count++;
> +			if ($is_rambus) {
> +				$spdsize = 0;
> +				$written = 0;
> +			} else {
> +				$written = $bytes[0];
> +				if ($bytes[1] <= 14) {
> +					$spdsize = 1 << $bytes[1];
> +				} else { $spdsize = "ERROR!"; }
> +			}
> +		} else {
> +			if ((($bytes[0] >> 4) & 7) <= $#sizes) {
> +				$spdsize = $sizes[($bytes[0] >> 4) & 7];
> +			} else { $spdsize = sprintf("Reserved (0x%X)",
> +					($bytes[0] >> 4) & 7); }
> +
> +			if (($bytes[0] & 15) <= $#used) {
> +				$written = $used[$bytes[0] & 15];
> +			} else { $written = sprintf("Reserved (0x%X)",
> +					$bytes[0] & 15); }
> +
> +			@bytes = readfullspd($written, $dimm_list[$i]);
> +			my $dimm_crc = 0;
> +			my $crc_cover = $bytes[0] & 0x80 ? 116 : 125;
> +			my $crc_ptr = 0;
> +			my $crc_bit;
> +			while ($crc_ptr <= $crc_cover) {
> +				$dimm_crc = $dimm_crc ^ ($bytes[$crc_ptr] << 8);
> +				for ($crc_bit = 0; $crc_bit < 8; $crc_bit++) {
> +					if ($dimm_crc & 0x8000) {
> +						$dimm_crc = ($dimm_crc << 1) ^
> +							0x1021;
> +					} else {
> +						$dimm_crc = $dimm_crc << 1
> +					}
> +				}
> +				$crc_ptr++;
> +			}
> +			$dimm_crc = $dimm_crc & 0xffff;
> +
> +			my $l = "EEPROM CRC of bytes 0-" .
> +				sprintf("%d", $crc_cover);
> +			my $crc_calc = $bytes[127] << 8 | $bytes[126];
> +			printl $l, ($dimm_crc == $crc_calc)?
> +				sprintf("OK (0x%.4X)", $dimm_crc):
> +				sprintf("Bad\n(found 0x%.4X, calculated 0x%.4X)\n",
> +					$crc_calc, $dimm_crc);
> +			next unless $crc_calc == $dimm_crc || $opt_igncheck;
> +			$dimm_count++;
> +		}

As said before, this all should go to a separate function. With
comments explaining what you do.

> +
>  		my $temp;
>  		if ($is_rambus) {
>  			if ($bytes[0] == 1) { $temp = "0.7"; }
>  			elsif ($bytes[0] == 2) { $temp = "1.0"; }
> -			elsif ($bytes[0] == 0 || $bytes[0] == 255) { $temp = "Invalid"; }
> -			else { $temp = "Reserved"; }
> +			elsif ($bytes[0] == 0 || $bytes[0] == 255) {
> +				$temp = "Invalid";
> +			} else { $temp = "Reserved"; }

Hum, gratuitous coding-style change? Please don't do this, this only
slows down reviews.

>  			printl "SPD Revision", $temp;
> -		} else {
> -			printl "# of bytes written to SDRAM EEPROM",
> -			       $bytes[0];
> +		}
> +		if ($spdsize != 0) {
> +			printl "# of bytes written to SDRAM EEPROM", $written;
>  		}
>  
> -		$l = "Total number of bytes in EEPROM";
> -		if ($bytes[1] <= 14) {
> -			printl $l, 2**$bytes[1];
> -		} elsif ($bytes[1] == 0) {
> -			printl $l, "RFU";
> -		} else { printl $l, "ERROR!"; }
> +		my $l = "Total number of bytes in EEPROM";
> +		printl $l, $spdsize;
>  
>  		$l = "Fundamental Memory type";
>  		my $type = "Unknown";
> @@ -1325,14 +1649,14 @@
>  			if ($bytes[2] == 1) { $type = "Direct Rambus"; }
>  			elsif ($bytes[2] == 17) { $type = "Rambus"; }
>  		} else {
> -			if ($bytes[2] == 1) { $type = "FPM DRAM"; }
> -			elsif ($bytes[2] == 2) { $type = "EDO"; }
> -			elsif ($bytes[2] == 3) { $type = "Pipelined Nibble"; }
> -			elsif ($bytes[2] == 4) { $type = "SDR SDRAM"; }
> -			elsif ($bytes[2] == 5) { $type = "Multiplexed ROM"; }
> -			elsif ($bytes[2] == 6) { $type = "DDR SGRAM"; }
> -			elsif ($bytes[2] == 7) { $type = "DDR SDRAM"; }
> -			elsif ($bytes[2] == 8) { $type = "DDR2 SDRAM"; }
> +			my @types = ("Reserved", "FPM DRAM", "EDO",
> +				"Pipelined Nibble", "SDR DRAM",
> +				"Multiplexed ROM", "DDR SGRAM", "DDR SDRAM",
> +				"DDR2 SDRAM", "FB_DIMM", "FB-DIMM PROBE",
> +				"DDR3 SDRAM");
> +			if ($bytes[2] <= $#types) {
> +				$type = $types[$bytes[2]];
> +			} else { $type = $types[0]; }

While I agree this change is a good idea, it should not be part of this
DDR3 patch. Especially when it breaks the SDRAM case! You changed the
"SDR SDRAM" string to SDR DRAM", while we do use these strings as hash
keys later in the script.

>  		}
>  		printl $l, $type;
>  
> @@ -1340,10 +1664,19 @@
>  		$decode_callback{$type}->(\@bytes)
>  			if exists $decode_callback{$type};
>  
> +		# DDR3 Manufacturer info is already decoded
> +		# (It's NOT common!)
> +
> +		next if ($type eq "DDR3 SDRAM");
> +

This hack breaks the html output mode.

>  # Decode next 35 bytes (64-98, common to all memory types)
>  		prints "Manufacturing Information";
>  
> -		@bytes = readspd64(64, $dimm_list[$i]);
> +		if ($#bytes == 63) {
> +			@bytes = readspd64(64, $dimm_list[$i]);
> +		} else {
> +			@bytes = @bytes[64..$#bytes];
> +		}

And this shouldn't be needed: if you reach this part of the code, it
means you're not in the DDR3 case, so you can't have bytes 64-127 in
the @bytes array yet.

>  
>  		$l = "Manufacturer";
>  		# $extra is a reference to an array containing up to

So, as I wrote before, let's clear up the script from its improper
assumptions first. I can help with this if you don't have the time, but
you must tell me what needs to be done and why.

Thanks,
-- 
Jean Delvare
