From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] i2c/of: Automatically populate i2c mux busses from
	device tree data.
Date: Tue, 27 Sep 2011 16:16:24 -0700
Message-ID: <1317165384-20390-3-git-send-email-david.daney@cavium.com>
References: <1317165384-20390-1-git-send-email-david.daney@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1317165384-20390-1-git-send-email-david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

For 'normal' i2c bus drivers, we can call of_i2c_register_devices()
and have the device tree framework automatically populate the bus with
the devices specified in the device tree.

This patch adds a common code to the i2c mux framework to have the mux
sub-busses be populated by the of_i2c_register_devices() too.  If the
mux device has an of_node, we populate the sub-bus' of_node so that
the subsequent call to of_i2c_register_devices() will find the
corresponding devices.

It seemed better to put this logic in i2c_add_mux_adapter() rather
than the individual mux drivers, as they will all probably want to do
the same thing.

Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/mux.txt |   60 +++++++++++++++++++++++++
 drivers/i2c/i2c-mux.c                         |   25 ++++++++++
 2 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/mux.txt

diff --git a/Documentation/devicetree/bindings/i2c/mux.txt b/Documentation/devicetree/bindings/i2c/mux.txt
new file mode 100644
index 0000000..af84cce
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/mux.txt
@@ -0,0 +1,60 @@
+Common i2c bus multiplexer/switch properties.
+
+An i2c bus multiplexer/switch will have several child busses that are
+numbered uniquely in a device dependent manner.  The nodes for an i2c bus
+multiplexer/switch will have one child node for each child
+bus.
+
+Required properties:
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Required properties for child nodes:
+- #address-cells = <1>;
+- #size-cells = <0>;
+- reg : The sub-bus number.
+
+Optional properties for child nodes:
+- Other properties specific to the multiplexer/switch hardware.
+- Child nodes conforming to i2c bus binding
+
+
+Example :
+
+	/*
+	   An NXP pca9548 8 channel I2C multiplexer at address 0x70
+	   with two NXP pca8574 GPIO expanders attached, one each to
+	   ports 3 and 4.
+	 */
+
+	mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			gpio1: gpio@38 {
+				compatible = "nxp,pca8574";
+				reg = <0x38>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+		};
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			gpio2: gpio@38 {
+				compatible = "nxp,pca8574";
+				reg = <0x38>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+		};
+	};
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 26ab31d..bebf94d 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -24,6 +24,8 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
+#include <linux/of.h>
+#include <linux/of_i2c.h>
 
 /* multiplexer per channel data */
 struct i2c_mux_priv {
@@ -142,6 +144,29 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
 		 i2c_adapter_id(&priv->adap));
 
+#ifdef CONFIG_OF
+	/* Try to get populate the mux adapter's of_node */
+	if (mux_dev->of_node) {
+		struct device_node *child = NULL;
+		const __be32 *reg;
+		int len;
+
+		for (;;) {
+			child = of_get_next_child(mux_dev->of_node, child);
+			if (!child)
+				break;
+			reg = of_get_property(child, "reg", &len);
+			if (!reg || (len < sizeof(__be32)))
+				continue;
+			if (chan_id == be32_to_cpup(reg)) {
+				priv->adap.dev.of_node = child;
+				break;
+			}
+		}
+	}
+	of_i2c_register_devices(&priv->adap);
+#endif
+
 	return &priv->adap;
 }
 EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
-- 
1.7.2.3
