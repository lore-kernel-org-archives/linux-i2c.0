From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/7] dt-bindings: i2c: add support for 'i2c-mux' subnode
Date: Wed, 27 Jul 2016 10:43:24 +0200
Message-ID: <1469609010-23049-2-git-send-email-peda@axentia.se>
References: <1469609010-23049-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0135.outbound.protection.outlook.com ([104.47.2.135]:56251
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753788AbcG0In7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Jul 2016 04:43:59 -0400
In-Reply-To: <1469609010-23049-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>

Similar to the new optional 'i2c-bus' subnode from Jon Hunter, this
adds an optional 'i2c-mux' subnode, for similar reasons. I.e. it is
bad of the i2c mux core to assume that any subnode of an i2c mux device
is a potential (when the 'reg' property matches) i2c-mux child bus,
given that i2c mux devices might do more than mux i2c traffic.

So, if an 'i2c-mux' subnode is present, dictate that all i2c-mux child
buses exist beneath that subnode.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/i2c/i2c-mux.txt | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux.txt b/Documentation/devicetree/bindings/i2c/i2c-mux.txt
index af84cce5cd7b..212e6779dc5c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux.txt
@@ -2,19 +2,32 @@ Common i2c bus multiplexer/switch properties.
 
 An i2c bus multiplexer/switch will have several child busses that are
 numbered uniquely in a device dependent manner.  The nodes for an i2c bus
-multiplexer/switch will have one child node for each child
-bus.
+multiplexer/switch will have one child node for each child bus.
 
-Required properties:
+Optional properties:
+- #address-cells = <1>;
+   This property is required is the i2c-mux child node does not exist.
+
+- #size-cells = <0>;
+   This property is required is the i2c-mux child node does not exist.
+
+- i2c-mux
+   For i2c multiplexers/switches that have child nodes that are a mixture
+   of both i2c child busses and other child nodes, the 'i2c-mux' subnode
+   can be used for populating the i2c child busses.  If an 'i2c-mux'
+   subnode is present, only subnodes of this will be considered as i2c
+   child busses.
+
+Required properties for the i2c-mux child node:
 - #address-cells = <1>;
 - #size-cells = <0>;
 
-Required properties for child nodes:
+Required properties for i2c child bus nodes:
 - #address-cells = <1>;
 - #size-cells = <0>;
 - reg : The sub-bus number.
 
-Optional properties for child nodes:
+Optional properties for i2c child bus nodes:
 - Other properties specific to the multiplexer/switch hardware.
 - Child nodes conforming to i2c bus binding
 
-- 
2.1.4
