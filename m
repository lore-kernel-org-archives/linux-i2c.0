From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
Date: Thu, 14 Feb 2019 09:57:23 -0800
Message-ID: <20190214175725.60462-7-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Update iProc I2C binding document to add new compatible string
"brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
also added that allows configuration of the host view into the APE's
address for "brcm,iproc-nic-i2c"

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 7a32bf81bfa9..d12cc33cca6c 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -3,7 +3,7 @@ Broadcom iProc I2C controller
 Required properties:
 
 - compatible:
-    Must be "brcm,iproc-i2c"
+    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
 
 - reg:
     Define the base and range of the I/O address space that contain the iProc
@@ -26,6 +26,10 @@ Optional properties:
     case, this property should be left unspecified, and driver will fall back
     to polling mode
 
+- brcm,ape-hsls-addr-mask:
+    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
+    'APE' co-processor. Value must be unsigned, 32-bit
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1
