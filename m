From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [RFC 3/5] dt-bindings: i3c: Document core bindings
Date: Mon, 31 Jul 2017 18:24:48 +0200
Message-ID: <1501518290-5723-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501518290-5723-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jan Kotas <jank-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

A new I3C subsystem has been added and a generic description has been
created to represent the I3C bus and the devices connected on it.

Document this generic representation.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/devicetree/bindings/i3c/i3c.txt | 90 +++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt

diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
new file mode 100644
index 000000000000..49261dec7b01
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/i3c.txt
@@ -0,0 +1,90 @@
+Generic device tree bindings for I3C busses
+===========================================
+
+This document describes generic bindings that should be used to describe I3C
+busses in a device tree.
+
+Required properties
+-------------------
+
+- #address-cells  - should be <1>. Read more about addresses below.
+- #size-cells     - should be <0>.
+- compatible      - name of I3C bus controller following generic names
+		    recommended practice.
+
+For other required properties e.g. to describe register sets,
+clocks, etc. check the binding documentation of the specific driver.
+
+Optional properties
+-------------------
+
+These properties may not be supported by all I3C master drivers. Each I3C
+master bindings should specify which of them are supported.
+
+- i3c-scl-frequency: frequency (in Hz) of the SCL signal used for I3C
+		     transfers. When undefined the core set it to 12.5MHz.
+
+- i2c-scl-frequency: frequency (in Hz) of the SCL signal used for I2C
+		     transfers. When undefined, the core looks at LVR values
+		     of I2C devices described in the device tree to determine
+		     the maximum I2C frequency.
+
+I2C devices
+===========
+
+Each I2C device connected to the bus should be described in a subnode with
+the following properties:
+
+All properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
+valid here.
+
+New required properties:
+------------------------
+- i3c-lvr: 32 bits integer property (only the lowest 8 bits are meaningful)
+	   describing device capabilities as described in the I3C
+	   specification.
+
+	   bit[31:8]: unused
+	   bit[7:5]: I2C device index. Possible values
+	    * 0: I2C device has a 50 ns spike filter
+	    * 1: I2C device does not have a 50 ns spike filter but supports high
+		 frequency on SCL
+	    * 2: I2C device does not have a 50 ns spike filter and is not
+		 tolerant to high frequencies
+	    * 3-7: reserved
+
+	   bit[4]: tell whether the device operates in FM or FM+ mode
+	    * 0: FM+ mode
+	    * 1: FM mode
+
+	   bit[3:0]: device type
+	    * 0-15: reserved
+
+I3C devices
+===========
+
+I3C are not described in the device tree yet. We could decide to represent them
+at some point to assign a specific dynamic address to a device or to force an
+I3C device to act as an I2C device if it has a static address.
+
+Example:
+
+	i3c-master@0d040000 {
+		compatible = "cdns,i3c-master";
+		clocks = <&coreclock>, <&i3csysclock>;
+		clock-names = "pclk", "sysclk";
+		interrupts = <3 0>;
+		reg = <0x0d040000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		status = "okay";
+		i2c-scl-frequency = <100000>;
+
+		nunchuk: nunchuk@52 {
+			compatible = "nintendo,nunchuk";
+			reg = <0x52>;
+			i3c-lvr = <0x10>;
+		};
+	};
+
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
