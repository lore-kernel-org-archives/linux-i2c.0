Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E11E1E12
	for <linux-i2c@vger.kernel.org>; Wed,  1 Jul 2026 03:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877860; cv=none; b=VoBRD6ZqbF3wFKw0US/Em1NDZV/UdsbjCPk9fAR2wBiEEzlLvb1sTv1qYwlc0KfOuKACywH00YoWF1HdPnf2xKMLijE/D3uenuxZIqWPOac36v4TrWx8qfQwRawdnBohN+jqQN89u9Sr1xyIOQiglZKGCr40EcO6i4AgXnB7ukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877860; c=relaxed/simple;
	bh=ycTR1Xh45KGJyLPrCqgX7rVnlpgMoHfIe2vF8cF3AtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZzAAXKXLb72ip+6/OGnyNzOi2HRy7q1CymWXENrCXCFWJ2Ktc8uf5hYDexqk+68ZCcUK0ZvjbkDjxUUs0BXmr3MUlUBjvgmJlrhDZWfrXg/vOuLmIQKLOsOhWrqBOIC4IDlfzIrD8oGlfRPAxlo61JBvawkk3mp42RR6zw16sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fArPPcVI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fArPPcVI"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9aaa90a791so49221a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 20:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782877857; x=1783482657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKtolNgkwXfU2Hd3h2F3z1NBHsrGcUQqY2mR9TYvoNM=;
        b=fArPPcVIx17IxikMKOImR1EK4eGFb2dzrolD9JfT/XlZJol552OtDQZC/W3jTMuTyE
         2BfusftC6no02G1gc+0c2m6CI2FPoxpkyOjEvD++aBvWJEWFoEA/YtsW2T3eJri1jSi1
         AeC5bdlbautBvyOZzBi52akP0jg0aHya/5YT8+JcMNw6CzRn0/N33kcIjnBSbl2IKRAJ
         SWzcnZg8MNassRMRopD5UeCsi9o572jJhZ7OlonqhNtijDLc6WovTHu3CV5Eez1zdDcj
         r8z23vLjqwld5LnOjfs3zaIrTm2OAsRTn7SW44Dzr8jx8n5k0HxiVVEoBUn3xVmpHaQG
         3F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782877857; x=1783482657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKtolNgkwXfU2Hd3h2F3z1NBHsrGcUQqY2mR9TYvoNM=;
        b=J0epQgrTEDLuR8irmejeeS5okrYX1Ey2CMZ1YqHonx7l1Q7CSLcvCRp4yyjMUezE2J
         j+EUUfa+xQE0NYdrPmGew1pjHjuinbKVf/+UY+vxL8VeetdZcslvMhyZ3NzczO4DRPKU
         3GB510pWVu7XC8r8hFcr5UNlsQ0rOzGzjVw/q7WxXj2oDcNrao+LqZycNkFpvw2gujKw
         pA58xMqz6Jcn3eUSTMohYQ2HxDZJkIh9R4t3VvnNrJ//EAmdUFqZSm/qE4lOE1yw2dMp
         Hx13CzvKImlzUCOoINnUJFPDy1AXW/UOH6DOCK84R4V3Z2D+HuD+HeXmSkOrxn23l+a8
         /nXw==
X-Forwarded-Encrypted: i=1; AFNElJ8kuVRjefWpg7+5Wei6z78S0Pjoo6sdT+XbGbxcUF9+rhTCtSrtjeoiNPsivPeQtSN5msg6sReBPgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0LioTPM7xe1ajgZxvpTyE/zHZSTGmiifa+8nHPKdGIjaLATa
	ludgqUxF1uaFlYkNXtmHxfmwwO9Bsvjw6Vu8HcHNYVcvpBt4m1zeuiMh
X-Gm-Gg: AfdE7cnnGKwekOnm1GkDonUaxrTLZL601NQEepb3rqhrpaAjNvIhCNOJpbP1Ut/1E9f
	CWeaeFkMVq4U20GsAF/XCFUTlGmAQfAZoeNbur5yS0KgBrFFVdE4UuCzLpY4UUdxPIa9zVM/s+r
	R7ov3AjYuXyJsNYiWytaE2AbCtd7rGpi+oboU8SETD4j/M1wvaGZtViYlX7VWsyschn25epdeP/
	W2yPJtt0a6ronvfhoqaCmAhDuRGEpnu7gkI4UcTThubYmiFEQge722yzDE0MKKmbTAhb3FTdHMX
	ns9a7buM99pVg0QLNTY6ydnulTeAoJcz5ANBjmrNIFlWC5dZoaAfNAO6UyVA8z2EahiVdjeNwe6
	KzsgEFIQ+5nfQA/9OTJv6QuA55zsmtcHD0qux265uVrwIuVPDzG2qTcSWLsgNnwWiUQvJWjeCWq
	CsZgGMr8gaQ7xtg9NvibzPyuuQxmUoFtr3zWtyUb/N9tzdvaQGFsGkhoI=
X-Received: by 2002:a05:6a21:6013:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3bfc5195871mr5644202637.27.1782877857389;
        Tue, 30 Jun 2026 20:50:57 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbd27a924sm2429089a12.14.2026.06.30.20.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 20:50:56 -0700 (PDT)
From: a0282524688@gmail.com
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v6 6/7] mfd: nct6694: Introduce regmap-based transport abstraction
Date: Wed,  1 Jul 2026 11:50:24 +0800
Message-Id: <20260701035025.3082927-7-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701035025.3082927-1-a0282524688@gmail.com>
References: <20260701035025.3082927-1-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

Wrap the USB transport behind a regmap_bus so that sub-device drivers
talk to the firmware exclusively through nct6694_{read,write}_msg(),
without referencing the underlying transport. This unblocks adding the
upcoming HIF (eSPI) backend without touching any sub-device driver.

Encode the firmware addressing scheme (host control, module id and
16-bit offset) into a single 32-bit regmap register so that struct
nct6694_cmd_header maps cleanly onto regmap_bulk_{read,write}():

    bits [31:24]  host control
    bits [23:16]  module id
    bits [15:0]   offset (low byte = command, high byte = selector)

Add nct6694_write_read_msg() for the few commands (e.g. the I2C
"deliver" command) that send a request and read the reply back in a
single transaction, and convert the I2C transfer path to use it.

The USB backend gains a scratch xfer_buf because nct6694_usb_write_msg()
writes the firmware response back into its payload buffer, which is
incompatible with the const buffer handed to regmap_bus->write. The
per-transport access_lock is removed: regmap already serialises bus
accesses on its own.

Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes in v6:
- New patch. Replaces the v5 function-pointer abstraction with a
  regmap_bus based transport: the firmware command header is packed into
  a single 32-bit regmap register and sub-device drivers use the regmap
  bulk accessors. Adds nct6694_write_read_msg() for request/response
  commands and drops the per-transport access_lock (regmap already
  serialises bus accesses).

 drivers/i2c/busses/i2c-nct6694.c |   2 +-
 drivers/mfd/Kconfig              |   1 +
 drivers/mfd/nct6694-usb.c        | 118 +++++++++++++++++++++----------
 include/linux/mfd/nct6694.h      |  63 ++++++++++++++---
 4 files changed, 134 insertions(+), 50 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nct6694.c b/drivers/i2c/busses/i2c-nct6694.c
index ef3329f34246..7e32dab6e759 100644
--- a/drivers/i2c/busses/i2c-nct6694.c
+++ b/drivers/i2c/busses/i2c-nct6694.c
@@ -77,7 +77,7 @@ static int nct6694_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int
 		deliver->addr = i2c_8bit_addr_from_msg(msg_temp);
 		if (msg_temp->flags & I2C_M_RD) {
 			deliver->r_cnt = msg_temp->len;
-			ret = nct6694_write_msg(data->nct6694, &cmd_hd, deliver);
+			ret = nct6694_write_read_msg(data->nct6694, &cmd_hd, deliver);
 			if (ret < 0)
 				return ret;
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5506a0adf3ec..742fc26e6ff7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1166,6 +1166,7 @@ config MFD_MENF21BMC
 config MFD_NCT6694
 	tristate
 	select MFD_CORE
+	select REGMAP
 	help
 	  Core MFD support for the Nuvoton NCT6694 peripheral expander.
 	  This provides the common APIs and shared structures used by all
diff --git a/drivers/mfd/nct6694-usb.c b/drivers/mfd/nct6694-usb.c
index 2289ebfde7fa..8e7f3b07de53 100644
--- a/drivers/mfd/nct6694-usb.c
+++ b/drivers/mfd/nct6694-usb.c
@@ -9,6 +9,7 @@
  * CAN, WDT, HWMON and RTC management.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -17,7 +18,9 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/nct6694.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
 #include <linux/usb.h>
 
 #define NCT6694_VENDOR_ID	0x0416
@@ -34,10 +37,10 @@ union __packed nct6694_usb_msg {
 };
 
 struct nct6694_usb_data {
-	struct mutex access_lock;
 	struct urb *int_in_urb;
 	struct usb_device *udev;
 	union nct6694_usb_msg *usb_msg;
+	void *xfer_buf;
 	__le32 *int_buffer;
 };
 
@@ -101,29 +104,15 @@ static int nct6694_usb_err_handling(struct nct6694 *nct6694, unsigned char err_s
 	return -EIO;
 }
 
-/**
- * nct6694_usb_read_msg() - Read message from NCT6694 device
- * @nct6694: NCT6694 device pointer
- * @cmd_hd: command header structure
- * @buf: buffer to store the response data
- *
- * Sends a command to the NCT6694 device and reads the response.
- * The command header is specified in @cmd_hd, and the response
- * data is stored in @buf.
- *
- * Return: Negative value on error or 0 on success.
- */
-int nct6694_usb_read_msg(struct nct6694 *nct6694,
-			 const struct nct6694_cmd_header *cmd_hd,
-			 void *buf)
+static int nct6694_usb_read_msg(struct nct6694 *nct6694,
+				const struct nct6694_cmd_header *cmd_hd,
+				void *buf)
 {
 	struct nct6694_usb_data *udata = nct6694->priv;
 	union nct6694_usb_msg *msg = udata->usb_msg;
 	struct usb_device *udev = udata->udev;
 	int tx_len, rx_len, ret;
 
-	guard(mutex)(&udata->access_lock);
-
 	memcpy(&msg->cmd_header, cmd_hd, sizeof(*cmd_hd));
 	msg->cmd_header.hctrl = NCT6694_HCTRL_GET;
 
@@ -153,30 +142,16 @@ int nct6694_usb_read_msg(struct nct6694 *nct6694,
 
 	return nct6694_usb_err_handling(nct6694, msg->response_header.sts);
 }
-EXPORT_SYMBOL_GPL(nct6694_usb_read_msg);
 
-/**
- * nct6694_usb_write_msg() - Write message to NCT6694 device
- * @nct6694: NCT6694 device pointer
- * @cmd_hd: command header structure
- * @buf: buffer containing the data to be sent
- *
- * Sends a command to the NCT6694 device and writes the data
- * from @buf. The command header is specified in @cmd_hd.
- *
- * Return: Negative value on error or 0 on success.
- */
-int nct6694_usb_write_msg(struct nct6694 *nct6694,
-			  const struct nct6694_cmd_header *cmd_hd,
-			  void *buf)
+static int nct6694_usb_write_msg(struct nct6694 *nct6694,
+				 const struct nct6694_cmd_header *cmd_hd,
+				 void *buf)
 {
 	struct nct6694_usb_data *udata = nct6694->priv;
 	union nct6694_usb_msg *msg = udata->usb_msg;
 	struct usb_device *udev = udata->udev;
 	int tx_len, rx_len, ret;
 
-	guard(mutex)(&udata->access_lock);
-
 	memcpy(&msg->cmd_header, cmd_hd, sizeof(*cmd_hd));
 	msg->cmd_header.hctrl = NCT6694_HCTRL_SET;
 
@@ -212,7 +187,67 @@ int nct6694_usb_write_msg(struct nct6694 *nct6694,
 
 	return nct6694_usb_err_handling(nct6694, msg->response_header.sts);
 }
-EXPORT_SYMBOL_GPL(nct6694_usb_write_msg);
+
+static int nct6694_usb_regmap_read(void *context, const void *reg_buf,
+				   size_t reg_size, void *val_buf,
+				   size_t val_size)
+{
+	struct nct6694 *nct6694 = context;
+	u32 reg = get_unaligned_be32(reg_buf);
+	const struct nct6694_cmd_header cmd_hd = {
+		.mod = FIELD_GET(NCT6694_REG_MOD, reg),
+		.offset = cpu_to_le16(FIELD_GET(NCT6694_REG_OFFSET, reg)),
+		.len = cpu_to_le16(val_size),
+	};
+
+	/*
+	 * A SET transaction is a request/response exchange: send the payload
+	 * already present in @val_buf and read the response back into it.
+	 */
+	if (FIELD_GET(NCT6694_REG_HCTRL, reg) == NCT6694_HCTRL_SET)
+		return nct6694_usb_write_msg(nct6694, &cmd_hd, val_buf);
+
+	return nct6694_usb_read_msg(nct6694, &cmd_hd, val_buf);
+}
+
+static int nct6694_usb_regmap_write(void *context, const void *data,
+				    size_t count)
+{
+	struct nct6694 *nct6694 = context;
+	struct nct6694_usb_data *udata = nct6694->priv;
+	u32 reg = get_unaligned_be32(data);
+	size_t len = count - sizeof(reg);
+	const struct nct6694_cmd_header cmd_hd = {
+		.mod = FIELD_GET(NCT6694_REG_MOD, reg),
+		.offset = cpu_to_le16(FIELD_GET(NCT6694_REG_OFFSET, reg)),
+		.len = cpu_to_le16(len),
+	};
+
+	if (len > NCT6694_MAX_PACKET_SIZE)
+		return -EINVAL;
+
+	/*
+	 * nct6694_usb_write_msg() reads the firmware response back into the
+	 * payload buffer, so copy the const regmap data into a scratch buffer
+	 * it can write to.
+	 */
+	memcpy(udata->xfer_buf, data + sizeof(reg), len);
+
+	return nct6694_usb_write_msg(nct6694, &cmd_hd, udata->xfer_buf);
+}
+
+static const struct regmap_bus nct6694_usb_regmap_bus = {
+	.read = nct6694_usb_regmap_read,
+	.write = nct6694_usb_regmap_write,
+};
+
+static const struct regmap_config nct6694_usb_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.reg_stride = 1,
+	.max_raw_read = NCT6694_MAX_PACKET_SIZE,
+	.max_raw_write = NCT6694_MAX_PACKET_SIZE,
+};
 
 static void nct6694_usb_int_callback(struct urb *urb)
 {
@@ -270,6 +305,10 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	if (!udata->usb_msg)
 		return -ENOMEM;
 
+	udata->xfer_buf = devm_kzalloc(dev, NCT6694_MAX_PACKET_SIZE, GFP_KERNEL);
+	if (!udata->xfer_buf)
+		return -ENOMEM;
+
 	udata->int_buffer = devm_kzalloc(dev, sizeof(*udata->int_buffer), GFP_KERNEL);
 	if (!udata->int_buffer)
 		return -ENOMEM;
@@ -283,9 +322,12 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	nct6694->dev = dev;
 	nct6694->priv = udata;
 
-	ret = devm_mutex_init(dev, &udata->access_lock);
-	if (ret)
+	nct6694->regmap = devm_regmap_init(dev, &nct6694_usb_regmap_bus, nct6694,
+					   &nct6694_usb_regmap_config);
+	if (IS_ERR(nct6694->regmap)) {
+		ret = PTR_ERR(nct6694->regmap);
 		goto err_urb;
+	}
 
 	interface = iface->cur_altsetting;
 
diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
index 853b1530755d..d655d726d4de 100644
--- a/include/linux/mfd/nct6694.h
+++ b/include/linux/mfd/nct6694.h
@@ -9,7 +9,9 @@
 #ifndef __MFD_NCT6694_H
 #define __MFD_NCT6694_H
 
+#include <linux/bitfield.h>
 #include <linux/idr.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -29,6 +31,9 @@ struct mfd_cell;
 #define NCT6694_HCTRL_SET	0x40
 #define NCT6694_HCTRL_GET	0x80
 
+/* Maximum message payload length exchanged with the firmware in one command */
+#define NCT6694_MAX_PACKET_SIZE	0x3F0
+
 enum nct6694_irq_id {
 	NCT6694_IRQ_GPIO0 = 0,
 	NCT6694_IRQ_GPIO1,
@@ -87,6 +92,7 @@ struct __packed nct6694_response_header {
 
 struct nct6694 {
 	struct device *dev;
+	struct regmap *regmap;
 	struct ida gpio_ida;
 	struct ida i2c_ida;
 	struct ida canfd_ida;
@@ -97,29 +103,64 @@ struct nct6694 {
 	void *priv;
 };
 
-int nct6694_core_probe(struct device *dev, struct nct6694 *nct6694,
-		       const struct mfd_cell *cells, int n_cells);
-void nct6694_core_remove(struct nct6694 *nct6694);
+/*
+ * The NCT6694 firmware is reached through messages that carry a module id
+ * together with an offset (or command/selector pair). These fields are packed
+ * into a single 32-bit regmap register so that the sub-device drivers can use
+ * the standard regmap bulk accessors, while each transport driver implements
+ * the actual I/O through its own regmap bus.
+ *
+ *   bits [31:24]  host control (NCT6694_HCTRL_GET / NCT6694_HCTRL_SET)
+ *   bits [23:16]  module id
+ *   bits [15:0]   offset (low byte = command, high byte = selector)
+ */
+#define NCT6694_REG_HCTRL	GENMASK(31, 24)
+#define NCT6694_REG_MOD		GENMASK(23, 16)
+#define NCT6694_REG_OFFSET	GENMASK(15, 0)
 
-int nct6694_usb_read_msg(struct nct6694 *nct6694,
-			 const struct nct6694_cmd_header *cmd_hd,
-			 void *buf);
-int nct6694_usb_write_msg(struct nct6694 *nct6694,
-			  const struct nct6694_cmd_header *cmd_hd,
-			  void *buf);
+static inline u32 nct6694_cmd_to_reg(const struct nct6694_cmd_header *cmd_hd,
+				     u8 hctrl)
+{
+	return FIELD_PREP(NCT6694_REG_HCTRL, hctrl) |
+	       FIELD_PREP(NCT6694_REG_MOD, cmd_hd->mod) |
+	       FIELD_PREP(NCT6694_REG_OFFSET, le16_to_cpu(cmd_hd->offset));
+}
 
 static inline int nct6694_read_msg(struct nct6694 *nct6694,
 				   const struct nct6694_cmd_header *cmd_hd,
 				   void *buf)
 {
-	return nct6694_usb_read_msg(nct6694, cmd_hd, buf);
+	return regmap_bulk_read(nct6694->regmap,
+				nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_GET),
+				buf, le16_to_cpu(cmd_hd->len));
 }
 
 static inline int nct6694_write_msg(struct nct6694 *nct6694,
 				    const struct nct6694_cmd_header *cmd_hd,
 				    void *buf)
 {
-	return nct6694_usb_write_msg(nct6694, cmd_hd, buf);
+	return regmap_bulk_write(nct6694->regmap,
+				 nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_SET),
+				 buf, le16_to_cpu(cmd_hd->len));
 }
 
+/*
+ * A few firmware commands (e.g. the I2C "deliver") transmit a request and
+ * read the reply back in a single transaction. Model this as a regmap read of
+ * a SET register: @buf carries the request on entry and holds the reply on
+ * return, so the firmware exchange stays a single message as before.
+ */
+static inline int nct6694_write_read_msg(struct nct6694 *nct6694,
+					 const struct nct6694_cmd_header *cmd_hd,
+					 void *buf)
+{
+	return regmap_bulk_read(nct6694->regmap,
+				nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_SET),
+				buf, le16_to_cpu(cmd_hd->len));
+}
+
+int nct6694_core_probe(struct device *dev, struct nct6694 *nct6694,
+		       const struct mfd_cell *cells, int n_cells);
+void nct6694_core_remove(struct nct6694 *nct6694);
+
 #endif
-- 
2.34.1

