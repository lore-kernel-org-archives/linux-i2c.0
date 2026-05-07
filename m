Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71731E824;
	Thu,  7 May 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177853; cv=none; b=IYOyk2tskusC8xY5GOd6O2f4Rr18E0IRdeOOVLqxR9M+tEQF66GxUkWyjJQTNhQ4JQ0G6TBgv9sEMcA3qMaMeYfmSuIQtRbYzpMmXqxnT0Q3SpB87QSK2L10wk84lvnzI8Qr1CYQ1q0E6ZVxY4FbEmdq9ddv1RVEzUn9aMhjpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177853; c=relaxed/simple;
	bh=PCdWB/j4d3tvqz2ICXj4w19V632VAX0CnlG+fbpCiVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzNeKkZylcjfLA8H/6BThPuBZN202X0UISvcVQdZmG707EiDwow9cOHN06SHo0y6Va3meliV4b+robNlWbI3hvJwSrTaVbURToW/BB7sL7AWO6kte4Lii2oPMwhiDkuHbHQaJT6GIYzSuCJ6IzHy17V4WdDqU8jspGKwIZycNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=aHELZxBr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="aHELZxBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778177841; x=1778782641;
	i=markus.stockhausen@gmx.de;
	bh=0YiKpRwYb2fXnbr0PtzZxuAo31T9Z1ow01hPDyeFMO4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aHELZxBrEm39edXMOOyjLNl+59LTfuJhf/fxOM3l9X9qpxAmnpUyK6cUEjor8y5f
	 o4DVHD3BXMTjHApAOA4xn/GTgkp1e66WjvcV3CGXMIMSVvQaNocptRw5ywSn26NdT
	 8gqMvbPLwt+4MND4ZQJWL/4i/aOao5ZPPlgMsU1gjP5DgHvA/pCKaOLaHdnj6PVb+
	 5naCTK1bAMOwS9mXlzeYQ2ajr0Qs/egcZph9ylek4e8k61G3p+fFWhq30/gPY/pWQ
	 II+l//Gpd/fHaQai4OLcKD2jPL2CNEwCZFwXcpIHB8opQsciixFYwzeXrKWw5tBdx
	 /9IM26jS8Rra+GD7OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1voYix31ZK-00P0ed; Thu, 07
 May 2026 20:17:21 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH 2/2] i2c: shared-gpio: Add driver for gpio based busses with shared SCL
Date: Thu,  7 May 2026 20:17:11 +0200
Message-ID: <20260507181711.2696783-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A0zUqg1Ysot0BC+ZoxQ069v2+QtiviSq4ODNCrl8cvoq/YE6D10
 0/E7G8kMxsa+9LwfFBHuVqehHmzv+2Pqjx3kckLHm5HZoIyiRFzqn32b3SNFUYFgb2qmQPi
 aKJMD7gWeTUB0tqUFiDwW7tJeE4x14hcipYqppOaAzvTJ8fjbtKxHUOtXyiqsIhDDZZgOSk
 IxLcU3rKf6HDjy52ILu8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PNYMtdRjryI=;OCB1EywrRFiWe5KtedIw9YR7oUT
 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

Some lower end hardware (especially Realtek based switches) are
designed with multiple I2C busses that share a single clock
(SCL) line. E.g. devices like the D-Link DGS-1250-28X can realize
4 I2C SFP busses with 5 gpios this way.

Provide a i2c-gpio-shared driver (derived from i2c-gpio) that
handles such hardware designs.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/i2c/busses/Kconfig           |  10 ++
 drivers/i2c/busses/Makefile          |   1 +
 drivers/i2c/busses/i2c-gpio-shared.c | 177 +++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-gpio-shared.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867a37..f3ab68beeb7f 100644
=2D-- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -691,6 +691,16 @@ config I2C_GPIO
 	  This is a very simple bitbanging I2C driver utilizing the
 	  arch-neutral GPIO API to control the SCL and SDA lines.
=20
+config I2C_GPIO_SHARED
+	tristate "multiple GPIO-based bitbanging I2C with shared SCL"
+	depends on GPIOLIB || COMPILE_TEST
+	select I2C_ALGOBIT
+	help
+	  This is an alternative of the I2C GPIO driver for devices with only
+	  few GPIO pins where multiple busses with dedicated SDA lines share
+	  a single SCL line. It can handle an arbitrary number of N shared
+	  busses implemented with N+1 gpios.
+
 config I2C_GPIO_FAULT_INJECTOR
 	bool "GPIO-based fault injector"
 	depends on I2C_GPIO
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 547123ab351f..724b09e613cb 100644
=2D-- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_I2C_EG20T)		+=3D i2c-eg20t.o
 obj-$(CONFIG_I2C_EMEV2)		+=3D i2c-emev2.o
 obj-$(CONFIG_I2C_EXYNOS5)	+=3D i2c-exynos5.o
 obj-$(CONFIG_I2C_GPIO)		+=3D i2c-gpio.o
+obj-$(CONFIG_I2C_GPIO_SHARED)	+=3D i2c-gpio-shared.o
 obj-$(CONFIG_I2C_HIGHLANDER)	+=3D i2c-highlander.o
 obj-$(CONFIG_I2C_HISI)		+=3D i2c-hisi.o
 obj-$(CONFIG_I2C_HIX5HD2)	+=3D i2c-hix5hd2.o
diff --git a/drivers/i2c/busses/i2c-gpio-shared.c b/drivers/i2c/busses/i2c=
-gpio-shared.c
new file mode 100644
index 000000000000..de082888860c
=2D-- /dev/null
+++ b/drivers/i2c/busses/i2c-gpio-shared.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Bitbanging driver for multiple I2C busses with shared SCL pin using th=
e GPIO API
+ * Copyright (c) 2025 Markus Stockhausen <markus.stockhausen at gmx.de>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+struct gpio_shared_ctx;
+
+struct gpio_shared_bus {
+	struct gpio_desc *sda;
+	struct i2c_adapter adap;
+	struct i2c_algo_bit_data bit_data;
+	struct gpio_shared_ctx *ctx;
+};
+
+struct gpio_shared_ctx {
+	struct device *dev;
+	struct gpio_desc *scl;
+	struct mutex lock;
+	struct gpio_shared_bus bus[];
+};
+
+static void gpio_shared_setsda(void *data, int state)
+{
+	struct gpio_shared_bus *bus =3D data;
+
+	gpiod_set_value_cansleep(bus->sda, state);
+}
+
+static void gpio_shared_setscl(void *data, int state)
+{
+	struct gpio_shared_bus *bus =3D data;
+	struct gpio_shared_ctx *ctx =3D bus->ctx;
+
+	gpiod_set_value_cansleep(ctx->scl, state);
+}
+
+static int gpio_shared_getsda(void *data)
+{
+	struct gpio_shared_bus *bus =3D data;
+
+	return gpiod_get_value_cansleep(bus->sda);
+}
+
+static int gpio_shared_getscl(void *data)
+{
+	struct gpio_shared_bus *bus =3D data;
+	struct gpio_shared_ctx *ctx =3D bus->ctx;
+
+	return gpiod_get_value_cansleep(ctx->scl);
+}
+
+static int gpio_shared_pre_xfer(struct i2c_adapter *adap)
+{
+	struct gpio_shared_bus *bus =3D container_of(adap, struct gpio_shared_bu=
s, adap);
+	struct gpio_shared_ctx *ctx =3D bus->ctx;
+
+	return mutex_lock_interruptible(&ctx->lock);
+}
+
+static void gpio_shared_post_xfer(struct i2c_adapter *adap)
+{
+	struct gpio_shared_bus *bus =3D container_of(adap, typeof(*bus), adap);
+	struct gpio_shared_ctx *ctx =3D bus->ctx;
+
+	mutex_unlock(&ctx->lock);
+}
+
+static void gpio_shared_del_adapter(void *data)
+{
+	i2c_del_adapter(data);
+}
+
+static int gpio_shared_probe(struct platform_device *pdev)
+{
+	int bus_count, msecs, ret, bus_num =3D 0;
+	struct device *dev =3D &pdev->dev;
+	struct gpio_shared_ctx *ctx;
+
+	bus_count =3D device_get_child_node_count(dev);
+	if (!bus_count)
+		return dev_err_probe(dev, -EINVAL, "no busses defined\n");
+
+	ctx =3D devm_kzalloc(dev, struct_size(ctx, bus, bus_count), GFP_KERNEL);
+	if (!ctx)
+		return dev_err_probe(dev, -ENOMEM, "memory allocation failed\n");
+
+	ctx->dev =3D dev;
+	mutex_init(&ctx->lock);
+
+	ctx->scl =3D devm_gpiod_get(dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
+	if (IS_ERR(ctx->scl))
+		return dev_err_probe(dev, PTR_ERR(ctx->scl), "shared SCL node not found=
\n");
+
+	device_for_each_child_node_scoped(dev, child) {
+		struct gpio_shared_bus *bus =3D &ctx->bus[bus_num];
+		struct i2c_adapter *adap =3D &bus->adap;
+		struct i2c_algo_bit_data *bit_data =3D &bus->bit_data;
+
+		bus->sda =3D devm_fwnode_gpiod_get(dev, child, "sda", GPIOD_OUT_HIGH_OP=
EN_DRAIN,
+						 fwnode_get_name(child));
+		if (IS_ERR(bus->sda))
+			return dev_err_probe(dev, PTR_ERR(bus->sda),
+					     "SDA node for bus %d not found\n", bus_num);
+		bus->ctx =3D ctx;
+		bit_data->data =3D bus;
+		bit_data->setsda =3D gpio_shared_setsda;
+		bit_data->setscl =3D gpio_shared_setscl;
+		bit_data->pre_xfer =3D gpio_shared_pre_xfer;
+		bit_data->post_xfer =3D gpio_shared_post_xfer;
+
+		if (fwnode_property_read_u32(child, "i2c-gpio-shared,delay-us", &bit_da=
ta->udelay))
+			bit_data->udelay =3D 5;
+		if (!fwnode_property_read_bool(child, "i2c-gpio-shared,sda-output-only"=
))
+			bit_data->getsda =3D gpio_shared_getsda;
+
+		if (!device_property_read_bool(dev, "i2c-gpio-shared,scl-output-only"))
+			bit_data->getscl =3D gpio_shared_getscl;
+		if (!device_property_read_u32(dev, "i2c-gpio-shared,timeout-ms", &msecs=
))
+			bit_data->timeout =3D msecs_to_jiffies(msecs);
+		else
+			bit_data->timeout =3D HZ / 10; /* 100ms */
+
+		if (gpiod_cansleep(bus->sda) || gpiod_cansleep(ctx->scl))
+			dev_warn(dev, "Slow GPIO pins might wreak havoc into I2C/SMBus bus tim=
ing\n");
+
+		adap->dev.parent =3D dev;
+		adap->owner =3D THIS_MODULE;
+		adap->algo_data =3D &bus->bit_data;
+		device_set_node(&adap->dev, child);
+		snprintf(adap->name, sizeof(adap->name),
+			 "i2c-gpio-shared:%s", fwnode_get_name(child));
+
+		ret =3D i2c_bit_add_bus(adap);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to register bus %d\n", bus_num)=
;
+
+		ret =3D devm_add_action_or_reset(dev, gpio_shared_del_adapter, adap);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "bus %d cleanup registration failed\n", bus_num);
+
+		dev_info(dev, "shared I2C bus %u using lines %u (SDA) and %u (SCL) dela=
y=3D%d\n",
+			 bus_num, desc_to_gpio(bus->sda), desc_to_gpio(ctx->scl),
+			 bit_data->udelay);
+
+		bus_num++;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id gpio_shared_of_match[] =3D {
+	{ .compatible =3D "i2c-gpio-shared" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gpio_shared_of_match);
+
+static struct platform_driver gpio_shared_driver =3D {
+	.probe =3D gpio_shared_probe,
+	.driver =3D {
+		.name =3D "i2c-gpio-shared",
+		.of_match_table =3D gpio_shared_of_match,
+	},
+};
+
+module_platform_driver(gpio_shared_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Markus Stockhausen <markus.stockhausen at gmx.de>");
+MODULE_DESCRIPTION("bitbanging multi I2C driver for shared SCL");
=2D-=20
2.54.0

