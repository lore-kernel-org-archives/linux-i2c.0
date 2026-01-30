Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025D378D81
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771456; cv=none; b=pj/7WXgDeQSxMPHdAtfrQ3Qon11IL3MpLzM+0AoEP6PNUWDKplslInLgaosP/dk87uGpF9MOecdz5H7QO9Arp2j/W3U4xD59R/KAl55GnYLhyDk6+YI8QXrNQ95gCizaP4S6GXjbQp1v1zTGDZs6jNePkvbpuoepH2rNBUAi+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771456; c=relaxed/simple;
	bh=rtfoSM7z1weGnv/Q0GoqC5/5YEvV7kYGC/IYA4jYkNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiFWfyTGhKnTZ+uXYn71I5RQytopUdNO8wOkWWG2sNIwg8EzVDHNrfrBjD8oSvWq+Bsy7HZXv+GRG8haW5xMPYfDEB3GNZrOZEspvHQokS9OODzYGXRXVZMWuzDhTFJRjd/T00XTWHuzTN5/OYF/iJLwRk7IOp+TIX063FXK7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCHJhMPk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCHJhMPk"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-655af782859so3669207a12.2
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769771453; x=1770376253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbxJ+mU3rm9LI/07bt3ncSPMi5OQc7Z/9GbRUILG9EE=;
        b=TCHJhMPkl+A1PFA4mlvtCxCy+Y0UUVxRIctB2EEIp+zeKCpUpVs86MUq8rwG3FjPjZ
         DOTo8cXXyT0MM/PyrDZDDL9TbvxrUTbIoS2N0sSH6l2o587utD/+STGz49Yx8Hkk5YRR
         AYSQcZG3JbrBNdIIExPMLYh9cez8Hja8Qs9lAhtekeAvMNyAr24deqtUfhvLNLulYv8o
         1VcOKtcmUd+wyR7zrbOJhAXbieHkthbY+gV9SxT+evw8htnNPs1WjRvoBhPfyG/4CNuM
         xjsfp35R6CETg/ENahsAFAlTG2F7QFIlvrY0Wjt+ME4CweYCPqEB5CNj4KCPw9YWYk6/
         gyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771453; x=1770376253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RbxJ+mU3rm9LI/07bt3ncSPMi5OQc7Z/9GbRUILG9EE=;
        b=gqBI0NRyXzo7bmu3fN6g9bMG9XJWaseJBaujxnJW5sexWNGQG/xnSG7CMUPg+2q9U4
         tItepgZsWEx62etilPmvhwLuWltN0r6p9A0blcolkVeJT1DDf+vCxyLaTy8O+Uk5SmJp
         dWUOM3hBao4PCEFBUZKgiViEz47T6FtJxm1MkgHwM1itAy/klnPBDkA24TandY366lc1
         SUlWRqsulrOvZHQNOW/RQ/AQWzWDo7ZuyHByrnqJNQptfstPeYKw+DSvFzbSTCN7tGQc
         zAnNcezGGT2LUY7WDgNDZI0NZUuU8OMiiArPSEXLX+/7/6K/R2ZalOhUqg/XJU5L3E68
         HgAw==
X-Forwarded-Encrypted: i=1; AJvYcCXgxex4Wz/kVcPxvlqT9GSELm5d3QG23IMunABqMyERswcZ69k00GUF1GHar3sSldXPdaoPfsvSNBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvX+FNIeyAOKJdDPk7LxGyJwSXhDE7vdVA/BxLpEbKP32OGsKW
	8jScJt2a+xusH8L+KgM4ZmBB8IOyk19gJEss+bEtbP31d9JFuW6Z09by
X-Gm-Gg: AZuq6aLF6k+gihW+J3mRZsT8q3peKxWfRW+EQrDCBTPnrsz2L0y7iQl7mcaTEfOTeUV
	0irOoTFgrYnGxkbjF6fsnIVpTHP0M8mbmqN+/ux8RogYP55SUyCROFVVOQFczM+fJYnHy5xPbJl
	3E6tawdK8L34QDFXFUIB9z6cEZnfGvvoybiHGE/KZHJ7NpVjZexHNFTawmILCAGV5OpYusKg0y1
	rNSnMqNE6oqL6Mh6RU88JE0mtUPR+AnhGpjO9q9hF2oEW2gzA8geztgpk2u8zEPkkavywTKgKi3
	CtUFJYvD5cqCfq0W33ftqfH81S3xo4r/2PyWymQiQreoscVPTMVx6ZAJou0Mibz71wgldHVhLOw
	LEGpZp6VAIcu+HLmJUUvjcxs4aB9STK6gZfIb9Yr+fg8v+IELl6hif7r+XvTCDn4IIhe85ZdJBl
	z0CRqvy7shJr3NuvIsXPBXSrgHKe/M8rylxcZu6Nmz
X-Received: by 2002:a17:906:dc92:b0:b86:e938:1b3a with SMTP id a640c23a62f3a-b8dff53de9dmr126132366b.17.1769771452761;
        Fri, 30 Jan 2026 03:10:52 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbeffedd3sm396035666b.29.2026.01.30.03.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:10:52 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andi.shyti@kernel.org,
	p.zabel@pengutronix.de,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] i2c: designware-platdrv: fix cleanup on probe failure
Date: Fri, 30 Jan 2026 14:10:37 +0300
Message-ID: <20260130111039.874548-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130111039.874548-1-a.shimko.dev@gmail.com>
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the error handling in dw_i2c_plat_probe() by consolidating
cleanup operations directly in the error path instead of using a
goto label.

This eliminates the goto statement, makes the error handling more
transparent, and reduces code indirection while maintaining identical
cleanup behavior on probe failure.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 88e70970c72c..74246fcd5138 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -292,14 +292,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	pm_runtime_enable(device);
 
 	ret = i2c_dw_probe(dev);
-	if (ret)
-		goto exit_probe;
-
-	return ret;
+	if (ret) {
+		dw_i2c_plat_pm_cleanup(dev);
+		i2c_dw_prepare_clk(dev, false);
+	}
 
-exit_probe:
-	dw_i2c_plat_pm_cleanup(dev);
-	i2c_dw_prepare_clk(dev, false);
 	return ret;
 }
 
-- 
2.43.0

