From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v4 4/5] dt: bindings: i2c-mux-pca954x: Add documentation for i2c-mux-irq-mask-en
Date: Mon, 16 Jan 2017 11:11:14 +0800
Message-ID: <1484536275-75995-5-git-send-email-preid@electromag.com.au>
References: <1484536275-75995-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:33840 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751479AbdAPDLY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 15 Jan 2017 22:11:24 -0500
In-Reply-To: <1484536275-75995-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: peda@axentia.se, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

Unfortunately some hardware device will assert their irq line immediately
on power on and provide no mechanism to mask the irq. As the i2c muxes
provide no method to mask irq line this provides a work around by keeping
the parent irq masked until enough device drivers have loaded to service
all pending interrupts.

For example the the ltc1760 assert its SMBALERT irq immediately on power
on. With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
device is registered irq are enabled and fire continuously as the second
device driver has not yet loaded. Setting this parameter to 0x3 while
delay the irq being enabled until both devices are ready.

Acked-by: Peter Rosin <peda@axentia.se>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index aa09704..6de1e8e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -19,6 +19,8 @@ Optional Properties:
   - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
     children in idle state. This is necessary for example, if there are several
     multiplexers on the bus and the devices behind them use same I2C addresses.
+  - nxp,irq-mask-enable: BitMask; Defines a mask for which irq lines need to be
+    unmasked before the parent irq line in enabled.
   - interrupt-parent: Phandle for the interrupt controller that services
     interrupts for this device.
   - interrupts: Interrupt mapping for IRQ.
@@ -36,6 +38,7 @@ Example:
 		#size-cells = <0>;
 		reg = <0x74>;
 
+		nxp,irq-mask-enable = <0x3>;
 		interrupt-parent = <&ipic>;
 		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
-- 
1.8.3.1
