From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v2 1/8] dt-bindings: i2c: add support for 'i2c-mux' subnode
Date: Mon, 15 Aug 2016 15:40:24 +0200
Message-ID: <1471268431-5148-2-git-send-email-peda@axentia.se>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471268431-5148-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Similar to the new optional 'i2c-bus' subnode from Jon Hunter, this
adds an optional 'i2c-mux' subnode, for similar reasons. I.e. it is
bad of the i2c mux core to assume that any subnode of an i2c mux device
is a potential (when the 'reg' property matches) i2c-mux child bus,
given that i2c mux devices might do more than mux i2c traffic.

So, if an 'i2c-mux' subnode is present, dictate that all i2c-mux child
buses exist beneath that subnode.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
