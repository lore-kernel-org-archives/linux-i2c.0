Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B030ACEE
	for <linux-i2c@vger.kernel.org>; Tue,  1 Sep 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276241; cv=none; b=WPeTHQNTQ3sT+5A3qvZsQwPs4PDK8yhy6divKDH/N9gQRo6eJCpfUncHuQFx6nYWIy9D2dTJqWZDxp8Wrwq9rHWUOjq0TMViN6betnAerYakWgMLtZa2lTPLXD62GZkMlcBRhBIDEs798iOK20lEIraGIba4ocX0Yt9Krum8mEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276241; c=relaxed/simple;
	bh=R3J7SqC7fHCmGp67WqxxTHHLBefiBq7BVcaPvaEvpd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MAKQ+TT4Zh4KI/ENe/sItBe0BNJZxjeefpJ9C6LAsVYMKQxyF9Upth0cFfrgGnHNzdbbp1zGrnAQKq6F/ALN8p5+wrzHGodqKmWSehP7UAIuhe1+4tgi4xGyGrH2X9KSAELCzA9e3drX5np//nKA+EFB2qr0MPICVlcnPGDL3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wjs2XlEl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjs2XlEl"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d560775ca2so36533245ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788276239; x=1788881039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VDQ/gaRAZ3HKhb9H+2sGnvihrzB7ojkgVvH0+sfX66k=;
        b=Wjs2XlEleyQ1tFn6ujSzoBcwG5HWpkW11gnX7sqcwCNHoSFUPeYBDQjWGpVfFaSj7k
         0JApffFBqFb1LN1NdiBC98/xIx9zeRV36Y4k0p5/Z6q9UXQQQngYweXFn1+T28+HkTa1
         3xgB2ccIIiWP5hyFl8K8xqNV7Sc/l8n1UUPUV5v9TKEDmos1WWZ/Gp0KN5U8aqFiF20+
         OmHxDUe4oDoMJu83Yg1cjE0jBYsC9F+CaYnRYliuiI2o+BIRmUk5Jn46HgAe1w103ejz
         eKOSBFMwwZVYxEnAkD93XEQ7Lv2Vk+PBwS9XEzhEAavKOohUt34xtB8FEMFQo2+Cm4AI
         ciCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276239; x=1788881039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VDQ/gaRAZ3HKhb9H+2sGnvihrzB7ojkgVvH0+sfX66k=;
        b=NJfKYzMigx4DOzKjFI780XolasofKk55JlDO6XjXVlvbAvouKMSLhk4UPtbbQWISUU
         4C+my+SrzX3DsgQfpT+KThOL20bhYKCE6F6raDrD4tKbpB8rwX45RlVY4C/pFM2sBpd7
         uWc0AZn9GcUBpKCxkZ4XLtHmAGauBQWzK0eVrTxgFTBmbEbYUCIOwuboT49ZoZLRtDhF
         EGW5lfDq00rPha/MkyJnHbDC05nbo03ly2AIp9G4FC/zGIUfD1oAuKRrTFQHwvXb0LVk
         u8D8A5fDeGIm0/SsvZulU0biAMyu39Jn5AhB7ResACqCW0EOH1VEICiJVdBdCES9ghr5
         eC4w==
X-Gm-Message-State: AFuF++lKG6kjr2KysHiPgygFvp+7Gx40qTCM9VeFuk55oNh6dwqjvMsa
	0irtliqxTVPq7scxlrao9zcBAmhLEHqBIEeNy/cvHK/vs2gb0SiTHC1af89SnQ==
X-Gm-Gg: AYBFou2RMQsO6T/LBNomOhTIlLdZHOf9BOm6UCT+rU0QOBn/yzOQwV2vobMMhg7jW/+
	UqsK2vx+RinwDuTZ2E42eIgQVSj5tY6gd2ErWH8woEGHtKY1tJYH5Ru6aBDIWQURpbRzOODRERk
	G8eWRuvrexmwDfdmTECYcln1NJ4fyo1fRVjCSMr62HGwC7zyzbL2zLyYRmEibODUa2GSGfP6lQS
	ypq4HQcSTkKASsre8ry/l/8luO0lq0ILQiCgkuHOQ4PxACSC3CfCUDrUsNen2RNhdaX5RpIxSCB
	FxAiax+OXW81r+Ca08DMF0fBwT8bOzUboH7Io2XOz5L5pt8fnSAccYC1Hczk49p0B4ii1Tf6oXl
	GUCfMFvr7nS4NJOnwonY2nlPJIaLrn+Qic86YYGWE/g6p73WtFuUMHkHtUjHzPangCVg3nHeEVP
	ebW7K6jm8b49U00LM6cnf845KuRudR6t+GzC1nxisU/yqbRMEjp9mTis/72zCj0wQ8L302mlpqu
	voe8kqt
X-Received: by 2002:a17:902:f549:b0:2d3:6fac:d67c with SMTP id d9443c01a7336-2d74dde1b5cmr436910015ad.10.1788276239275;
        Tue, 01 Sep 2026 08:23:59 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:21dc:72d0:b0da:acd8:9bc9:d346])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd386eefsm736365ad.28.2026.09.01.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:23:58 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: core: fix slab-use-after-free in i2c_adapter_depth()
Date: Tue,  1 Sep 2026 22:23:53 +0700
Message-ID: <20260901152353.104578-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_adapter_depth() walks adapter->dev.parent assuming every
ancestor in the chain stays alive as long as the adapter does. That
is only true while each ancestor stays registered: device_add()
pins dev->parent, but device_del() unpins it regardless of whether
the child device's own memory is still kept alive by someone else.

This breaks for a USB-backed i2c adapter (e.g. radio-usb-si4713)
parented to its usb_device. If the host controller is unbound while
a userspace fd for the adapter is still open, the adapter's own
reference keeps the leaf usb_device alive, but that usb_device's
device_del() has already dropped its pin on its own parent (the
root hub), which then gets freed. A later i2c_transfer() walks into
that freed root hub and KASAN reports a use-after-free read.

Fix it by stopping the walk as soon as we reach a device that is no
longer registered, instead of trusting the rest of the chain.

Reported-by: syzbot+450abcfc7906fe1a1e16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=450abcfc7906fe1a1e16
Signed-off-by: ThangNN99 <ngocthang2710.1999@gmail.com>
---
 drivers/i2c/i2c-core-base.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index fb25704219c7..8c64a27eef5f 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1240,7 +1240,12 @@ unsigned int i2c_adapter_depth(struct i2c_adapter *adapter)
 	unsigned int depth = 0;
 	struct device *parent;
 
-	for (parent = adapter->dev.parent; parent; parent = parent->parent)
+	/* An unregistered device may already be freed; stop there. */
+	if (!device_is_registered(&adapter->dev))
+		return depth;
+
+	for (parent = adapter->dev.parent; parent && device_is_registered(parent);
+	     parent = parent->parent)
 		if (parent->type == &i2c_adapter_type)
 			depth++;
 
-- 
2.43.0

base-commit: 786262be6048deab760f68c8acc2c85607165894
