Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4335DA76
	for <linux-i2c@vger.kernel.org>; Fri, 17 Apr 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412507; cv=none; b=G4ZCdugGWnhsf40PHoaaNIoNoDVlSLRaQ9lGU1HqGINkp3eLeGk7Flptk2/adAVCmw/3gChFaYnUhaexkSUcsEX99STg5XhrPhMrB0DQkLx+6rctE3hoBGwbJcKZRAH/IGj1QlTSdKrjWe3F/DVV1x2IZyVqS1WOFZ/m+6ZYW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412507; c=relaxed/simple;
	bh=Nl9d5nSBusaUTgZlzx73GKAsZqFkN+SKYI5SmPtNhyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0Q+C40zVYEXLBKUmntDQ46s8HGoWYp6D3hNfC69g9F7YT/uiD5FH7eOqetll9hU7Mb2ARfS1Mjm/gs75N5z64PeXUGjqjGGpJVnZCc48NAdKzvS7lrhAQI9izpKPf4jBglAlQbZXdFzL1IDVeV96U4+3hArEl+jtbOVV/kHYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso282566a91.2
        for <linux-i2c@vger.kernel.org>; Fri, 17 Apr 2026 00:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776412506; x=1777017306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyBPa3qqHsAAAwhDXzGCxDz5edbgYqDleVeYrzy0gcw=;
        b=cu4D4/qZIj6docWtptc0AhJ/ZvXKjK4yldOJIntYw2zadi9B9sF0g4zL8zbiRTYZBA
         6JRjJTQbH8OjQbBxKe0PukH1Mlo5xnT4o+Cytde9TcmTVvRuaHQxKUTOn4/g0HdaoddL
         Dg8JvdxWdyj+D928lA7GbhRfGH9wWUfKT2yA54fnmmwqEkiC6OZzkjTXxBW9ADu+9VOb
         SXIuysGbSfnbdKFfCRqeY2mOWvbyXJW+1dYtgyDWQrKn8vmY/HVPTq/+B+sWrOrI3LfL
         XYckiCJpZxtRyKI3g8E+/+djTzGDytOI9IHp9JOadyCj+801nkxYO6eL94nKgAd2vp5P
         EblQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aZH1slePTfr0lWwEjHmO61iOvNdSx2lx4mbbh7oza/s8Za6aqpz1mxLvwCUV9luDCUJkR8GNde8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHTdsLNEtI/9JfMZDUirA52Ans3pu6rnyMWJl++mMImfQ4ESO
	CsdrNkChQ1edgSkFw/0yWzggO3//c9J1UwhvIfPM8sYGkusoyNMryiz2hCCuocXKP6lhQA==
X-Gm-Gg: AeBDievEQpMTSfJ78BnZO5MJJcxvDbjW2XRIaP8XbT9oVU1lpUw2164YB8MXmypTUQu
	Xg9Hjb2aoqcJrWRIYuswV5OMVBrA5+bowiMaoRN/SCP9PeyC1hZZ/OjV1df6enBddB5kxXToo8/
	onGLEWb+6GKzhEecGuOA3NVcVKoSNiF75NP6U5tKyWng85srbAfWVMEplOCKju5WliadQwEk1Fp
	PGAIRjnx8FZ/2mBkkyIPvz1AmJmCy1BLwdLM5Kt5qyFIZi1ATlKycbW5MDJDGI1BFut2rfsLPAF
	52+8mDm5brAS8BbWGi6QgfyBsQUpkU8jQ7PB2KUng3Jx0/LA0RNSlICGeqdBLen2bmGWQ9c5onU
	zy3WQdOtNDZm39XKscKfE764YPCeAJu5PqjGTGMsib17TB0c7GjXisu8LlS++LymHHNydfuEm/R
	KyueSS55l2lS6oxCj/c8BWM4CUubccUcOW0yqg7FOmHkeWlcTvRv6opyRQ5A==
X-Received: by 2002:a17:90a:d2c7:b0:35d:935f:2ff with SMTP id 98e67ed59e1d1-361403ade81mr2058149a91.2.1776412505614;
        Fri, 17 Apr 2026 00:55:05 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2e5cesm13509375ad.25.2026.04.17.00.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 00:55:04 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] i2c: designware: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()
Date: Fri, 17 Apr 2026 15:54:51 +0800
Message-ID: <20260417075451.5435-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR() wrapper macros
to make the code look more straightforward.

No intentional functional impact.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/i2c/busses/i2c-designware-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd56170..4bb0abda0a91 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -958,8 +958,8 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	 * registered to the device core and immediate resume in case bus has
 	 * registered I2C slaves that do I2C transfers in their probe.
 	 */
-	ACQUIRE(pm_runtime_noresume, pm)(dev->dev);
-	ret = ACQUIRE_ERR(pm_runtime_noresume, &pm);
+	PM_RUNTIME_ACQUIRE(dev->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 	if (ret)
 		return ret;
 
-- 
2.43.0

