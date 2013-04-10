From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 6/6] DDR3: Print core timings at all supported standard
 speeds
Date: Wed, 10 Apr 2013 22:22:59 +0200
Message-ID: <20130410222259.297c503d@endymion.delvare>
References: <20130410221330.213ca5be@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130410221330.213ca5be-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Print timings at standard DDR3 speeds. This makes it easier to figure
out which memory modules will work well together.
---
 eeprom/decode-dimms |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Note : if anyone has SPD data for DDR3-1866 or DDR3-2133, please send
them to me so that I can test my code better.

--- i2c-tools.orig/eeprom/decode-dimms	2013-04-10 17:33:33.755706113 +0200
+++ i2c-tools/eeprom/decode-dimms	2013-04-10 21:53:08.674615604 +0200
@@ -1421,6 +1421,25 @@ sub decode_ddr3_sdram($)
 	}
 	printl("Supported CAS Latencies (tCL)", cas_latencies(keys %cas));
 
+# standard DDR3 speeds
+	prints("Timings at Standard Speeds");
+	foreach my $ctime_at_speed (7.5/8, 7.5/7, 1.25, 1.5, 1.875, 2.5) {
+		my $best_cas = $highestCAS;
+
+		# Find min CAS latency at this speed
+		for ($ii = 14; $ii >= 0; $ii--) {
+			next unless ($cas_sup & (1 << $ii));
+			if (ceil($taa / $ctime_at_speed) <= $ii + 4) {
+				$best_cas = $ii + 4;
+			}
+		}
+
+		printl_cond($ctime_at_speed >= $ctime,
+			    "tCL-tRCD-tRP-tRAS" . as_ddr(3, $ctime_at_speed),
+			    ddr_core_timings($best_cas, $ctime_at_speed,
+					     $trcd, $trp, $tras));
+	}
+
 # more timing information
 	prints("Timing Parameters");
 


-- 
Jean Delvare
