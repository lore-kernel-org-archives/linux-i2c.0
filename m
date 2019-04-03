From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v6 4/9] dt-bindings: i2c: iproc: make 'interrupts' optional
Date: Tue,  2 Apr 2019 18:18:25 -0700
Message-ID: <20190403011830.3254-5-ray.jui@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403011830.3254-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Update the binding document to make the 'interrupts' property optional.
For certain revisions of the I2C controller (e.g., iProc NIC I2C), I2C
interrupt is unwired to the interrupt controller. In such case, this
'interrupts' property should be left unspecified, and driver will fall
back to polling mode

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/brcm,iproc-i2c.txt        | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 81f982ccca31..7a32bf81bfa9 100644
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
 
@@ -21,6 +18,14 @@ Required properties:
 - #size-cells:
     Always 0
 
+Optional properties:
+
+- interrupts:
+    Should contain the I2C interrupt. For certain revisions of the I2C
+    controller, I2C interrupt is unwired to the interrupt controller. In such
+    case, this property should be left unspecified, and driver will fall back
+    to polling mode
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1
