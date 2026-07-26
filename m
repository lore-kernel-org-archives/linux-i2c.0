Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D27288B8
	for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053064; cv=none; b=f2ezN6ocxsPk26W7elJHniW820yLgmbxDFU9jMGiorRA4npvDHZk92+wSCXrle4X/6C3CtAkTYpPq8h6D453jYXo39bTKv+dWfWCPqMCm35PdGSAc30HKZypgkHjhJGIQe6AAgHwB099VVUybb0W9jKSwhmI3NB/RFTZff9TbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053064; c=relaxed/simple;
	bh=Y7HcoRerzsbgTMKBHjGeBjlXnASBY1wVnyZiToHg+S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9Zrq7G9ay5LipLtkc6CSLRVgxo5VGjq78pQ8mGAfky7VwVfq1abtwEk0rNW6cGOn0uM9m8h+SFDk/X4eT98CbouWANvzpT0jn0R9iG9/j4RBHr9Yboc4BZ7KV5p5L43T3oiR9+FVsG13H7mtlem6H5lQJLhwUa3YcyobyKa9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMS4EqwQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMS4EqwQ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so22002125ad.1
        for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785053063; x=1785657863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pc+LLUxUsAlG4VNPUy+0mBD+EfmSxjlMd8BD9q3fDIk=;
        b=XMS4EqwQRmWWEEy+kDeohTo3n9a4hZth8paKV+SoVvM6v5nXx8lI+3CvLpyh5aYmKq
         sQy7YOTXODIOp7zPLxoJyhS1rx0hjM9HbPtKIGtEefU0BSfcrTI5MIeT7fwxaYrLdInX
         HbrxEnRDrcDDuLZTnE3PMifKdX6VYys+gVJgm4qq2ZBZXc88Lo4rT6uxRohsoKu3S5+w
         YqTKgsBXY1uEnHdf/t75nI+WPsj39r+2fAR4jF8NaKsZs5Ba2GApq1IacpKdwDYzpnNo
         46H/iw/afEE47cy7Hh3ktmjHnJzDKyYFCj+VAxlgxGLzfEZq2JwvzqPZtJ0ciUkeNfUH
         hphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785053063; x=1785657863;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pc+LLUxUsAlG4VNPUy+0mBD+EfmSxjlMd8BD9q3fDIk=;
        b=bMU3wYqz9Nz1OhB8ZAzdU4g8iOGGghxMMt+7yt37Uvn0aMB8IlCIXOZ4WFTsvF3Va4
         GDcN9JKq2/uDx0pAzp6w7/gtDt0RwAx7eBMRMgjfI2CSVupAzsT3MQWOyIDMcsdz4Ez1
         zLefS/t6Q4FlGxahljVK6Sd6Ot2vEEZBg4mllYolLPzYmzsXNXOaqR7w0i9AmnZk3r6/
         5J0OMDX5e+fEflwMes7Q0/8dnnn0l1VIcGDhPg2GJMHkoR/MsLCNjopV6HdihakTraUd
         pf97m0W96H0o8XIYlLwS39CgbR9iLcO1YK+DDC+S5U+sh+37MIMcHel/sktAPDsY5nbU
         0y2A==
X-Forwarded-Encrypted: i=1; AHgh+RrUysskbFvBcCYyVQWkYN+xB9x970d78UVvZ8ZBC5dH0xtDbOEMVM+O/mXLAKtipMf8A77uNnpV+IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkRVqKc++Px1PObECNpNUwf+DS9iP+tRV+cfP+i4OkQ/6B9Zm
	UCCyi6mpKH8OQHRafpt8TcCwRn1CUOE/PAawgfD3smd6uM8DX+6cDWso
X-Gm-Gg: AR+sD11KcBmg48NKL8e1Xi1D64uWQEVeOSpM9F8xqUXyx5qU15u1C6csoTZFkivP8uB
	SkL6nW/3HYKyjiUDHEETM53IjDoy47RgMGfLwWk+ZI4U52Pn5UlvG/U7gVxgIEMl9HlZUW+G6No
	iT1t8vVxASRnaG3QzJW1T0MtRV96N/tOx2I8egp2DTGGDeU5Y7LYyBY9Dvcxl/vnah5z1QV0O6q
	9oqQXFRNoQcobLekh+/WOeMK/h4Up6u6DeQQplBnn7gB0ajOQATzwwCCEzAvoxa9mV+CSRVuYIS
	ijqsRnOJJ5+eF5BUgAuygaizD8txKD/pTt7Wv461h2f8uHThKqqAWlHpmTnji9mT4HOAbuyAE3g
	X95tNseffN7JIc40VPmJm8GoXqEcezDzbRrDppOPG9txvE0Y3GB9g5R56vfKkvKzLvTzBhQ85bP
	v3Zp9YBaIyQaKHUZzEIK4bf+U3Xk3gjSNc+KEjoaukUEDUKqq1lonxnFPwhnDWSCE=
X-Received: by 2002:a17:902:c402:b0:2cf:a2d2:84c0 with SMTP id d9443c01a7336-2cfde55bb4amr44610785ad.0.1785053062892;
        Sun, 26 Jul 2026 01:04:22 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b8esm17503365ad.31.2026.07.26.01.04.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 01:04:22 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] usb: misc: usbio: bound the debug hex dumps by the received length
Date: Sun, 26 Jul 2026 16:59:13 +0900
Message-ID: <20260726080129.44969-4-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726080129.44969-1-skyexpoc@gmail.com>
References: <20260726080129.44969-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbio_ctrl_msg() and usbio_bulk_msg() hex dump the reply with "%*phN",
using a length the device supplied and that has not been validated yet:

	ret = usb_control_msg(usbio->udev, pipe, 0, request | USB_DIR_IN, 0, 0,
			      cpkt, cpkt_len, USBIO_CTRLXFER_TIMEOUT);
	dev_dbg(usbio->dev, "control in %d hdr %*phN data %*phN\n", ret,
		(int)sizeof(*cpkt), cpkt, (int)cpkt->len, cpkt->data);

cpkt->len is a u8 read back out of usbio->ctrlbuf after the IN transfer,
and bpkt_len in usbio_bulk_msg() is le16_to_cpu(bpkt->len) read out of
usbio->rxbuf.  Both are handed to "%*phN" as the field width.
hex_string() in lib/vsprintf.c caps that at 64, and dereferences every
byte up to that cap regardless of how much room the output buffer has:

	if (spec.field_width > 0)
		len = min(spec.field_width, 64);

	for (i = 0; i < len; ++i) {
		if (buf < end)
			*buf = hex_asc_hi(addr[i]);

So the dump reads up to byte 67 of ctrlbuf and byte 68 of rxbuf.  Both
buffers are sized from the endpoint packet sizes, so this is out of
bounds whenever ep0 wMaxPacketSize is below 68 and whenever the bulk in
endpoint is below 69.  That covers every low, full and high speed ep0
(8, 16, 32 or 64) and the bulk sizes the supported bridges actually use
(64, or 63 for the Synaptics Sabre via USBIO_QUIRK_BULK_MAXP_63).

A device answering one of the five usbio_ctrl_msg() calls in
usbio_probe() with cpkt->len = 255 therefore leaks up to 60 bytes of
adjacent slab memory into the kernel log during enumeration, before any
user space is involved.  On the bulk path a reply claiming
bpkt->len = 0xffff reads 5 bytes past a 64 byte rxbuf.

Unlike the endpoint size issues this needs no malformed descriptor at
all; it only needs the dev_dbg() calls to be enabled.  When they are, it
is a slab-out-of-bounds read under KASAN and the bytes reach dmesg.

Bound both dumps by the number of bytes actually received.  That is in
bounds by construction and also stops the dump printing stale bytes left
over from an earlier transfer.  The matching dumps on the two OUT paths
are left alone: they use lengths the driver itself just wrote, which the
size checks above them already bound.

Found by code review.  The out-of-bounds read was reproduced under
AddressSanitizer with a userspace model of the two dev_dbg() call sites
and of hex_string()'s field-width handling; it has not been exercised on
hardware or on dummy_hcd.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
--- a/drivers/usb/misc/usbio.c
+++ b/drivers/usb/misc/usbio.c
@@ -14,6 +14,7 @@
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/lockdep.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -141,7 +142,7 @@
 	struct usbio_ctrl_packet *cpkt;
 	unsigned int pipe;
 	u16 cpkt_len;
-	int ret;
+	int dbg_len, ret;
 
 	lockdep_assert_held(&usbio->ctrl_mutex);
 
@@ -181,8 +182,15 @@
 	cpkt_len = sizeof(*cpkt) + ibuf_len;
 	ret = usb_control_msg(usbio->udev, pipe, 0, request | USB_DIR_IN, 0, 0,
 			      cpkt, cpkt_len, USBIO_CTRLXFER_TIMEOUT);
+	/*
+	 * cpkt->len has just been written by the device and is not validated
+	 * until below, while %*phN dereferences up to 64 bytes of whatever
+	 * field width it is handed.  Bound the dump by what was received.
+	 */
+	dbg_len = (ret > (int)sizeof(*cpkt)) ?
+		  min_t(int, cpkt->len, ret - (int)sizeof(*cpkt)) : 0;
 	dev_dbg(usbio->dev, "control in %d hdr %*phN data %*phN\n", ret,
-		(int)sizeof(*cpkt), cpkt, (int)cpkt->len, cpkt->data);
+		(int)sizeof(*cpkt), cpkt, dbg_len, cpkt->data);
 
 	if (ret < sizeof(*cpkt)) {
 		dev_err(usbio->dev, "USB control in failed: %d\n", ret);
@@ -258,7 +266,7 @@
 	struct usbio_client *client = adev_to_client(adev);
 	struct usbio_device *usbio = client->bridge;
 	struct usbio_bulk_packet *bpkt;
-	int ret, act = 0;
+	int ret, act = 0, dbg_len;
 	u16 bpkt_len;
 
 	lockdep_assert_held(&client->mutex);
@@ -314,8 +322,14 @@
 	act = usbio->rxdat_len;
 	bpkt = usbio->rxbuf;
 	bpkt_len = le16_to_cpu(bpkt->len);
+	/*
+	 * Same as in usbio_ctrl_msg(): bpkt_len is device supplied and is only
+	 * validated below, so bound the dump by what was received.
+	 */
+	dbg_len = (act > (int)sizeof(*bpkt)) ?
+		  min_t(int, bpkt_len, act - (int)sizeof(*bpkt)) : 0;
 	dev_dbg(usbio->dev, "bulk in %d hdr %*phN data %*phN\n", act,
-		(int)sizeof(*bpkt), bpkt, bpkt_len, bpkt->data);
+		(int)sizeof(*bpkt), bpkt, dbg_len, bpkt->data);
 
 	/*
 	 * Unsupported bulk commands get only an usbio_packet_header with
-- 
2.51.0

