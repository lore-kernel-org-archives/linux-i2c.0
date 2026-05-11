Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387A423A8E;
	Mon, 11 May 2026 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516752; cv=none; b=aMWQW+pIE3eoiUeKrw2S4CW0+nbqri53G5b3C5uw+V2joy19IawBhOuyuZoenIHZc0g+Qj9wqZFqQUyYaBc4w+0bi4pYmzys9UCM0kGENK7cVo0+A32ke6aU+K2tM+C6VCy+VVRhdaTQn/gsmRWT1LYv8lo3CslBh+dysxL4MBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516752; c=relaxed/simple;
	bh=DPbnf6MGBU3b6nKgqX6UGpYhgSgvie+K3MD21ur2Ia0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNtN/6NGlpcS1sZGNhxiTV9HMIxrGY/IrnC70+xoG2zKkv+ypQFdZLH8SXNgmDeQOynGWZXarqIcqtLAlGxndiWhVF/z050k4xh8Zedfapy15slqauL4MF2hmEBBemUKJzfRJfyhZ7ADegpnQgvLHVivNsSX5AsoEatgBsln/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=BpSY/xbb; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="BpSY/xbb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778516739; x=1779121539;
	i=markus.stockhausen@gmx.de;
	bh=agRpan8t6v3k2tTxfEPtrd8OdVxyi9l/GF0U6kuKpoI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BpSY/xbbh5IAtszadpJfrQVVb03/njZ/xXxlKlVv0gGo5yWg1mrY1FiOAZA/0K53
	 JfynueXVVNC/J/qsgOSs5dpi/0VL5Hfygpo+BiyoEKyu2VFrvqEJnQmtfa1WB3r4f
	 5g1rCHifJQINVCQCh3r/Mt+eHyjfGnWJPUp8B3F0CjOrm8AvIDyr8PVnLRlPBQ+Yv
	 LVHr2sqWNitZBRNO/mv53AX+m6zTiv3oXFll3zyRztcYJoRgkMCXqQTHUAiMbxrxq
	 g06Rh/aN//KaHb87xCBm+n+W7I3OCApA+LNASYbBAEEGexrSExMGKhL2glkxfFl2h
	 Ne0Weba82bjiYfJymQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1wcCug0HSj-007tr9; Mon, 11
 May 2026 18:25:39 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: brgl@kernel.org,
	wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH v2 2/2] i2c: Add driver for gpio based busses with shared SCL
Date: Mon, 11 May 2026 18:25:28 +0200
Message-ID: <20260511162528.84508-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511162528.84508-1-markus.stockhausen@gmx.de>
References: <20260511162528.84508-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:On4uk//+WYrRctNeLe2q5vU+t1QEv8d/WS5gycAKCLsL0FEQntE
 t1FExeOUL/kPx3W8ORwc4sPX6rTIERjDLn4EmjkvZHsbZt+3a8UiVzEZ+L4EYakMZg4wE08
 N5J3lZH0UiO9bMKW1nckAgdz7kD1WwlFzxuzGNdItzg5YbdnyeUGJ3BmL6oBdmMbbC2btsY
 Yh+aqkrbpHIi5/HL7bCww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qJRP1NXdY+o=;B5ubRGLUCw507UJCHtBc5mn8H/6
 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
 QnIFwRibnUK2gL4oP4CI2V4eA94=

Some lower end hardware (especially Realtek based switches) are
designed with multiple I2C busses that share a single clock
(SCL) line. E.g. the D-Link DGS-1250-28X realizes 4 I2C SFP busses
with 5 gpios.

Provide a i2c-gpio-shared driver that handles such hardware designs.
It manages up to 32 buses that share a single SCL line. All data
transfers (including recovery) are synchronized with a central mutex.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/i2c/busses/Kconfig           |  10 ++
 drivers/i2c/busses/Makefile          |   1 +
 drivers/i2c/busses/i2c-gpio-shared.c | 257 +++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-gpio-shared.c

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867a37..fa05db759b15 100644
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
+	  a single SCL line. It can handle up to 32 buses, where N shared I2C
+	  buses are implemented with N+1 GPIO.
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
index 000000000000..4c2e4011fcbf
=2D-- /dev/null
+++ b/drivers/i2c/busses/i2c-gpio-shared.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Bitbanging driver for up to 32 I2C buses that share a single SCL pin *=
/
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+#define MAX_BUSES 32
+
+struct gpio_shared_ctx;
+
+struct gpio_shared_bus {
+	struct gpio_desc *sda;
+	struct i2c_adapter adap;
+	struct i2c_algo_bit_data bit_data;
+	struct i2c_bus_recovery_info recovery_info;
+	struct gpio_shared_ctx *ctx;
+};
+
+struct gpio_shared_ctx {
+	struct gpio_desc *scl;
+	struct mutex lock;
+	struct gpio_shared_bus bus[];
+};
+
+static struct gpio_shared_bus *adap_to_bus(struct i2c_adapter *adap)
+{
+	return container_of(adap, struct gpio_shared_bus, adap);
+}
+
+static struct gpio_shared_ctx *adap_to_ctx(struct i2c_adapter *adap)
+{
+	return adap_to_bus(adap)->ctx;
+}
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
+
+	gpiod_set_value_cansleep(bus->ctx->scl, state);
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
+
+	return gpiod_get_value_cansleep(bus->ctx->scl);
+}
+
+static int gpio_shared_pre_xfer(struct i2c_adapter *adap)
+{
+	return mutex_lock_interruptible(&adap_to_ctx(adap)->lock);
+}
+
+static void gpio_shared_recovery_set_scl(struct i2c_adapter *adap, int va=
l)
+{
+	gpiod_set_value_cansleep(adap_to_ctx(adap)->scl, val);
+}
+
+static int gpio_shared_recovery_get_scl(struct i2c_adapter *adap)
+{
+	return gpiod_get_value_cansleep(adap_to_ctx(adap)->scl);
+}
+
+static void gpio_shared_recovery_set_sda(struct i2c_adapter *adap, int va=
l)
+{
+	gpiod_set_value_cansleep(adap_to_bus(adap)->sda, val);
+}
+
+static int gpio_shared_recovery_get_sda(struct i2c_adapter *adap)
+{
+	return gpiod_get_value_cansleep(adap_to_bus(adap)->sda);
+}
+
+static void gpio_shared_prepare_recovery(struct i2c_adapter *adap)
+{
+	mutex_lock(&adap_to_ctx(adap)->lock);
+}
+
+static void gpio_shared_unlock(struct i2c_adapter *adap)
+{
+	mutex_unlock(&adap_to_ctx(adap)->lock);
+}
+
+static void gpio_shared_del_adapter(void *data)
+{
+	i2c_del_adapter(data);
+}
+
+static int gpio_shared_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	int bus_count, sda_count, ret;
+	struct gpio_shared_ctx *ctx;
+	u32 used_buses =3D 0;
+
+	bus_count =3D device_get_child_node_count(dev);
+	if (!bus_count)
+		return dev_err_probe(dev, -EINVAL, "no buses defined\n");
+
+	if (bus_count > MAX_BUSES)
+		return dev_err_probe(dev, -EINVAL, "maximum of %d buses allowed\n", MAX=
_BUSES);
+
+	sda_count =3D gpiod_count(dev, "sda");
+	if (sda_count < 0)
+		return dev_err_probe(dev, sda_count, "sda-gpios missing\n");
+
+	if (sda_count !=3D bus_count)
+		return dev_err_probe(dev, -EINVAL,
+				     "sda-gpios count (%d) must match child node count (%d)\n",
+				     sda_count, bus_count);
+
+	ctx =3D devm_kzalloc(dev, struct_size(ctx, bus, bus_count), GFP_KERNEL);
+	if (!ctx)
+		return dev_err_probe(dev, -ENOMEM, "memory allocation failed\n");
+
+	ret =3D devm_mutex_init(dev, &ctx->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "mutex initialization failed\n");
+
+	platform_set_drvdata(pdev, ctx);
+
+	ctx->scl =3D devm_gpiod_get(dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
+	if (IS_ERR(ctx->scl))
+		return dev_err_probe(dev, PTR_ERR(ctx->scl), "shared SCL GPIO not found=
\n");
+
+	device_for_each_child_node_scoped(dev, child) {
+		struct i2c_algo_bit_data *bit_data;
+		struct i2c_bus_recovery_info *ri;
+		struct gpio_shared_bus *bus;
+		struct i2c_adapter *adap;
+		u32 bus_num, clock_freq;
+
+		/* Use the child's reg value as the index into the sda-gpios array. */
+		ret =3D fwnode_property_read_u32(child, "reg", &bus_num);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "missing reg property in child node\n");
+
+		if (bus_num >=3D sda_count)
+			return dev_err_probe(dev, -EINVAL,
+					     "reg value %u out of range (max %d)\n",
+					     bus_num, sda_count - 1);
+
+		if (used_buses & BIT(bus_num))
+			return dev_err_probe(dev, -EINVAL,
+					     "duplicate definition of bus %d\n", bus_num);
+
+		bus =3D &ctx->bus[bus_num];
+		bit_data =3D &bus->bit_data;
+		ri =3D &bus->recovery_info;
+		adap =3D &bus->adap;
+
+		bus->sda =3D devm_gpiod_get_index(dev, "sda", bus_num,
+						GPIOD_OUT_HIGH_OPEN_DRAIN);
+		if (IS_ERR(bus->sda))
+			return dev_err_probe(dev, PTR_ERR(bus->sda),
+					     "SDA GPIO for bus %u not found\n", bus_num);
+		/*
+		 * Data transfer synchronization between multiple busses is realized by=
 mutex
+		 * locking/unlocking within pre_xfer and post_xfer helpers.
+		 */
+		bus->ctx =3D ctx;
+		bit_data->data =3D bus;
+		bit_data->setsda =3D gpio_shared_setsda;
+		bit_data->setscl =3D gpio_shared_setscl;
+		bit_data->getsda =3D gpio_shared_getsda;
+		bit_data->getscl =3D gpio_shared_getscl;
+		bit_data->pre_xfer =3D gpio_shared_pre_xfer;
+		bit_data->post_xfer =3D gpio_shared_unlock;
+		bit_data->timeout =3D msecs_to_jiffies(100);
+		/*
+		 * clock-frequency specifies the I2C bus frequency. Convert to the half=
-period
+		 * delay in microseconds that i2c-algo-bit expects. Default to 5 us (~1=
00 kHz)
+		 * if not specified. This is usually lower than the configured frequenc=
y,
+		 * especially near the 400 kHz limit.
+		 */
+		if (!fwnode_property_read_u32(child, "clock-frequency", &clock_freq) &&
+		    clock_freq > 0)
+			bit_data->udelay =3D max(1u, DIV_ROUND_UP(1000000, 2 * clock_freq));
+		else
+			bit_data->udelay =3D 5;
+		/*
+		 * i2c_recover_bus() is called by the I2C core without going through pr=
e_xfer
+		 * and post_xfer. So the shared SCL mutex is NOT held at that point. Pr=
ovide
+		 * prepare_recovery/unprepare_recovery to explicitly prevent concurrent=
 SCL
+		 * access from another bus.
+		 */
+		ri->recover_bus =3D i2c_generic_scl_recovery;
+		ri->set_scl =3D gpio_shared_recovery_set_scl;
+		ri->get_scl =3D gpio_shared_recovery_get_scl;
+		ri->set_sda =3D gpio_shared_recovery_set_sda;
+		ri->get_sda =3D gpio_shared_recovery_get_sda;
+		ri->prepare_recovery =3D gpio_shared_prepare_recovery;
+		ri->unprepare_recovery =3D gpio_shared_unlock;
+
+		adap->dev.parent =3D dev;
+		adap->owner =3D THIS_MODULE;
+		adap->algo_data =3D bit_data;
+		adap->bus_recovery_info =3D ri;
+		device_set_node(&adap->dev, child);
+		snprintf(adap->name, sizeof(adap->name), "i2c-gpio-shared:%u", bus_num)=
;
+
+		ret =3D devm_add_action_or_reset(dev, gpio_shared_del_adapter, adap);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "bus %u cleanup registration failed\n", bus_num);
+
+		ret =3D i2c_bit_add_bus(adap);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to register bus %u\n", bus_num)=
;
+
+		dev_info(dev, "registered I2C bus %u with shared SCL (udelay %d us)\n",
+			 bus_num, bit_data->udelay);
+
+		used_buses |=3D BIT(bus_num);
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
+MODULE_AUTHOR("Markus Stockhausen <markus.stockhausen@gmx.de>");
+MODULE_DESCRIPTION("bitbanging multi I2C driver for shared SCL");
=2D-=20
2.54.0

