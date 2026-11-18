Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989829;
	b=y3SSKPzvpwok+7aJ+5QiCKI98qMVMeEpDLZ/oKR38wXqVSUlt33CiFsYN4uv1S0cImZm
	 DJizd8rqIUUPxvgfzOa98gli/Bm4TzRJMKQ5ujyZ1NLT0NTNeB/4hXIa/MudMfvEkKIoc
	 oX+4Vbe3fAY44C8pIQpcbrFalvx5Eh4A4u9Nafrneh8DtC7SvDlF7R2Wq3v7dMpr9XbzF
	 HzYWd6jpIvjTLjxTeSY5ZMDpWE4MQPND0Eqe9zJhdRAy0oMtWs4au5tetqnS4I746Xdkz
	 77i0czSzJ8g+fCxk/xkz8iwpufgi+DfuskIK3Kf9McMzY4R99lij2kbdN16kbbcm6rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lRR130UK8rk6jZxfjzpqstBolZ6R352UcLgE8pxhZPA=;
	b=fzHCCR/FgcMZdqvEb3rg6wXPgqmADCQvgMysVRfljaiutu3GGd6ccX8PU+jsx0X52vll
	 rsbkne4FqK+MOFcwE6eVheCvcOmKApeSM8F5G3cTjg/pxGG0Y4zmdOQYViXWS3KWU2Vu8
	 HSgvMQk6AMHcQvCB0GERNpiSP3HdfOKDYAsVR5e1G0sw/AkkrowgDr5k4Ew318CQJMptW
	 h69Ma5GmWVN8BK2BtnQgUOR+iC6tnZUHQVQSCEsuSC7NNDiA69VQzDEzysL4KAfjYKoJf
	 ESINkVZ7vRKDL5ZkpqujRgulCe7O1Viqdfb4FVWczzhjyMAjEDyzxX2yaEO4ZfKy1XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpYzlVnG;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468760A382F
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 08:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6468760A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpYzlVnG
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso1056460b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 00:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794989828; x=1795594628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRR130UK8rk6jZxfjzpqstBolZ6R352UcLgE8pxhZPA=;
        b=RpYzlVnGf+fHMyeS6zW5j8TNMxvtTEDBaNwdQEbO2cW9a7CRgCf6ZSJ/E+zX5egwDU
         jXxxBFvDajfTB4HVjlyLcPVPb0xK1+T6T6CuNmK9RgxirveagDvESHPSP1hwJNu8ek37
         usBZQIflziSCkFADdyCpgVHbKrLtSjcb/93ZlciEDNq4DBz1egFO+NVfK13rqU52Kd5X
         nFDq6R8TkxBjB9Fa6+R5JYOjkPsdrFz3PrKX7I+6pfu1GQfhXyfnc2gzmnFUcR9kR3zL
         8qkif+RAMnmrEGmmLmTKoEujToEgBhBO2ft91xMptC2EdGDhtP4Yns5aGWRFcC1v4PnW
         7NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794989828; x=1795594628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lRR130UK8rk6jZxfjzpqstBolZ6R352UcLgE8pxhZPA=;
        b=oGWykiB3V6c6wCVgEpxrE/QCNUr4t1+IZc+liUXE4gXjvqN7Kiz+PLixaT8cKYIVz/
         JGMVtd8QxjsSWmNqthhDyzoQar11R9dgwbcmxqv4R7rttsFhedezvzcWM6vKCNtVzk88
         EKx6AkZiGqtQW0oynk+pMYrAtae9N1LCG1/Wpd8z0Pl0mOXy7SQmWrEPmkBNy128bMBl
         LzTS7jnq70ioxnh3gQw6PmG4nN1oWZ8ZunxUK/cNHxtiujz/l+MIvDfgsPWZjOkENEd/
         veDdJjKt9EL7klihagSD8yMslOt1C/n7JVRHhlYCdCd/bIiqPclfpDfOvYfG025cy7TG
         AbfQ==
X-Forwarded-Encrypted: i=1; AL+hErG5tp0rk/X+ORquEoBkjhq/zrGzFbZVumzx3E0gb/6pvEMdbo07AGm7cYomGojyhXPcZlsMaaADjMk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gu/ufxUMjigZmEWZM5FYYSk1MkMU/6tAofRf/C2rg6I8gL7CR
	8r3Oq1SzLBid51D0gGu+F8mZNPolr574nNv2yKa3V8xHtTESBbiJRC5H
X-Gm-Gg: AYBFou1Frq2eLbZ6DZK3HACWir10pWeWmGHFPn62nskdAENbWhQdpL0FwNB4EhpTmb8
	9oSdMsMif3wCtxONDeav5BZBndpzsvt3Oy2TMf31ZKoL7mj5q+n+5jtnnc/89E3x5xwiKmjE1iM
	oo4b7hBPaW502YJdqzqWhiXZRmjwX6AxuUvdKlPEGITXvCEpWg2Gn+SiGi4hqCPRGrUnZXFdtqU
	iqLn87syOpig0KSNuCdy0lXnuLv4JDUWYCNWWSZzfPu/THzwoHX0uszhVVe6q2xGv7PLwO1ESv0
	Ca0bCdbpVAr77Z3QYU8lQ5y/Hp4BsylbzGr9G9PCKvS1TGlXjDQsHQDRvOG4eRifv5Nwe95QaEM
	jygA/EalJj/qdda9tVhiTwj3ABY385gtV2wP0Pj5ECl4Kzx8vZjB6pkjCeAEmSFD9HLi/KQ+9WC
	TXOakJRC1wcgCoFKpHgUE0TgZJZozkCbuM4Z5OyJaknpxYq882W8Os77N3uR0PPvDiMmeIduecX
	ll3C31FXO+UjSLnGGrDl5G0fhh9HFO34AvcmLtITSubTiFDQVr8uzVBOJsW6z33G1RBcNNB5+6m
	yEo2G+EPaTgxnUwJ+z+4Ad/mXc7XwNf487yCaa2bHravSZYHWYcIv5Koa8OYrVpw3FJk2UY=
X-Received: by 2002:a05:6a20:d12e:b0:3f1:fdd4:5742 with SMTP id adf61e73a8af0-3fe89c1273fmr1439074637.9.1794989827725;
        Wed, 18 Nov 2026 00:17:07 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cad8cefbsm764401b3a.31.2026.11.18.00.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:17:07 -0800 (PST)
From: a0282524688@gmail.com
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>,
	linux-i2c@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v10 11/13] mfd: nct6694: Introduce regmap-based transport abstraction
Date: Wed, 18 Nov 2026 16:16:22 +0800
Message-Id: <20261118081625.2399247-12-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118081625.2399247-1-a0282524688@gmail.com>
References: <20261118081625.2399247-1-a0282524688@gmail.com>
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

From: Ming Yu <a0282524688@gmail.com>

Sub-device drivers call into the USB transport directly, so a second
transport cannot be added without touching all of them.

Wrap the transport behind a regmap bus. The command header is mapped
onto a single 32-bit register by packing the host control byte, the
module id and the 16-bit offset, so that the sub-device drivers can use
the regmap bulk accessors. The access_lock is dropped as regmap already
serialises the bus accesses. Transfers larger than the transport buffer
are rejected, as the length field of the command header is 16 bits wide.

Add nct6694_write_read_msg() for the commands that send a request and
read the reply back in the same firmware message, and use it for the
I2C deliver command.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
Changes in v10:
- None.

Changes in v9:
- Rejected transfers larger than NCT6694_MAX_DATA_LEN in the regmap bus
  callbacks, as the length field of the command header is 16 bits wide.
- Added Andi's Acked-by.

Changes in v8:
- Renamed the transport buffer arguments to tx_buf/rx_buf.
- Dropped max_raw_read/max_raw_write from the regmap_config, as they
  are ignored when a regmap_bus is provided.

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
 drivers/mfd/nct6694-usb.c        | 108 +++++++++++++++++++------------
 include/linux/mfd/nct6694.h      |  53 ++++++++++++---
 4 files changed, 114 insertions(+), 50 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nct6694.c b/drivers/i2c/busses/i2c-nct6694.c
index d3e2316ff53c..113171ddb3ef 100644
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
index 87ed55c155f0..3c59ef8768e2 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1182,6 +1182,7 @@ config MFD_MENF21BMC
 config MFD_NCT6694
 	tristate "Nuvoton NCT6694 support"
 	select MFD_CORE
+	select REGMAP
 	depends on USB
 	help
 	  This enables support for the Nuvoton USB device NCT6694, which shares
diff --git a/drivers/mfd/nct6694-usb.c b/drivers/mfd/nct6694-usb.c
index 8f9c7b7d9471..e8299ef71931 100644
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
@@ -35,7 +38,6 @@ union __packed nct6694_usb_hdr {
 
 struct nct6694_usb_data {
 	struct nct6694 core;
-	struct mutex access_lock;
 	struct usb_device *usb_dev;
 	struct urb *int_urb;
 	union nct6694_usb_hdr *hdr_buf;
@@ -108,21 +110,9 @@ static int nct6694_usb_err_handling(struct nct6694 *ddata, unsigned char err_sta
 	return -EIO;
 }
 
-/**
- * nct6694_usb_read_msg() - Read message from NCT6694 device
- * @ddata: NCT6694 device pointer
- * @cmd_hd: command header structure
- * @buf: buffer to store the response data
- *
- * Sends a command to the NCT6694 device and reads the response.
- * The command header is specified in @cmd_hd, and the response
- * data is stored in @buf.
- *
- * Return: Negative value on error or 0 on success.
- */
-int nct6694_usb_read_msg(struct nct6694 *ddata,
-			 const struct nct6694_cmd_header *cmd_hd,
-			 void *buf)
+static int nct6694_usb_read_msg(struct nct6694 *ddata,
+				const struct nct6694_cmd_header *cmd_hd,
+				void *rx_buf)
 {
 	struct nct6694_usb_data *usb_data = to_nct6694_usb_data(ddata);
 	union nct6694_usb_hdr *hdr = usb_data->hdr_buf;
@@ -133,8 +123,6 @@ int nct6694_usb_read_msg(struct nct6694 *ddata,
 	if (data_len > NCT6694_MAX_DATA_LEN)
 		return -EINVAL;
 
-	guard(mutex)(&usb_data->access_lock);
-
 	memcpy(&hdr->cmd_header, cmd_hd, sizeof(*cmd_hd));
 	hdr->cmd_header.hctrl = NCT6694_HCTRL_GET;
 
@@ -168,26 +156,15 @@ int nct6694_usb_read_msg(struct nct6694 *ddata,
 		return -EIO;
 	}
 
-	memcpy(buf, usb_data->data_buf, data_len);
+	memcpy(rx_buf, usb_data->data_buf, data_len);
 
 	return nct6694_usb_err_handling(ddata, hdr->response_header.sts);
 }
-EXPORT_SYMBOL_GPL(nct6694_usb_read_msg);
 
-/**
- * nct6694_usb_write_msg() - Write message to NCT6694 device
- * @ddata: NCT6694 device pointer
- * @cmd_hd: command header structure
- * @buf: buffer containing the data to be sent
- *
- * Sends a command to the NCT6694 device and writes the data
- * from @buf. The command header is specified in @cmd_hd.
- *
- * Return: Negative value on error or 0 on success.
- */
-int nct6694_usb_write_msg(struct nct6694 *ddata,
-			  const struct nct6694_cmd_header *cmd_hd,
-			  void *buf)
+/* @rx_buf may be NULL when the reply to the SET command is not needed */
+static int nct6694_usb_write_msg(struct nct6694 *ddata,
+				 const struct nct6694_cmd_header *cmd_hd,
+				 const void *tx_buf, void *rx_buf)
 {
 	struct nct6694_usb_data *usb_data = to_nct6694_usb_data(ddata);
 	union nct6694_usb_hdr *hdr = usb_data->hdr_buf;
@@ -198,11 +175,9 @@ int nct6694_usb_write_msg(struct nct6694 *ddata,
 	if (data_len > NCT6694_MAX_DATA_LEN)
 		return -EINVAL;
 
-	guard(mutex)(&usb_data->access_lock);
-
 	memcpy(&hdr->cmd_header, cmd_hd, sizeof(*cmd_hd));
 	hdr->cmd_header.hctrl = NCT6694_HCTRL_SET;
-	memcpy(usb_data->data_buf, buf, data_len);
+	memcpy(usb_data->data_buf, tx_buf, data_len);
 
 	/* Send command packet to USB device */
 	ret = usb_bulk_msg(usb_dev, usb_sndbulkpipe(usb_dev, NCT6694_BULK_OUT_EP),
@@ -240,11 +215,59 @@ int nct6694_usb_write_msg(struct nct6694 *ddata,
 		return -EIO;
 	}
 
-	memcpy(buf, usb_data->data_buf, data_len);
+	if (rx_buf)
+		memcpy(rx_buf, usb_data->data_buf, data_len);
 
 	return nct6694_usb_err_handling(ddata, hdr->response_header.sts);
 }
-EXPORT_SYMBOL_GPL(nct6694_usb_write_msg);
+
+static int nct6694_usb_regmap_read(void *context, const void *reg_buf,
+				   size_t reg_size, void *val_buf,
+				   size_t val_size)
+{
+	struct nct6694 *ddata = context;
+	u32 reg = get_unaligned_be32(reg_buf);
+	const struct nct6694_cmd_header cmd_hd = {
+		.mod = FIELD_GET(NCT6694_REG_MOD, reg),
+		.offset = cpu_to_le16(FIELD_GET(NCT6694_REG_OFFSET, reg)),
+		.len = cpu_to_le16(val_size),
+	};
+
+	if (val_size > NCT6694_MAX_DATA_LEN)
+		return -EINVAL;
+
+	if (FIELD_GET(NCT6694_REG_HCTRL, reg) == NCT6694_HCTRL_SET)
+		return nct6694_usb_write_msg(ddata, &cmd_hd, val_buf, val_buf);
+
+	return nct6694_usb_read_msg(ddata, &cmd_hd, val_buf);
+}
+
+static int nct6694_usb_regmap_write(void *context, const void *data,
+				    size_t count)
+{
+	struct nct6694 *ddata = context;
+	u32 reg = get_unaligned_be32(data);
+	const struct nct6694_cmd_header cmd_hd = {
+		.mod = FIELD_GET(NCT6694_REG_MOD, reg),
+		.offset = cpu_to_le16(FIELD_GET(NCT6694_REG_OFFSET, reg)),
+		.len = cpu_to_le16(count - sizeof(reg)),
+	};
+
+	if (count - sizeof(reg) > NCT6694_MAX_DATA_LEN)
+		return -EINVAL;
+
+	return nct6694_usb_write_msg(ddata, &cmd_hd, data + sizeof(reg), NULL);
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
+};
 
 static void nct6694_usb_int_callback(struct urb *urb)
 {
@@ -329,9 +352,12 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	ddata->dev = dev;
 	usb_data->usb_dev = usb_dev;
 
-	ret = devm_mutex_init(dev, &usb_data->access_lock);
-	if (ret)
+	ddata->regmap = devm_regmap_init(dev, &nct6694_usb_regmap_bus, ddata,
+					 &nct6694_usb_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
+		ret = PTR_ERR(ddata->regmap);
 		goto err_free_urb;
+	}
 
 	int_pipe = usb_rcvintpipe(usb_dev, NCT6694_INT_IN_EP);
 	usb_fill_int_urb(usb_data->int_urb, usb_dev, int_pipe,
diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
index 26e9034daa53..92949f182e2f 100644
--- a/include/linux/mfd/nct6694.h
+++ b/include/linux/mfd/nct6694.h
@@ -9,6 +9,9 @@
 #ifndef __MFD_NCT6694_H
 #define __MFD_NCT6694_H
 
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+
 #define NCT6694_HWMON_MOD	0x00
 #define NCT6694_PWM_MOD		0x01
 #define NCT6694_I2C_MOD		0x03
@@ -82,6 +85,7 @@ struct __packed nct6694_response_header {
 
 struct nct6694 {
 	struct device *dev;
+	struct regmap *regmap;
 	struct ida gpio_ida;
 	struct ida i2c_ida;
 	struct ida canfd_ida;
@@ -92,25 +96,58 @@ struct nct6694 {
 int nct6694_device_init(struct device *dev);
 void nct6694_device_exit(struct device *dev);
 
-int nct6694_usb_read_msg(struct nct6694 *ddata,
-			 const struct nct6694_cmd_header *cmd_hd,
-			 void *buf);
-int nct6694_usb_write_msg(struct nct6694 *ddata,
-			  const struct nct6694_cmd_header *cmd_hd,
-			  void *buf);
+/*
+ * Each firmware command is mapped to a single 32-bit regmap register, so that
+ * the sub-device drivers use the regmap bulk accessors and each transport only
+ * implements a regmap bus:
+ *
+ *   bits [31:24]  host control (NCT6694_HCTRL_GET / NCT6694_HCTRL_SET)
+ *   bits [23:16]  module id
+ *   bits [15:0]   offset (low byte = command, high byte = selector)
+ */
+#define NCT6694_REG_HCTRL	GENMASK(31, 24)
+#define NCT6694_REG_MOD		GENMASK(23, 16)
+#define NCT6694_REG_OFFSET	GENMASK(15, 0)
+
+static inline u32 nct6694_cmd_to_reg(const struct nct6694_cmd_header *cmd_hd,
+				     u8 hctrl)
+{
+	return FIELD_PREP(NCT6694_REG_HCTRL, hctrl) |
+	       FIELD_PREP(NCT6694_REG_MOD, cmd_hd->mod) |
+	       FIELD_PREP(NCT6694_REG_OFFSET, le16_to_cpu(cmd_hd->offset));
+}
 
 static inline int nct6694_read_msg(struct nct6694 *ddata,
 				   const struct nct6694_cmd_header *cmd_hd,
 				   void *buf)
 {
-	return nct6694_usb_read_msg(ddata, cmd_hd, buf);
+	return regmap_bulk_read(ddata->regmap,
+				nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_GET),
+				buf, le16_to_cpu(cmd_hd->len));
 }
 
 static inline int nct6694_write_msg(struct nct6694 *ddata,
 				    const struct nct6694_cmd_header *cmd_hd,
 				    void *buf)
 {
-	return nct6694_usb_write_msg(ddata, cmd_hd, buf);
+	return regmap_bulk_write(ddata->regmap,
+				 nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_SET),
+				 buf, le16_to_cpu(cmd_hd->len));
+}
+
+/*
+ * Some commands, such as the I2C deliver, send a request and read the reply
+ * back in the same firmware message. Express this as a read of a SET register:
+ * @buf holds the request on entry and the reply on return. This relies on the
+ * regmap being uncached and byte sized, so that @buf reaches the bus as is.
+ */
+static inline int nct6694_write_read_msg(struct nct6694 *ddata,
+					 const struct nct6694_cmd_header *cmd_hd,
+					 void *buf)
+{
+	return regmap_bulk_read(ddata->regmap,
+				nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_SET),
+				buf, le16_to_cpu(cmd_hd->len));
 }
 
 #endif
-- 
2.34.1

