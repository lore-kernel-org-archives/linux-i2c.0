Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BE37C927
	for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 03:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283352; cv=none; b=cnVAamemy/GtCjJxWTtxlDe59yaG39OSNQTAqQpMc3t39USvH7Cv2jLmpDjdMBM2fY0vgwvcK/yAm6o97yFIle2kp+Nv+zCVyz4FO32n2OzRuUzL2cSUrjIAyE0sX/oLUQ/OlzrkO+beVm2XF44iOW/k6V+s4Grct52pf8Bz0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283352; c=relaxed/simple;
	bh=wyfBHj1kfbB/Xu2NXnAjxXZqzOU15ldhxzy5vRJ/5ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oImQ6+6kxpcllkdbYhT0BqFM38khyzf2+0MlC7XLR/F7pWrtk5rflYNbRt18KsI/uvQ7MmpG45Mu8DVwr7GYTIKgzRKKN1zm91iTGsIirV5ZPmtewD8e4uXYLwjuthPKGhF0D+lVyY42okNSUv7Y/qbcXUPdG6iTmr9OVKOFleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjCM5G+m; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjCM5G+m"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so345751b3a.3
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 20:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787283345; x=1787888145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVGJq/cPYPrGdMaDb09iv6l5Ams0yt9+9ZCGjPPurrE=;
        b=KjCM5G+mmxqDQUq/U/h+wdGBFwjwTIZVyrbhnqicPSnz4yfoiiv8feUEd+Qonaf6aB
         7TIaiTZwqwNrPlbz1uc+Nwuivr72EmWOzJG+i634yBDw8bqkl9EmVYQ/MEDtYq0+TlkH
         XFe9T7Xr071kVZIUbXUGkL4qBJ+G20vUwHXrTss3suxJ7kgd64kwEWNAeeSbPcH6mFrH
         K2ZPKUE0aKtQDKh/j3QuxLPLwHDNSMQPTxJE/0MsqKtfDMwe27bwWEpazmiq+PxrKLtg
         fEKnjE9IKtgHk+BaAzfjrHsH/9ms0eOVHD7cTHO5S5pjkQgd3wce2D40VG8x9l3An3HZ
         gN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787283345; x=1787888145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVGJq/cPYPrGdMaDb09iv6l5Ams0yt9+9ZCGjPPurrE=;
        b=jfTF7PT4SFVWFtwk7XTJ3hLfacdrqlbFG5FriwQC9hC+2oh6FxCtQsuTQxlHMDVdDu
         bsF6wTq265OJ+y9Bsqak8k72V314RayGVtgO2nKZ5cx+4IksNDmeNV45sf21yQZIQT+G
         9AVWGbIJqb7q5G89LU+hPE7TqbYZMpUjj03wp3oVBrD1kS9b+2QIHNRd5QXaHqAw1gK8
         6pSnvN2pnzVSGet5yLIt9YPN7vKOA6xS/tzht7qR3m9WG5O8R8p6jvEYsxPApFeL2voy
         EOSTH3nW5hKhQ6lP2FmaZa71fxtzijLO+YNUWF1YHGNM7C4bKPEYx1Vkucx4OZiZlflk
         1I8g==
X-Forwarded-Encrypted: i=1; AHgh+RqfNkZadW7Dcu0mDeWSICr+OXOU/w5HuwcfWZtYHD1d4ShbpsP0LgtFG6FoMsqU53PM7vdvBSrDeZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HQngHJu0v4UQcl8hvM5e+zvD7hKGsuSQ0Gx15I9qz1adl7pI
	Qmks1N2oeYxy22NWbLN2Uj25R78YqOBLCgEu6bTozNQ+fuiY+CE9asV6
X-Gm-Gg: AR+sD10xmHT6cq8Q5jJaOUvu9JTEqKGO5jadosTONrBStY4pGFk/6YoLnYroz9I9CyE
	+77KHb0yWENf86PkUj4qI0vIdfdiWqRYmj8kJCzS4/ILk1+M0DFSEQJgOizseG5sBhjpaUBQOrW
	xj84eMlfiSprJ3E4M7Mt29VFT/vO2/oc1yC4hxuoiypOuJWy3VT4jFObIU5N2dxSqvSJW7LDfNw
	NpvVawhdzbIuG02Eb3lQaxKqQzX9vhKjF3THXhrY8sJDIHypB3am9pp8c5oKbS4nNdOZNpb1olo
	za6UbVhFZRQt/ya73JI3kANTuR8kAkmI46Hb/Uxs1N9JzbsTavx8YOBQIggksEtmPeNJZJwe40k
	SgUPTY7uum5i4Urpidspgnfzt4N6GmWnFSg9avVUzUGOqoRxFFfY2+xQ1undiCUkHU8PRUxDPVf
	2+GOAzh/E4sDWpSfdzuuP8BoNMCZUA2LcH16BtxwaYu0C3jztuqG396dv3MiWwtZgqaSnUMjqbr
	aaIV6G3OCL6nEmKdSCLoevAySkXeLM=
X-Received: by 2002:a05:6a21:e584:b0:3cc:c7cf:5a44 with SMTP id adf61e73a8af0-3cd2fd4d78amr6863464637.2.1787283345094;
        Thu, 20 Aug 2026 20:35:45 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15891a04csm2204271a12.15.2026.08.20.20.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:35:44 -0700 (PDT)
From: a0282524688@gmail.com
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>,
	linux-i2c@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v7 09/10] mfd: nct6694: Introduce regmap-based transport abstraction
Date: Fri, 21 Aug 2026 11:35:04 +0800
Message-Id: <20260821033505.4017901-10-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821033505.4017901-1-a0282524688@gmail.com>
References: <20260821033505.4017901-1-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yu <a0282524688@gmail.com>

Sub-device drivers call into the USB transport directly, so a second
transport cannot be added without touching all of them.

Wrap the transport behind a regmap bus and let the sub-device drivers
reach the firmware only through nct6694_{read,write}_msg(). The command
header maps onto the regmap bulk accessors by packing the host control
byte, the module id and the 16-bit offset into a single 32-bit register.

Add nct6694_write_read_msg() for the commands that transmit a request
and read the reply back within the same firmware message, and use it for
the I2C deliver command.

Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes in v7:
- Made the USB transport helpers static and gave nct6694_usb_write_msg()
  separate @tx/@rx buffers, so a SET command only copies the firmware
  reply back when the caller asks for it.
- Documented in the shared header why nct6694_write_read_msg() is
  expressed as a read of a SET register.

Changes in v6:
- New patch. Replaces the v5 function-pointer abstraction with a
  regmap_bus based transport: the firmware command header is packed into
  a single 32-bit regmap register and sub-device drivers use the regmap
  bulk accessors. Adds nct6694_write_read_msg() for request/response
  commands and drops the per-transport access_lock (regmap already
  serialises bus accesses).

 drivers/i2c/busses/i2c-nct6694.c |   2 +-
 drivers/mfd/Kconfig              |   1 +
 drivers/mfd/nct6694-usb.c        | 106 +++++++++++++++++++------------
 include/linux/mfd/nct6694.h      |  62 ++++++++++++++----
 4 files changed, 120 insertions(+), 51 deletions(-)

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
index cc3e7b7b3a0d..979ae1125d16 100644
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
@@ -34,7 +37,6 @@ union __packed nct6694_usb_msg {
 };
 
 struct nct6694_usb_data {
-	struct mutex access_lock;
 	struct urb *int_in_urb;
 	struct usb_device *udev;
 	union nct6694_usb_msg *usb_msg;
@@ -102,21 +104,9 @@ static int nct6694_usb_err_handling(struct nct6694 *nct6694, unsigned char err_s
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
@@ -127,8 +117,6 @@ int nct6694_usb_read_msg(struct nct6694 *nct6694,
 	if (len > NCT6694_MAX_PACKET_SIZE)
 		return -EINVAL;
 
-	guard(mutex)(&udata->access_lock);
-
 	memcpy(&msg->cmd_header, cmd_hd, sizeof(*cmd_hd));
 	msg->cmd_header.hctrl = NCT6694_HCTRL_GET;
 
@@ -160,22 +148,15 @@ int nct6694_usb_read_msg(struct nct6694 *nct6694,
 
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
+/*
+ * @tx is const because regmap_bus->write() hands over the caller's buffer. The
+ * firmware always answers a SET command with a payload of the same length;
+ * callers that need it pass @rx, the others pass NULL.
  */
-int nct6694_usb_write_msg(struct nct6694 *nct6694,
-			  const struct nct6694_cmd_header *cmd_hd,
-			  void *buf)
+static int nct6694_usb_write_msg(struct nct6694 *nct6694,
+				 const struct nct6694_cmd_header *cmd_hd,
+				 const void *tx, void *rx)
 {
 	struct nct6694_usb_data *udata = nct6694->priv;
 	union nct6694_usb_msg *msg = udata->usb_msg;
@@ -186,11 +167,9 @@ int nct6694_usb_write_msg(struct nct6694 *nct6694,
 	if (len > NCT6694_MAX_PACKET_SIZE)
 		return -EINVAL;
 
-	guard(mutex)(&udata->access_lock);
-
 	memcpy(&msg->cmd_header, cmd_hd, sizeof(*cmd_hd));
 	msg->cmd_header.hctrl = NCT6694_HCTRL_SET;
-	memcpy(udata->xfer_buf, buf, len);
+	memcpy(udata->xfer_buf, tx, len);
 
 	/* Send command packet to USB device */
 	ret = usb_bulk_msg(udev, usb_sndbulkpipe(udev, NCT6694_BULK_OUT_EP), &msg->cmd_header,
@@ -222,11 +201,57 @@ int nct6694_usb_write_msg(struct nct6694 *nct6694,
 		return -EIO;
 	}
 
-	memcpy(buf, udata->xfer_buf, len);
+	if (rx)
+		memcpy(rx, udata->xfer_buf, len);
 
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
+	if (FIELD_GET(NCT6694_REG_HCTRL, reg) == NCT6694_HCTRL_SET)
+		return nct6694_usb_write_msg(nct6694, &cmd_hd, val_buf, val_buf);
+
+	return nct6694_usb_read_msg(nct6694, &cmd_hd, val_buf);
+}
+
+static int nct6694_usb_regmap_write(void *context, const void *data,
+				    size_t count)
+{
+	struct nct6694 *nct6694 = context;
+	u32 reg = get_unaligned_be32(data);
+	size_t len = count - sizeof(reg);
+	const struct nct6694_cmd_header cmd_hd = {
+		.mod = FIELD_GET(NCT6694_REG_MOD, reg),
+		.offset = cpu_to_le16(FIELD_GET(NCT6694_REG_OFFSET, reg)),
+		.len = cpu_to_le16(len),
+	};
+
+	return nct6694_usb_write_msg(nct6694, &cmd_hd, data + sizeof(reg), NULL);
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
@@ -300,9 +325,12 @@ static int nct6694_usb_probe(struct usb_interface *iface,
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
 
 	ret = usb_find_int_in_endpoint(iface->cur_altsetting, &int_endpoint);
 	if (ret)
diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
index cb311e58a437..aef0f9bd914c 100644
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
 
@@ -90,6 +92,7 @@ struct __packed nct6694_response_header {
 
 struct nct6694 {
 	struct device *dev;
+	struct regmap *regmap;
 	struct ida gpio_ida;
 	struct ida i2c_ida;
 	struct ida canfd_ida;
@@ -100,29 +103,66 @@ struct nct6694 {
 	void *priv;
 };
 
-int nct6694_core_probe(struct device *dev, struct nct6694 *nct6694,
-		       const struct mfd_cell *cells, int n_cells);
-void nct6694_core_remove(struct nct6694 *nct6694);
+/*
+ * Firmware messages are addressed by a module id and a 16-bit offset (a
+ * command/selector pair). Pack them together with the host control byte into a
+ * single 32-bit regmap register, so that sub-device drivers can issue commands
+ * through the regmap bulk accessors while each transport driver only has to
+ * implement a regmap bus.
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
+ * A few commands, such as the I2C deliver, transmit a request and read the
+ * reply back within the same firmware message. regmap has no accessor for such
+ * an exchange, so express it as a read of a SET register: @buf carries the
+ * request on entry and holds the reply on return. This relies on the transport
+ * bus being handed @buf directly, which holds as long as the regmap is left
+ * uncached and byte sized.
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

