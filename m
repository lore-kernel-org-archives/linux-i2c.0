From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH i2c-tools] decode-dimms: Complete check for out-of-bounds
 vendor ID
Date: Mon, 1 Jun 2015 08:38:33 +0200
Message-ID: <20150601083833.0ea3e5e1@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We also need to discard vendor ID 0 and to report "Unknown" if the
vendor is in a page we don't support yet.
---
Lubomir, this goes on top of your (modified) patch. Does it look good
to you? Thanks.

 eeprom/decode-dimms |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2015-06-01 08:19:59.292190666 +0200
+++ i2c-tools/eeprom/decode-dimms	2015-06-01 08:35:31.806092421 +0200
@@ -344,8 +344,10 @@ sub manufacturer_ddr3($$)
 	my ($count, $code) = @_;
 	my $manufacturer;
 
-	return "Invalid" if parity($code) != 1;
-	return "Unknown" if ($code & 0x7F) - 1 >= @{$vendors[$count & 0x7F]};
+	return "Invalid" if parity($code) != 1
+			 or ($code & 0x7F) == 0;
+	return "Unknown" if ($count & 0x7F) >= @vendors
+			 or ($code & 0x7F) - 1 >= @{$vendors[$count & 0x7F]};
 	$manufacturer = $vendors[$count & 0x7F][($code & 0x7F) - 1];
 	$manufacturer =~ s/ \(former .*\)$// if $opt_side_by_side;
 	$manufacturer .= "? (Invalid parity)" if parity($count) != 1;


-- 
Jean Delvare
SUSE L3 Support
