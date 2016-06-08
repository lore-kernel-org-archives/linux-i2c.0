From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] i2c: mux: refer to i2c-mux.txt
Date: Wed,  8 Jun 2016 15:21:39 +0900
Message-ID: <1465366899-4824-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

Correct references to i2c-mux.txt which was previously mux.txt.

Also correct the spelling of relevant.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt | 4 ++--
 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt      | 3 ++-
 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt           | 6 +++---
 Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt        | 4 ++--
 Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt            | 6 +++---
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt b/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt
index bfeabb843941..71191ff0e781 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt
@@ -44,8 +44,8 @@ Required properties:
 - our-claim-gpio: The GPIO that we use to claim the bus.
 - their-claim-gpios: The GPIOs that the other sides use to claim the bus.
   Note that some implementations may only support a single other master.
-- Standard I2C mux properties. See mux.txt in this directory.
-- Single I2C child bus node at reg 0. See mux.txt in this directory.
+- Standard I2C mux properties. See i2c-mux.txt in this directory.
+- Single I2C child bus node at reg 0. See i2c-mux.txt in this directory.
 
 Optional properties:
 - slew-delay-us: microseconds to wait for a GPIO to go high. Default is 10 us.
diff --git a/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
index 6078aefe7ed4..7ce23ac61308 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
@@ -27,7 +27,8 @@ Required properties:
 - i2c-bus-name: The name of this bus. Also needed as pinctrl-name for the I2C
 		parents.
 
-Furthermore, I2C mux properties and child nodes. See mux.txt in this directory.
+Furthermore, I2C mux properties and child nodes. See i2c-mux.txt in this
+directory.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
index 66709a825541..21da3ecbb370 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
@@ -22,8 +22,8 @@ Required properties:
 - i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
   port is connected to.
 - mux-gpios: list of gpios used to control the muxer
-* Standard I2C mux properties. See mux.txt in this directory.
-* I2C child bus nodes. See mux.txt in this directory.
+* Standard I2C mux properties. See i2c-mux.txt in this directory.
+* I2C child bus nodes. See i2c-mux.txt in this directory.
 
 Optional properties:
 - idle-state: value to set the muxer to when idle. When no value is
@@ -33,7 +33,7 @@ For each i2c child node, an I2C child bus will be created. They will
 be numbered based on their order in the device tree.
 
 Whenever an access is made to a device on a child bus, the value set
-in the revelant node's reg property will be output using the list of
+in the relevant node's reg property will be output using the list of
 GPIOs, the first in the list holding the least-significant value.
 
 If an idle state is defined, using the idle-state (optional) property,
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
index ae8af1694e95..33119a98e144 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt
@@ -28,9 +28,9 @@ Also required are:
 * Standard pinctrl properties that specify the pin mux state for each child
   bus. See ../pinctrl/pinctrl-bindings.txt.
 
-* Standard I2C mux properties. See mux.txt in this directory.
+* Standard I2C mux properties. See i2c-mux.txt in this directory.
 
-* I2C child bus nodes. See mux.txt in this directory.
+* I2C child bus nodes. See i2c-mux.txt in this directory.
 
 For each named state defined in the pinctrl-names property, an I2C child bus
 will be created. I2C child bus numbers are assigned based on the index into
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
index 688783fbe696..de00d7fc450b 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt
@@ -7,8 +7,8 @@ Required properties:
 - compatible: i2c-mux-reg
 - i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
   port is connected to.
-* Standard I2C mux properties. See mux.txt in this directory.
-* I2C child bus nodes. See mux.txt in this directory.
+* Standard I2C mux properties. See i2c-mux.txt in this directory.
+* I2C child bus nodes. See i2c-mux.txt in this directory.
 
 Optional properties:
 - reg: this pair of <offset size> specifies the register to control the mux.
@@ -24,7 +24,7 @@ Optional properties:
   given, it defaults to the last value used.
 
 Whenever an access is made to a device on a child bus, the value set
-in the revelant node's reg property will be output to the register.
+in the relevant node's reg property will be output to the register.
 
 If an idle state is defined, using the idle-state (optional) property,
 whenever an access is not being made to a device on a child bus, the
-- 
2.1.4
