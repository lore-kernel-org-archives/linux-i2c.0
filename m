From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] decode-dimms: Default to merging cells in side-by-side
 output mode
Date: Mon, 22 Oct 2012 12:39:31 +0200
Message-ID: <20121022123931.42a1b76c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Default to merging cells in side-by-side output mode. Add an option to
revert to no cell merging.
---
 eeprom/decode-dimms |    9 +++++++++
 1 file changed, 9 insertions(+)

--- i2c-tools.orig/eeprom/decode-dimms	2012-10-22 11:26:16.531386765 +0200
+++ i2c-tools/eeprom/decode-dimms	2012-10-22 11:26:30.979391794 +0200
@@ -1696,6 +1696,8 @@ foreach (@ARGV) {
 			"                          (useful for postprocessing the output)\n",
 			"      --side-by-side      Display all DIMMs side-by-side if possible\n",
 			"      --merge-cells       Merge neighbour cells with identical values\n",
+			"                          (side-by-side output only, default)\n",
+			"      --no-merge-cells    Don't merge neighbour cells with identical values\n",
 			"                          (side-by-side output only)\n",
 			"  -c, --checksum          Decode completely even if checksum fails\n",
 			"  -x,                     Read data from hexdump files\n",
@@ -1729,6 +1731,10 @@ EOF
 		$opt_merge = 1;
 		next;
 	}
+	if ($_ eq '--no-merge-cells') {
+		$opt_merge = 0;
+		next;
+	}
 	if ($_ eq '-c' || $_ eq '--checksum') {
 		$opt_igncheck = 1;
 		next;
@@ -1750,6 +1756,9 @@ EOF
 	push @dimm, { eeprom => basename($_), file => $_ } if $use_hexdump;
 }
 
+# Default values
+$opt_merge = 1 unless defined $opt_merge;
+
 # From a sysfs device path and an attribute name, return the attribute
 # value, or undef (stolen from sensors-detect)
 sub sysfs_device_attribute


-- 
Jean Delvare
