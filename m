From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/3] dt-bindings: i2c: i2c-gpio: Add support for named gpios
Date: Thu, 24 Aug 2017 11:21:12 +0200
Message-ID: <1503566474-5335-2-git-send-email-geert+renesas@glider.be>
References: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

The current i2c-gpio DT bindings use a single unnamed "gpios" property
to refer to the SDA and SCL signal lines by index.  This is error-prone
for the casual DT writer and reviewer, as one has to look up the order
in the DT bindings.

Fix this by amending the DT bindings to use two separate named gpios
properties, and deprecate the old unnamed variant.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
index 4f8ec947c6bd9cad..61033f73577dd70e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.txt
@@ -2,8 +2,9 @@ Device-Tree bindings for i2c gpio driver
 
 Required properties:
 	- compatible = "i2c-gpio";
-	- gpios: sda and scl gpio
-
+	- sda-gpios: gpio used for the sda signal
+	- scl-gpios: gpio used for the scl signal
+	- gpios: sda and scl gpio, alternative for {sda,scl}-gpios (deprecated)
 
 Optional properties:
 	- i2c-gpio,sda-open-drain: sda as open drain
-- 
2.7.4
