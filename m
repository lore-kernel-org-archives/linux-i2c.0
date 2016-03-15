From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] i2c: imx: Spelling s/propoerty/property/
Date: Tue, 15 Mar 2016 17:51:28 +0100
Message-ID: <1458060690-9738-2-git-send-email-geert+renesas@glider.be>
References: <1458060690-9738-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:52060 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbcCOQvf (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Mar 2016 12:51:35 -0400
In-Reply-To: <1458060690-9738-1-git-send-email-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
index eab5836ba7f98a10..b967544590e804c4 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
@@ -11,7 +11,7 @@ Required properties:
 
 Optional properties:
 - clock-frequency : Constains desired I2C/HS-I2C bus clock frequency in Hz.
-  The absence of the propoerty indicates the default frequency 100 kHz.
+  The absence of the property indicates the default frequency 100 kHz.
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
 - scl-gpios: specify the gpio related to SCL pin
-- 
1.9.1
