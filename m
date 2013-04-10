From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/6] DDR3: Fix tRAS value
Date: Wed, 10 Apr 2013 22:17:40 +0200
Message-ID: <20130410221740.182105ce@endymion.delvare>
References: <20130410221330.213ca5be@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130410221330.213ca5be-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

DDR3: Use the right nibble from byte 21 as the MSB of tRAS.
---
 eeprom/decode-dimms |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- i2c-tools.orig/eeprom/decode-dimms	2013-04-10 14:09:02.415218409 +0200
+++ i2c-tools/eeprom/decode-dimms	2013-04-10 14:11:18.839376112 +0200
@@ -1393,7 +1393,7 @@ sub decode_ddr3_sdram($)
 	$taa  = int($bytes->[16] / $bytes->[12]);
 	$trcd = int($bytes->[18] / $bytes->[12]);
 	$trp  = int($bytes->[20] / $bytes->[12]);
-	$tras = int((($bytes->[21] >> 4) * 256 + $bytes->[22]) / $bytes->[12]);
+	$tras = int(((($bytes->[21] & 0x0f) << 8) + $bytes->[22]) / $bytes->[12]);
 
 	printl("tCL-tRCD-tRP-tRAS", join("-", $taa, $trcd, $trp, $tras));
 

-- 
Jean Delvare
