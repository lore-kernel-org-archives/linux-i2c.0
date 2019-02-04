From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts' optional
Date: Mon,  4 Feb 2019 15:15:49 -0800
Message-ID: <20190204231554.87666-4-ray.jui@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204231554.87666-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

In prep for the introduction of polling mode into the driver, update the
binding document to make the 'interrupts' property optional

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 81f982ccca31..d3a3620b1f06 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -9,9 +9,6 @@ Required properties:
     Define the base and range of the I/O address space that contain the iProc
     I2C controller registers
 
-- interrupts:
-    Should contain the I2C interrupt
-
 - clock-frequency:
     This is the I2C bus clock. Need to be either 100000 or 400000
 
@@ -21,6 +18,13 @@ Required properties:
 - #size-cells:
     Always 0
 
+Optional properties:
+
+- interrupts:
+    Should contain the I2C interrupt. If unspecified, driver will fall back to
+    polling mode
+
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1
