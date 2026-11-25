Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636372;
	b=frBWFAsi3N2qHNkoaJ/pGbt133zfxr/GqG3+tOOlswjjff4q/jFb36rYptjtthtnE3MA
	 80AQu3ZDKnqdgLgkiPwDdeg7vbjHHpGh3Dq/L0oo7ersqwSb6BxXodgxQUKNtTrCKmQdC
	 PLp2iX/jczC5E3AZPiotjBVIswD1QPUBkezuuxhx8G5I5vFldH4s44DOAzLWQaY2RQ51C
	 eY94ixGtU5jZngkHQIHAApDxF70o0oeHvjMBYf9VVSjWJRsB/eTrRedmrGmOjE4so2+So
	 lOs70QZappIrAhoHewT0uJipiCZ/xsfCkXG58LX0L7UwD+D59h2Ope+CSD92kIYoRLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BZcZxhaxSJ/yJnQYWyNEcboOSPjno3nyUstEGgSmoHg=;
	b=lFapiX8MPDEKQKUP4nIjM32vlqrvPMKAzamsCst+YamSkDt4ayj2mv490Dr5m/Lx8i3M
	 Oyrxi6Vb1iMCOqvlU65uo8rH+hNglRCbIPgWQQUN2nnSFqWSNkXeGjs/tb5tjlaYbrErU
	 K2lCpXSjxi490x5nft1yjNEbZ0OCxnGHTGJy6Wb3CZtPAXM3Y3LiPsDnrAOrI6Yw24nFY
	 k5gxxanVfqKBSY8dpe30v0tz/N1RSwOjtmZNhuWW+wn3DKQKrdD27TYeBaV5ApM5BXZeK
	 k4mrnAGG6+ncjHDAaxAlbrPaeSVucXFxjWoq+rf3/D1N917vqt75iYebdwXIuvRinLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A6V64foD;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3C606A326
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 19:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA3C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A6V64foD
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-491971ac844so5572046f8f.2
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 11:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795636370; x=1796241170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZcZxhaxSJ/yJnQYWyNEcboOSPjno3nyUstEGgSmoHg=;
        b=A6V64foDaVtI4/WwFsF/il3g2hZKWvB29X7UnZOKrsekYUlS8i5lNskB5IeKirP7HO
         a+U+HFDEzgpnKULD1r4T2JSQvrTuzJhODoai1UIsIH1KRQ9Y2Ip0t0DCgHefQzgeBe+Z
         gf87mQiDvSmGdfe4S7IxsibYUIJx+icDJWEkNPj4cQfmTLKld3mj1zecnTQdNP/Wm55q
         cvtpavIL8e56L7cTxcu84GRT4aX57WzXpVXeMaTqVpTgx0JcUSvTLdXoEVfhUqL53PgK
         061cDOfepmOYhYOVv5uxY+bll8s9aRBK5PVAtkQ21VwtaSQAhGAT3OvMrtPKjxRBgRrK
         R+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795636370; x=1796241170;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BZcZxhaxSJ/yJnQYWyNEcboOSPjno3nyUstEGgSmoHg=;
        b=Jfv4Gtlm25gWcmsgz5cCV2AGrXCz9tP3mKQQ3RrEMl7wswY8iqNr9UO3EAks8unXy5
         63/ZhtVLJ3BT6vzx7P6v9oEvCExnbVnRrOx13VpYozCI77pMCNpCxwdijv3JRdAIS71U
         OEqQsZ0ZXUUwIvgmCSQp6qic0q2LPQP4W5FzxMGe3yMSCWx8gc+zYGoDPOFVHCHmbiTJ
         Q3Ia69HKRqStGoNd5p8lrSnc3Fqska0XygU4rp9E/sHjcqOooQfWoiS5jrGvYuJjhxxB
         22ayXEP9uILQwzX11Qm4RT96wqxTYZlBwdN0hiX0fk3oFDALCgAoEufIP6JX9UDpJ4jT
         G3kg==
X-Forwarded-Encrypted: i=1; AL+hErHagdk1gOHGJIYQsmNTbnFWaEnH9+PK66JdYJ3nNiMvbfP13dbIMYeV+hZBJWUviKLX5/pSXLltioQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WYWKm58H8iaI5B1J6boLaBK+j/aMnGp5v5dgdn6jZkBf7hN/B
	km7Sbr05kosjNy/6Rf7wZ6aNickZaHlLF2XCkXMFO2Vl48FKjsPuELfVMo/7+I+L
X-Gm-Gg: AZFdTZfr/qXh6i/fkBafQV/48YmPVmebOfo8D79f7OrYbf+g1gxvGN5NqLeqxfSrxFB
	7rXZnWpeoxuORr6Jn5621wbGxa7nnMEP+lnctdsCWrNJd7hyawGhChNDtij1MBc0hgw5ZBEEWHk
	GY86FqhF9hSuEycMpjwMo+4kJs+ZgarCOyTTkndw0LTZJE5T3vUi0tgh986hoqKQpXcOcQLHUMH
	HVnDkxYjiJcKBkn2Hxh+472g5CPpaLqV+0us4wNuF1g6YXSb6TAEtDP0AFTVVRzk3XQqoRYpPh0
	IdGXxPwm6aT7Dz+XY6kvmRMIZSnvfC5cVaYYVlXCLTGkrqmb/eAyvp00k9XH98tN+JM6+UdR3/2
	yBX7G1ziOwBEoFab/dtfI/g5NnpCWWD/6hyS5KH8EhGSa7qQv4Ir9L9rOC+czTsyMGxqPz01Mia
	EcvZMQB7j/jpTyysZvXYebIrJLvN1HTi75qHB4s8uP/dSAH5FLFPbulLy2dnkXEvCfOeBuDVRc9
	l2J5mla4iU2pmrXUhQEwaeqCfGBI15PJeJBltcU+RJL/+n8BbJyNE9Pt4rYA2KbrxmUkyDQ35x3
	VlKjUmRIdP9Kub0Uh0DUH1dkJXstKtvYICArB5U3Ag3nfyAYfMcUwKulUHzcA1FZm+LUtvKdeQu
	mKiAca0Hzuo8oOol3XVFJB4KsEK+Z+Z/h99mNyBOQXCeHMlrE/o1h/M2R1NmIc5UZqVOv9RMAQL
	0yFTTOFUw=
X-Received: by 2002:a05:6000:2607:b0:48f:bb92:c5a7 with SMTP id ffacd0b85a97d-4abb0c5d665mr37431353f8f.9.1795636369875;
        Wed, 25 Nov 2026 11:52:49 -0800 (PST)
Received: from macbook-pro-de-benjamin-5.home (2a01cb0c0829f8009c6f5770f9f21e3b.ipv6.abo.wanadoo.fr. [2a01:cb0c:829:f800:9c6f:5770:f9f2:1e3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm30383269f8f.46.2026.11.25.11.52.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:52:48 -0800 (PST)
From: =?UTF-8?q?Benjamin=20Cab=C3=A9?= <kartben@gmail.com>
To: Till Harbaum <till@harbaum.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] i2c: tiny-usb: add Zephyr Project VID/PID pair
Date: Wed, 25 Nov 2026 20:52:35 +0100
Message-ID: <20261125195236.95816-1-kartben@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
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
Reviewed-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---
Resend of [1], unchanged apart from collecting Fabio's Reviewed-by.
Still applies cleanly on current mainline.

[1] https://lore.kernel.org/r/20260820213958.41276-1-kartben@gmail.com

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
 

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.43.0

