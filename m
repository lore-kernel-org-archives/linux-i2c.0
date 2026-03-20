Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC63750CC
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009657; cv=none; b=tHWdZeKjpEvWpru7vb0WLgoj23NlKZuu/t82fIiXrqp7KXgjaKdNdqTOJZLHah5KPjyfZwwNfvYHa1tyiM+6SvOy2gYF1q1OMj5xp35G+Z17SrQAGLtz6fO4+BXjkPZh7cp6ZukpFuauXheNr7ZWWOldUZmthlhZnJgGiONGLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009657; c=relaxed/simple;
	bh=qFwlrOl6OoPTHBv9dJfBEs5/1cjpbC0jhe9v4VmDuWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CybjEgs1SzUDZuf2HQ1pLV1Ghl6/iwcFNgVgNr1Kw6ptSKKn2baCjed9oANH+sQ0lp6vfm2iem1x/V7bwHjUmwX23Za61+cZwDCWxDQeq2aCSyW4jozjwupm+eUwdMVa+Vw+7z6Kd1qefEAvrcfte+3NPUpSXER7HbmBkWBXNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aToWYn/Z; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aToWYn/Z"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfc1aced74so86642085a.2
        for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774009654; x=1774614454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwhC5aGzvmdqgyR356mBtQsDlqCDQz9WRNIFqjMsSC4=;
        b=aToWYn/ZVm6Tpdnazl90yN9v76BeNoRrmTdd4IWvAhBGgn8ZwaIgG9F8LJVhv/DyPo
         49X0WQqQUlLNUZRT1diZx0mdVqSgycTnSU3VbV8HyTF2YK72aGICHHtkvXAQrgm5YDIS
         xDck5wloFoYnzS2G/xCqVRw32krCHda4CUe1ixSx6OFGgMfLRAtslzU3zg79hIk1haW8
         S11EReby6FTLvLGF7m318k45ZW2Rvd6LiQd39Jlx0xq0T+fKTWPItG0vQ+DQoXtR7b4j
         hPkRzBVH4F8y3m44+RP4HuGkk21RS3poUQh9gqwSWE+mk+YvuycgEJKT0Z+waOmiZFtI
         L6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774009654; x=1774614454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwhC5aGzvmdqgyR356mBtQsDlqCDQz9WRNIFqjMsSC4=;
        b=Fm4E7rUchIqkkHwCWkwD7PWKCX+d1DcOGQCvoWv2gYTgbs0G45/F1qVM995Vkvvq8x
         ZtdjAHuCaR27IRTkxknFg8AtYkpBGwi2h0LjPDP1Lu5bkb2E+UFvDVmhIvWbx1sw8eck
         fEYLzY3zk38rroNdqoQinKmz3h/4itEJxLfxFA9UI16b9WoMRJWZf2jQrVZRWPKQPlUc
         A+uv1ku4tz9D6hfeINKfrvPeZwiR5seiGbYoN5X4iZyb5CZmV6sjVa80oMZUBrqdU0jM
         TYTedyKNp2cgDwsNSMwFcouRPm6PF7AnHiao/gOOpQoeHywpBa+JCQv4xaTTVp40pG/6
         YGIg==
X-Forwarded-Encrypted: i=1; AJvYcCUK44TvsTt2oOPB/rSNuCintzzf8SGrNtQmjX3ndNqYQHDYHwTeP4+aEjq/IpSmdy3u8UCtSNLGj5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtJVyHBN504rQEarPJwgt7jk12J/tBBmgBCVQKkWxHov7XHZda
	ht9tg+eThYOP8XO7WhTnk03Ket6FslTRJx3NUamv9RFEOo7dzcythAd6
X-Gm-Gg: ATEYQzxKuKHBVdfqMn5R08CepizL2q8x005T1xsz9mb2j1l0TzeF+rMxOa3OsZvV2Cx
	Ya6YPdmW2ggPFBBdqVnQOWW6ikTMaIH45tT/tlTxwtJmDZPhjzpsEg8erd8Vw++nMG42MY7XNJj
	M3PXbGcwowvTWXAWcmI/nrJJCERRghQ2Jw5xRswrrj9J0juvusSuv3bkZ8Tg0BQRU2gMKN6U7wP
	gxOhAu/6+9LMBM25r9qvFalwXzIIDwQKpZwlNdVUiVFXhrOqYCW8+f4obQMVo4rFwSof2t6ZfvC
	sK+K8yb+SXTUIQYDR8RvG6fjoiqJks/cp0vCP2N+WvnZb+G3EWPvTvSz2W+3Zsjzxlh0jwfsD4n
	xEGKV3Uk7vmLUZ6jFEgHoihfk8ldREKgZ+Hm2MQjljH7iJVoxxgUyr4iH33OMOMqQqQ3S2F9LpO
	fw6ekEnr8KWmB07J+cnJn/
X-Received: by 2002:a05:620a:46aa:b0:8c9:fb26:dc6e with SMTP id af79cd13be357-8cfc7f3465amr378078885a.38.1774009653898;
        Fri, 20 Mar 2026 05:27:33 -0700 (PDT)
Received: from jovin ([184.145.97.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f94b04sm154080085a.17.2026.03.20.05.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:27:33 -0700 (PDT)
From: Jovin Basil <jovin555@gmail.com>
To: 
Cc: jovin555@gmail.com,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: gpio: replace printk with dev_err in probe
Date: Fri, 20 Mar 2026 08:26:43 -0400
Message-ID: <20260320122656.430939-1-jovin555@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jovin Basil <jovin555@gmail.com>
---
 drivers/i2c/busses/i2c-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index f4355b17bfbf..f51f12c70a78 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -490,7 +490,7 @@ static int __init i2c_gpio_init(void)
 
 	ret = platform_driver_register(&i2c_gpio_driver);
 	if (ret)
-		printk(KERN_ERR "i2c-gpio: probe failed: %d\n", ret);
+		dev_err(&pdev->dev, "probe failed :%d\n",ret);
 
 	return ret;
 }
-- 
2.47.3

