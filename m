From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/3] decode-dimms: Print DDR2 equivalent speed of tCK max
Date: Mon, 22 Oct 2012 13:39:43 +0200
Message-ID: <20121022133943.28b14338@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Print DDR2 equivalent speed of tCK max.
---
 eeprom/decode-dimms |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-10-22 12:39:45.000000000 +0200
+++ i2c-tools/eeprom/decode-dimms	2012-10-22 12:42:11.723525497 +0200
@@ -1186,9 +1186,11 @@ sub decode_ddr2_sdram($)
 
 	printl_cond(defined $cycle_time, "Minimum Cycle Time", $cycle_time);
 	printl_cond(defined $access_time, "Maximum Access Time", $access_time);
-
-	printl("Maximum Cycle Time (tCK max)",
-	       tns(ddr2_sdram_ctime($bytes->[43])));
+	$temp = ddr2_sdram_ctime($bytes->[43]);
+	printl_cond(($bytes->[43] & 0xf0) && $bytes->[43] != 0xff,
+		    "Maximum Cycle Time (tCK max)",
+		    $temp == 0 ? "" : # Can't happen, prevent div by 0
+		    tns($temp)." (DDR2-".int(2000 / $temp).")");
 
 # more timing information
 	prints("Timing Parameters");


-- 
Jean Delvare
