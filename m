From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 7/7] decode-dimms: Strip former manufacturer name in
 side-by-side mode
Date: Thu, 15 Nov 2012 12:59:21 +0100
Message-ID: <20121115125921.01795f05@endymion.delvare>
References: <20121115115231.341ac0c9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121115115231.341ac0c9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Strip former manufacturer name in side-by-side output mode, to avoid
overly large columns.
---
 eeprom/decode-dimms |    1 +
 1 file changed, 1 insertion(+)

--- i2c-tools.orig/eeprom/decode-dimms	2012-11-15 11:47:17.878976012 +0100
+++ i2c-tools/eeprom/decode-dimms	2012-11-15 11:47:19.684976039 +0100
@@ -342,6 +342,7 @@ sub manufacturer_ddr3($$)
 	return "Invalid" if parity($code) != 1;
 	return "Unknown" if ($code & 0x7F) - 1 > $vendors[$count & 0x7F];
 	$manufacturer = $vendors[$count & 0x7F][($code & 0x7F) - 1];
+	$manufacturer =~ s/ \(former .*\)$// if $opt_side_by_side;
 	$manufacturer .= "? (Invalid parity)" if parity($count) != 1;
 	return $manufacturer;
 }

-- 
Jean Delvare
