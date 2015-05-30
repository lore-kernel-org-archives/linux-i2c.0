From: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Subject: [PATCH i2c-tools] decode-dimms: correctly check for out-of-bounds vendor id
Date: Sat, 30 May 2015 13:03:32 +0200
Message-ID: <1432983812-7975-1-git-send-email-lkundrak@v3.sk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

---
 eeprom/decode-dimms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/eeprom/decode-dimms b/eeprom/decode-dimms
index 3a50c07..4a861bd 100755
--- a/eeprom/decode-dimms
+++ b/eeprom/decode-dimms
@@ -345,7 +345,7 @@ sub manufacturer_ddr3($$)
 	my $manufacturer;
 
 	return "Invalid" if parity($code) != 1;
-	return "Unknown" if ($code & 0x7F) - 1 > $vendors[$count & 0x7F];
+	return "Unknown" if ($code & 0x7F) > @{$vendors[$count & 0x7F]};
 	$manufacturer = $vendors[$count & 0x7F][($code & 0x7F) - 1];
 	$manufacturer =~ s/ \(former .*\)$// if $opt_side_by_side;
 	$manufacturer .= "? (Invalid parity)" if parity($count) != 1;
-- 
2.4.0
