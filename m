From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Support SMBus multiplexing on Asus Z8 series
Date: Fri, 27 Jul 2012 17:30:41 +0200
Message-ID: <20120727173041.7ea7d723@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add support for SMBus multiplexing on Asus Z8 motherboard series. On
these boards, the memory slots are behind a GPIO-controlled I2C
multiplexer. Models with 6 or 12 memory slots have 2 segments behind
the multiplexer, while models with 18 memory slots have 3 such
segments.

On these boards, only the memory slots are behind the multiplexer,
so it is possible to keep the autodetection mechanism.

The code is generic enough so it could work on other boards as long as
the multiplexer is controlled by GPIO pins. For other forms of
multiplexing (for example using an I2C device) additional code will be
needed.

Thanks to Asus for providing a board to develop and test this feature,
as well as all the technical information required.

At the moment, the GPIO driver must be loaded before the i2c-i801
driver, but I hope to solve this soon, using deferred probing on
the i2c-mux-gpio side.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
This patch depends on two patches not yet upstream:
https://lkml.org/lkml/2012/7/23/234
http://marc.info/?l=linux-i2c&m=134314191700778&w=2

 drivers/i2c/busses/i2c-i801.c |  214 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 1 deletion(-)

--- linux-3.5.orig/drivers/i2c/busses/i2c-i801.c	2012-07-27 11:32:08.000000000 +0200
+++ linux-3.5/drivers/i2c/busses/i2c-i801.c	2012-07-27 17:16:10.979717026 +0200
@@ -79,6 +79,13 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
+#include <linux/err.h>
+
+#if defined CONFIG_I2C_MUX || defined CONFIG_I2C_MUX_MODULE
+#include <linux/gpio.h>
+#include <linux/i2c-mux-gpio.h>
+#include <linux/platform_device.h>
+#endif
 
 /* I801 SMBus address offsets */
 #define SMBHSTSTS(p)	(0 + (p)->smba)
@@ -156,6 +163,15 @@
 #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS	0x8c22
 
+struct i801_mux_config {
+	char *gpio_chip;
+	unsigned values[3];
+	int n_values;
+	unsigned classes[3];
+	unsigned gpios[2];		/* Relative to gpio_chip->base */
+	int n_gpios;
+};
+
 struct i801_priv {
 	struct i2c_adapter adapter;
 	unsigned long smba;
@@ -173,6 +189,12 @@ struct i801_priv {
 	int count;
 	int len;
 	u8 *data;
+
+#if defined CONFIG_I2C_MUX || defined CONFIG_I2C_MUX_MODULE
+	const struct i801_mux_config *mux_drvdata;
+	unsigned mux_priv[2];
+	struct platform_device *mux_pdev;
+#endif
 };
 
 static struct pci_driver i801_driver;
@@ -897,6 +919,193 @@ static void __init input_apanel_init(voi
 static void __devinit i801_probe_optional_slaves(struct i801_priv *priv) {}
 #endif	/* CONFIG_X86 && CONFIG_DMI */
 
+#if defined CONFIG_I2C_MUX || defined CONFIG_I2C_MUX_MODULE
+static struct i801_mux_config i801_mux_config_asus_z8_d12 = {
+	.gpio_chip = "gpio_ich",
+	.values = { 0x02, 0x03 },
+	.n_values = 2,
+	.classes = { I2C_CLASS_SPD, I2C_CLASS_SPD },
+	.gpios = { 52, 53 },
+	.n_gpios = 2,
+};
+
+static struct i801_mux_config i801_mux_config_asus_z8_d18 = {
+	.gpio_chip = "gpio_ich",
+	.values = { 0x02, 0x03, 0x01 },
+	.n_values = 3,
+	.classes = { I2C_CLASS_SPD, I2C_CLASS_SPD, I2C_CLASS_SPD },
+	.gpios = { 52, 53 },
+	.n_gpios = 2,
+};
+
+static struct dmi_system_id __devinitdata mux_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "Z8NA-D6(C)"),
+		},
+		.driver_data = &i801_mux_config_asus_z8_d12,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "Z8P(N)E-D12(X)"),
+		},
+		.driver_data = &i801_mux_config_asus_z8_d12,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "Z8NH-D12"),
+		},
+		.driver_data = &i801_mux_config_asus_z8_d12,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "Z8PH-D12/IFB"),
+		},
+		.driver_data = &i801_mux_config_asus_z8_d12,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "Z8NR-D12"),
+		},
+		.driver_data = &i801_mux_config_asus_z8_d12,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "Z8P(N)H-D12"),
+		},
+		.driver_data = &i801_mux_config_asus_z8_d12,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "Z8PG-D18"),
+		},
+		.driver_data = &i801_mux_config_asus_z8_d18,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "Z8PE-D18"),
+		},
+		.driver_data = &i801_mux_config_asus_z8_d18,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "Z8PS-D12"),
+		},
+		.driver_data = &i801_mux_config_asus_z8_d12,
+	},
+	{ }
+};
+
+static int __devinit match_gpio_chip_by_label(struct gpio_chip *chip,
+					      void *data)
+{
+	return !strcmp(chip->label, data);
+}
+
+/* Setup multiplexing if needed */
+static int __devinit i801_add_mux(struct i801_priv *priv)
+{
+	struct device *dev = &priv->adapter.dev;
+	const struct i801_mux_config *mux_config;
+	struct gpio_chip *gpio;
+	struct i2c_mux_gpio_platform_data gpio_data;
+	int i, err;
+
+	if (!priv->mux_drvdata)
+		return 0;
+	mux_config = priv->mux_drvdata;
+
+	/* Find GPIO chip */
+	gpio = gpiochip_find(mux_config->gpio_chip, match_gpio_chip_by_label);
+	if (gpio) {
+		dev_info(dev,
+			 "GPIO chip %s found, SMBus multiplexing enabled\n",
+			 mux_config->gpio_chip);
+	} else {
+		dev_err(dev,
+			"GPIO chip %s not found, SMBus multiplexing disabled\n",
+			mux_config->gpio_chip);
+		return -ENODEV;
+	}
+
+	/* Find absolute GPIO pin numbers */
+	if (ARRAY_SIZE(priv->mux_priv) < mux_config->n_gpios) {
+		dev_err(dev, "i801_priv.mux_priv too small (%lu, need %d)\n",
+			ARRAY_SIZE(priv->mux_priv), mux_config->n_gpios);
+		return -ENODEV;
+	}
+	for (i = 0; i < mux_config->n_gpios; i++)
+		priv->mux_priv[i] = gpio->base + mux_config->gpios[i];
+
+	/* Prepare the platform data */
+	memset(&gpio_data, 0, sizeof(struct i2c_mux_gpio_platform_data));
+	gpio_data.parent = priv->adapter.nr;
+	gpio_data.values = mux_config->values;
+	gpio_data.n_values = mux_config->n_values;
+	gpio_data.classes = mux_config->classes;
+	gpio_data.gpios = priv->mux_priv;
+	gpio_data.n_gpios = mux_config->n_gpios;
+	gpio_data.idle = I2C_MUX_GPIO_NO_IDLE;
+
+	/* Register the mux device */
+	priv->mux_pdev = platform_device_register_data(dev, "i2c-mux-gpio",
+				priv->mux_priv[0], &gpio_data,
+				sizeof(struct i2c_mux_gpio_platform_data));
+	if (IS_ERR(priv->mux_pdev)) {
+		err = PTR_ERR(priv->mux_pdev);
+		priv->mux_pdev = NULL;
+		dev_err(dev, "Failed to register i2c-mux-gpio device\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void __devexit i801_del_mux(struct i801_priv *priv)
+{
+	if (priv->mux_pdev)
+		platform_device_unregister(priv->mux_pdev);
+}
+
+static unsigned int __devinit i801_get_adapter_class(struct i801_priv *priv)
+{
+	const struct dmi_system_id *id;
+	const struct i801_mux_config *mux_config;
+	unsigned int class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	int i;
+
+	id = dmi_first_match(mux_dmi_table);
+	if (id) {
+		/* Remove from branch classes from trunk */
+		mux_config = id->driver_data;
+		for (i = 0; i < mux_config->n_values; i++)
+			class &= ~mux_config->classes[i];
+
+		/* Remember for later */
+		priv->mux_drvdata = mux_config;
+	}
+
+	return class;
+}
+#else
+static inline int i801_add_mux(struct i801_priv *priv) { return 0; }
+static inline void i801_del_mux(struct i801_priv *priv) { }
+
+static inline unsigned int i801_get_adapter_class(struct i801_priv *priv)
+{
+	return I2C_CLASS_HWMON | I2C_CLASS_SPD;
+}
+#endif
+
 static int __devinit i801_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
@@ -910,7 +1119,7 @@ static int __devinit i801_probe(struct p
 
 	i2c_set_adapdata(&priv->adapter, priv);
 	priv->adapter.owner = THIS_MODULE;
-	priv->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	priv->adapter.class = i801_get_adapter_class(priv);
 	priv->adapter.algo = &smbus_algorithm;
 
 	priv->pci_dev = dev;
@@ -1030,6 +1239,8 @@ static int __devinit i801_probe(struct p
 	}
 
 	i801_probe_optional_slaves(priv);
+	/* We ignore errors - multiplexing is optional */
+	i801_add_mux(priv);
 
 	pci_set_drvdata(dev, priv);
 
@@ -1049,6 +1260,7 @@ static void __devexit i801_remove(struct
 {
 	struct i801_priv *priv = pci_get_drvdata(dev);
 
+	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
 


-- 
Jean Delvare
