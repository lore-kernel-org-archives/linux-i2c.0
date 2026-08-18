Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53FA470EA7
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057283; cv=none; b=psC/rRlLNvenQ8Q57UxDR3OienkyyNIHTiKlMMInLX7uzM9uBABXexxvSaFEKBE25lVq71VViRZpmIB5KZc4uZmG/7ahKr654zAOMF+g5ggCz+ZApicPvzlb1KPbzYzeHSc1yH96gwVL8n+CrQ3fqBa7czpJYHbiJ3/98E4QPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057283; c=relaxed/simple;
	bh=A6wW0ZUu2F786I5qd4l5k3Jghmxrfs2uEICSKwWPqmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJft06R6eGl9GaNo/L56Oyznb6Ccnnx4auFJwPz9iMt/U0P6y8lYY3TEOKSftVoWgJVsMXy5/xQNPl06A3ZICJgbGhb1WJ5UEFKDNd86bMY2s+xA1m04TDsimvQHrGvat4INii5c4B19tsZuL3g+6dME91PDbKn32AFXlf52eMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSy8Aper; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSy8Aper"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so4154219a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787057279; x=1787662079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dlh7Y8qVGJ8WIGHUnigalQWKQ2jUi5iYeCv0CSAEtt8=;
        b=OSy8AperA9oGV6ov1ohMxewqu3Fkmpatvp7e8lCuY/lqlJrmPkAzgzeICKL2iPSLL4
         78pZ09E+U48NnwULG7yPLfNgnhG/YA4TJNqUau1Pi13o6mr4zGysFpXJhp/LdAN0CY5B
         GikYVFrW6+mLxPSZjsyty1NG1nkrBWHCAAmXzDl9mjJskDlUixd61mM64FZKZy3PSp9V
         exSFv/NPpgV5m9+jbyOAdthoOWx+HYzX6drbh47VV5CgfYEjgPTdLSjSOJk1yWmqHJuy
         xHijKxZ8ExZW3aCaC/JD5btuGsE2Cd8OILqnZfyOjsZOxJV8Ej8/UzjtDfWs2pj2gwan
         Z0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057279; x=1787662079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dlh7Y8qVGJ8WIGHUnigalQWKQ2jUi5iYeCv0CSAEtt8=;
        b=o8ucfl40oOqQDdd/Jq1Odp/jzf5L9qAAgQq8AZa6zAtURH+b5k2jjhF4e+s4aZqfo6
         f1XjBwPKnLEoEglgpC5+il6NMkXcaVcDbBcb9vC/8yVoSSaqI1SDYmB6YPBT0mSJJoV0
         5bqMJqdfrOh1vkFnTEjs4fBLUDmDFi1NO/INFs/UYEVco1/Vqef7KxBiDBtQFCBsPEOv
         GLegO/ElSgDiNDiNY4PZtx30aXzQk3ogj89t5ioHv5btRErCpGUy2yoScgCKMd+jWkO5
         +3ITiLrlWFPTefTm0Lh6yhVHRkrzlTH8ySzMDefDwQa/dtSXH+fCS07Dk/XNze5MxECN
         abwg==
X-Gm-Message-State: AOJu0YyG4/mCRfC47A3kn90AeFq68klRv8QNzsGvHuF0kZT2jmtbIJni
	vt8niWElY1ndTs3CNO430ASCrKy3z4o8b0D4ufT2krulmBJpI8KibpGEw578AabpKw==
X-Gm-Gg: AR+sD139CFkz8Q51b2qygShaGyb0CT5kEJK80cMGY96MNAD6R/iAIGjq1/h1FOkmurJ
	hD41BvTie5FtZ/t4M00RSmQLBUY/NhzaAXvL72Q59/xnARSa32QTG5Nm9rTy3c3LjPKrrT7baAc
	LrUhm6cSHZqMLPub30jdLrHbshGbDo/nw0+An0HYkKLoWxRa1eXJxTUqwVHVzOcQwAZRiAzsiIq
	6dDnGlGP+mloWjJe65INPoecp5cbZBzk0KnohlFOYOz3U+9bVIrbeOo9T8Tzn0vsPwBgku9jnjh
	goQWp4wUfkzGXidiTRIpIMRWOjuym/SYidGqvboeW266mszEpzbISY/SbbPlFQPxM6BtEqnTSaX
	n3BkF7ukx4qJVyM/FA7pIJghPv+4aPSUtZlPqidBtt49q1mDuRWRHHZ7tyrMoicai676XmAUR0i
	Z3kFDHFOjiaiNjq4nnJmkegBbSm3jTPXtEdnGZhLJqBcfQSnZkfXe4mOzyJvLawxvXCOjEPTzAy
	gXpH2GY0SXnNnW7/5sNRpVztVypzJ1tzTN30BVLJlKraZGK8B5WaE8QltjXQB6fgJPP
X-Received: by 2002:a17:90b:4fce:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3955a3dd55fmr12225088a91.1.1787057279493;
        Tue, 18 Aug 2026 05:47:59 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395320229f4sm8266238a91.15.2026.08.18.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:47:59 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: bence98@sch.bme.hu,
	andi.shyti@kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] i2c: cp2615: Validate read length before copying
Date: Tue, 18 Aug 2026 12:47:37 +0000
Message-ID: <20260818124737.64478-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read_len field comes from the untrusted USB payload, which could
potentially exceed the client's originally requested buffer length or
MAX_I2C_SIZE, allowing an out-of-bounds read and write.

Limit read_len to the maximum size of the response buffer and return
-EPROTO for an invalid response.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/i2c/busses/i2c-cp2615.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index 951de6249834..2c79530da306 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -136,7 +136,7 @@ cp2615_i2c_send(struct usb_interface *usbif, struct cp2615_i2c_transfer *i2c_w)
 }
 
 static int
-cp2615_i2c_recv(struct usb_interface *usbif, unsigned char tag, void *buf)
+cp2615_i2c_recv(struct usb_interface *usbif, unsigned char tag, void *buf, int len)
 {
 	struct usb_device *usbdev = interface_to_usbdev(usbif);
 	struct cp2615_iop_msg *msg;
@@ -160,6 +160,11 @@ cp2615_i2c_recv(struct usb_interface *usbif, unsigned char tag, void *buf)
 		return -EIO;
 	}
 
+	if (i2c_r->read_len > len || i2c_r->read_len > MAX_I2C_SIZE) {
+		kfree(msg);
+		return -EPROTO;
+	}
+
 	res = cp2615_check_status(i2c_r->status);
 	if (!res)
 		memcpy(buf, &i2c_r->data, i2c_r->read_len);
@@ -236,7 +241,7 @@ cp2615_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		ret = cp2615_i2c_send(usbif, &i2c_w);
 		if (ret)
 			break;
-		ret = cp2615_i2c_recv(usbif, i2c_w.tag, msg->buf);
+		ret = cp2615_i2c_recv(usbif, i2c_w.tag, msg->buf, msg->len);
 	}
 	if (ret < 0)
 		return ret;
-- 
2.53.0

