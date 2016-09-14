From: Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] dt-bindings: i2c-meson: add gxbb compatible string
Date: Wed, 14 Sep 2016 11:49:17 +0200
Message-ID: <1473846557-18123-3-git-send-email-jbrunet@baylibre.com>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473846557-18123-1-git-send-email-jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Signed-off-by: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Signed-off-by: Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
index 682f9a6f766e..386357d1aab0 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -1,7 +1,7 @@
 Amlogic Meson I2C controller
 
 Required properties:
- - compatible: must be "amlogic,meson6-i2c"
+ - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
  - reg: physical address and length of the device registers
  - interrupts: a single interrupt specifier
  - clocks: clock for the device
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
