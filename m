From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH v2 1/5] dt-bindings: i2c: update documentation for the Meson-AXG
Date: Mon, 20 Nov 2017 22:54:11 +0800
Message-ID: <20171120145415.6581-2-yixun.lan@amlogic.com>
References: <20171120145415.6581-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:47234 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdKTOyy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 20 Nov 2017 09:54:54 -0500
In-Reply-To: <20171120145415.6581-1-yixun.lan@amlogic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Yixun Lan <yixun.lan@amlogic.com>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

From: Jian Hu <jian.hu@amlogic.com>

Update the doc to explicitly add Meson-AXG to support list

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
index 611b934c7e10..13d410de077c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -1,7 +1,11 @@
 Amlogic Meson I2C controller
 
 Required properties:
- - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
+ - compatible: must be:
+	"amlogic,meson6-i2c" for Meson8 and compatible SoCs
+	"amlogic,meson-gxbb-i2c" for GXBB and compatible SoCs
+	"amlogic,meson-axg-i2c"for AXG and compatible SoCs
+
  - reg: physical address and length of the device registers
  - interrupts: a single interrupt specifier
  - clocks: clock for the device
-- 
2.15.0
