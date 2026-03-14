Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E0288C3D
	for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773451935; cv=none; b=lJYYhNNZs2uRN7wkMgsBSBOR5JJ4oWhcWMK8WK4sm+bB1zTf7m+G9wIYSIb/eoPyeK3rTwIfBr5I5N+1c6ur1UeRjM6rtmLwYde+0JNU2JyD+7FjZbL5nEo0+wgzt0eP6VxX7SeJ8P8EDjwGKkY2artGrTCnyu2uscQqm72DLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773451935; c=relaxed/simple;
	bh=p8T4E7480ILfoOrSFfqVs8pQWFIFxD+u2YFQz9fnNxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbK7YqbMEOOIKm2SNSihCmktA+warWIw5YaVeTtieJFb1JQGwivILv6H3w5WnsS3o77auvU5UzybZncM1xTjH0f2gD32Je5TS4clyjyIdj1LOVhu5ffMrkLJYVIgOLLSx1Baq/o5TqaEdinD29AFdMmRFt48xfRIrXWlkg/0dUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA1DBfzM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA1DBfzM"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so2534850f8f.1
        for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 18:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773451932; x=1774056732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvDWBNZNK1PJ+DFXrEgOI7FkazNpTVvzpyU4Do+y01s=;
        b=FA1DBfzMSq9HUDJmjQ3PFv0cBwqahnZsxgMIu0G0GzM9t6J8+vpwuLdf3H1hP2Ir6n
         JeG1Fh2uMIg41kydTFU5zELzenDn5EQF//AOx9pp3yQkbjGAeLoCwCW5hxig61Q32TvD
         rftXzBTk7l8KuiM5401ZPhgTbqxvr++ku/UI80rEmpcrQ1ssdXJPTbJnp+5haD3CxGOf
         addpHiWxKbICG7DRtIkvnic1r/aBEM98F8nfFVo89+ZgdEs3eHLFcXdMga4A+bzKbWwL
         xRIgBUWaAJ3fpmDELudj2L+g7SjNTrdj/tf+j0CgHpycE7uHEE/0M7Bsuhg8iGvMv/U5
         6KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773451932; x=1774056732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jvDWBNZNK1PJ+DFXrEgOI7FkazNpTVvzpyU4Do+y01s=;
        b=PUAg5fozajj/E9ec8tiJjhHIdXXt9DZorm+lj8EmzO3JyxAEPM4ljwRQ1ZjFQ+n04J
         uVjjIqI4MZnX2bK72v3EKeGnVrTMyJbZ+VcwrGn1L1ar2R47U1FTEiHmyfs5hN1Gorms
         DWU5hwzTnxHPPbmeNS8mEVVavEQISj942cQu763MHFQZZoPgn350Y8b7A12LI9fL0Cix
         aTQ3aSgpVSD5buzEt8fhU1f7BkapeUPWWAD+u9ctzRss6Egsz3xlXVWA3Azt6Ldfhct1
         D3ncriMsd6Zenhw2XHai71qZt/DRH4ZU1EJ6dZ2+QR9c8Y+3PNjG2Eyr++AAy1Mb/drk
         9yQQ==
X-Gm-Message-State: AOJu0YzrH6nCjpZW+7Sva09PxNmei8oyxLGzuHlOyWaXjC0vzU39/Ctm
	7VerZQveodTUXOC+qkAgaQRgQNrmppG9WIwWBpD6NIW251d0jyf+PwDrZbT+7OlVwoo=
X-Gm-Gg: ATEYQzzmKERsINY4dCl9gRrdIA/gCkVE8zL+dUDVn4qFavuplr53sDIs1T6pAyn6j7a
	H4IpTdx4JlMGj3cCIU149b0AX03bJcDL5gnEspF53lSPytlynWUav+vUuZ+ejCDrZMa+08Fvi4u
	75zccM/J3jzttzx6J7nVv0+ZgdDZAFeA+gmCPenp7AqiEs3031GXmv8g5CiINGpfuuxRKY562QT
	ywhSTEXKsD+6r2A0+qjCtR4mLws/PhL1j6rXatkRWKwnnJqcwEE36IpNZx28VqKeYgxsgxKz7eD
	GOiF4H0BuLAY7yEzrMyOwWGivr/ASABpE8lxYX1LSK6ISDHZ34JS760BvapXcR3bO+iFSlOncB1
	XNlCgBz9pG1BLlegZf7n/1mZjqsXLBQ1j+6H82eH2WQ3Brs54t6CA8XqTiu3SI9+ChNM/Tdcyzz
	Rzo255eO6SkJAPvMCAuJVXO8ynIbYnRzvnmhF0h33YO65JdSilXcXiwogoBA4J4EqKkbM21JpPY
	p5F6tW0C/Lm1k7usf1aReeqEK2fxpZko6cnN5Jv8J+VGzNqf+31egynBh/koJR8k+xU2Gr1P7FK
	/jnvWxgRrac=
X-Received: by 2002:a05:6000:1787:b0:439:c677:5145 with SMTP id ffacd0b85a97d-43a04d880e8mr9903496f8f.22.1773451932107;
        Fri, 13 Mar 2026 18:32:12 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm21876575f8f.31.2026.03.13.18.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:32:11 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: linux-i2c@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	wsa+renesas@sang-engineering.com,
	westeri@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edward Blair <edward.blair@gmail.com>
Subject: [PATCH 2/2] usb: typec: ucsi: add ITE885x I2C transport driver
Date: Sat, 14 Mar 2026 01:31:56 +0000
Message-ID: <20260314013157.7181-3-edward.blair@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314013157.7181-1-edward.blair@gmail.com>
References: <20260314013157.7181-1-edward.blair@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a UCSI transport driver for ITE8853/ITE8800-ITE8805 USB Type-C
controllers, commonly found on ASUS Z690/Z790/X670E motherboards.

These controllers implement the UCSI protocol over I2C with
ITE-proprietary register offsets and dedicated interrupt registers:

  - CCI at 0x84, MESSAGE_IN at 0x88, CONTROL at 0x98
  - INT_STATUS at 0xBD, INT_ACK at 0xBC
  - GPIO interrupt (level-triggered, active-low)

The ITE8853 does not accept PPM_RESET over I2C (the Windows driver
handles it internally), so the driver intercepts this command and
returns a synthetic reset-complete response.

Tested on ASUS ROG Strix Z790-E Gaming WiFi with ITE8853 at I2C
address 0x40 on the DesignWare I2C controller.

Signed-off-by: Edward Blair <edward.blair@gmail.com>
---
 drivers/usb/typec/ucsi/Kconfig    |  11 ++
 drivers/usb/typec/ucsi/Makefile   |   1 +
 drivers/usb/typec/ucsi/ucsi_ite.c | 285 ++++++++++++++++++++++++++++++
 3 files changed, 297 insertions(+)
 create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index 87dd992a4..455272b5a 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -104,4 +104,15 @@ config UCSI_HUAWEI_GAOKUN
 	  To compile the driver as a module, choose M here: the module will be
 	  called ucsi_huawei_gaokun.
 
+config UCSI_ITE
+	tristate "UCSI Interface Driver for ITE885x"
+	depends on I2C
+	help
+	  This driver enables UCSI support on platforms that expose an ITE8853
+	  or ITE8800-ITE8805 USB Type-C controller over I2C, commonly found
+	  on ASUS Z690/Z790/X670E motherboards.
+
+	  To compile the driver as a module, choose M here: the module will be
+	  called ucsi_ite.
+
 endif
diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
index c7e38bf01..9bc1d6bbb 100644
--- a/drivers/usb/typec/ucsi/Makefile
+++ b/drivers/usb/typec/ucsi/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
 obj-$(CONFIG_CROS_EC_UCSI)		+= cros_ec_ucsi.o
 obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)	+= ucsi_yoga_c630.o
 obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)	+= ucsi_huawei_gaokun.o
+obj-$(CONFIG_UCSI_ITE)			+= ucsi_ite.o
diff --git a/drivers/usb/typec/ucsi/ucsi_ite.c b/drivers/usb/typec/ucsi/ucsi_ite.c
new file mode 100644
index 000000000..400b844a1
--- /dev/null
+++ b/drivers/usb/typec/ucsi/ucsi_ite.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UCSI I2C transport driver for ITE885x USB-C controllers
+ *
+ * ITE8853/ITE8800-ITE8805 are UCSI-compliant USB-C controllers found on
+ * ASUS Z690/Z790/X670E motherboards. They communicate via I2C with
+ * ITE-proprietary register offsets and interrupt registers.
+ *
+ * Note: Some BIOS implementations declare both MSFT8000 (generic UCSI) and
+ * ITE8853 (vendor-specific) ACPI devices at the same I2C address. The i2c
+ * core skips the generic device when a vendor-specific sibling exists,
+ * allowing this driver to bind to the ITE8853 client with proper IRQ.
+ */
+
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include "ucsi.h"
+
+/* ITE-specific I2C register offsets */
+#define ITE_REG_CCI		0x84
+#define ITE_REG_MESSAGE_IN	0x88
+#define ITE_REG_CONTROL		0x98
+#define ITE_REG_INT_ACK		0xbc
+#define ITE_REG_INT_STATUS	0xbd
+
+/* INT_STATUS register bits */
+#define ITE_INT_VENDOR_ALERT	BIT(0)
+#define ITE_INT_CCI		BIT(1)
+
+/* INT_ACK register values */
+#define ITE_ACK_VENDOR		0x01
+#define ITE_ACK_CCI		0x02
+
+struct ucsi_ite {
+	struct device *dev;
+	struct i2c_client *client;
+	struct ucsi *ucsi;
+};
+
+static int ucsi_ite_read(struct ucsi_ite *ite, u8 reg, void *val, size_t len)
+{
+	struct i2c_msg msgs[] = {
+		{
+			.addr = ite->client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &reg,
+		},
+		{
+			.addr = ite->client->addr,
+			.flags = I2C_M_RD,
+			.len = len,
+			.buf = val,
+		},
+	};
+	int ret;
+
+	ret = i2c_transfer(ite->client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs)) {
+		dev_err(ite->dev, "i2c read 0x%02x failed: %d\n", reg, ret);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	return 0;
+}
+
+static int ucsi_ite_write(struct ucsi_ite *ite, u8 reg, const void *val,
+			  size_t len)
+{
+	struct i2c_msg msg = {
+		.addr = ite->client->addr,
+		.flags = 0,
+	};
+	u8 *buf;
+	int ret;
+
+	buf = kmalloc(len + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = reg;
+	memcpy(&buf[1], val, len);
+	msg.len = len + 1;
+	msg.buf = buf;
+
+	ret = i2c_transfer(ite->client->adapter, &msg, 1);
+	kfree(buf);
+	if (ret != 1) {
+		dev_err(ite->dev, "i2c write 0x%02x failed: %d\n", reg, ret);
+		return ret < 0 ? ret : -EIO;
+	}
+
+	return 0;
+}
+
+static int ucsi_ite_read_version(struct ucsi *ucsi, u16 *version)
+{
+	/*
+	 * The ITE8853 does not expose a UCSI VERSION register over I2C.
+	 * The Windows driver never reads it. Report UCSI 1.0.
+	 */
+	*version = UCSI_VERSION_1_0;
+	return 0;
+}
+
+static int ucsi_ite_read_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct ucsi_ite *ite = ucsi_get_drvdata(ucsi);
+
+	return ucsi_ite_read(ite, ITE_REG_CCI, cci, sizeof(*cci));
+}
+
+static int ucsi_ite_read_message_in(struct ucsi *ucsi, void *val, size_t len)
+{
+	struct ucsi_ite *ite = ucsi_get_drvdata(ucsi);
+
+	return ucsi_ite_read(ite, ITE_REG_MESSAGE_IN, val, len);
+}
+
+static int ucsi_ite_async_control(struct ucsi *ucsi, u64 command)
+{
+	struct ucsi_ite *ite = ucsi_get_drvdata(ucsi);
+
+	return ucsi_ite_write(ite, ITE_REG_CONTROL, &command, sizeof(command));
+}
+
+static int ucsi_ite_sync_control(struct ucsi *ucsi, u64 command, u32 *cci,
+				 void *data, size_t size)
+{
+	/*
+	 * The ITE8853 handles PPM_RESET internally and does not accept it
+	 * over I2C — the Windows driver never sends it. Fake a successful
+	 * reset so the UCSI core can proceed with initialization.
+	 */
+	if ((command & 0xff) == UCSI_PPM_RESET) {
+		if (cci)
+			*cci = UCSI_CCI_RESET_COMPLETE;
+		return 0;
+	}
+
+	return ucsi_sync_control_common(ucsi, command, cci, data, size);
+}
+
+static const struct ucsi_operations ucsi_ite_ops = {
+	.read_version = ucsi_ite_read_version,
+	.read_cci = ucsi_ite_read_cci,
+	.poll_cci = ucsi_ite_read_cci,
+	.read_message_in = ucsi_ite_read_message_in,
+	.sync_control = ucsi_ite_sync_control,
+	.async_control = ucsi_ite_async_control,
+};
+
+static irqreturn_t ucsi_ite_irq(int irq, void *data)
+{
+	struct ucsi_ite *ite = data;
+	u8 status;
+	u32 cci;
+	u8 ack;
+	int ret;
+
+	ret = ucsi_ite_read(ite, ITE_REG_INT_STATUS, &status, sizeof(status));
+	if (ret)
+		return IRQ_NONE;
+
+	if (!(status & (ITE_INT_CCI | ITE_INT_VENDOR_ALERT)))
+		return IRQ_NONE;
+
+	if (status & ITE_INT_CCI) {
+		ack = ITE_ACK_CCI;
+		ucsi_ite_write(ite, ITE_REG_INT_ACK, &ack, sizeof(ack));
+
+		ret = ucsi_ite_read(ite, ITE_REG_CCI, &cci, sizeof(cci));
+		if (!ret)
+			ucsi_notify_common(ite->ucsi, cci);
+	}
+
+	if (status & ITE_INT_VENDOR_ALERT) {
+		ack = ITE_ACK_VENDOR;
+		ucsi_ite_write(ite, ITE_REG_INT_ACK, &ack, sizeof(ack));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ucsi_ite_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct ucsi_ite *ite;
+	int ret;
+
+	ite = devm_kzalloc(dev, sizeof(*ite), GFP_KERNEL);
+	if (!ite)
+		return -ENOMEM;
+
+	ite->dev = dev;
+	ite->client = client;
+	i2c_set_clientdata(client, ite);
+
+	ite->ucsi = ucsi_create(dev, &ucsi_ite_ops);
+	if (IS_ERR(ite->ucsi))
+		return PTR_ERR(ite->ucsi);
+
+	ucsi_set_drvdata(ite->ucsi, ite);
+
+	ret = request_threaded_irq(client->irq, NULL, ucsi_ite_irq,
+				   IRQF_ONESHOT, dev_name(dev), ite);
+	if (ret) {
+		dev_err(dev, "failed to request IRQ: %d\n", ret);
+		goto err_destroy;
+	}
+
+	ret = ucsi_register(ite->ucsi);
+	if (ret) {
+		dev_err(dev, "failed to register UCSI: %d\n", ret);
+		goto err_free_irq;
+	}
+
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, ite);
+err_destroy:
+	ucsi_destroy(ite->ucsi);
+	return ret;
+}
+
+static void ucsi_ite_remove(struct i2c_client *client)
+{
+	struct ucsi_ite *ite = i2c_get_clientdata(client);
+
+	ucsi_unregister(ite->ucsi);
+	free_irq(client->irq, ite);
+	ucsi_destroy(ite->ucsi);
+}
+
+static int ucsi_ite_suspend(struct device *dev)
+{
+	struct ucsi_ite *ite = dev_get_drvdata(dev);
+
+	disable_irq(ite->client->irq);
+
+	return 0;
+}
+
+static int ucsi_ite_resume(struct device *dev)
+{
+	struct ucsi_ite *ite = dev_get_drvdata(dev);
+
+	enable_irq(ite->client->irq);
+
+	return ucsi_resume(ite->ucsi);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ucsi_ite_pm, ucsi_ite_suspend,
+				ucsi_ite_resume);
+
+static const struct acpi_device_id ucsi_ite_acpi_ids[] = {
+	{ "ITE8853" },
+	{ "ITE8800" },
+	{ "ITE8801" },
+	{ "ITE8802" },
+	{ "ITE8803" },
+	{ "ITE8804" },
+	{ "ITE8805" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, ucsi_ite_acpi_ids);
+
+static struct i2c_driver ucsi_ite_driver = {
+	.driver = {
+		.name = "ucsi_ite",
+		.acpi_match_table = ucsi_ite_acpi_ids,
+		.pm = pm_sleep_ptr(&ucsi_ite_pm),
+	},
+	.probe = ucsi_ite_probe,
+	.remove = ucsi_ite_remove,
+};
+module_i2c_driver(ucsi_ite_driver);
+
+MODULE_AUTHOR("Edward Blair <edward.blair@gmail.com>");
+MODULE_DESCRIPTION("UCSI I2C transport driver for ITE885x USB-C controllers");
+MODULE_LICENSE("GPL");
-- 
2.53.0

