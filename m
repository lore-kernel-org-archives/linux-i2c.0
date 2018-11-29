From: Jian Hu <jian.hu@amlogic.com>
Subject: [PATCH 1/2] dt-bindings: i2c: meson: add Meson G12A SoC i2c compatible string
Date: Thu, 29 Nov 2018 18:59:55 +0800
Message-ID: <1543489197-183181-2-git-send-email-jian.hu@amlogic.com>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Jianxin Pan <jianxin.pan@amlogic.com>, Hanjie Lin <hanjie.lin@amlogic.com>, linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Add Meson G12A SoC i2c controller compatible string

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
 Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
index 13d410d..795bc12 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -5,6 +5,7 @@ Required properties:
 	"amlogic,meson6-i2c" for Meson8 and compatible SoCs
 	"amlogic,meson-gxbb-i2c" for GXBB and compatible SoCs
 	"amlogic,meson-axg-i2c"for AXG and compatible SoCs
+	"amlogic,meson-g12a-i2c" for G12A and compatible SoCs
 
  - reg: physical address and length of the device registers
  - interrupts: a single interrupt specifier
-- 
1.9.1
