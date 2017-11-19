From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 4/6] decode-dimms: Decode physical characteristics of DDR4
Date: Sun, 19 Nov 2017 13:35:22 +0100
Message-ID: <20171119133522.1f2046af@endymion>
References: <20171119133309.67d4c596@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750865AbdKSMfY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 19 Nov 2017 07:35:24 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07216AAB9
        for <linux-i2c@vger.kernel.org>; Sun, 19 Nov 2017 12:35:23 +0000 (UTC)
In-Reply-To: <20171119133309.67d4c596@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>

Print the physical characteristics of unbuffered, registered and
load-reduced DDR4 SDRAM modules.
---
 eeprom/decode-dimms |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- i2c-tools.orig/eeprom/decode-dimms	2017-11-17 11:25:15.453970328 +0100
+++ i2c-tools/eeprom/decode-dimms	2017-11-17 11:27:11.401380668 +0100
@@ -1404,6 +1404,7 @@ sub ddr3_mtb_ftb($$$$)
 	return $byte1 * $mtb + $byte2 * $ftb / 1000;
 }
 
+# Also works for DDR4
 sub ddr3_reference_card($$)
 {
 	my ($rrc, $ext) = @_;
@@ -1727,7 +1728,7 @@ use constant DDR4_UNBUFFERED	=> 1;
 use constant DDR4_REGISTERED	=> 2;
 use constant DDR4_LOAD_REDUCED	=> 4;
 
-# Parameter: EEPROM bytes 0-383 (using 1-125)
+# Parameter: EEPROM bytes 0-383 (using 1-130)
 sub decode_ddr4_sdram($)
 {
 	my $bytes = shift;
@@ -1915,6 +1916,25 @@ sub decode_ddr4_sdram($)
 
 	printl("Thermal Sensor",
 	       $bytes->[14] & 0x80 ? "TSE2004 compliant" : "No");
+
+# type-specific settings
+	if ($module_types[$bytes->[3] & 0x0f]->{family} == DDR4_UNBUFFERED ||
+	    $module_types[$bytes->[3] & 0x0f]->{family} == DDR4_REGISTERED ||
+	    $module_types[$bytes->[3] & 0x0f]->{family} == DDR4_LOAD_REDUCED) {
+		prints("Physical Characteristics");
+
+		my $height = $bytes->[128] & 0x1f;
+		printl("Module Height",
+		       $height == 0x00 ? "15 mm or less" :
+		       $height == 0x1f ? "more than 45 mm" :
+		       sprintf("%u mm", $height + 15));
+		printl("Module Thickness",
+		       sprintf("%d mm front, %d mm back",
+			       ($bytes->[129] & 0x0f) + 1,
+			       (($bytes->[129] >> 4) & 15) + 1));
+		printl("Module Reference Card",
+		       ddr3_reference_card($bytes->[130], $bytes->[128]));
+	}
 }
 
 # Parameter: EEPROM bytes 0-127 (using 4-5)

-- 
Jean Delvare
SUSE L3 Support
