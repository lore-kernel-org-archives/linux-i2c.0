From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/9] dt-bindings: i2c: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:45 +0200
Message-ID: <20180506112404.24872-2-wsa+renesas@sang-engineering.com>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c-davinci.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
index 64e6e656c345c2..b745f3706120f0 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
@@ -24,7 +24,7 @@ Recommended properties :
 - clock-frequency : desired I2C bus clock frequency in Hz.
 - ti,has-pfunc: boolean; if defined, it indicates that SoC supports PFUNC
 	registers. PFUNC registers allow to switch I2C pins to function as
-	GPIOs, so they can by toggled manually.
+	GPIOs, so they can be toggled manually.
 
 Example (enbw_cmc board):
 	i2c@1c22000 {
-- 
2.11.0
