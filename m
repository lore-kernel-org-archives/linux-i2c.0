From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0018/1529] Fix typo
Date: Sat, 21 May 2016 13:37:47 +0200
Message-ID: <20160521113747.32214-1-andrea.gelmini@gelma.net>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36247 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbcEULhy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 21 May 2016 07:37:54 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, wsa@the-dreams.de, dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@hellion.org.uk, galak@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
index 89b3250..75dd5c2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-s3c2410.txt
@@ -22,7 +22,7 @@ Required for all cases except "samsung,s3c2440-hdmiphy-i2c":
     - gpios: The order of the gpios should be the following: <SDA, SCL>.
       The gpio specifier depends on the gpio controller. Required in all
       cases except for "samsung,s3c2440-hdmiphy-i2c" whose input/output
-      lines are permanently wired to the respective clienta
+      lines are permanently wired to the respective client
   - Pinctrl variant (preferred, if available):
     - pinctrl-0: Pin control group to be used for this controller.
     - pinctrl-names: Should contain only one value - "default".
-- 
2.8.2.534.g1f66975
