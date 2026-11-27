Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771829;
	b=qipHCEbsWr5zIvANoLkbB/kG0cDBpW5SbcBJEdxTi3FKp+N/sIxdfYDgKyF0KbKVVV3Y
	 MLq+n8v7x4EEXH9IgeHvNu1LeCXgh0WYSxsYu6HVKAQ7DFnsV+0cb9f+RjaFHnK3Ajo7J
	 3yQLMhR+GKtl9Oqj3ngOAvzI62/jnCD5Bpf9GVofKvax8UJqjWDCKJObmJW1Y5h40dVZ1
	 eQqFsWFqiphIbkE1mm9xyVZ8Qqa7jIPT1ZxmjBxRFtwVtCRYp2nhh9IpHlyW8uII1cb5I
	 LrPOn1xqHQj7jZjAQjw3xG4PiF9fy6FUmyft/XFDt7vQr+nbyFu4zwoqi+Nvv3Bf9CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771829;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=kbYNNhBz6CwZpMRT22iSiPDx3yk5IGhzvctdNhPZigE=;
	b=MBw/oAZJ7UPkp53EtZuL9Q/rmr7GdCEDpp4KaieexT07Kygnw90eB0gti73dt12U8zy3
	 mzZ5GlFTCoUNIWkO4PhaGcuR42oef/os/APghN82b24KSdgX0BPQJUxxzbBBKUOBaI2zY
	 CIICRun4bdAE99bSGGk1jv/TCPEfzLI86LuzlbTb/EHcUJyVd2qxZwtQSn8EhRVcrGZlg
	 S2YJ/zu6OswOUeGS/T7sK/+hu/AHK45Y26WevoLObAKRQ1BEeycEnueN3jtPdHV4EGaeT
	 9P1zRyafduZaTT8TMrL7d7lIAjtfCAAVpVkTcoHoKk0SuwkI0QzE+yv46ZXvdzyyHsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	arc=none smtp.remote-ip=92.121.34.21
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFC606A335;
	Fri, 27 Nov 2026 09:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CCFC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E96A720001A;
	Fri, 27 Nov 2026 10:30:25 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 969B2200018;
	Fri, 27 Nov 2026 10:30:25 +0100 (CET)
Received: from lsv031125.swis.in-blr01.nxp.com (lsv031125.swis.in-blr01.nxp.com [10.12.177.172])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3DCAF18000B7;
	Fri, 27 Nov 2026 17:30:23 +0800 (+08)
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
Subject: [PATCH v3 2/2] i2c: mux: Add NXP PCA9641 I2C bus master arbiter driver
Date: Fri, 27 Nov 2026 15:00:13 +0530
Message-Id: <20261127093013.2857245-3-shivprakash.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127093013.2857245-1-shivprakash.gupta@nxp.com>
References: <20261127093013.2857245-1-shivprakash.gupta@nxp.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add a driver for the NXP PCA9641 2-to-1 I2C bus master arbiter.

The PCA9641 allows two upstream I2C masters to share a single downstream
slave bus using a lock/grant protocol: a master asserts LOCK_REQ, waits
for LOCK_GRANT, sets BUS_CONNECT to close the switch, performs
transactions, then clears LOCK_REQ to release the bus.

The driver supports interrupt-assisted arbitration when INT0/INT1 is
connected to a GPIO. The interrupt is requested as an exclusive hard IRQ
that is disabled while idle and armed only in select_chan(). The handler
disables the line and wakes the waiter, which always re-reads LOCK_GRANT.
Polling mode is used when no usable interrupt is configured.

Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
---
 MAINTAINERS                         |   7 +
 drivers/i2c/muxes/Kconfig           |  15 +
 drivers/i2c/muxes/Makefile          |   1 +
 drivers/i2c/muxes/i2c-mux-pca9641.c | 468 ++++++++++++++++++++++++++++
 4 files changed, 491 insertions(+)
 create mode 100644 drivers/i2c/muxes/i2c-mux-pca9641.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 742c4e6b291f..78d74ceb1822 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20333,6 +20333,13 @@ L:	linux-i3c@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/i3c/nxp,p3h2840.yaml
 
+NXP PCA9641 I2C BUS MASTER ARBITER DRIVER
+M:	Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/nxp,pca9641.yaml
+F:	drivers/i2c/muxes/i2c-mux-pca9641.c
+
 NXP PF5300/PF5301/PF5302 PMIC REGULATOR DEVICE DRIVER
 M:	Woodrow Douglass <wdouglass@carnegierobotics.com>
 S:	Maintained
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 6d2f66810cdc..57d2ae8b30f7 100644
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
+	  for a single downstream slave bus using a lock/grant ownership
+	  model. The driver waits for ownership by polling or, when an
+	  interrupt line is described and usable, by using the INT0/INT1
+	  output. Atomic I2C transfers are not supported.
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
index 000000000000..b7a7ed421219
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-mux-pca9641.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I2C bus master arbiter driver for the NXP PCA9641
+ *
+ * Copyright (C) 2026 Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
+ * Based on i2c-mux-pca9541.c by Guenter Roeck <linux@roeck-us.net>
+ *
+ * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCA9641.pdf
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/preempt.h>
+#include <linux/workqueue.h>
+
+#define PCA9641_ID		0x00
+#define PCA9641_CONTR		0x01
+#define PCA9641_RT		0x03
+#define PCA9641_INT_STATUS	0x04
+#define PCA9641_INT_MSK		0x05
+
+#define PCA9641_CTL_LOCK_REQ	BIT(0)
+#define PCA9641_CTL_LOCK_GRANT	BIT(1)
+#define PCA9641_CTL_BUS_CONNECT	BIT(2)
+
+#define PCA9641_INTS_BUS_LOST	BIT(1)
+#define PCA9641_INTS_LOCK_GRANT	BIT(2)
+#define PCA9641_INTS_ARB	(PCA9641_INTS_BUS_LOST | PCA9641_INTS_LOCK_GRANT)
+#define PCA9641_MSK_ALL		0x7f
+#define PCA9641_MSK_GRANT_ONLY	(PCA9641_MSK_ALL & ~PCA9641_INTS_LOCK_GRANT)
+
+#define PCA9641_ID_MAGIC	0x38
+#define PCA9641_POLL_US		1000
+#define PCA9641_IRQ_CHECK_MS	50
+#define PCA9641_RECOVERY_MS	100
+
+struct pca9641 {
+	struct i2c_client *client;
+	struct completion grant;
+	struct delayed_work recovery_work;
+	atomic_t irq_fired;
+	int irq;
+	bool selected;
+	bool release_pending;
+	bool irq_cleanup_pending;
+};
+
+/* The mux core holds the parent adapter lock around select and deselect. */
+static int pca9641_reg_write(struct i2c_client *client, u8 reg, u8 val)
+{
+	union i2c_smbus_data data = { .byte = val };
+
+	return __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				I2C_SMBUS_WRITE, reg, I2C_SMBUS_BYTE_DATA,
+				&data);
+}
+
+static int pca9641_reg_read(struct i2c_client *client, u8 reg)
+{
+	union i2c_smbus_data data;
+	int ret;
+
+	ret = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			       I2C_SMBUS_READ, reg, I2C_SMBUS_BYTE_DATA,
+			       &data);
+	return ret ?: data.byte;
+}
+
+/* No atomic transfers: the arbiter can wait for an external master. */
+static bool pca9641_cannot_sleep(void)
+{
+	return irqs_disabled() ||
+	       (IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preemptible());
+}
+
+/* Retain failure state because the mux core may discard deselect errors. */
+static int pca9641_release_bus(struct pca9641 *data)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+
+	ret = pca9641_reg_write(client, PCA9641_CONTR, 0);
+	if (ret)
+		ret = pca9641_reg_write(client, PCA9641_CONTR, 0);
+	data->release_pending = !!ret;
+	if (ret)
+		dev_err_ratelimited(&client->dev,
+				    "Failed to release bus: %d\n", ret);
+	return ret;
+}
+
+static int pca9641_mask_irqs(struct pca9641 *data)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+
+	data->irq_cleanup_pending = true;
+	ret = pca9641_reg_write(client, PCA9641_INT_MSK, PCA9641_MSK_ALL);
+	if (ret)
+		return ret;
+
+	ret = pca9641_reg_write(client, PCA9641_INT_STATUS, PCA9641_INTS_ARB);
+	if (!ret)
+		data->irq_cleanup_pending = false;
+	return ret;
+}
+
+/* Retry failed cleanup even if no transfer follows; a peer may be waiting. */
+static void pca9641_schedule_recovery(struct pca9641 *data)
+{
+	if (data->release_pending || data->irq_cleanup_pending)
+		queue_delayed_work(system_freezable_wq, &data->recovery_work,
+				   msecs_to_jiffies(PCA9641_RECOVERY_MS));
+}
+
+static void pca9641_recovery_work(struct work_struct *work)
+{
+	struct pca9641 *data = container_of(to_delayed_work(work),
+					   struct pca9641, recovery_work);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	if (data->irq_cleanup_pending) {
+		ret = pca9641_mask_irqs(data);
+		if (ret)
+			dev_err_ratelimited(&client->dev,
+					    "Failed to mask/clear IRQ: %d\n", ret);
+	}
+	if (data->release_pending)
+		pca9641_release_bus(data);
+	pca9641_schedule_recovery(data);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+}
+
+/* No I2C access here (waiter holds the lock); disable the level IRQ first. */
+static irqreturn_t pca9641_irq_handler(int irq, void *dev_id)
+{
+	struct pca9641 *data = dev_id;
+
+	if (!atomic_xchg(&data->irq_fired, 1))
+		disable_irq_nosync(irq);
+	complete(&data->grant);
+
+	return IRQ_HANDLED;
+}
+
+/* Slow-bus irqchips may sleep or do I2C in bus-lock callbacks; poll instead. */
+static bool pca9641_irq_usable(unsigned int irq)
+{
+	unsigned int type = irq_get_trigger_type(irq);
+	struct irq_data *d = irq_get_irq_data(irq);
+	struct irq_chip *chip;
+
+	if (!d || (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_EDGE_FALLING))
+		return false;
+
+	while (d) {
+		chip = irq_data_get_irq_chip(d);
+		if (!chip || chip->irq_bus_lock || chip->irq_bus_sync_unlock)
+			return false;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+		d = d->parent_data;
+#else
+		break;
+#endif
+	}
+
+	return true;
+}
+
+static void pca9641_irq_start(struct pca9641 *data)
+{
+	reinit_completion(&data->grant);
+	atomic_set(&data->irq_fired, 0);
+	enable_irq(data->irq);
+}
+
+/* Leave exactly one disable held; balance the handler's disable if it ran. */
+static void pca9641_irq_stop(struct pca9641 *data)
+{
+	disable_irq(data->irq);
+	if (atomic_xchg(&data->irq_fired, 0))
+		enable_irq(data->irq);
+}
+
+/* Wait for ownership; the hardware status, not the IRQ, is authoritative. */
+static int pca9641_wait_grant(struct pca9641 *data, ktime_t deadline,
+			      bool irq_armed)
+{
+	struct i2c_client *client = data->client;
+	unsigned long wait;
+	s64 remaining;
+	int ctrl;
+
+	for (;;) {
+		ctrl = pca9641_reg_read(client, PCA9641_CONTR);
+		if (ctrl < 0)
+			return ctrl;
+		if (ctrl & PCA9641_CTL_LOCK_GRANT)
+			return 0;
+
+		remaining = ktime_us_delta(deadline, ktime_get());
+		if (remaining <= 0)
+			return -ETIMEDOUT;
+
+		if (irq_armed && !atomic_read(&data->irq_fired)) {
+			/* Periodically check for a lost or miswired IRQ. */
+			wait = usecs_to_jiffies(min_t(s64, remaining,
+						      PCA9641_IRQ_CHECK_MS * 1000));
+			wait_for_completion_timeout(&data->grant, max(1UL, wait));
+		} else {
+			usleep_range(PCA9641_POLL_US, PCA9641_POLL_US + 500);
+		}
+	}
+}
+
+static int pca9641_select_chan(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct pca9641 *data = i2c_mux_priv(muxc);
+	struct i2c_client *client = data->client;
+	int ret, cleanup_ret, ctrl;
+	bool irq_armed = false;
+	ktime_t deadline;
+
+	/* Deselect may run even when select fails; neither may sleep here. */
+	if (pca9641_cannot_sleep())
+		return -EOPNOTSUPP;
+
+	data->selected = false;
+	if (data->release_pending) {
+		ret = pca9641_release_bus(data);
+		if (ret) {
+			pca9641_schedule_recovery(data);
+			return ret;
+		}
+	}
+
+	ret = pca9641_mask_irqs(data);
+	if (ret) {
+		pca9641_schedule_recovery(data);
+		return ret;
+	}
+
+	/* RT=0 disables the reserve timer; release explicitly after STOP. */
+	ret = pca9641_reg_write(client, PCA9641_RT, 0);
+	if (ret)
+		return ret;
+
+	if (data->irq > 0) {
+		pca9641_irq_start(data);
+		irq_armed = true;
+		/* Arm before requesting ownership; BUS_LOST remains masked. */
+		data->irq_cleanup_pending = true;
+		ret = pca9641_reg_write(client, PCA9641_INT_MSK,
+					PCA9641_MSK_GRANT_ONLY);
+		if (ret)
+			goto stop_irq;
+	}
+
+	deadline = ktime_add_ms(ktime_get(),
+				jiffies_to_msecs(max(1, client->adapter->timeout)));
+	/* Clear optional disconnect, priority and initialization controls. */
+	data->release_pending = true;
+	ret = pca9641_reg_write(client, PCA9641_CONTR, PCA9641_CTL_LOCK_REQ);
+	if (!ret)
+		ret = pca9641_wait_grant(data, deadline, irq_armed);
+
+stop_irq:
+	if (irq_armed) {
+		pca9641_irq_stop(data);
+		cleanup_ret = pca9641_mask_irqs(data);
+		if (cleanup_ret) {
+			dev_err_ratelimited(&client->dev,
+					    "Failed to mask/clear IRQ: %d\n", cleanup_ret);
+			if (!ret)
+				ret = cleanup_ret;
+		}
+	}
+	if (ret)
+		goto release;
+
+	ret = pca9641_reg_write(client, PCA9641_CONTR,
+				PCA9641_CTL_LOCK_REQ | PCA9641_CTL_BUS_CONNECT);
+	if (ret)
+		goto release;
+
+	ctrl = pca9641_reg_read(client, PCA9641_CONTR);
+	if (ctrl < 0) {
+		ret = ctrl;
+		goto release;
+	}
+	if ((ctrl & (PCA9641_CTL_LOCK_REQ | PCA9641_CTL_LOCK_GRANT |
+		     PCA9641_CTL_BUS_CONNECT)) !=
+	    (PCA9641_CTL_LOCK_REQ | PCA9641_CTL_LOCK_GRANT |
+	     PCA9641_CTL_BUS_CONNECT)) {
+		ret = -EIO;
+		goto release;
+	}
+
+	data->selected = true;
+	return 0;
+
+release:
+	if (data->release_pending)
+		pca9641_release_bus(data);
+	pca9641_schedule_recovery(data);
+	return ret;
+}
+
+static int pca9641_release_chan(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct pca9641 *data = i2c_mux_priv(muxc);
+	int ret;
+
+	if (pca9641_cannot_sleep())
+		return -EOPNOTSUPP;
+
+	/* The mux core calls deselect even after a failed select. */
+	if (!data->selected)
+		return 0;
+
+	data->selected = false;
+	ret = pca9641_release_bus(data);
+	if (ret)
+		pca9641_schedule_recovery(data);
+	return ret;
+}
+
+/* Called only when no downstream transfer can be in progress. */
+static void pca9641_cleanup(struct pca9641 *data)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+
+	/* Cancel outside the parent lock: recovery may be waiting for it. */
+	cancel_delayed_work_sync(&data->recovery_work);
+
+	/* Linux IRQ is already disabled at idle. Never re-enable on removal. */
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	ret = pca9641_mask_irqs(data);
+	if (ret)
+		ret = pca9641_mask_irqs(data);
+	if (ret)
+		dev_warn(&client->dev, "Failed to mask/clear IRQ: %d\n", ret);
+	pca9641_release_bus(data);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+}
+
+static int pca9641_probe(struct i2c_client *client)
+{
+	struct i2c_adapter *adap = client->adapter;
+	struct i2c_mux_core *muxc;
+	int id, ret, release_ret;
+	struct pca9641 *data;
+
+	if (client->irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	id = i2c_smbus_read_byte_data(client, PCA9641_ID);
+	if (id < 0)
+		return dev_err_probe(&client->dev, id, "Failed to read ID\n");
+	if (id != PCA9641_ID_MAGIC)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "Unexpected ID 0x%02x\n", id);
+
+	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
+			     I2C_MUX_ARBITRATOR, pca9641_select_chan,
+			     pca9641_release_chan);
+	if (!muxc)
+		return -ENOMEM;
+
+	data = i2c_mux_priv(muxc);
+	data->client = client;
+	data->irq = -1;
+	init_completion(&data->grant);
+	INIT_DELAYED_WORK(&data->recovery_work, pca9641_recovery_work);
+	atomic_set(&data->irq_fired, 0);
+	i2c_set_clientdata(client, muxc);
+
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
+	ret = pca9641_mask_irqs(data);
+	release_ret = pca9641_release_bus(data);
+	if (!ret)
+		ret = release_ret;
+	if (!ret)
+		ret = pca9641_reg_write(client, PCA9641_RT, 0);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
+	if (ret) {
+		pca9641_cleanup(data);
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to initialize arbiter\n");
+	}
+
+	if (client->irq > 0 && !pca9641_irq_usable(client->irq)) {
+		dev_warn(&client->dev,
+			 "Unsupported IRQ provider or trigger, polling instead\n");
+	} else if (client->irq > 0) {
+		ret = devm_request_irq(&client->dev, client->irq,
+				       pca9641_irq_handler,
+				       IRQF_NO_AUTOEN | IRQF_NO_THREAD,
+				       dev_name(&client->dev), data);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		if (ret)
+			dev_warn(&client->dev,
+				 "Failed to request IRQ (%d), polling instead\n", ret);
+		else
+			data->irq = client->irq;
+	}
+
+	ret = i2c_mux_add_adapter(muxc, 0, 0);
+	if (ret) {
+		pca9641_cleanup(data);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void pca9641_remove(struct i2c_client *client)
+{
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
+	struct pca9641 *data = i2c_mux_priv(muxc);
+
+	i2c_mux_del_adapters(muxc);
+	pca9641_cleanup(data);
+}
+
+static const struct i2c_device_id pca9641_id[] = {
+	{ .name = "pca9641" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pca9641_id);
+
+static const struct of_device_id pca9641_of_match[] = {
+	{ .compatible = "nxp,pca9641" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pca9641_of_match);
+
+static struct i2c_driver pca9641_driver = {
+	.driver = {
+		.name = "pca9641",
+		.of_match_table = pca9641_of_match,
+	},
+	.probe = pca9641_probe,
+	.remove = pca9641_remove,
+	.id_table = pca9641_id,
+};
+module_i2c_driver(pca9641_driver);
+
+MODULE_AUTHOR("Shiv Prakash Gupta <shivprakash.gupta@nxp.com>");
+MODULE_DESCRIPTION("NXP PCA9641 I2C bus master arbiter driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

