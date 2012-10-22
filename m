From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/3] decode-dimms: Print only the DDR2 timings which were
 properly defined
Date: Mon, 22 Oct 2012 12:56:29 +0200
Message-ID: <20121022125629.3d328539@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Print only the DDR2 timings which were properly defined.
---
 eeprom/decode-dimms |   62 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 20 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-10-22 09:50:20.000000000 +0200
+++ i2c-tools/eeprom/decode-dimms	2012-10-22 10:22:53.744716447 +0200
@@ -1194,29 +1194,51 @@ sub decode_ddr2_sdram($)
 
 # more timing information
 	prints("Timing Parameters");
-	printl("Address/Command Setup Time Before Clock (tIS)",
-	       tns(ddr2_sdram_atime($bytes->[32])));
-	printl("Address/Command Hold Time After Clock (tIH)",
-	       tns(ddr2_sdram_atime($bytes->[33])));
-	printl("Data Input Setup Time Before Strobe (tDS)",
-	       tns(ddr2_sdram_atime($bytes->[34])));
-	printl("Data Input Hold Time After Strobe (tDH)",
-	       tns(ddr2_sdram_atime($bytes->[35])));
+	# According to the JEDEC standard, the four timings below can't be less
+	# than 0.1 ns, however we've seen memory modules code such values so
+	# handle them properly.
+	printl_cond($bytes->[32] && $bytes->[32] != 0xff,
+		    "Address/Command Setup Time Before Clock (tIS)",
+		    tns(ddr2_sdram_atime($bytes->[32])));
+	printl_cond($bytes->[33] && $bytes->[33] != 0xff,
+		    "Address/Command Hold Time After Clock (tIH)",
+		    tns(ddr2_sdram_atime($bytes->[33])));
+	printl_cond($bytes->[34] && $bytes->[34] != 0xff,
+		    "Data Input Setup Time Before Strobe (tDS)",
+		    tns(ddr2_sdram_atime($bytes->[34])));
+	printl_cond($bytes->[35] && $bytes->[35] != 0xff,
+		    "Data Input Hold Time After Strobe (tDH)",
+		    tns(ddr2_sdram_atime($bytes->[35])));
+
 	printl("Minimum Row Precharge Delay (tRP)", tns($trp));
-	printl("Minimum Row Active to Row Active Delay (tRRD)",
-	       tns($bytes->[28]/4));
+	printl_cond($bytes->[28] & 0xfc,
+		    "Minimum Row Active to Row Active Delay (tRRD)",
+		    tns($bytes->[28]/4));
 	printl("Minimum RAS# to CAS# Delay (tRCD)", tns($trcd));
 	printl("Minimum RAS# Pulse Width (tRAS)", tns($tras));
-	printl("Write Recovery Time (tWR)", tns($bytes->[36]/4));
-	printl("Minimum Write to Read CMD Delay (tWTR)", tns($bytes->[37]/4));
-	printl("Minimum Read to Pre-charge CMD Delay (tRTP)", tns($bytes->[38]/4));
-	printl("Minimum Active to Auto-refresh Delay (tRC)",
-	       tns(ddr2_sdram_rtime($bytes->[41], 0, ($bytes->[40] >> 4) & 7)));
-	printl("Minimum Recovery Delay (tRFC)",
-	       tns(ddr2_sdram_rtime($bytes->[42], $bytes->[40] & 1,
-				    ($bytes->[40] >> 1) & 7)));
-	printl("Maximum DQS to DQ Skew (tDQSQ)", tns($bytes->[44]/100));
-	printl("Maximum Read Data Hold Skew (tQHS)", tns($bytes->[45]/100));
+	printl_cond($bytes->[36] & 0xfc,
+		    "Write Recovery Time (tWR)",
+		    tns($bytes->[36]/4));
+	printl_cond($bytes->[37] & 0xfc,
+		    "Minimum Write to Read CMD Delay (tWTR)",
+		    tns($bytes->[37]/4));
+	printl_cond($bytes->[38] & 0xfc,
+		    "Minimum Read to Pre-charge CMD Delay (tRTP)",
+		    tns($bytes->[38]/4));
+
+	printl_cond($bytes->[41] && $bytes->[41] != 0xff,
+		    "Minimum Active to Auto-refresh Delay (tRC)",
+		    tns(ddr2_sdram_rtime($bytes->[41], 0,
+					 ($bytes->[40] >> 4) & 7)));
+	printl_cond($bytes->[42],
+		    "Minimum Recovery Delay (tRFC)",
+		    tns(ddr2_sdram_rtime($bytes->[42], $bytes->[40] & 1,
+					 ($bytes->[40] >> 1) & 7)));
+
+	printl_cond($bytes->[44], "Maximum DQS to DQ Skew (tDQSQ)",
+		    tns($bytes->[44]/100));
+	printl_cond($bytes->[45], "Maximum Read Data Hold Skew (tQHS)",
+		    tns($bytes->[45]/100));
 	printl_cond($bytes->[46], "PLL Relock Time", $bytes->[46] . " us");
 }
 


-- 
Jean Delvare
