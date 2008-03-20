From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] More DDR2 data for decode-dimms.pl
Date: Wed, 19 Mar 2008 18:36:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0803191731500.16142@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0802281401020.14140@shell4.speakeasy.net>
	<20080319141609.338c19b1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080319141609.338c19b1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Wed, 19 Mar 2008, Jean Delvare wrote:
> I don't understand the point of the first parameter ($t). The function
> is always called with $t = 2. If you ever needed to ignore $b2, rather
> than calling this function with $t = 1, you could simply pass $b2 = 0.
> Or even better, you wouldn't call ddrx_sdram_rtime() at all, as it
> would return $b1 directly.

The idea was to use the same function for ddr1 and ddr2, hence the name,
with $t the type to use.  But the specs are different enought that it is
probably a bad idea.

> > +	my @volts = ("TTL/5V Tolerant", "LVTTL", "HSTL 1.5V",
> > +		     "SSTL 3.3V", "SSTL 2.5V", "SSTL 1.8V", "TBD");
> > +	printl "Voltage Interface Level", $volts[$bytes->[8]];
>
> Not sure what sense it makes to have "TBD" in the list. Presumably all
> the values above 6 are "to be defined", not just 6.

The spec, http://www.jedec.org/download/search/4_01_02_10R14.pdf
On page 10, they only list 0-6, with 6 as TBD.  I thought maybe they
intended to use 6 for something but hadn't decided on the voltage at the
time the spec was written, while the rest were intended to be undefined.
The spec uses "undefined", "reserved", "TBD", and "-" in various places and
not clear what they mean exactly.

> > +	printl "Minimum Active to Auto-refresh Delay (tRC)",
> > +	       tns(ddrx_sdram_rtime(2, $bytes->[41], ($bytes->[40]>>3)&0xe));
> > +	printl "Minimum Recovery Delay (tRFC)",
> > +	       tns(ddrx_sdram_rtime(2, $bytes->[42], $bytes->[40]));
>
> As far as I can see, the masking isn't needed, as you do it again in
> ddrx_sdram_rtime(). That being said, it would probably make sense to do
> all the shifting and masking on the caller's side. Doing half of the
> shifting outside and the other half inside the function is pretty
> confusing.

This is better?

        printl "Minimum Active to Auto-refresh Delay (tRC)",
               tns(ddr2_sdram_rtime($bytes->[41], ($bytes->[40] >> 4) & 7));
        printl "Minimum Recovery Delay (tRFC)",
               tns(ddr2_sdram_rtime($bytes->[42] + ($bytes->[40] & 1) * 256,
	                            ($bytes->[40] >> 1) & 7));

I was trying to do as much as possible on the callee's side.

---
This lets decode-dimms.pl decode almost all of the SPD data for DDR2 dimms.
Including all the detailed timing parameters with their standard tXXX
names, useful if one is trying to program a DDR memory controller for
example.

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
@@ -834,6 +839,39 @@
 	return $atime;
 }

+sub ddr2_sdram_rtime($$)
+{
+	my ($rtime, $ext) = @_;
+	my @table = (0, .25, .33, .50, .66, .75);
+
+	return $time + $table[$ext];
+}
+
+sub ddr2_module_types($)
+{
+	my $byte = shift;
+	my @types = qw(RDIMM UDIMM SO-DIMM Micro-DIMM Mini-RDIMM Mini-UDIMM);
+	my @widths = (133.35, 133.25, 67.6, 45.5, 82.0, 82.0);
+	my @suptypes;
+
+	foreach $ii (0..5) {
+		push @suptypes, "$types[$ii] ($widths[$ii] mm)"
+			if($byte & (1 << $ii));
+	}
+
+	return @subtypes;
+}
+
+sub ddr2_refresh_rate($)
+{
+	my $bytes = shift;
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
@@ -875,6 +913,31 @@
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
+	printl "Supported Burst Lengths", join(', ', @burst);
+
 	my $highestCAS = 0;
 	my %cas;
 	for ($ii = 2; $ii < 7; $ii++) {
@@ -899,31 +962,60 @@
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
+	       tns(ddr2_sdram_rtime($bytes->[41], ($bytes->[40] >> 4) & 7));
+	printl "Minimum Recovery Delay (tRFC)",
+	       tns(ddr2_sdram_rtime($bytes->[42] + ($bytes->[40] & 1) * 256,
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
