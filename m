From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] More DDR2 data for decode-dimms.pl
Date: Thu, 20 Mar 2008 08:47:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0803200822100.16142@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0802281401020.14140@shell4.speakeasy.net>
	<20080319141609.338c19b1@hyperion.delvare>
	<Pine.LNX.4.58.0803191731500.16142@shell2.speakeasy.net>
	<20080320121336.2109d6d3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080320121336.2109d6d3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 20 Mar 2008, Jean Delvare wrote:
> If you want to move some more code in the callee, I propose the
> following:
>
> sub ddr2_sdram_rtime($$)
> {
> 	my ($rtime, $ext1, $ext2) = @_;
> 	my @table = (0, .25, .33, .50, .66, .75);
>
> 	return $time + ext1 * 256 + $table[$ext2];
> }
>
> (...)
> 	printl "Minimum Active to Auto-refresh Delay (tRC)",
> 	       tns(ddr2_sdram_rtime($bytes->[41], 0, ($bytes->[40] >> 4) & 7));
> 	printl "Minimum Recovery Delay (tRFC)",
> 	       tns(ddr2_sdram_rtime($bytes->[42], $bytes->[40] & 1,
> 				    ($bytes->[40] >> 1) & 7));

Ok, I've changed it to use this method.  Thought I would have put the " &
7" inside the function, since it's common to any and all calls to the
function.  It's one less thing for the person calling it to worry about.

> I'm fine with the rest, with one question though:
>
> > +	my @burst;
> > +	push @burst, 4 if ($bytes->[16] & 4);
> > +	push @burst, 8 if ($bytes->[16] & 8);
> > +	printl "Supported Burst Lengths", join(', ', @burst);
>
> Do DDR2 modules have to support burst at all? The SDR code assumes that
> the module might not support any burst length and prints "None" in this
> case. I suspect that we should do the same for DDR2.

Good question, all my SPD data supports 4 and 8, but I didn't see anything
in the spec (which is not very precise about such matters) that said bursts
must be supported.  I put in a line of code to say "None" if there are no
bursts lengths.

---------------------------------------------------------------------------
This lets decode-dimms.pl decode almost all of the SPD data for DDR2 dimms.
Included are all the detailed timing parameters with their standard tXXX
names, useful if one is trying to program a DDR memory controller for
example.  Or just to compare against any other SPD dump or memory spec
sheet.

---
Index: eeprom/decode-dimms.pl
===================================================================
--- eeprom/decode-dimms.pl	(revision 5151)
+++ eeprom/decode-dimms.pl	(working copy)
@@ -406,6 +406,11 @@
 	}
 }

+sub tns($) # print a time in ns
+{
+	return sprintf("%3.2f ns", $_[0]);
+}
+
 # Parameter: bytes 0-63
 sub decode_sdr_sdram($)
 {
@@ -834,6 +839,40 @@
 	return $atime;
 }

+# Base, high-bit, 3-bit fraction code
+sub ddr2_sdram_rtime($$$)
+{
+	my ($rtime, $msb, $ext) = @_;
+	my @table = (0, .25, .33, .50, .66, .75);
+
+	return $rtime + $msb * 256 + $table[$ext];
+}
+
+sub ddr2_module_types($)
+{
+	my $byte = shift;
+	my @types = qw(RDIMM UDIMM SO-DIMM Micro-DIMM Mini-RDIMM Mini-UDIMM);
+	my @widths = (133.35, 133.25, 67.6, 45.5, 82.0, 82.0);
+	my @suptypes;
+
+	foreach (0..5) {
+		push @suptypes, "$types[$_] ($widths[$_] mm)"
+			if($byte & (1 << $_));
+	}
+
+	return @suptypes;
+}
+
+sub ddr2_refresh_rate($)
+{
+	my $byte = shift;
+	my @refresh = qw(Normal Reduced Reduced Extended Extended Extended);
+	my @refresht = (15.625, 3.9, 7.8, 31.3, 62.5, 125);
+
+	return "$refresh[$byte & 0x7f] ($refresht[$byte & 0x7f] us)".
+	       ($byte & 0x80 ? " - Self Refresh" : "");
+}
+
 # Parameter: bytes 0-63
 sub decode_ddr2_sdram($)
 {
@@ -875,6 +914,32 @@
 				       $bytes->[5] . "," . $bytes->[17];
 	}

+	printl "Banks x Rows x Columns x Bits",
+	       join(' x ', $bytes->[17], $bytes->[3], $bytes->[4], $bytes->[6]);
+	printl "Ranks", ($bytes->[5]&7) + 1;
+
+	printl "SDRAM Device Width", $bytes->[13]." bits";
+
+	my @heights = ('< 25.4', '25.4', '25.4 - 30.0', '30.0', '30.5', '> 30.5');
+	printl "Module Height", $heights[$bytes->[5] >> 5]." mm";
+
+	my @suptypes = ddr2_module_types($bytes->[20]);
+	printl "Module Type".(@suptypes > 1 ? 's' : ''),  join(', ', @suptypes);
+
+	printl "DRAM Package", $bytes->[5] & 0x10 ? "Stack" : "Planar";
+
+	my @volts = ("TTL (5V Tolerant)", "LVTTL", "HSTL 1.5V",
+		     "SSTL 3.3V", "SSTL 2.5V", "SSTL 1.8V", "TBD");
+	printl "Voltage Interface Level", $volts[$bytes->[8]];
+
+	printl "Refresh Rate", ddr2_refresh_rate($bytes->[12]);
+
+	my @burst;
+	push @burst, 4 if ($bytes->[16] & 4);
+	push @burst, 8 if ($bytes->[16] & 8);
+	$burst[0] = 'None' if !@burst;
+	printl "Supported Burst Lengths", join(', ', @burst);
+
 	my $highestCAS = 0;
 	my %cas;
 	for ($ii = 2; $ii < 7; $ii++) {
@@ -899,31 +964,60 @@
 		ceil($tras/$ctime);

 # latencies
-	if (keys %cas) { $temp = join ', ', sort { $b <=> $a } keys %cas; }
+	if (keys %cas) { $temp = join ', ', map("${_}T", sort { $b <=> $a } keys %cas); }
 	else { $temp = "None"; }
-	printl "Supported CAS Latencies", $temp;
+	printl "Supported CAS Latencies (tCL)", $temp;

 # timings
 	if (exists $cas{$highestCAS}) {
-		printl "Minimum Cycle Time (CAS $highestCAS)",
-		       "$ctime ns";
-		printl "Maximum Access Time (CAS $highestCAS)",
-		       ddr2_sdram_atime($bytes->[10]) . " ns";
+		printl "Minimum Cycle Time at CAS $highestCAS (tCK min)",
+		       tns($ctime);
+		printl "Maximum Access Time at CAS $highestCAS (tAC)",
+		       tns(ddr2_sdram_atime($bytes->[10]));
 	}

 	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[23..24])) {
-		printl "Minimum Cycle Time (CAS ".($highestCAS-1).")",
-		       ddr2_sdram_ctime($bytes->[23]) . " ns";
-		printl "Maximum Access Time (CAS ".($highestCAS-1).")",
-		       ddr2_sdram_atime($bytes->[24]) . " ns";
+		printl "Minimum Cycle Time at CAS ".($highestCAS-1),
+		       tns(ddr2_sdram_ctime($bytes->[23]));
+		printl "Maximum Access Time at CAS ".($highestCAS-1),
+		       tns(ddr2_sdram_atime($bytes->[24]));
 	}

 	if (exists $cas{$highestCAS-2} && spd_written(@$bytes[25..26])) {
-		printl "Minimum Cycle Time (CAS ".($highestCAS-2).")",
-		       ddr2_sdram_ctime($bytes->[25]) . " ns";
-		printl "Maximum Access Time (CAS ".($highestCAS-2).")",
-		       ddr2_sdram_atime($bytes->[26]) . " ns";
+		printl "Minimum Cycle Time at CAS ".($highestCAS-2),
+		       tns(ddr2_sdram_ctime($bytes->[25]));
+		printl "Maximum Access Time at CAS ".($highestCAS-2),
+		       tns(ddr2_sdram_atime($bytes->[26]));
 	}
+	printl "Maximum Cycle Time (tCK max)",
+	       tns(ddr2_sdram_ctime($bytes->[43]));
+
+	# Some timing information
+	prints("Timing Parameters");
+	printl "Address/Command Setup Time Before Clock (tIS)",
+	       tns(ddr2_sdram_atime($bytes->[32]));
+	printl "Address/Command Hold Time After Clock (tIH)",
+	       tns(ddr2_sdram_atime($bytes->[33]));
+	printl "Data Input Setup Time Before Strobe (tDS)",
+	       tns(ddr2_sdram_atime($bytes->[34]));
+	printl "Data Input Hold Time After Strobe (tDH)",
+	       tns(ddr2_sdram_atime($bytes->[35]));
+	printl "Minimum Row Precharge Delay (tRP)", tns($trp);
+	printl "Minimum Row Active to Row Active Delay (tRRD)",
+	       tns($bytes->[28]/4);
+	printl "Minimum RAS# to CAS# Delay (tRCD)", tns($trcd);
+	printl "Minimum RAS# Pulse Width (tRAS)", tns($tras);
+	printl "Write Recovery Time (tWR)", tns($bytes->[36]/4);
+	printl "Minimum Write to Read CMD Delay (tWTR)", tns($bytes->[37]/4);
+	printl "Minimum Read to Pre-charge CMD Delay (tRTP)", tns($bytes->[38]/4);
+	printl "Minimum Active to Auto-refresh Delay (tRC)",
+	       tns(ddr2_sdram_rtime($bytes->[41], 0, ($bytes->[40] >> 4) & 7));
+	printl "Minimum Recovery Delay (tRFC)",
+	       tns(ddr2_sdram_rtime($bytes->[42], $bytes->[40] & 1,
+				    ($bytes->[40] >> 1) & 7));
+	printl "Maximum DQS to DQ Skew (tDQSQ)", tns($bytes->[44]/100);
+	printl "Maximum Read Data Hold Skew (tQHS)", tns($bytes->[45]/100);
+	printl "PLL Relock Time", $bytes->[46] . " us" if ($bytes->[46]);
 }

 # Parameter: bytes 0-63

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
