Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91231422542
	for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971764; cv=none; b=DkwUpWE1RxiPd27sH1eH5AK+FHJBWPgBQ0HhNlbtZJEU+bxHQWr1y8JvHEYkc2iTs386LSep80+5OwViNCVofU4MNDpJAfXKbGUOXrjzPItdrjpraxItnavDsU7D6MILWHpD8Qwt0DSONqBxEOfjMxzfUtpfHD92BuhgepJYQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971764; c=relaxed/simple;
	bh=NKHdJelI9s38P4FDxyQk5KzyPEvSv5ZJDipRC2BrZ4E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qyfs/ejs7SwU2sUGd9sBYHA6jcWVqWmWlePCsFIoYWmN0JsDd00n2Fe4GC1WG8dSAwoeJegWZyI08VcUJK8iF0oEbnE5zUxKcFrMdFvVh4PIME7oIgqMIolpraEqjR0Cfs1gLfzDPO0xUIAimHy46dV93iTCcNYPoOtRwu0xido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptSCL/AB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptSCL/AB"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso57725785ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786971761; x=1787576561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ndGaNRfoNoSmNjoeBTk9W6ub7IDFY1I1hsv9aH7jqkg=;
        b=ptSCL/AB1Bgp3y00P6st17jUPNm9Q1Ak1pimkhEICsqLCVkDh2bD0tmQu3gwwJPn1w
         /YxtRpVa7t1obZV/xTmY7R18twlILsfWtfi8STU34HdQjeVBrSUCd8UwWBHN2m2/JS7Q
         uUYEhRoE9er14ck2c//XtrPjx3oShejPQ/Yy7UxSenis8lFprjbGAMhJ4LOI7rFPco8h
         xxxLNhGUqOnwbjcnaGks+7+z6iyLjsWFCVyKgnZqTZClTZ6LEs+RCOlq2mjgZpciEhRh
         6hScZK0MWp4+FWSiaeR6VZ3GVcgQ3Z5n1Ljn2Rf5iEPASIb7I1R/A1j7RZjJx23rWprc
         7BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971761; x=1787576561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndGaNRfoNoSmNjoeBTk9W6ub7IDFY1I1hsv9aH7jqkg=;
        b=RyLeDmAlIts15SLj3CS/9hDd4j614/0XBer3yj0NAWcQR7fjj/RMl4e+rAvbHOFxKA
         hvQko7vuPUV4JMJcZ/6xlU0BIY63GafpDM3Iue2V3c3QCvoFLyDPfFE/rai/l9KxAutk
         CJ9K7G45pgG8rqgcodf9WeCwquTxVqJTK8aLHOfZC/jwJHYuDFQNp9Nhat3GHGoxIKne
         GNwaS9tSOq3WgVWu9NiCUwsqj/L9WOW+VuPGa2CzAFXcVeohTZwMJ867wUFvjdXuizP5
         AyxWU4oCMct2MnmVzkgBbWVTpT09/OciHjyhXHVC/BUzKblgNer5azPIQVpzbrGyogAZ
         RQHA==
X-Forwarded-Encrypted: i=1; AHgh+RoPyubKoXk6nPvHTbCFk+/ykmfcLpNW49NrS63GzpjvwkL2mWQdYB0FH20IImnKnsFWkKnwTabCymM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwROXt/CYEh/GgWao2AT8Noluw7nNhGZ5Pi4RLX2CYlhiVy4ndY
	izmy9oKaMF65xZqIaIT9qlHnRmk5bqshoakHk8eBVNYZ87i/TwGYW9/S
X-Gm-Gg: AR+sD12gTaxrMSDedatmHxfEwGOqowqAVLIENAM9Jvb3fZJH0fTUqMNq0zAltbe9Pg9
	pYi/2/mUJGMby+WY+XarJOYPbG8e0ZDMQX0LRZ8TdHkaZ0EFi6DT7PUEcUtmS4W+QmGpuQGERcX
	xpbAxPRImyL4wz+ZBFH4on9YMLH4ADCYQbkvhvSTJXbl1gi3+7AH/jWQ4BGNDFtK/LhNMeoo262
	qko6hS1KGJ/rB3ovCFIN0IkVrWQDDnfkiTOlHSY6MWBkK9zbLV6EXuZyXMln1Jb72dn06Pt5kny
	cK8YhHF2aPaNpNvetusa8fFwKZ0Fucs2NXJr4JiJMOjw51l+0R5oiJdWezD6tfLYnoyZbTTQTc8
	ZCpBmEyo9d5ZOV9c7ogGz5cZ7snGfltA6eKLZkC5tUPpA9examsWiOYZEfjCLKxQwYAKGkxKtUV
	xjRTTv+CUorpxAcCPkiAQ1HR7Ie1WmuxrdDoQWL45AKiphrEgjt5/xn5yEvfYOFhonTv6YpWj/s
	6+K9PbnwcdN4ns=
X-Received: by 2002:a17:902:ebcd:b0:2d2:ae04:5712 with SMTP id d9443c01a7336-2d5c5422f5cmr1611025ad.21.1786971760878;
        Mon, 17 Aug 2026 06:02:40 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e8csm5402435ad.2.2026.08.17.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:02:40 -0700 (PDT)
From: zhaohaiyang1 <yewentian395@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-i2c@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhaohaiyang1 <zhaohaiyang1@xiaomi.com>
Subject: [PATCH] i2c: bcm2835: add missing braces to for loop in bcm2835_i2c_xfer
Date: Mon, 17 Aug 2026 21:02:34 +0800
Message-Id: <20260817130234.372628-1-yewentian395@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhaohaiyang1 <zhaohaiyang1@xiaomi.com>

Add curly braces around the multi-statement body of the for loop
that checks for unsupported read messages. This fixes a coding
style issue where the compound statement lacked explicit braces.

Signed-off-by: zhaohaiyang1 <zhaohaiyang1@xiaomi.com>
---
 drivers/i2c/busses/i2c-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 8554e790f8e3..76d017cf1582 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -349,12 +349,13 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 	unsigned long time_left;
 	int i;
 
-	for (i = 0; i < (num - 1); i++)
+	for (i = 0; i < (num - 1); i++) {
 		if (msgs[i].flags & I2C_M_RD) {
 			dev_warn_once(i2c_dev->dev,
 				      "only one read message supported, has to be last\n");
 			return -EOPNOTSUPP;
 		}
+	}
 
 	i2c_dev->curr_msg = msgs;
 	i2c_dev->num_msgs = num;
-- 
2.43.0

