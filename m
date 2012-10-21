From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] decode-dimms: Print DDR core timings for all supported
 CAS values
Date: Sun, 21 Oct 2012 21:10:04 +0200
Message-ID: <20121021211004.2ea0a1ac@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Print DDR core timings for all supported CAS values.
---
 eeprom/decode-dimms |   39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-10-19 14:08:56.000000000 +0200
+++ i2c-tools/eeprom/decode-dimms	2012-10-19 15:19:46.620456787 +0200
@@ -830,6 +830,14 @@ sub decode_sdr_sdram($)
 		    (($bytes->[35] >> 7) ? -$temp : $temp) . " ns");
 }
 
+sub ddr_core_timings($$$$$)
+{
+	my ($cas, $ctime, $trcd, $trp, $tras) = @_;
+
+	return $cas . "-" . ceil($trcd/$ctime) . "-" . ceil($trp/$ctime) .
+		"-" . ceil($tras/$ctime) . " as DDR" . int(2000 / $ctime);
+}
+
 # Parameter: EEPROM bytes 0-127 (using 3-62)
 sub decode_ddr_sdram($)
 {
@@ -843,8 +851,8 @@ sub decode_ddr_sdram($)
 # speed
 	prints("Memory Characteristics");
 
-	$temp = ($bytes->[9] >> 4) + ($bytes->[9] & 0xf) * 0.1;
-	my $ddrclk = 2 * (1000 / $temp);
+	my $ctime = ($bytes->[9] >> 4) + ($bytes->[9] & 0xf) * 0.1;
+	my $ddrclk = 2 * (1000 / $ctime);
 	my $tbits = ($bytes->[7] * 256) + $bytes->[6];
 	if (($bytes->[11] == 2) || ($bytes->[11] == 1)) { $tbits = $tbits - 8; }
 	my $pcclk = int ($ddrclk * $tbits / 8);
@@ -893,18 +901,11 @@ sub decode_ddr_sdram($)
 	my $trcd;
 	my $trp;
 	my $tras;
-	my $ctime = ($bytes->[9] >> 4) + ($bytes->[9] & 0xf) * 0.1;
 
 	$trcd = ($bytes->[29] >> 2) + (($bytes->[29] & 3) * 0.25);
 	$trp = ($bytes->[27] >> 2) + (($bytes->[27] & 3) * 0.25);
 	$tras = $bytes->[30];
 
-	printl("tCL-tRCD-tRP-tRAS",
-		$highestCAS . "-" .
-		ceil($trcd/$ctime) . "-" .
-		ceil($trp/$ctime) . "-" .
-		ceil($tras/$ctime));
-
 # latencies
 	printl("Supported CAS Latencies", cas_latencies(keys %cas));
 
@@ -925,28 +926,38 @@ sub decode_ddr_sdram($)
 	printl("Supported WE Latencies", $temp);
 
 # timings
-	my ($cycle_time, $access_time);
+	my ($cycle_time, $access_time, $core_timings);
 
 	if (exists $cas{$highestCAS}) {
+		$core_timings = ddr_core_timings($highestCAS, $ctime,
+			$trcd, $trp, $tras);
+
 		$cycle_time = "$ctime ns at CAS $highestCAS";
 		$access_time = (($bytes->[10] >> 4) * 0.1 + ($bytes->[10] & 0xf) * 0.01)
 			     . " ns at CAS $highestCAS";
 	}
 
 	if (exists $cas{$highestCAS-0.5} && spd_written(@$bytes[23..24])) {
-		$cycle_time .= "\n".(($bytes->[23] >> 4) + ($bytes->[23] & 0xf) * 0.1)
-			     . " ns at CAS ".($highestCAS-0.5);
+		$ctime = ($bytes->[23] >> 4) + ($bytes->[23] & 0xf) * 0.1;
+		$core_timings .= "\n".ddr_core_timings($highestCAS-0.5, $ctime,
+			$trcd, $trp, $tras);
+
+		$cycle_time .= "\n$ctime ns at CAS ".($highestCAS-0.5);
 		$access_time .= "\n".(($bytes->[24] >> 4) * 0.1 + ($bytes->[24] & 0xf) * 0.01)
 			      . " ns at CAS ".($highestCAS-0.5);
 	}
 
 	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[25..26])) {
-		$cycle_time .= "\n".(($bytes->[25] >> 4) + ($bytes->[25] & 0xf) * 0.1)
-			     . " ns at CAS ".($highestCAS-1);
+		$ctime = ($bytes->[25] >> 4) + ($bytes->[25] & 0xf) * 0.1,
+		$core_timings .= "\n".ddr_core_timings($highestCAS-1, $ctime,
+			$trcd, $trp, $tras);
+
+		$cycle_time .= "\n$ctime ns at CAS ".($highestCAS-1);
 		$access_time .= "\n".(($bytes->[26] >> 4) * 0.1 + ($bytes->[26] & 0xf) * 0.01)
 			      . " ns at CAS ".($highestCAS-1);
 	}
 
+	printl_cond(defined $core_timings, "tCL-tRCD-tRP-tRAS", $core_timings);
 	printl_cond(defined $cycle_time, "Minimum Cycle Time", $cycle_time);
 	printl_cond(defined $access_time, "Maximum Access Time", $access_time);
 	printl_cond($bytes->[43] & 0xfc,


-- 
Jean Delvare
