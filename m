From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 6/7] decode-dimms: Bad manufacturer page count parity is not
 fatal
Date: Thu, 15 Nov 2012 12:58:29 +0100
Message-ID: <20121115125829.28b2580e@endymion.delvare>
References: <20121115115231.341ac0c9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121115115231.341ac0c9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If DDR3 manufacturer page count parity is wrong, still print the
manufacturer name (if valid) but add a question mark.
---
 eeprom/decode-dimms |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-11-15 11:45:52.020974740 +0100
+++ i2c-tools/eeprom/decode-dimms	2012-11-15 11:47:17.878976012 +0100
@@ -337,10 +337,13 @@ sub parity($)
 sub manufacturer_ddr3($$)
 {
 	my ($count, $code) = @_;
-	return "Invalid" if parity($count) != 1;
+	my $manufacturer;
+
 	return "Invalid" if parity($code) != 1;
-	return (($code & 0x7F) - 1 > $vendors[$count & 0x7F]) ? "Unknown" :
-		$vendors[$count & 0x7F][($code & 0x7F) - 1];
+	return "Unknown" if ($code & 0x7F) - 1 > $vendors[$count & 0x7F];
+	$manufacturer = $vendors[$count & 0x7F][($code & 0x7F) - 1];
+	$manufacturer .= "? (Invalid parity)" if parity($count) != 1;
+	return $manufacturer;
 }
 
 sub manufacturer(@)

-- 
Jean Delvare
