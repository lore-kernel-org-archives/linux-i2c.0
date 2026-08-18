Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA12D9EFF
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051840; cv=none; b=XwbbI+x0lrXv1y/nI7I0qFEVOCLQ+18FozLAIXEWy5NiDJB4iV6XmVDmeIG4JqKk2xV4THfu4Nzq4kww5VZZ6Oo9LW63HtNLxLVyjzkrGPAAR/5UMfn5mByP4R1MjbxIDbSu0+CtkcteYrjisN4/2TggdMGyMQFRiddUwlSe2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051840; c=relaxed/simple;
	bh=XOZ1C1WKX1Q/N+q97vmu/pBg6mYYy87yS7RYm+CZIq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JavbW4s8XiJfRGIJYhVPGuroMpzt77Ga9iVOWOpcJJ0cN3U44dWqtKX+RfCrnutTFI1vZU9YNaX/bM/llgarWmkbOKEz6Mp+i5+AHLt3DLB4CCfPaXTgu40iqjf4ehQSnkwyOOQCndfWzUv8tVqyB5asqzBtdgDktX9UMbD0e8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THVHSd6c; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THVHSd6c"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceaf8a1265so65803015ad.2
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 04:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787051838; x=1787656638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MC+OZGjGzIkVi4Bke2RwJ2I/Y01BrvObCBkky9oI6Y=;
        b=THVHSd6ccuooFx/7/ty2TUozXULkt+U/mW7YUmeEPIFUSOdY9vBk8de2uo17Lb+Lyq
         Gds/8LPWmp2fhveC1drNjVSBVJxwcuVDtMGF4gFoXc8f9eK7Wr6N3S1x6ZcXE1VWsymw
         ixEDaWmKFPTpRvquwOrlqYHNQgbt4Eyz84XMnG8/qWCjG/IJ6wBRO0C9V+oU0OBtFQ+C
         IWyf2p410R44KzdUXXFz4DhLJqS+qtPfGj9/GZJDV89hJD+upql7j9wU5PX0P5nwwsPs
         E3ot+Ipe2doDMs4YaDUw6tHRMQU6l4zHSolR+klKA3i/eOnt9Fz307N2yNYl1LWmZgDf
         rh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051838; x=1787656638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/MC+OZGjGzIkVi4Bke2RwJ2I/Y01BrvObCBkky9oI6Y=;
        b=s+mzQliqVD1Kxo/An17vh8kFQbLJ2QeBjDSQzJTveB/pxgKlh4vg0q77lQqQxanCcE
         Y1gUl8mAuLda7KnMa7aGwJbGALPO+WpmH1W7fwi79zxPTq4dhKFFtIljQSY55JsaEZMp
         RDBPh2ksauN7H/RZcIqtmiwPNGfxis2iPbVHhWOMuNSwI3LcY0KLPw+mfFl1mS9Tl66+
         oIgW0GSRMYHJdjoG4U1oJCMzTK3EJPohc+G9VgHllcPlSbTpkmuUOWsws58yYENa4hmh
         d52aTlBNwws0WBjMisKN0E+WCoTk3W8ecUl4/qAPHxo1UwRA6nqDvwa0GMgCwkgUBWs+
         jqvA==
X-Forwarded-Encrypted: i=1; AHgh+RrbvlU/zBVsof+V7LbI3NvLZlZH/uD5TJQxIWsbdGh3DNZ9FWg3Sc2iosr36kMkbSvb//p5X7Xgux4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBLjatmz0uAN/B7o2h8P30oPtEgOfCMdUm+PttiJq8KJEuusT
	FpOZX31/4+6PXrgl/YGBOGfNlQY6Np7yB4mwqkxRnZIznV+vptmM/MU=
X-Gm-Gg: AR+sD12ZKIhGzvLvfA8lT7ZItRE7MFeFZVdOOVG/gnHVnNfAhaR5/ACPwjE44uDsU0F
	k3dkAJQmbnbnydkM0jBBBD774+CosxlHKmB4Kv7J/4d+LhGaivkvhzYoz+xqjWJanb7l8rCsnEG
	f9p0oKbOlIPcRzBoIpGWd587YP9MZAf+4TOcjSTAnZc59G8sVzo3R2K8Netp0uzJgf6378AaY5n
	AtJ66HE0uidqIqVsl25pkqgrCmqveD6wE1iD7rUkZ15dBmZyhP1wHdUXSZ2Si/Vt2H/yiboiD3o
	ahxtkBRiVVyYqQEb7MSGE/xpBsqZgpMmPBC5c0CLA3Nd5tnUx+PaJ3pXYIpGFMCU5RPVyLH8e4z
	Oh/6Gs4PBalmt+vBpsHiPPx0Mcw/JbB6I/pkWtJHnZGevTB1c35hi/ushi1Z3RffSr6EyYQahLT
	MBnNlVe4KQ4IyAtn5bYW58G/bsMtlVcFGCbKSW/An9jQtjyr5cXiwEhQE6q37ia5Vt/OutgRini
	z5QA4VVkwCxrVpfrQU4OUHiiVDLoq+3XlOtlsVOdtnI0WR3FfhiHh8vJ4acGzjlu15Pdz6E/ULf
	M3PX
X-Received: by 2002:a17:902:f691:b0:2ca:481:de45 with SMTP id d9443c01a7336-2d5c4f3b815mr95122705ad.6.1787051837903;
        Tue, 18 Aug 2026 04:17:17 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e542ebsm13534685ad.47.2026.08.18.04.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:17:17 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: triet.hoang.dev@gmail.com
Cc: andi.shyti@kernel.org,
	bence98@sch.bme.hu,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: cp2615: handle allocation failure
Date: Tue, 18 Aug 2026 11:17:01 +0000
Message-ID: <20260818111703.19604-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816161751.24840-1-triet.hoang.dev@gmail.com>
References: <20260816161751.24840-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the result of kzalloc_obj() and return -ENOMEM
when the allocation fails instead of passing a NULL pointer
to the message initialization helpers, which would return -EINVAL.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Clarify the commit message to describe the actual behavior change.
- Fix coding style regression
---
 drivers/i2c/busses/i2c-cp2615.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index 951de6249834..c1275fcad636 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -128,6 +128,9 @@ cp2615_i2c_send(struct usb_interface *usbif, struct cp2615_i2c_transfer *i2c_w)
 	struct usb_device *usbdev = interface_to_usbdev(usbif);
 	int res = cp2615_init_i2c_msg(msg, i2c_w);
 
+	if (!msg)
+		return -ENOMEM;
+
 	if (!res)
 		res = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, IOP_EP_OUT),
 				   msg, ntohs(msg->length), NULL, 0);
@@ -176,6 +179,9 @@ static int cp2615_check_iop(struct usb_interface *usbif)
 	struct usb_device *usbdev = interface_to_usbdev(usbif);
 	int res = cp2615_init_iop_msg(msg, iop_GetAccessoryInfo, NULL, 0);
 
+	if (!msg)
+		return -ENOMEM;
+
 	if (res)
 		goto out;
 
-- 
2.53.0

