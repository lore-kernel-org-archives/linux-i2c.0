From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 5/5] dt-bindings: at24: add bindings for Rohm BR24T01
Date: Mon, 29 Jan 2018 16:45:48 +0100
Message-ID: <1517240748-14780-6-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1517240748-14780-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38833 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeA2PqO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 29 Jan 2018 10:46:14 -0500
In-Reply-To: <1517240748-14780-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, geert@linux-m68k.org, kieran.bingham@ideasonboard.com
Cc: wsa@the-dreams.de, magnus.damm@gmail.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Both manufacturer and name variant.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 1812c84..dd29937 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -40,6 +40,7 @@ Required properties:
                 "microchip",
                 "ramtron",
                 "renesas",
+                "rohm",
                 "nxp",
                 "st",
 
@@ -47,6 +48,7 @@ Required properties:
                 variants of the above. Known such exceptions are listed below:
 
                 "renesas,r1ex24002" - the fallback is "atmel,24c02"
+                "rohm,br24t01" - the fallback is "atmel,24c01"
 
   - reg: The I2C address of the EEPROM.
 
-- 
2.7.4
