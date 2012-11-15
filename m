From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/7] decode-dimms: Delete ddr2_core_timings
Date: Thu, 15 Nov 2012 12:49:11 +0100
Message-ID: <20121115124911.0021df4f@endymion.delvare>
References: <20121115115231.341ac0c9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121115115231.341ac0c9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ddr2_core_timings is now the exact same function as ddr_core_timings
so delete the former and user the latter everywhere.
---
 eeprom/decode-dimms |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-11-15 09:59:02.000000000 +0100
+++ i2c-tools/eeprom/decode-dimms	2012-11-15 09:59:33.500544032 +0100
@@ -1091,14 +1091,6 @@ sub ddr2_refresh_rate($)
 	       ($byte & 0x80 ? " - Self Refresh" : "");
 }
 
-sub ddr2_core_timings($$$$$)
-{
-	my ($cas, $ctime, $trcd, $trp, $tras) = @_;
-
-	return $cas . "-" . ceil($trcd/$ctime) . "-" . ceil($trp/$ctime) .
-		"-" . ceil($tras/$ctime);
-}
-
 # Parameter: EEPROM bytes 0-127 (using 3-62)
 sub decode_ddr2_sdram($)
 {
@@ -1189,7 +1181,7 @@ sub decode_ddr2_sdram($)
 	my ($cycle_time, $access_time, $core_timings);
 
 	if (exists $cas{$highestCAS}) {
-		$core_timings = ddr2_core_timings($highestCAS, $ctime,
+		$core_timings = ddr_core_timings($highestCAS, $ctime,
 			$trcd, $trp, $tras) . " as DDR2-" . int(2000 / $ctime);
 
 		$cycle_time = tns($ctime) . " at CAS $highestCAS (tCK min)";
@@ -1199,7 +1191,7 @@ sub decode_ddr2_sdram($)
 
 	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[23..24])) {
 		$ctime1 = ddr2_sdram_ctime($bytes->[23]);
-		$core_timings .= "\n".ddr2_core_timings($highestCAS-1, $ctime1,
+		$core_timings .= "\n".ddr_core_timings($highestCAS-1, $ctime1,
 			$trcd, $trp, $tras) . " as DDR2-" . int(2000 / $ctime1);
 
 		$cycle_time .= "\n".tns($ctime1)
@@ -1210,7 +1202,7 @@ sub decode_ddr2_sdram($)
 
 	if (exists $cas{$highestCAS-2} && spd_written(@$bytes[25..26])) {
 		$ctime2 = ddr2_sdram_ctime($bytes->[25]);
-		$core_timings .= "\n".ddr2_core_timings($highestCAS-2, $ctime2,
+		$core_timings .= "\n".ddr_core_timings($highestCAS-2, $ctime2,
 			$trcd, $trp, $tras) . " as DDR2-" . int(2000 / $ctime2);
 
 		$cycle_time .= "\n".tns($ctime2)
@@ -1245,8 +1237,8 @@ sub decode_ddr2_sdram($)
 
 		printl_cond($ctime >= $ctime_min && $ctime <= $ctime_max,
 			    "tCL-tRCD-tRP-tRAS as DDR2-".int(2000 / $ctime),
-			    ddr2_core_timings($best_cas, $ctime,
-					      $trcd, $trp, $tras));
+			    ddr_core_timings($best_cas, $ctime,
+					     $trcd, $trp, $tras));
 	}
 
 # more timing information


-- 
Jean Delvare
