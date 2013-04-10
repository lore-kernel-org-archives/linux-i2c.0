From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/6] DDR3: Store time bases, don't print them
Date: Wed, 10 Apr 2013 22:19:16 +0200
Message-ID: <20130410221916.68177bc1@endymion.delvare>
References: <20130410221330.213ca5be@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130410221330.213ca5be-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

DDR3: Don't print the medium and fine time bases, they aren't directly
useful to the user. Simply store them for later use.
---
 eeprom/decode-dimms |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2013-04-10 14:30:19.753833437 +0200
+++ i2c-tools/eeprom/decode-dimms	2013-04-10 15:37:24.481817216 +0200
@@ -1335,6 +1335,7 @@ sub decode_ddr3_sdram($)
 	my $bytes = shift;
 	my $temp;
 	my $ctime;
+	my ($ftb, $mtb);
 
 	my @module_types = ("Undefined", "RDIMM", "UDIMM", "SO-DIMM",
 			    "Micro-DIMM", "Mini-RDIMM", "Mini-UDIMM",
@@ -1346,18 +1347,17 @@ sub decode_ddr3_sdram($)
 					$module_types[$bytes->[3]] :
 					sprintf("Reserved (0x%.2X)", $bytes->[3]));
 
+# time bases
+	if (($bytes->[9] & 0x0f) == 0 || $bytes->[11] == 0) {
+		print STDERR "Invalid time base divisor, can't decode\n";
+		return;
+	}
+	$ftb = ($bytes->[9] >> 4) / ($bytes->[9] & 0x0f);
+	$mtb = $bytes->[10] / $bytes->[11];
+
 # speed
 	prints("Memory Characteristics");
 
-	my $dividend = ($bytes->[9] >> 4) & 15;
-	my $divisor  = $bytes->[9] & 15;
-	printl("Fine time base", sprintf("%.3f", $dividend / $divisor) . " ps");
-
-	$dividend = $bytes->[10];
-	$divisor  = $bytes->[11];
-	my $mtb = $dividend / $divisor;
-	printl("Medium time base", tns3($mtb));
-
 	$ctime = $bytes->[12] * $mtb;
 	my $ddrclk = 2 * (1000 / $ctime);
 	my $tbits = 1 << (($bytes->[8] & 7) + 3);

-- 
Jean Delvare
