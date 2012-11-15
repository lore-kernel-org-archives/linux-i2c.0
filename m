From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/7] decode-dimms: Introduce helper function as_ddr
Date: Thu, 15 Nov 2012 12:50:22 +0100
Message-ID: <20121115125022.426b0c3a@endymion.delvare>
References: <20121115115231.341ac0c9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121115115231.341ac0c9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Introduce helper function as_ddr(), hopefully this makes the code a
little more readable. 
---
 eeprom/decode-dimms |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-11-15 10:52:06.000000000 +0100
+++ i2c-tools/eeprom/decode-dimms	2012-11-15 10:57:57.171530598 +0100
@@ -830,6 +830,14 @@ sub decode_sdr_sdram($)
 		    (($bytes->[35] >> 7) ? -$temp : $temp) . " ns");
 }
 
+sub as_ddr($$)
+{
+	my ($gen, $ctime) = @_;
+
+	return " as DDR" . ($gen == 1 ? "" : $gen) . "-" .
+	       int(2000 / $ctime);
+}
+
 sub ddr_core_timings($$$$$)
 {
 	my ($cas, $ctime, $trcd, $trp, $tras) = @_;
@@ -931,7 +939,7 @@ sub decode_ddr_sdram($)
 
 	if (exists $cas{$highestCAS}) {
 		$core_timings = ddr_core_timings($highestCAS, $ctime,
-			$trcd, $trp, $tras) . " as DDR-" . int(2000 / $ctime);
+			$trcd, $trp, $tras) . as_ddr(1, $ctime);
 
 		$cycle_time = "$ctime ns at CAS $highestCAS";
 		$access_time = (($bytes->[10] >> 4) * 0.1 + ($bytes->[10] & 0xf) * 0.01)
@@ -941,7 +949,7 @@ sub decode_ddr_sdram($)
 	if (exists $cas{$highestCAS-0.5} && spd_written(@$bytes[23..24])) {
 		$ctime1 = ($bytes->[23] >> 4) + ($bytes->[23] & 0xf) * 0.1;
 		$core_timings .= "\n".ddr_core_timings($highestCAS-0.5, $ctime1,
-			$trcd, $trp, $tras) . " as DDR-" . int(2000 / $ctime1);
+			$trcd, $trp, $tras) . as_ddr(1, $ctime1);
 
 		$cycle_time .= "\n$ctime1 ns at CAS ".($highestCAS-0.5);
 		$access_time .= "\n".(($bytes->[24] >> 4) * 0.1 + ($bytes->[24] & 0xf) * 0.01)
@@ -951,7 +959,7 @@ sub decode_ddr_sdram($)
 	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[25..26])) {
 		$ctime2 = ($bytes->[25] >> 4) + ($bytes->[25] & 0xf) * 0.1,
 		$core_timings .= "\n".ddr_core_timings($highestCAS-1, $ctime2,
-			$trcd, $trp, $tras) . " as DDR-" . int(2000 / $ctime2);
+			$trcd, $trp, $tras) . as_ddr(1, $ctime2);
 
 		$cycle_time .= "\n$ctime2 ns at CAS ".($highestCAS-1);
 		$access_time .= "\n".(($bytes->[26] >> 4) * 0.1 + ($bytes->[26] & 0xf) * 0.01)
@@ -984,7 +992,7 @@ sub decode_ddr_sdram($)
 		}
 
 		printl_cond($ctime >= $ctime_min && ($ctime_max < 1 || $ctime <= $ctime_max),
-			    "tCL-tRCD-tRP-tRAS as DDR-".int(2000 / $ctime),
+			    "tCL-tRCD-tRP-tRAS" . as_ddr(1, $ctime),
 			    ddr_core_timings($best_cas, $ctime,
 					     $trcd, $trp, $tras));
 	}
@@ -1182,7 +1190,7 @@ sub decode_ddr2_sdram($)
 
 	if (exists $cas{$highestCAS}) {
 		$core_timings = ddr_core_timings($highestCAS, $ctime,
-			$trcd, $trp, $tras) . " as DDR2-" . int(2000 / $ctime);
+			$trcd, $trp, $tras) . as_ddr(2, $ctime);
 
 		$cycle_time = tns($ctime) . " at CAS $highestCAS (tCK min)";
 		$access_time = tns(ddr2_sdram_atime($bytes->[10]))
@@ -1192,7 +1200,7 @@ sub decode_ddr2_sdram($)
 	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[23..24])) {
 		$ctime1 = ddr2_sdram_ctime($bytes->[23]);
 		$core_timings .= "\n".ddr_core_timings($highestCAS-1, $ctime1,
-			$trcd, $trp, $tras) . " as DDR2-" . int(2000 / $ctime1);
+			$trcd, $trp, $tras) . as_ddr(2, $ctime1);
 
 		$cycle_time .= "\n".tns($ctime1)
 			     . " at CAS ".($highestCAS-1);
@@ -1203,7 +1211,7 @@ sub decode_ddr2_sdram($)
 	if (exists $cas{$highestCAS-2} && spd_written(@$bytes[25..26])) {
 		$ctime2 = ddr2_sdram_ctime($bytes->[25]);
 		$core_timings .= "\n".ddr_core_timings($highestCAS-2, $ctime2,
-			$trcd, $trp, $tras) . " as DDR2-" . int(2000 / $ctime2);
+			$trcd, $trp, $tras) . as_ddr(2, $ctime2);
 
 		$cycle_time .= "\n".tns($ctime2)
 			     . " at CAS ".($highestCAS-2);
@@ -1236,7 +1244,7 @@ sub decode_ddr2_sdram($)
 		}
 
 		printl_cond($ctime >= $ctime_min && $ctime <= $ctime_max,
-			    "tCL-tRCD-tRP-tRAS as DDR2-".int(2000 / $ctime),
+			    "tCL-tRCD-tRP-tRAS" . as_ddr(2,$ctime),
 			    ddr_core_timings($best_cas, $ctime,
 					     $trcd, $trp, $tras));
 	}

-- 
Jean Delvare
