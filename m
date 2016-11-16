From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [RFC PATCH 7/7] i2c: i2c-mux-simple: new driver
Date: Thu, 17 Nov 2016 00:48:31 +0100
Message-ID: <1479340111-1259-8-git-send-email-peda@axentia.se>
References: <1479340111-1259-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479340111-1259-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a generic simple i2c mux that uses the generic multiplexer
subsystem to do the muxing.

The user can select if the mux is to be mux-locked and parent-locked
as described in Documentation/i2c/i2c-topology.
---
 drivers/i2c/muxes/Kconfig          |  12 +++
 drivers/i2c/muxes/Makefile         |   1 +
 drivers/i2c/muxes/i2c-mux-simple.c | 172 +++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/i2c/muxes/i2c-mux-simple.c

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index e280c8ecc0b5..45e80ad2d4ab 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -72,6 +72,18 @@ config I2C_MUX_REG
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mux-reg.
 
+config I2C_MUX_SIMPLE
+	tristate "Simple I2C multiplexer"
+	depends on OF
+	help
+	  If you say yes to this option, support will be included for a
+	  simple generic I2C multiplexer. This driver provides access to
+	  I2C busses connected through a MUX, which is controlled
+	  by a generic MUX controller.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mux-simple.
+
 config I2C_DEMUX_PINCTRL
 	tristate "pinctrl-based I2C demultiplexer"
 	depends on PINCTRL && OF
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 7c267c29b191..eea1fb9e6466 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
 obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
 obj-$(CONFIG_I2C_MUX_REG)	+= i2c-mux-reg.o
+obj-$(CONFIG_I2C_MUX_SIMPLE)	+= i2c-mux-simple.o
 
 ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
diff --git a/drivers/i2c/muxes/i2c-mux-simple.c b/drivers/i2c/muxes/i2c-mux-simple.c
new file mode 100644
index 000000000000..308ecbf9d66c
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-mux-simple.c
@@ -0,0 +1,172 @@
+/*
+ * Generic simple I2C multiplexer
+ *
+ * Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/module.h>
+#include <linux/mux.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+struct mux {
+	struct mux_control *control;
+
+	int parent;
+	int n_values;
+	u32 *values;
+};
+
+static int i2c_mux_select(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct mux *mux = i2c_mux_priv(muxc);
+
+	return mux_control_select(mux->control, chan);
+}
+
+static int i2c_mux_deselect(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct mux *mux = i2c_mux_priv(muxc);
+
+	return mux_control_deselect(mux->control);
+}
+
+static int i2c_mux_probe_dt(struct mux *mux,
+			    struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *adapter_np, *child;
+	struct i2c_adapter *adapter;
+	int i = 0;
+
+	if (!np)
+		return -ENODEV;
+
+	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
+	if (!adapter_np) {
+		dev_err(dev, "Cannot parse i2c-parent\n");
+		return -ENODEV;
+	}
+	adapter = of_find_i2c_adapter_by_node(adapter_np);
+	of_node_put(adapter_np);
+	if (!adapter)
+		return -EPROBE_DEFER;
+
+	mux->parent = i2c_adapter_id(adapter);
+	put_device(&adapter->dev);
+
+	mux->control = devm_mux_control_get(dev, "mux");
+	if (IS_ERR(mux->control)) {
+		if (PTR_ERR(mux->control) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get control-mux\n");
+		return PTR_ERR(mux->control);
+	}
+
+	mux->n_values = of_get_child_count(np);
+
+	mux->values = devm_kzalloc(dev,
+				   sizeof(*mux->values) * mux->n_values,
+				   GFP_KERNEL);
+	if (!mux->values)
+		return -ENOMEM;
+
+	for_each_child_of_node(np, child) {
+		of_property_read_u32(child, "reg", mux->values + i);
+		i++;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id i2c_mux_of_match[] = {
+	{ .compatible = "i2c-mux-simple,parent-locked",
+	  .data = (void *)0, },
+	{ .compatible = "i2c-mux-simple,mux-locked",
+	  .data = (void *)1, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, i2c_mux_of_match);
+
+static int i2c_mux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct i2c_mux_core *muxc;
+	struct mux *mux;
+	struct i2c_adapter *parent;
+	int i, ret;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	ret = i2c_mux_probe_dt(mux, dev);
+	if (ret < 0)
+		return ret;
+
+	parent = i2c_get_adapter(mux->parent);
+	if (!parent)
+		return -EPROBE_DEFER;
+
+	muxc = i2c_mux_alloc(parent, dev, mux->n_values, 0, 0,
+			     i2c_mux_select, i2c_mux_deselect);
+	if (!muxc) {
+		ret = -ENOMEM;
+		goto alloc_failed;
+	}
+	muxc->priv = mux;
+
+	platform_set_drvdata(pdev, muxc);
+
+	match = of_match_device(of_match_ptr(i2c_mux_of_match), dev);
+	if (match)
+		muxc->mux_locked = !!of_device_get_match_data(dev);
+
+	for (i = 0; i < mux->n_values; i++) {
+		ret = i2c_mux_add_adapter(muxc, 0, mux->values[i], 0);
+		if (ret)
+			goto add_adapter_failed;
+	}
+
+	dev_info(dev, "%d port mux on %s adapter\n",
+		 mux->n_values, parent->name);
+
+	return 0;
+
+add_adapter_failed:
+	i2c_mux_del_adapters(muxc);
+alloc_failed:
+	i2c_put_adapter(parent);
+
+	return ret;
+}
+
+static int i2c_mux_remove(struct platform_device *pdev)
+{
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+
+	i2c_mux_del_adapters(muxc);
+	i2c_put_adapter(muxc->parent);
+
+	return 0;
+}
+
+static struct platform_driver i2c_mux_driver = {
+	.probe	= i2c_mux_probe,
+	.remove	= i2c_mux_remove,
+	.driver	= {
+		.name	= "i2c-mux-simple",
+		.of_match_table = i2c_mux_of_match,
+	},
+};
+module_platform_driver(i2c_mux_driver);
+
+MODULE_DESCRIPTION("Simple I2C multiplexer driver");
+MODULE_AUTHOR("Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
