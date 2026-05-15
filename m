Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B383264C8
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850359; cv=none; b=Dc4tVzUbgITOjg0TeHGIf8VuespB5XBdnVAQtRX8AVLjVrFu59OHhBD3GdrdoHPLf0ukzK0eGdGMhEcdL0sgAv6Dx3ijWQAVLCSYa1nJ/xIFNT9JfwMHZjIg0SM3nS0hXaYMAysQXwidpBf0fkSddLfZxAPVWHaRsFZhjSZ9pqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850359; c=relaxed/simple;
	bh=iWY+q9sLtnNig3SzAMNoTAy7uLEwPsn7zXPcA9ddAwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeAdtWCHrBozR8t8i6m1ShrKE9eZQJbRDlsiukY+HGUl02Jn0erjbpHiCU1GUbidrW4nvElVKqfDJCv4ME4epo37KFu/s3Y7NLj5l7qyeyTsZFGr5CBe5upuIn3V5BKf/Z5TYvhES6OBBtSznF6vqU3E07fAXVBjyjwYgHINnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPwPsFQb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPwPsFQb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bd80b3aa13so6365635ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850354; x=1779455154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQMFhBzx5aVGgtqoPDMmCR48uTyf1EP0ur/Np06OS/8=;
        b=jPwPsFQb+s6t2c0rKm1YZgMBc/bEsp3RGYvMYGe8g/c5DqXJsttt3TUDiYxYjk/jqC
         eWTV2cMJ8zj6xFtgNTHPTsv2zD69hALwTuhEAP/cFS+LG0J7katkLyuDfD3hG6QfQ3YS
         Bm6wsZvI4hDj8RcaYsO5iLCzTCNIWIifPzpPZfeCKE3qasRLYFpzrju4x9ADsVo97+7g
         vG2BA0hCVw1nbQHn5tmZmCdpZL0/IKPR9N4ElsVFteEGwo6wUPqsG1LeN9dU45nWWNxA
         kA5Sib1DuWoqYt6STaStgmF22krs9BO/jy9J8JVsSvCh1D0GD5HlJCTbdQB5UC0RD6yr
         w5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850354; x=1779455154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQMFhBzx5aVGgtqoPDMmCR48uTyf1EP0ur/Np06OS/8=;
        b=cUNGyKln1wcwjMqXS0mvi/RG4Zt4y5Vr6/DC9BhIGwWw7J9H6HMIN2Efrx2dt/mDND
         vMSGmdWqlZNhNRfJnfzf2bPn/sVAzdfMglK3sBUlS3vs7yemSnKJ2VdrgXQmVkP7Pl0H
         ArGhD8s1bpEd83bEgceYrCTz8mJzVoI9M2f2H48GJ8JuU3Cqgpc36q9b2/hZUuWW9v2u
         wlH3jzD3lOaoSKTg8kz7nhiET4/u3gEP4P+bExcN49lFPeIrCcsM8qy1Unhzf/6dpd5T
         8EKo020sLJhmAUF+FfkoV4D6d3a2zWKyKA9s8VQCBp0fWSd82cHwMupLg7StMiSAgYDN
         ePrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wuP9h/EhHhn6aCdRrGG0msqr7VBQu8QqLKSdxBgkNTPkjGYw8iCZYASrl/Ugayo/g4RnTneW0wLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRc1MgvNJwizSeI+8Y5unndTvlYOS2WWwU3NazjzNsdiUYXzch
	lqKvNXINC/QwEntEq/q3MVtGeuVHmRdi2u8QQ8T20C9mk3AJRrIHBZRn6+9oN50=
X-Gm-Gg: Acq92OG+pD4HD1Q3Wh0buJQ4eZcujKm4wThNxkRv1v/PddezX0ltqvdIoh8kgd+uTFt
	PGeQ3gN7J6/aaOg+CHzDz70qNdfumhdG/06tvd2fQWm/zDDpluCkx0luxsS6a+U4g6a3EWfsOxX
	TFYTY5snb4jrmFZfTfFnuG0VEVZ5PZkOq909IV2NqQAY8dF+KX3zju17KKYZ6SBGAWaoX64Gk7t
	TXksX/o70RNPNIfCPFG0NZlNGw+eWnEVrcCidNtOvddWlffoZP2TmV4u8yINk3EYKf/+wlr5+WZ
	t7mqC8ddqtT45ADqH+1FqEKCWVW/LDSAGDWx2sEBVocAA43ZDPE5sqgbjpYBUsOOrgwRS/91WN+
	ob5I/boEthub1N5ofjHHzgoNs0pgJ59XfXR959q3ZuuTKRJJmkUM1R2UWyyt8Ces1uv/f5ItOPT
	llD5oSAUaAQGhWKOlKXaK5tsCiRSPUgpx6eZA9ujeVe+oZYnIsOSF/7GE96e0=
X-Received: by 2002:a17:903:b45:b0:2b9:cd2d:6f13 with SMTP id d9443c01a7336-2bd7e7d88e8mr49950205ad.10.1778850353958;
        Fri, 15 May 2026 06:05:53 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fbc05sm60630605ad.57.2026.05.15.06.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:05:53 -0700 (PDT)
From: Xinhao Lv <lvxinhao.dev@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Xinhao Lv <lvxinhao3@xiaomi.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: [PATCH v2] i2c: dev: cap msg length against allocated buffer in i2cdev_ioctl_rdwr
Date: Fri, 15 May 2026 21:05:23 +0800
Message-ID: <20260515130545.991714-1-lvxinhao.dev@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xinhao Lv <lvxinhao3@xiaomi.com>

In i2cdev_ioctl_rdwr(), the buffer for each I2C message is allocated
via memdup_user() using the user-supplied msgs[i].len. However, the
underlying I2C adapter driver may modify msgs[i].len during
i2c_transfer() (e.g., for I2C_M_RECV_LEN messages where the actual
length is determined by the slave device).

After i2c_transfer() returns, copy_to_user() uses the potentially
modified msgs[i].len without verifying it still fits within the
originally allocated buffer. If an adapter driver sets msgs[i].len to a
value larger than the allocation, this results in an out-of-bounds read
from the SLUB object, which CONFIG_HARDENED_USERCOPY detects as a
kernel memory exposure attempt:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'kmalloc-128' (offset 0, size 271)!

  Call trace:
   usercopy_abort+0xe0/0xe4
   __check_heap_object+0xd0/0xf0
   __check_object_size+0x398/0x4a0
   i2cdev_ioctl_rdwr+0x298/0x3f0
   i2cdev_ioctl+0x160/0x5a0
   __arm64_sys_ioctl+0x114/0x170

Fix this by saving each message's original allocation length before
calling i2c_transfer(), and capping msgs[i].len to that saved length
before copy_to_user(). This ensures we never copy more bytes than were
actually allocated, regardless of what the adapter driver does to the
length field.

Found by syzkaller on an ARM64 platform.

Signed-off-by: Xinhao Lv <lvxinhao3@xiaomi.com>
---
v1 -> v2: resend with git-send-email to fix formatting (v1 was mangled
by Outlook, leading whitespace in diff was stripped)

 drivers/i2c/i2c-dev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ccaac5e..af5b0a7 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -244,6 +244,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		unsigned nmsgs, struct i2c_msg *msgs)
 {
 	u8 __user **data_ptrs;
+	u16 *orig_lens;
 	int i, res;
 
 	/* Adapter must support I2C transfers */
@@ -254,6 +255,12 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 	if (!data_ptrs)
 		return -ENOMEM;
 
+	orig_lens = kmalloc_array(nmsgs, sizeof(u16), GFP_KERNEL);
+	if (!orig_lens) {
+		kfree(data_ptrs);
+		return -ENOMEM;
+	}
+
 	res = 0;
 	for (i = 0; i < nmsgs; i++) {
 		/* Limit the size of the message to a sane amount */
@@ -268,6 +275,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 			res = PTR_ERR(msgs[i].buf);
 			break;
 		}
+		orig_lens[i] = msgs[i].len;
 		/* memdup_user allocates with GFP_KERNEL, so DMA is ok */
 		msgs[i].flags |= I2C_M_DMA_SAFE;
 
@@ -300,12 +308,15 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		for (j = 0; j < i; ++j)
 			kfree(msgs[j].buf);
 		kfree(data_ptrs);
+		kfree(orig_lens);
 		return res;
 	}
 
 	res = i2c_transfer(client->adapter, msgs, nmsgs);
 	while (i-- > 0) {
 		if (res >= 0 && (msgs[i].flags & I2C_M_RD)) {
+			if (msgs[i].len > orig_lens[i])
+				msgs[i].len = orig_lens[i];
 			if (copy_to_user(data_ptrs[i], msgs[i].buf,
 					 msgs[i].len))
 				res = -EFAULT;
@@ -313,6 +324,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		kfree(msgs[i].buf);
 	}
 	kfree(data_ptrs);
+	kfree(orig_lens);
 	return res;
 }
 
-- 
2.50.1

