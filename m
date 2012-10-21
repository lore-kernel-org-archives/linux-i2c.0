From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] decode-dimms: Print extra timing values for DDR SDRAM
Date: Sun, 21 Oct 2012 21:08:25 +0200
Message-ID: <20121021210825.7b4812ba@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Print extra timing values for DDR memory modules as we do for DDR2
memory modules.
---
 eeprom/decode-dimms |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-10-20 13:28:11.000000000 +0200
+++ i2c-tools/eeprom/decode-dimms	2012-10-20 13:31:05.899876006 +0200
@@ -536,7 +536,12 @@ sub prints($) # print separator w/ given
 
 # Helper functions
 
-sub tns($) # print a time in ns
+sub tns1($) # print a time in ns, with 1 decimal digit
+{
+	return sprintf("%.1f ns", $_[0]);
+}
+
+sub tns($) # print a time in ns, with 2 decimal digits
 {
 	return sprintf("%3.2f ns", $_[0]);
 }
@@ -944,8 +949,48 @@ sub decode_ddr_sdram($)
 
 	printl_cond(defined $cycle_time, "Minimum Cycle Time", $cycle_time);
 	printl_cond(defined $access_time, "Maximum Access Time", $access_time);
+	printl_cond($bytes->[43] & 0xfc,
+		    "Maximum Cycle Time (tCK max)",
+		    $bytes->[43] == 0xff ? "No minimum frequency" :
+		    $bytes->[43] == 0x00 ? "" : # Can't happen, prevent div by 0
+		    tns1($bytes->[43]/4)." (DDR".int(8000 / $bytes->[43]).")");
+
+
+# more timing information
+	prints("Timing Parameters");
+	printl_cond($bytes->[32] != 0xff,
+		    "Address/Command Setup Time Before Clock",
+		    tns(ddr2_sdram_atime($bytes->[32])));
+	printl_cond($bytes->[33] != 0xff,
+		    "Address/Command Hold Time After Clock",
+		    tns(ddr2_sdram_atime($bytes->[33])));
+	printl_cond($bytes->[34] != 0xff,
+		    "Data Input Setup Time Before Clock",
+		    tns(ddr2_sdram_atime($bytes->[34])));
+	printl_cond($bytes->[35] != 0xff,
+		    "Data Input Hold Time After Clock",
+		    tns(ddr2_sdram_atime($bytes->[35])));
+	printl("Minimum Row Precharge Delay (tRP)", tns($trp));
+	printl_cond($bytes->[28] & 0xfc,
+		    "Minimum Row Active to Row Active Delay (tRRD)",
+		    tns($bytes->[28]/4));
+	printl("Minimum RAS# to CAS# Delay (tRCD)", tns($trcd));
+	printl("Minimum RAS# Pulse Width (tRAS)", tns($tras));
+	printl_cond($bytes->[41] && $bytes->[41] != 0xff,
+		    "Minimum Active to Active/AR Time (tRC)",
+		    tns($bytes->[41]));
+	printl_cond($bytes->[42],
+		    "Minimum AR to Active/AR Command Period (tRFC)",
+		    tns($bytes->[42]));
+	printl_cond($bytes->[44],
+		    "Maximum DQS to DQ Skew (tDQSQ)",
+		    tns($bytes->[44]/100));
+	printl_cond(($bytes->[45] & 0xf0) && $bytes->[45] != 0xff,
+		    "Maximum Read Data Hold Skew (tQHS)",
+		    tns(ddr2_sdram_atime($bytes->[45])));
 
 # module attributes
+	prints("Module Attributes");
 	if (($bytes->[47] & 0x03) == 0x01) { $temp = "1.125\" to 1.25\""; }
 	elsif (($bytes->[47] & 0x03) == 0x02) { $temp = "1.7\""; }
 	else { $temp = "Other"; }


-- 
Jean Delvare
