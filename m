Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38238C41B
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644916; cv=none; b=hb9kK9UGupd7rxuSaylpc/zQ94rc9nbDtWPBadKSepUa0h4L/ACmrnB09yVTkY61CANS7WWrjwhkhL/g+oeZXOAixsKdoaGV9cPuMWFNUt1W1cQdRaAkAYnAfN63+xpaGWPNOrKYQO2Jq4Pjc8d+sWbFdAb1IzSlgOfyH05cNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644916; c=relaxed/simple;
	bh=4/VXWgsIRIKfrVHunlg8WMDRE+QLI3xVo05RjJxnkwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ucca0n3MlIUf/oerEWnLf46zPy92ll5jePLr+zSpa/0acrb86naxhY7wnfd81EMxh0D2b9/APOaZzG6zIj58BRNoQnph6z5RJl+Apj7DLlTMUjAfC0YOqui+13OQCW+SY+QLPi1y+ZiJp80M4SW7M3MWs3tWjnvHALvRVN7b68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5D+ev3T; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5D+ev3T"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8423f236418so6166125b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644915; x=1785249715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YAwfc5iFE/E+WtAWO7/fCyQvb8Oo2HFdE/v5P8GpI9A=;
        b=V5D+ev3TFS8adlNMISbPmTPOjrVQBd7yQhzN4yxinPOadXIxMCv5AeOUElfaXhbKmO
         D5m7JyDpEitvl2WRi+7LlkgFnlwfod8o59F54Z1osD04+55+El5dGw31h3LoKZzT83Xq
         /B9iXPj99a6G215x8ZTDoTBDlA+gW778IypZ0wK0rkZD8CX6cOls5VkntaEAk4ynzmvq
         V4Yas/Xm3uv7fIZoO5Q4MWzJ6o6ESBS/RFgNlrC56tzmo4IWHSvq9DHsa3CCstdWiDwC
         PTK/3ZZqeYUPKBBRx4gtb3HtOZ1FnTr5ZJzShL1qpSleTiwmEAI3jRTyaVkQw8gXsGdC
         4law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644915; x=1785249715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YAwfc5iFE/E+WtAWO7/fCyQvb8Oo2HFdE/v5P8GpI9A=;
        b=sV8+N6vtJI1+zTCZqCuffyW3XC8t495OCvDwYb9v2PZ2MWtKKDQ64jQilQQd0CoHC3
         4qQ4yIMuwxiZbIrrjPeki8Zesi1BHWHt93kFgGJPDlV/t9yQVrCnlTq3dH5I0Jx1xN1v
         ICu41TGiOaPQtl+lCwO7AfDUVC2mkvZuUBg4jUd46nZFQ9a7cRGG6Kqc8M+aVMiZDeY6
         e/YP0T9+ADeUUDG8b2MP+ExgTybK2N7nlWqHOpECPqIlA0BNeNmYqTLKE/ZFSZJrKhlW
         aRtyHX6KG/NlUV07/qVv7KJpziDiZrOeT7Q1C32zmxTfPsui4SjJQu1kd47+f+epuHgn
         uz8g==
X-Forwarded-Encrypted: i=1; AHgh+Rokldn2u59HTU2KkE0sgok2Q1CgYI81wwk4qdE7KDauVAsIJLu9+BPCZctjA9r4xXjHgmgsQtXh8Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5OMtg9d0n72m/JMNkc8MeVr5D5cagXCZbFHYwnodIzE00h9X
	40p5mykgqIxLaO+JjEwnncfiDuBBGnUng7i9SYpVtz8MFukjIVLXPp0=
X-Gm-Gg: AR+sD13Bl1BQn416NMrQBxEvHGqO+WDs+MfWJBUJjL83BuuOBaxoGpK0Y+pVUftrShF
	L3+4x7SmSPu1pZCctslJNJL7Oe4+8xHSD8gDyYrpPFpL2ElbS1eDCXi0RwBnN7oSsV3zJ7uWUdm
	lNEhomP0WNl6HjbZu/zuHmE3qaTMD+Yy/a7BmTK471WO4r1kr0sxjXgCydEmbB/Rc7KeMHTcCmX
	eH6ANhIxrVOFbhNTgSvnRYKq+MY6BKp+bpvVFw4civpCfxaI/c2bpQa/AZ4YPIcm1lZEIZ0ww8W
	J3RuBSidWWBKJAfH8UDuwbXCyYX1DOu0/ijsU6B12+Ke7DNnERaSGIgdZtiznk7offPfAvz7AB5
	3O5xo52WP3DhN6LijRfi/8Z7IVp3BMOu9XBt0DYHGgatQBx0pEeb0p762wkAJ7wGrhPRzPr7E9n
	intg54uovKPjLOAWKbX14DqJyKEJNwhVh3P9Vgygr3BhrV6J2g3f9l91TDLALULRoLbITRltvRX
	ALp0t1DYQOVDVvM4CzfcfPHg5S7Gtpzbmuvc5gg
X-Received: by 2002:a05:6a00:1c82:b0:845:c6fc:2821 with SMTP id d2e1a72fcca58-84c292a3dc9mr19309918b3a.22.1784644914563;
        Tue, 21 Jul 2026 07:41:54 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcc78asm7649075b3a.23.2026.07.21.07.41.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 07:41:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Elie Morisse <syniurge@gmail.com>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] i2c: amd-mp2: Unregister callback on adapter add failure
Date: Tue, 21 Jul 2026 23:41:47 +0900
Message-Id: <20260721144147.31150-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_mp2_register_cb() stores the platform I2C context in the MP2 PCI
driver's callback table before the adapter is registered. If
i2c_add_adapter() fails, probe returns and devres frees the context,
but the PCI driver can still dereference the stale pointer from its IRQ
and system-sleep callbacks.

Unregister the callback before returning the adapter registration error.

Fixes: 529766e0a011 ("i2c: Add drivers for the AMD PCIe MP2 I2C controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/i2c/busses/i2c-amd-mp2-plat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-plat.c b/drivers/i2c/busses/i2c-amd-mp2-plat.c
index 188e24cc4d..9fdd6a5fb8 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-plat.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-plat.c
@@ -316,8 +316,10 @@ static int i2c_amd_probe(struct platform_device *pdev)
 
 	amd_mp2_pm_runtime_put(mp2_dev);
 
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&pdev->dev, "i2c add adapter failed = %d\n", ret);
+		amd_mp2_unregister_cb(&i2c_dev->common);
+	}
 
 	return ret;
 }
-- 
2.47.1

