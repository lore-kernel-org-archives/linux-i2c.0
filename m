Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22652D63E5
	for <linux-i2c@vger.kernel.org>; Sat, 29 Aug 2026 04:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787977359; cv=none; b=GKg9Br5H1Dw5cyhy+3fY+Zb/BqAsCT/bUEjnY70tR2lUgyL1XOyV0GWsEGMYR6Z5UG6dFoKLhaPW2UWRn0cGruSOWRucEBAWAjyPqeagKRHjuvToMZcgiUlff/nQmLvKFAbqsNXrOZR5BQKpmU0/fuMeHEo81z1k2+5rJ0M/cH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787977359; c=relaxed/simple;
	bh=AwOUkUcDpHDo5ZDzj3i/viDVju6Fox7LlmZcp7Ebp+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hok3PFuJOpk6273UCdw/KJhVF9sLYNu7UhifCKuLAH/apH6ZsmBhgPfEpJobxGBUii9Au6FDjOGRPTT8W71kGuZvXlVwKfqFxpGjSkD9KMNG91urCZ9SmdUJvwDri3DhMCZ6uinpwrxUvix/z1qneELuwfBR2/v7+V0TRrF9mw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8M6Z849; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8M6Z849"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d8f265cbe6so1246565ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 21:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787977357; x=1788582157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iVZiLDeRwsupettcPIKD0pcIzIKNg0UVhzocRgCkSCA=;
        b=G8M6Z849XbvSWm0PmxKra7oVe4tWoR0vHtl7DHi2HlPE3e3uFPbPNb4X4M3e1tqUKV
         cfTHkGd6wm984qbguQJENlb+CeRJ43TiIkNpLOcBnkxPJsTWq5LZu2oA+BL0EfSlwZzS
         2blx+TNxwqusvGBBZU24lNOncnfesF/nu0HlYLl9WoSPmWdBfycvwpFxgRAvODBXOW7u
         dek0VNW3fbcQ1lK/jra/XSvkdQpmiVX5HiSEll16efjdu5RI9maLRvkcfisRjXyROttM
         iFUmppr7Z6mnfs0giQEWbY289yC7zrxty5Th7sQEhJRh04cd00i++NQeTxgnuxCUj0YH
         NXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787977357; x=1788582157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iVZiLDeRwsupettcPIKD0pcIzIKNg0UVhzocRgCkSCA=;
        b=eAKc/aNk83VA2M84UrhJy6Xx1eXCl9s4/aTfJpUkdNDH3Z75/iS3+dUmzHY+FIAmZZ
         iUwRQCmOQlTD2yNkiZyOWaKZsmr3mY6UtonGIYoUgBwrpuVqfukeUracqhC+pyopB79K
         y8Wt7EkxiHUlKUkto+2fm8XWZ02KMz5K9Zt8/5hIr/EJk+s0lchrYw/qC43Es1w5wSGF
         slmuz2sqb2rEwuQR71qkgWU74Zz1C9K7CU9qruJqE8Z44Ybgsq4F/D9aIDfXjon/Hsus
         t3CYGIJ18+TXFI5tJxiuBPpLSzUR64j0SiKxII6qX6OcSwdTa2tI+SaDUw2uJxYYw7KD
         hsjw==
X-Forwarded-Encrypted: i=1; AKwUvBwY1/b+4AWhpZlTl3QpEs6Lqx0LBcKZhbQ2WM9PdiFM0r98vW7MUrgXJt8hb+qsVTNbOaiHLuaS4ak=@vger.kernel.org
X-Gm-Message-State: AFuF++m3R6Nb9W1TH/KIbh61p3DPykXm1BKBrSkRcPZauzb9ZFCeXC63
	xMCYRnm0Tq7aKVYz57+ClRJkqRUzMKoOsEcoQ923peHdqUhwJg1/RZr57pJKz44/Vg==
X-Gm-Gg: AYBFou0Mg3i8+gM7E1BLL7ugh+dBBfJhaCk6cbJ0GCwkuvTJCJKLIFUK/YK6FjNZwgH
	Pban3ZtzL/CvUAh0GUMLiZzM4onaON7oV99aZulLOVRED6dW+WUorn1xADnPQcrr4fkIDU33gv6
	rTIHjvydC7wWEfjbGUkyiN5OglWgK0m+5vsdXiF0Q978Bw6slu64KgGj5DAZ1ZBzfDgXqCKlnSn
	tRNbhErLIQvsvn2sekvKoM6Vf3NmtaBxfUJ3wICk7Cb4ZJjTfCeqvsVOV/MN1+QaF6f1DYf0/KO
	2CVguPuL5dZ19T18OCo/idmKX5k/5QCPdWHY29LMVeK+/TjCP4D0dLoIHfgL9fXlCnR0Wsmggv7
	0QI237vIqvlEg/fzH1Rzy1cqfdoMfCV3ae1QqkqDcZnMiU5x7rHEinhTV9aEMNoo10hqlP5Zwtz
	p7H5dNvGouxIp7qqc8m80NmAP00em5w3/5kWJkoWsRgwi4hq3vUJgET6wcgmS9ZSYPB0oOcX0i/
	Q==
X-Received: by 2002:a17:903:1a30:b0:2d8:d4ce:9f32 with SMTP id d9443c01a7336-2d8d4cea3demr62880705ad.16.1787977357271;
        Fri, 28 Aug 2026 21:22:37 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([113.185.106.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7598b98cbsm11139845ad.76.2026.08.28.21.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 21:22:36 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: andi.shyti@kernel.org
Cc: bence98@sch.bme.hu,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH v3] i2c: cp2615: handle allocation failure
Date: Sat, 29 Aug 2026 11:22:07 +0700
Message-ID: <20260829042207.27323-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Also separate kzalloc_obj() calls from variable declarations.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Clarify the commit message to describe the actual behavior change.
- Fix coding style regression
Changes in v3:
- Separate kzalloc_obj() calls from variable declarations.
---
 drivers/i2c/busses/i2c-cp2615.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index 951de6249834..62192e919744 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -124,10 +124,15 @@ static int cp2615_check_status(enum cp2615_i2c_status status)
 static int
 cp2615_i2c_send(struct usb_interface *usbif, struct cp2615_i2c_transfer *i2c_w)
 {
-	struct cp2615_iop_msg *msg = kzalloc_obj(*msg);
 	struct usb_device *usbdev = interface_to_usbdev(usbif);
-	int res = cp2615_init_i2c_msg(msg, i2c_w);
+	struct cp2615_iop_msg *msg;
+	int res;
+
+	msg = kzalloc_obj(*msg);
+	if (!msg)
+		return -ENOMEM;
 
+	res = cp2615_init_i2c_msg(msg, i2c_w);
 	if (!res)
 		res = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, IOP_EP_OUT),
 				   msg, ntohs(msg->length), NULL, 0);
@@ -171,11 +176,16 @@ cp2615_i2c_recv(struct usb_interface *usbif, unsigned char tag, void *buf)
 /* Checks if the IOP is functional by querying the part's ID */
 static int cp2615_check_iop(struct usb_interface *usbif)
 {
-	struct cp2615_iop_msg *msg = kzalloc_obj(*msg);
-	struct cp2615_iop_accessory_info *info = (struct cp2615_iop_accessory_info *)&msg->data;
 	struct usb_device *usbdev = interface_to_usbdev(usbif);
-	int res = cp2615_init_iop_msg(msg, iop_GetAccessoryInfo, NULL, 0);
+	struct cp2615_iop_msg *msg;
+	struct cp2615_iop_accessory_info *info;
+	int res;
+
+	msg = kzalloc_obj(*msg);
+	if (!msg)
+		return -ENOMEM;
 
+	res = cp2615_init_iop_msg(msg, iop_GetAccessoryInfo, NULL, 0);
 	if (res)
 		goto out;
 
@@ -194,6 +204,7 @@ static int cp2615_check_iop(struct usb_interface *usbif)
 		goto out;
 	}
 
+	info = (struct cp2615_iop_accessory_info *)&msg->data;
 	switch (ntohs(info->part_id)) {
 	case PART_ID_A01:
 		dev_dbg(&usbif->dev, "Found A01 part. (WARNING: errata exists!)\n");
-- 
2.53.0

