From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [trivial] dt-bindings: i2c: i2c-mux: Spelling s/required is/required if/
Date: Thu, 21 Sep 2017 14:52:29 +0200
Message-ID: <1505998349-10091-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/i2c/i2c-mux.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux.txt b/Documentation/devicetree/bindings/i2c/i2c-mux.txt
index 212e6779dc5c0caf..b38f58a1c8784184 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux.txt
@@ -6,10 +6,10 @@ multiplexer/switch will have one child node for each child bus.
 
 Optional properties:
 - #address-cells = <1>;
-   This property is required is the i2c-mux child node does not exist.
+   This property is required if the i2c-mux child node does not exist.
 
 - #size-cells = <0>;
-   This property is required is the i2c-mux child node does not exist.
+   This property is required if the i2c-mux child node does not exist.
 
 - i2c-mux
    For i2c multiplexers/switches that have child nodes that are a mixture
-- 
2.7.4
