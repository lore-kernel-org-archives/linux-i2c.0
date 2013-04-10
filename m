From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/6] DDR3: Use fine time base
Date: Wed, 10 Apr 2013 22:20:47 +0200
Message-ID: <20130410222047.171e290f@endymion.delvare>
References: <20130410221330.213ca5be@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130410221330.213ca5be-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

DDR3: Decode the FTB fields of tCk, tAA, tRCD, tRP and tRC.
---
 eeprom/decode-dimms |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2013-04-10 14:12:37.739202969 +0200
+++ i2c-tools/eeprom/decode-dimms	2013-04-10 14:17:03.383357005 +0200
@@ -1329,6 +1329,17 @@ sub decode_ddr2_sdram($)
 	printl_cond($bytes->[46], "PLL Relock Time", $bytes->[46] . " us");
 }
 
+# Return combined time in ns
+sub ddr3_mtb_ftb($$$$)
+{
+	my ($byte1, $byte2, $mtb, $ftb) = @_;
+
+	# byte1 is unsigned in ns, but byte2 is signed in ps
+	$byte2 -= 0x100 if $byte2 & 0x80;
+
+	return $byte1 * $mtb + $byte2 * $ftb / 1000;
+}
+
 # Parameter: EEPROM bytes 0-127 (using 3-76)
 sub decode_ddr3_sdram($)
 {
@@ -1358,7 +1369,7 @@ sub decode_ddr3_sdram($)
 # speed
 	prints("Memory Characteristics");
 
-	$ctime = $bytes->[12] * $mtb;
+	$ctime = ddr3_mtb_ftb($bytes->[12], $bytes->[34], $mtb, $ftb);
 	my $ddrclk = 2 * (1000 / $ctime);
 	my $tbits = 1 << (($bytes->[8] & 7) + 3);
 	my $pcclk = int ($ddrclk * $tbits / 8);
@@ -1390,12 +1401,12 @@ sub decode_ddr3_sdram($)
 	my $trp;
 	my $tras;
 
-	$taa  = ceil($bytes->[16] / $bytes->[12]);
-	$trcd = ceil($bytes->[18] / $bytes->[12]);
-	$trp  = ceil($bytes->[20] / $bytes->[12]);
-	$tras = ceil(((($bytes->[21] & 0x0f) << 8) + $bytes->[22]) / $bytes->[12]);
+	$taa  = ddr3_mtb_ftb($bytes->[16], $bytes->[35], $mtb, $ftb);
+	$trcd = ddr3_mtb_ftb($bytes->[18], $bytes->[36], $mtb, $ftb);
+	$trp  = ddr3_mtb_ftb($bytes->[20], $bytes->[37], $mtb, $ftb);
+	$tras = ((($bytes->[21] & 0x0f) << 8) + $bytes->[22]) * $mtb;
 
-	printl("tCL-tRCD-tRP-tRAS", join("-", $taa, $trcd, $trp, $tras));
+	printl("tCL-tRCD-tRP-tRAS", ddr_core_timings(ceil($taa / $ctime), $ctime, $trcd, $trp, $tras));
 
 # latencies
 	my $highestCAS = 0;
@@ -1417,7 +1428,7 @@ sub decode_ddr3_sdram($)
 	printl("Minimum Row Active to Row Active Delay (tRRD)",
 		tns3($bytes->[19] * $mtb));
 	printl("Minimum Active to Auto-Refresh Delay (tRC)",
-		tns3((((($bytes->[21] >> 4) & 15) << 8) + $bytes->[23]) * $mtb));
+		tns3(ddr3_mtb_ftb((($bytes->[21] & 0xf0) << 4) + $bytes->[23], $bytes->[38], $mtb, $ftb)));
 	printl("Minimum Recovery Delay (tRFC)",
 		tns3((($bytes->[25] << 8) + $bytes->[24]) * $mtb));
 	printl("Minimum Write to Read CMD Delay (tWTR)",

-- 
Jean Delvare
