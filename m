From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] i2c: rcar: Spelling s/propoerty/property/
Date: Tue, 15 Mar 2016 17:51:29 +0100
Message-ID: <1458060690-9738-3-git-send-email-geert+renesas@glider.be>
References: <1458060690-9738-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:33769 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbcCOQvd (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Mar 2016 12:51:33 -0400
In-Reply-To: <1458060690-9738-1-git-send-email-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index 95e97223a71c8300..cf8bfc956cdcea64 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -17,7 +17,7 @@ Required properties:
 
 Optional properties:
 - clock-frequency: desired I2C bus clock frequency in Hz. The absence of this
-  propoerty indicates the default frequency 100 kHz.
+  property indicates the default frequency 100 kHz.
 - clocks: clock specifier.
 
 - i2c-scl-falling-time-ns: see i2c.txt
-- 
1.9.1
