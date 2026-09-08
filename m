Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E23953D0D0;
	Tue,  8 Sep 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871356; cv=none; b=R1ARIa355f4JLNpiamuWVf1EaSZ+WeIKZMhEsxM1SJsKhVMyvHjCDmMO1FTYklbDEZFREgtf+XbpSbaqrsXzl4A1ZvOZZChFtXgNdmFWIEZQFEQe7GtirOGZgg1bggigORbYPTCv7VtOLLB1rCmTMFuGV6CjIcSFvkDFmZDuYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871356; c=relaxed/simple;
	bh=mG6VMgXewG0BSEDj8aWtQhIGRmlfqNWnj5PMzCHkxCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s9HoSK9RDt05X1hZa33B9Vv15PtWLVveAaUbLaM19wfx0Qzxi01jCCq/YwtW5qW0erKdVP0Q9ZRnaIIK0xcfV3SvaFCEXoL3/v3kPnyjJU+2djJNLsVtDBoTJNjh+xZL38cD/HBv8WMXJXz/wNRQXGJ+Sqp1nOFUdl9gr9twIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BF961A00B5;
	Tue,  8 Sep 2026 14:32:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA5181A0044;
	Tue,  8 Sep 2026 14:32:34 +0200 (CEST)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EF08818000B5;
	Tue,  8 Sep 2026 20:32:31 +0800 (+08)
From: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peda@lysator.liu.se,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Subject: [PATCH 2/2] i2c: mux: Add NXP PCA9641 I2C bus master arbiter driver
Date: Tue,  8 Sep 2026 18:01:46 +0530
Message-Id: <20260908123146.1839854-3-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908123146.1839854-1-shivprakash.gupta@nxp.com>
References: <20260908123146.1839854-1-shivprakash.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add a driver for the NXP PCA9641 2-to-1 I2C bus master arbiter.

The PCA9641 allows two upstream I2C masters to share a single downstream
slave bus using a lock/grant protocol: a master asserts LOCK_REQ, waits
for LOCK_GRANT, sets BUS_CONNECT to open the switch, performs transactions,
then clears LOCK_REQ to release the bus.

The driver supports interrupt-assisted arbitration when INT0/INT1 is
connected to a GPIO. A threaded IRQ handler signals a completion variable
that select_chan() waits on, avoiding busy-polling. Polling mode is used
when no interrupt is configured.

Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
---
 MAINTAINERS                         |   7 +
 drivers/i2c/muxes/Kconfig           |  15 ++
 drivers/i2c/muxes/Makefile          |   1 +
 drivers/i2c/muxes/i2c-mux-pca9641.c | 395 ++++++++++++++++++++++++++++
 4 files changed, 418 insertions(+)
 create mode 100644 drivers/i2c/muxes/i2c-mux-pca9641.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6215fcb07770..2b02090edc9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12250,6 +12250,13 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-nvidia-gpu.rst
 F:	drivers/i2c/busses/i2c-nvidia-gpu.c
 
+NXP PCA9641 I2C BUS MASTER ARBITER DRIVER
+M:	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml
+F:	drivers/i2c/muxes/i2c-mux-pca9641.c
+
 I2C MUXES
 M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-i2c@vger.kernel.org
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 6d2f66810cdc..0caff9592466 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -64,6 +64,21 @@ config I2C_MUX_PCA9541
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mux-pca9541.
 
+config I2C_MUX_PCA9641
+	tristate "NXP PCA9641 I2C Master Arbiter"
+	help
+	  If you say yes here you get support for the NXP PCA9641
+	  2-to-1 I2C bus master arbiter.
+
+	  The PCA9641 arbitrates between two upstream I2C masters competing
+	  for a single downstream slave bus. It implements a lock/grant
+	  ownership model with an optional reserve time window, hardware
+	  interrupt outputs (INT0/INT1), and a 16-bit shared mailbox for
+	  inter-master communication.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mux-pca9641.
+
 config I2C_MUX_PCA954x
 	tristate "NXP PCA954x/PCA984x and Maxim MAX735x/MAX736x I2C Mux/switches"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 4b24f49515a7..a50df4013224 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_I2C_MUX_LTC4306)	+= i2c-mux-ltc4306.o
 obj-$(CONFIG_I2C_MUX_MLXCPLD)	+= i2c-mux-mlxcpld.o
 obj-$(CONFIG_I2C_MUX_MULE)	+= i2c-mux-mule.o
 obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
+obj-$(CONFIG_I2C_MUX_PCA9641)	+= i2c-mux-pca9641.o
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
 obj-$(CONFIG_I2C_MUX_PINCTRL)	+= i2c-mux-pinctrl.o
 obj-$(CONFIG_I2C_MUX_REG)	+= i2c-mux-reg.o
diff --git a/drivers/i2c/muxes/i2c-mux-pca9641.c b/drivers/i2c/muxes/i2c-mux-pca9641.c
new file mode 100644
index 000000000000..c12aa88dcf56
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-mux-pca9641.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I2C multiplexer driver for PCA9641 2-to-1 I2C bus master arbiter
+ *
+ * Copyright (C) 2026 Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
+ *
+ * Based on i2c-mux-pca9541.c by Guenter Roeck <linux@roeck-us.net>
+ *
+ * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCA9641.pdf
+ */
+
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+/* Register addresses, selected via the 3 LSBs of the command code byte */
+#define PCA9641_ID          0x00  /* Device ID register (R only, value 0x38) */
+#define PCA9641_CONTR       0x01  /* Control register (R/W) */
+#define PCA9641_STATUS      0x02  /* Status register (R/W) */
+#define PCA9641_RT          0x03  /* Reserve Time register (R/W) */
+#define PCA9641_INT_STATUS  0x04  /* Interrupt Status register (R/W, sticky) */
+#define PCA9641_INT_MSK     0x05  /* Interrupt Mask register (R/W) */
+#define PCA9641_MB_LO       0x06  /* Mailbox low byte (R/W) */
+#define PCA9641_MB_HI       0x07  /* Mailbox high byte (R/W) */
+
+/* CONTR register (0x01) bit definitions */
+#define PCA9641_CTL_LOCK_REQ        BIT(0)  /* Request downstream bus ownership */
+#define PCA9641_CTL_LOCK_GRANT      BIT(1)  /* Downstream bus granted (R only) */
+#define PCA9641_CTL_BUS_CONNECT     BIT(2)  /* Connect master to downstream bus */
+#define PCA9641_CTL_BUS_INIT        BIT(3)  /* Trigger bus init/recovery (9 clocks) */
+#define PCA9641_CTL_SMBUS_SWRST     BIT(4)  /* Assert SCL LOW 35 ms after soft reset */
+#define PCA9641_CTL_IDLE_TIMER_DIS  BIT(5)  /* Disconnect after 100 ms bus idle */
+#define PCA9641_CTL_SMBUS_DIS       BIT(6)  /* Disconnect on SMBus timeout detection */
+#define PCA9641_CTL_PRIORITY        BIT(7)  /* Tie-break priority when both request */
+
+/* STATUS register (0x02) bit definitions (datasheet Section 8.3) */
+#define PCA9641_STA_OTHER_LOCK      BIT(0)  /* Other master currently holds the lock (R only) */
+#define PCA9641_STA_SCL_IO          BIT(6)  /* Manual SCL I/O (LOCK_GRANT=1, BUS_CONNECT=0) */
+#define PCA9641_STA_SDA_IO          BIT(7)  /* Manual SDA I/O (LOCK_GRANT=1, BUS_CONNECT=0) */
+
+/* INT_STATUS register (0x04) bit definitions (sticky, clear by writing 1) */
+#define PCA9641_INTS_INT_IN         BIT(0)  /* Interrupt received on INT_IN pin */
+#define PCA9641_INTS_BUS_LOST       BIT(1)  /* This master involuntarily lost the bus */
+#define PCA9641_INTS_LOCK_GRANT     BIT(2)  /* This master was granted the bus */
+#define PCA9641_INTS_TEST_INT       BIT(3)  /* Self-test interrupt triggered */
+#define PCA9641_INTS_MBOX_EMPTY     BIT(4)  /* Sent mailbox data was read by other master */
+#define PCA9641_INTS_MBOX_FULL      BIT(5)  /* New mailbox data received from other master */
+#define PCA9641_INTS_BUS_HUNG       BIT(6)  /* Bus hung condition detected */
+
+/* INT_MSK register (0x05) bit definitions (1 = masked/disabled, POR = 0x7F) */
+#define PCA9641_MSK_INT_IN          BIT(0)
+#define PCA9641_MSK_BUS_LOST        BIT(1)
+#define PCA9641_MSK_LOCK_GRANT      BIT(2)
+#define PCA9641_MSK_TEST_INT        BIT(3)
+#define PCA9641_MSK_MBOX_EMPTY      BIT(4)
+#define PCA9641_MSK_MBOX_FULL       BIT(5)
+#define PCA9641_MSK_BUS_HUNG        BIT(6)
+
+/* POR value of INT_MSK: all interrupt sources masked */
+#define PCA9641_INT_MSK_ALL         0x7Fu
+
+/*
+ * Interrupt mask value that enables only LOCK_GRANT and BUS_LOST.
+ * All other sources remain masked (bit = 1 means masked).
+ */
+#define PCA9641_INT_MSK_ARB \
+	(PCA9641_INT_MSK_ALL & ~(PCA9641_MSK_LOCK_GRANT | PCA9641_MSK_BUS_LOST))
+
+/* Value in ID register that uniquely identifies PCA9641 (vs. PCA9541) */
+#define PCA9641_ID_MAGIC            0x38u
+
+/* Arbitration retry delays (microseconds) */
+#define PCA9641_DELAY_SHORT         50u
+#define PCA9641_DELAY_LONG          1000u
+
+/**
+ * struct pca9641 - per-device driver state
+ * @client:          I2C client for the arbiter device
+ * @select_timeout:  Current polling retry delay in microseconds
+ * @irq:             Linux IRQ number for INT0/INT1 GPIO, or -1 if not used
+ * @lock_grant_comp: Completion signaled from the IRQ handler on LOCK_GRANT
+ */
+struct pca9641 {
+	struct i2c_client *client;
+	unsigned long select_timeout;
+	int irq;
+	struct completion lock_grant_comp;
+};
+
+static const struct i2c_device_id pca9641_id[] = {
+	{ "pca9641" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pca9641_id);
+
+static const struct of_device_id pca9641_of_match[] = {
+	{ .compatible = "nxp,pca9641" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pca9641_of_match);
+
+/*
+ * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
+ * as they will try to lock the adapter a second time.
+ */
+static int pca9641_reg_write(struct i2c_client *client, u8 reg, u8 val)
+{
+	union i2c_smbus_data data = { .byte = val };
+
+	return __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				I2C_SMBUS_WRITE, reg,
+				I2C_SMBUS_BYTE_DATA, &data);
+}
+
+/*
+ * Read from chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
+ * as they will try to lock adapter a second time.
+ */
+static int pca9641_reg_read(struct i2c_client *client, u8 reg)
+{
+	union i2c_smbus_data data;
+	int ret;
+
+	ret = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			       I2C_SMBUS_READ, reg,
+			       I2C_SMBUS_BYTE_DATA, &data);
+
+	return ret ? ret : (int)data.byte;
+}
+
+/* Release bus ownership. */
+static void pca9641_release_bus(struct i2c_client *client)
+{
+	pca9641_reg_write(client, PCA9641_CONTR, 0x00);
+}
+
+/*
+ * Threaded IRQ handler for INT0/INT1. Signals the completion waited on by
+ * pca9641_select_chan(). No I2C access here to avoid deadlock on the adapter
+ * mutex held by select_chan().
+ */
+static irqreturn_t pca9641_irq_handler(int irq, void *dev_id)
+{
+	struct pca9641 *data = dev_id;
+
+	complete(&data->lock_grant_comp);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Arbitration management. Asserts LOCK_REQ and checks LOCK_GRANT to acquire
+ * the downstream bus. Returns 1 when acquired, 0 to retry, <0 on error.
+ */
+static int pca9641_arbitrate(struct i2c_client *client)
+{
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca9641 *data = i2c_mux_priv(muxc);
+	int ctrl, status, ret;
+
+	ctrl = pca9641_reg_read(client, PCA9641_CONTR);
+	if (ctrl < 0)
+		return ctrl;
+
+	if (ctrl & PCA9641_CTL_LOCK_GRANT) {
+		if (!(ctrl & PCA9641_CTL_BUS_CONNECT)) {
+			ret = pca9641_reg_write(client, PCA9641_CONTR,
+						(u8)(ctrl | PCA9641_CTL_BUS_CONNECT));
+			if (ret < 0)
+				return ret;
+		}
+		return 1;
+	}
+
+	if (!(ctrl & PCA9641_CTL_LOCK_REQ)) {
+		ret = pca9641_reg_write(client, PCA9641_CONTR,
+					(u8)(ctrl | PCA9641_CTL_LOCK_REQ));
+		if (ret < 0)
+			return ret;
+		data->select_timeout = PCA9641_DELAY_SHORT;
+		return 0;
+	}
+
+	status = pca9641_reg_read(client, PCA9641_STATUS);
+	if (status < 0)
+		return status;
+
+	data->select_timeout = (status & PCA9641_STA_OTHER_LOCK) ?
+				PCA9641_DELAY_LONG : PCA9641_DELAY_SHORT;
+
+	return 0;
+}
+
+/*
+ * Acquire the downstream bus before a transaction. Uses interrupt mode
+ * if IRQ is available, polling otherwise.
+ */
+static int pca9641_select_chan(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct pca9641 *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+	unsigned long timeout = jiffies + 2 * client->adapter->timeout;
+	int ctrl, ret;
+
+	if (data->irq > 0) {
+		reinit_completion(&data->lock_grant_comp);
+
+		ctrl = pca9641_reg_read(client, PCA9641_CONTR);
+		if (ctrl < 0)
+			return ctrl;
+
+		if (ctrl & PCA9641_CTL_LOCK_GRANT)
+			goto set_bus_connect;
+
+		ret = pca9641_reg_write(client, PCA9641_CONTR,
+					(u8)((ctrl & ~PCA9641_CTL_BUS_CONNECT) |
+					     PCA9641_CTL_LOCK_REQ));
+		if (ret < 0)
+			return ret;
+
+		if (!wait_for_completion_timeout(&data->lock_grant_comp,
+						 client->adapter->timeout)) {
+			ctrl = pca9641_reg_read(client, PCA9641_CONTR);
+			if (ctrl < 0)
+				return ctrl;
+			if (!(ctrl & PCA9641_CTL_LOCK_GRANT)) {
+				dev_warn(&client->dev,
+					 "Timed out waiting for bus grant\n");
+				return -ETIMEDOUT;
+			}
+			goto set_bus_connect;
+		}
+
+		ctrl = pca9641_reg_read(client, PCA9641_CONTR);
+		if (ctrl < 0)
+			return ctrl;
+
+		if (!(ctrl & PCA9641_CTL_LOCK_GRANT)) {
+			dev_warn(&client->dev,
+				 "Interrupt fired but LOCK_GRANT not set\n");
+			return -ETIMEDOUT;
+		}
+
+set_bus_connect:
+		(void)pca9641_reg_write(client, PCA9641_INT_STATUS,
+					PCA9641_INTS_LOCK_GRANT | PCA9641_INTS_BUS_LOST);
+
+		if (!(ctrl & PCA9641_CTL_BUS_CONNECT)) {
+			ret = pca9641_reg_write(client, PCA9641_CONTR,
+						(u8)(ctrl | PCA9641_CTL_BUS_CONNECT));
+			if (ret < 0)
+				return ret;
+		}
+		return 0;
+	}
+
+	do {
+		ret = pca9641_arbitrate(client);
+		if (ret)
+			return ret < 0 ? ret : 0;
+
+		if (data->select_timeout <= PCA9641_DELAY_SHORT)
+			udelay(data->select_timeout);
+		else
+			msleep(data->select_timeout / 1000);
+	} while (time_is_after_eq_jiffies(timeout));
+
+	dev_warn(&client->dev, "Failed to acquire I2C bus, timed out\n");
+	return -ETIMEDOUT;
+}
+
+/* Release the downstream bus after a transaction completes. */
+static int pca9641_release_chan(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct pca9641 *data = i2c_mux_priv(muxc);
+
+	pca9641_release_bus(data->client);
+	return 0;
+}
+
+static int pca9641_probe(struct i2c_client *client)
+{
+	struct i2c_adapter *adap = client->adapter;
+	struct i2c_mux_core *muxc;
+	struct pca9641 *data;
+	int id, ret;
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	id = i2c_smbus_read_byte_data(client, PCA9641_ID);
+	if (id < 0) {
+		dev_err(&client->dev, "Failed to read device ID: %d\n", id);
+		return id;
+	}
+	if ((u8)id != PCA9641_ID_MAGIC) {
+		dev_err(&client->dev,
+			"Unexpected device ID 0x%02x (expected 0x%02x for PCA9641)\n",
+			(u8)id, PCA9641_ID_MAGIC);
+		return -ENODEV;
+	}
+
+	/* Clear any stale bus ownership from a previous crash. */
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
+	pca9641_release_bus(client);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
+
+	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
+			     I2C_MUX_ARBITRATOR,
+			     pca9641_select_chan, pca9641_release_chan);
+	if (!muxc)
+		return -ENOMEM;
+
+	data = i2c_mux_priv(muxc);
+	data->client = client;
+	data->irq = -1;
+	init_completion(&data->lock_grant_comp);
+
+	i2c_set_clientdata(client, muxc);
+
+	/* Optional interrupt mode; fall back to polling on failure. */
+	if (client->irq > 0) {
+		ret = i2c_smbus_write_byte_data(client, PCA9641_INT_MSK,
+						PCA9641_INT_MSK_ARB);
+		if (ret < 0) {
+			dev_warn(&client->dev,
+				 "Failed to set interrupt mask (%d); using polling\n",
+				 ret);
+			goto add_adapter;
+		}
+
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, pca9641_irq_handler,
+						IRQF_ONESHOT | IRQF_SHARED,
+						dev_name(&client->dev), data);
+		if (ret < 0) {
+			dev_warn(&client->dev,
+				 "Failed to request IRQ %d (%d); using polling\n",
+				 client->irq, ret);
+			i2c_smbus_write_byte_data(client, PCA9641_INT_MSK,
+						  PCA9641_INT_MSK_ALL);
+		} else {
+			data->irq = client->irq;
+			dev_dbg(&client->dev,
+				"Interrupt mode enabled on IRQ %d\n",
+				client->irq);
+		}
+	}
+
+add_adapter:
+	ret = i2c_mux_add_adapter(muxc, 0, 0);
+	if (ret)
+		return ret;
+
+	dev_info(&client->dev,
+		 "PCA9641 I2C master arbiter registered (I2C bus %s, %s mode)\n",
+		 client->name,
+		 data->irq > 0 ? "interrupt" : "polling");
+
+	return 0;
+}
+
+static void pca9641_remove(struct i2c_client *client)
+{
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca9641 *data = i2c_mux_priv(muxc);
+
+	if (data->irq > 0)
+		(void)i2c_smbus_write_byte_data(client, PCA9641_INT_MSK,
+						PCA9641_INT_MSK_ALL);
+
+	i2c_mux_del_adapters(muxc);
+}
+
+static struct i2c_driver pca9641_driver = {
+	.driver = {
+		.name		= "pca9641",
+		.of_match_table	= pca9641_of_match,
+	},
+	.probe		= pca9641_probe,
+	.remove		= pca9641_remove,
+	.id_table	= pca9641_id,
+};
+
+module_i2c_driver(pca9641_driver);
+
+MODULE_AUTHOR("Shiv Prakash Gupta <shivprakash.gupta@nxp.com>");
+MODULE_DESCRIPTION("PCA9641 2-to-1 I2C bus master arbiter driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

