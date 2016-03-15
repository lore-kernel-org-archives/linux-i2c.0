From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] i2c: sirf: Spelling s/propoerty/property/
Date: Tue, 15 Mar 2016 17:51:30 +0100
Message-ID: <1458060690-9738-4-git-send-email-geert+renesas@glider.be>
References: <1458060690-9738-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:33770 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbcCOQvd (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Mar 2016 12:51:33 -0400
In-Reply-To: <1458060690-9738-1-git-send-email-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/i2c/i2c-sirf.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sirf.txt b/Documentation/devicetree/bindings/i2c/i2c-sirf.txt
index 7baf9e133fa8670c..2701eefb00f77c9f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sirf.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sirf.txt
@@ -8,7 +8,7 @@ Required properties :
 
 Optional properties:
 - clock-frequency : Constains desired I2C/HS-I2C bus clock frequency in Hz.
-  The absence of the propoerty indicates the default frequency 100 kHz.
+  The absence of the property indicates the default frequency 100 kHz.
 
 Examples :
 
-- 
1.9.1
