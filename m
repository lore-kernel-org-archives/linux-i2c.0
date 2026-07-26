Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61B37B016
	for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065787; cv=none; b=O3F4PEqnyYgj7T7KN3YCEu7lh00mgYpc66s3x4ATxqpJd+rXWALWjaUpScgwsk5ETMTLf5OBIk7i2D5qPl6OzqTDyqHJo9RQCgnNJhRtIqx1Az7DiBNQ6hDksNf40IpAjFvVGZ13Ma4KGyxgFXDr3jo+rfzTfsWV8sOQYwTDLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065787; c=relaxed/simple;
	bh=+AQdO9jbHPGWTkO02kfiTsWfoEksoJp8fjCl6GsmFuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIUkrOzEuMp4HMfzk8EsEfx3C/NAUqj6XV+aRl+rinKWGlaKpoV26aVQLKfQR/GRz0YsE24gh6RkEyLq7D7DI0k5XL9CYwaSNFuAp22+NsWvqTBUXkDEEoNm4lfYIedjeo1gke+oLftWnjLJrEmwW0JMeSToiRdwPsjvJfLPecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgAJjsTr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgAJjsTr"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e0688b859so992205b3a.0
        for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785065785; x=1785670585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V3UIYH7lFVlBcdk70z0Hk0kHBBIMfI7kKaGxbMqB1eQ=;
        b=rgAJjsTrNukpgUEKryoqaFs6cbW8loh0W0eONnFgqHFU6pdEJbwxFcRNOMWhJbPrSB
         riCmki9G3/hCawxutH6R182gU/w9ehrK4AWcEc5Vq4XQqK4Ykh+qLJyW5Md2Mf7Gnv1F
         NuMTndCt2mdX6LKVAWqmoJT6nAsxHaYU4BaChlDI7dlijlZCgVpO4S+zpv6ku1DzyyOs
         PH+Zkq0pN7D8HCul2+8FVPqYtMOQ8/usvfj5t2o2NkP32KItB0FaEGAiKkJFiWd+3lSt
         6NUSOxGIQ2fsXM0SGKDKN3WbsBgHIuEWRGkTXMcbkO15xq8XSlV7H4+X0D8tHw3vgwIU
         ITmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065785; x=1785670585;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3UIYH7lFVlBcdk70z0Hk0kHBBIMfI7kKaGxbMqB1eQ=;
        b=EMRWrfYYdY3yZi7nW6bsAN7LH14chDGVo2ZKir2u+hVUURvec1Z8KwvUO0BpiQnWJk
         TuqVYyZIsVCMH1efRlmiJtEe6cuIej6G8TVrexSl0KSpk0X+lnCuy3wSgaI0b6XEUkDh
         jKgbRe3GQxR4DiifqyXxC+wtwtYl+2NNfxjMLVUTe7J2E0Se39WZJe/xfPzDcHSnBRfL
         sQBnHQ+snMi4STcm8xQxxNnKPlyIITP5kbKg/NfspCMuOJjwyRWgBPsovb2PpEi3+UeA
         a6lFuUqDdS66IAdNxQ2Q9YJX6pLSrW/JXFNRfsz171KSg+rPDWanZEh1NiIU3kmHCWLq
         xciw==
X-Forwarded-Encrypted: i=1; AHgh+RoqvlO+ZknOjfhfsY7PUpWAsncPqrp1Rrr9cl3WbXSUy/JcKN5GJCpoZQl5uOsRT8yz7999LiAgIYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEXe6MXIOpBFromk2+XUTJGlPXdyddJheQBisrhUq9fHMPhuFz
	D3rIZo6akDy83wVIkvoZTPbTRMjvJScGt93wIPK7uBB2dupudDhaeF4G
X-Gm-Gg: AR+sD10kCdZ/tyF/tKgUYZeyEkdbBKWhzMnjH+YspLe7PnJoDE8kXnBGZuX70o8jcJV
	lFMddfinJlpN0i+0IR6pqaHYDnzDWnXVmJRCowJTGZkcz8O2cpBoBD69Wf9TNMJ65yk6lmicltX
	muk0XpTfOBe8feQVmUrAr6fBOFb/n3f5Q9bQGDx0lCCcJEQuGWfix3C86x066GeKxUr5qjCsPRj
	9VUYj8r6J1SpSbqBgZvGzcI8OXp4Fw5x88EqUabTaItOr/Bqrqh0awlTsknXMo7mWVBs6DPwDQ3
	o7kuu8lRs66Kd6BbunMxu+63FMO18PDU/riMFyNgaBgVHGw7AH23xlAPrDbG+L+OhPvkF5cSQSV
	ZyXWdFjyCvNX/+ezP8HWwMPzGf0WPp6Ej9klX7HKon0pSUxWq7ab43JqFdQjkx+ZOMadU8AYq7J
	ksESjuqXH0iYUtvdfQ4DVJYnsobvgqHjsPpyhH+lN//krVlK504Amzw8W5lFw9ubfDORb4yU42M
	Q==
X-Received: by 2002:a05:6a00:218f:b0:848:2f71:b657 with SMTP id d2e1a72fcca58-84e59589e65mr3842731b3a.66.1785065784806;
        Sun, 26 Jul 2026 04:36:24 -0700 (PDT)
Received: from localhost.localdomain (211-20-143-81.hinet-ip.hinet.net. [211.20.143.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532585edsm1785051b3a.4.2026.07.26.04.36.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 04:36:22 -0700 (PDT)
From: =?UTF-8?q?HE=20WEI=20=28=E3=82=AE=E3=82=AB=E3=82=AF=29?= <skyexpoc@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HE WEI <skyexpoc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] i2c: usbio: reject bridges with undersized transfer buffers
Date: Sun, 26 Jul 2026 20:35:08 +0900
Message-ID: <20260726113511.57596-3-skyexpoc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726113511.57596-1-skyexpoc@gmail.com>
References: <20260726113511.57596-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

usbio_i2c_read() and usbio_i2c_write() derive their per-transfer chunk
size from the bridge buffer sizes:

	u16 rxchunk = i2c->rxbuf_len - I2C_RW_OVERHEAD;
	u16 txchunk = i2c->txbuf_len - I2C_RW_OVERHEAD;

I2C_RW_OVERHEAD is sizeof(struct usbio_bulk_packet) +
sizeof(struct usbio_i2c_rw), i.e. a size_t of value 10, while the two
lengths are u16.  The subtraction is therefore done in size_t and, for a
bridge reporting less than 10, wraps before being truncated back into a
u16.  rxbuf_len = 8, a legal full speed bulk wMaxPacketSize, gives
rxchunk = 65534.

The chunk size decides whether a transfer has to be split:

	if (msg->len > rxchunk) {
		/* Need to split the input buffer */

The adapter quirks cap msg->len at 4096, so a wrapped chunk size makes
that condition permanently false, the splitting path becomes dead code,
and the single-shot path asks usbio_bulk_msg() for more than the bridge
buffer can hold.

The boundary value is worse.  rxbuf_len of exactly 10 gives rxchunk 0,
and I2C_AQ_NO_ZERO_LEN guarantees msg->len is at least 1, so the split
loop is entered and never advances:

		do {
			if (msg->len - len < rxchunk)
				rxchunk = msg->len - len;
			ret = usbio_bulk_msg(...);
			if (ret < 0)
				return ret;
			memcpy(&msg->buf[len], rbuf->data, rxchunk);
			len += rxchunk;
		} while (msg->len > len);

"msg->len - len < rxchunk" is 1 < 0, so rxchunk stays 0 and len never
grows.  The only exit is an error return, so a device that keeps
answering keeps the loop running indefinitely and uninterruptibly, while
holding both usbio->bulk_mutex and the client mutex, which blocks every
other user of the bridge.  txbuf_len is independent and can be left at a
normal value, so usbio_i2c_init() succeeds and the read is reached.

Check both lengths once at probe time.

This is a behaviour change: a bridge reporting a bulk wMaxPacketSize
below 11 no longer gets an I2C adapter at all.  Such an adapter could
never have completed a transfer.  usbio_i2c_xfer() runs usbio_i2c_init()
first and bails out on failure, and that needs obuf_len = 7 to fit in
txbuf_len - sizeof(struct usbio_bulk_packet), so anything below 12
already returned -EMSGSIZE for every single transfer.  Failing to probe
is better than registering an adapter that cannot work.  No supported
bridge is affected: they use 64, or 63 via USBIO_QUIRK_BULK_MAXP_63.

This additionally covers the case where usbio_get_txrxbuf_len() returns
without writing its output parameters because the bridge is already
gone; the lengths then stay 0 and the bridge is rejected instead of
being used.

Found by code review.  The non-terminating loop was reproduced with a
userspace model of usbio_i2c_read()'s split path; it has not been
exercised on hardware or on dummy_hcd.

Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5 asan
Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>
---
--- a/drivers/i2c/busses/i2c-usbio.c
+++ b/drivers/i2c/busses/i2c-usbio.c
@@ -245,6 +245,20 @@
 
 	usbio_acpi_bind(i2c->adev, usbio_i2c_acpi_hids);
 	usbio_get_txrxbuf_len(i2c->adev, &i2c->txbuf_len, &i2c->rxbuf_len);
+
+	/*
+	 * usbio_i2c_read() and usbio_i2c_write() compute their chunk size as
+	 * "<buf>_len - I2C_RW_OVERHEAD".  Those lengths are u16 and the
+	 * overhead is a size_t, so a bridge reporting less than the overhead
+	 * makes the subtraction wrap and the truncated u16 chunk size then
+	 * defeats the splitting logic, while reporting exactly the overhead
+	 * makes the chunk 0 and the split loop in usbio_i2c_read() never
+	 * advance.  Refuse to attach to such a bridge.
+	 */
+	if (i2c->txbuf_len <= I2C_RW_OVERHEAD || i2c->rxbuf_len <= I2C_RW_OVERHEAD)
+		return dev_err_probe(dev, -EINVAL,
+				     "Bridge buffers too small: tx %u rx %u\n",
+				     i2c->txbuf_len, i2c->rxbuf_len);
 
 	i2c->rwbuf = devm_kzalloc(dev, max(i2c->txbuf_len, i2c->rxbuf_len), GFP_KERNEL);
 	if (!i2c->rwbuf)
-- 
2.51.0

