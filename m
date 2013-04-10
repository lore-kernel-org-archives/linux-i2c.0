From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 5/6] DDR3: Repeat core timings as time values
Date: Wed, 10 Apr 2013 22:22:05 +0200
Message-ID: <20130410222205.7c08cb85@endymion.delvare>
References: <20130410221330.213ca5be@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130410221330.213ca5be-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

DDR3: Repeat tCK, tAA, tRCD, tRP and tRAS values, so that they show up
no only as cycle counts but also absolute time values.
---
 eeprom/decode-dimms |    5 +++++
 1 file changed, 5 insertions(+)

--- i2c-tools.orig/eeprom/decode-dimms	2013-04-10 15:42:32.755478921 +0200
+++ i2c-tools/eeprom/decode-dimms	2013-04-10 15:52:46.527793347 +0200
@@ -1424,9 +1424,14 @@ sub decode_ddr3_sdram($)
 # more timing information
 	prints("Timing Parameters");
 
+	printl("Minimum Cycle Time (tCK)", tns3($ctime));
+	printl("Minimum CAS Latency Time (tAA)", tns3($taa));
 	printl("Minimum Write Recovery time (tWR)", tns3($bytes->[17] * $mtb));
+	printl("Minimum RAS# to CAS# Delay (tRCD)", tns3($trcd));
 	printl("Minimum Row Active to Row Active Delay (tRRD)",
 		tns3($bytes->[19] * $mtb));
+	printl("Minimum Row Precharge Delay (tRP)", tns3($trp));
+	printl("Minimum Active to Precharge Delay (tRAS)", tns3($tras));
 	printl("Minimum Active to Auto-Refresh Delay (tRC)",
 		tns3(ddr3_mtb_ftb((($bytes->[21] & 0xf0) << 4) + $bytes->[23], $bytes->[38], $mtb, $ftb)));
 	printl("Minimum Recovery Delay (tRFC)",

-- 
Jean Delvare
