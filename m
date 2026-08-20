Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C83B71AA
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262006; cv=none; b=RQkBHP3bGGtDc3NWGL4zQWOVVduDb72vJYb6R4KqCGkbnNANk+9cdwT4FQyxPdVWG3qkxBvs4WkdcrbOpPI23wR6uNldqWXqAfFLe4E6niZO1V9cx0UfxPAsvRWKYeLTVBhdJHI5+f3KtJvlI8DAV8y7LyNC/RTQAqCrwRWofQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262006; c=relaxed/simple;
	bh=Zl6wUP1R0MbhaQMe/CaSWH1CK7ZZnf3hPFFpHs1l1QY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MietfjQF1FvCIFVzIMcJfmJWb6uBPTdw4uXrldxGNmc75FuSgK9VPHpd9p8seq0VYQJjDoFxQLIFYB9WcmeNMqulcVX4ysU7Zuj/7bAPdN4pVP8LzkJYKeC7iYCPAoHQoU5C1Yyo6S+7kzr8Ir/Lj0PQ4WlNowXkIZ183iENKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFaY7si3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFaY7si3"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so345084f8f.1
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787262002; x=1787866802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/S/n7d60IPenCr0oCOquDxWa23qqnUlu/ruC4GGmms=;
        b=tFaY7si3Bz6dgDEzxm7F4zLm/Qf7jV5LdV+qQn5Mi+sKWkKUTIJxQYbaZWqz9Nvbnm
         xpXTAdB60OATbzub86TgzLjUvSzLwU7FVaH935jbwDZ3NKTliJDONWN1sp8aNqBxB57n
         sOXNthGclLbKsKZ1/utSIITBeYMntZUtkbh7LNkvKgD7kb6mLuvQSAVkJE+MQ2+sFvkA
         jNE4bIHmbTBbFbNg910ERlMWZCqzZ44N17PNvUDbrB59apTP00XZjSj52GgkiqVzhf08
         eRnMfG3KdV6xOjktKuRZ6+ml8z9b18FxpZ4JHZXQ23sCx0d/VdLUekwjRhKrgozBFyE5
         zt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262002; x=1787866802;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0/S/n7d60IPenCr0oCOquDxWa23qqnUlu/ruC4GGmms=;
        b=YUJty0zrgASsSWdyvKUXBzjsKHlLKMdnXkSrJS1u2PK6P2QWdePyhuR+7NFhaRYOyJ
         41nyfBDYO77bCTd4gvVzq1GEIeaPfP2nd3MjIhmqFZ4ygAHjJEoiEbCmm7uauwATOxl8
         zAEbJGvWV5Yf6p2+5UrcGPlyYffNytyoKm866Ca7KzjKTd1rWKRsROe/PVYkZOqQp4kl
         /RBRBM3b/khAeYM+KBSFfbIuNpLzFmONU+uQuUsERBgMWx+6CGXPD8W8q5Usmy41TPFQ
         UB0BKRCIMrquTD7RLBE/EIs6aChVGZj/x+f2D1GTlGr3C0k4XJUrbT9vOgaBNhRooXtn
         Ep0A==
X-Gm-Message-State: AFuF++lwtdWlEb6VnmgZcCRpH45AYz77HXCRqpgjExN88ZRSD/QyQ95u
	VkOmKRV1FzlZlAlVpRfIbvJ1nnTwNVFafuboi/Lj+ihb8aCJRWP43xU2
X-Gm-Gg: AR+sD10QiBDomPcmuacxITdQIGJNNiGe0fLjZDK2o9tb0KUi0Y6Ol/lkS2rZ5X3X/zl
	rr+BTSPl5RZqKpuJ+dfso9Mtl/XLYTcsvxMgX2CAphCTwSJwvLlmhgzbJJmG6eaunvsMWhvGuhv
	Dsx0zMPUxe0FtD/M2HkYrjQcljoygmtOenTdzyc3NPw2QYBOakXPUOnLNglRCwEFDUJpjE9iAs2
	iMW04Sxcbk0RnBNHEbo1gddspNOsUKX87/8RdQy6ALNK3mBfeNbmrUsKWc1PExyWnJFCmvgsO2+
	glZ17gYBrNiEwnFUfVm4jGqQbfrFKfjKK18mdpLUDI3JA2Cif+vY3ZgO40KMhlrZRrCgOC6Yvyy
	Lgk+X6UY+iy1/iS+R1ZZA6V6s+ni/Nwy4AYN+zOWcXfCEycE0RG1lJNpcweyIxoSjECXtmARhoR
	bOyElntrISKzdfpvdXL3aDQtbgCVP50LzAMfPgovWoMAl59S5Pl+/FWJs8CamDA2nAAXeXNQyMh
	/VEhExHL9eCmfFU0Tz2CniufN2IuauBl5A5xgtAIxrVhWv15RGQoQc=
X-Received: by 2002:a05:6000:461c:b0:47f:96e3:5309 with SMTP id ffacd0b85a97d-482c0b6331emr2836146f8f.9.1787262001657;
        Thu, 20 Aug 2026 14:40:01 -0700 (PDT)
Received: from localhost.localdomain (88-165-21-128.subs.proxad.net. [88.165.21.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d059bsm13245121f8f.36.2026.08.20.14.39.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 14:40:01 -0700 (PDT)
From: =?UTF-8?q?Benjamin=20Cab=C3=A9?= <kartben@gmail.com>
To: Till Harbaum <till@harbaum.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: tiny-usb: add Zephyr Project VID/PID pair
Date: Thu, 20 Aug 2026 23:39:46 +0200
Message-ID: <20260820213958.41276-1-kartben@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Zephyr Project ships an i2c-tiny-usb sample with its USB device
stack, which turns any supported board into a USB-to-I2C bridge. The
sample implements the same vendor request protocol as the original
i2c-tiny-usb firmware, exposing a single vendor-specific interface
with no endpoints, so it can be driven by this driver as-is.

Zephyr in-tree samples must use the project's own USB vendor ID
(0x2fe3) rather than a donated or third-party one, and product ID
0x0013 is reserved for this sample in the project's VID/PID list.
Without an entry here, users have to bind the device by hand through
the driver's dynamic ID sysfs attribute.

Link: https://github.com/zephyrproject-rtos/zephyr/commit/281b5743d183
Assisted-by: Claude:claude-opus-5
Signed-off-by: Benjamin Cabé <kartben@gmail.com>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 73355a56aabf..113af96728dd 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -157,11 +157,13 @@ static const struct i2c_algorithm usb_algorithm = {
 /*
  * Initially the usb i2c interface uses a vid/pid pair donated by
  * Future Technology Devices International Ltd., later a pair was
- * bought from EZPrototypes
+ * bought from EZPrototypes. The Zephyr Project reserved a pid from
+ * its own vid for the i2c-tiny-usb sample of its USB device stack.
  */
 static const struct usb_device_id i2c_tiny_usb_table[] = {
 	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
 	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
+	{ USB_DEVICE(0x2fe3, 0x0013) },   /* Zephyr Project */
 	{ }                               /* Terminating entry */
 };
 
-- 
2.55.0

