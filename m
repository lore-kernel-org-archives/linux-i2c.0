Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704039DBCB
	for <linux-i2c@vger.kernel.org>; Fri, 26 Jun 2026 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782442755; cv=none; b=fhhP+6IpBQHfwXf0t4wpCtLW1KfL7KuOpgYuG7StA4hle95avdONk6yBnsHDd9pVLtcIPq4Um9UGYsNFg4Kyl0nO+xpUSd3iSScMIG8OqOFmPRxT6jzFiT0eKfjkbaoYw/vnhYOwTHqe4bjqDIdMFieMmV290eJRnt3+tt+x55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782442755; c=relaxed/simple;
	bh=54Z8Cw8L0KFu3D/Cv1efbP6u76H/GbdlhPOW5yAC0bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfuEEBLclWE9OV8JWVq/HYssZFkarLhhYxYbzs13w6oy3XJk93PHCO4vIFgq5uIcAFOpyJG8EpD9+f2soWOr+/PKUNJoFCCuD02FrbwsvFYhxfgvEUrzg0oLcaqLO45PJ3V7qcAw+EQSqB5VqBAmsR2jAwcKcMEXkjEFuWMXk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqK1RYPY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqK1RYPY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so3099215ad.2
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782442753; x=1783047553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvC4gX1oHDIM5j6whwgmhqEecsHukjk3hp3brUU36ME=;
        b=jqK1RYPYmyh0xTG851ApT5aJo4r0yDPYrl2XyL1Ygd0vzhJMzJExTbCwmtwpnDQ+vV
         AK7HVHyOzDAC0hrqUhR84opc0o74/p8Qk8lU0kx26aLdJTg/aUSeylHtnRpSqXuEZDTI
         lHVHSz+nV76ZayUWPqD4kEiEXE1uZEwAniTocgRZtny8pMjg2BFBZYlJErUacZ7JXDC5
         dBvyS6O7aemMD069iOX3RYlmpUy+tCJXUnsNynfdK4Rr/KfeySboOSb/qyoWKrkCn4hf
         16OuKW6HREso9FnLEYQj2/rDG9+JWC+DFEqQrwILg0kn2OM7G43TLvCbhZ55JX4/iQNy
         /mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782442753; x=1783047553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IvC4gX1oHDIM5j6whwgmhqEecsHukjk3hp3brUU36ME=;
        b=f0bD2VVKp5C2+tOak0f5+lBrdQguzLChCZgR4j+aZwjxGZYWbJCFGEe4nR04j1JPnG
         7UYyO17TMM0rIe9GELSqBpc4gfznxZxWhd9qV5ywILYoHYGKXeHUfM3KSH6ETnYXaEIG
         AHHO2LlU5FRHr7klmtsZ9PoCHjSJkGBXA3T7gOCQJj4+a+zj/bpTcZPCwDJULmtXvmYe
         1ouu+MQe0ZPA+JqJJaRh52lv4C1+hiy/tE48dWwFBE9/KswQPdbdjjgsUsbgyW33Rgqk
         Q7/EuhubmkHsT+au+QUPkFWkfbGxZ9ao+Mu/7tvyBV7ZFKmSHpHFT11LtyJOOZEaese2
         PE4g==
X-Forwarded-Encrypted: i=1; AHgh+RqbOLkpipCoC6jijmuM2jYzHouDtGE7fqTPsQRkKoeUUY6XUykYM5gbB5bPTugTrHuf/NSywtJAPdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPnRG/2tpbSbcogFhqXSaNmHCFljQjP225POi2vRnuy/dQXE8
	+EVdt6o47TcrBYwCr6E3pcUdxKxobEjLBUMEkCHGG2QEeokmChYK0yWG
X-Gm-Gg: AfdE7cl5Vb5stJQNlUrtZwesoMHDFQm52a0N+Di61K1XH8iFZT9GueG2xEfm8Rgko1B
	ZJfMlcgoztdutJWqYUMNsvCiz6T0UqeE6XnsD2K4LiBumJmZ7TDEF13XvDXjau7jVNbTldSXmRJ
	uoTf89GMrzCy8NKtlwy7nRRJEQ7y4gBNnb7HjNFk2IyTpA0TOnCgNVT0EfYNxtAHQSvyIrlJrgX
	pDcH968zA2nL7KKW95MjCrmPMTS60hvRFe7To5csllT1oAqfLk6t9BH3Tvm2mpwi1WwITl0jeAX
	ACCzaoaa9ziBnK9UQWBEYIHQXYvPsSZqWM/YRernA5DSCKumhPZb2S5xvDzZi30c1Gt6qTOiakl
	LUYjUKJxCwDEYbSJUYmhMW/t6grgG+zHCzl4bRxLRIm1FDi8xlkLpA3Hs82QOWLoIhNXm0aB2l4
	qYe15GqsJsd2c=
X-Received: by 2002:a17:903:1acb:b0:2c8:1f58:55dd with SMTP id d9443c01a7336-2c81f58569bmr423295ad.9.1782442753216;
        Thu, 25 Jun 2026 19:59:13 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afb1e0sm31252535ad.29.2026.06.25.19.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 19:59:12 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: frank.li@oss.nxp.com
Cc: Frank.Li@nxp.com,
	andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	liem16213@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	stable@vger.kernel.org,
	wsa@kernel.org
Subject: [PATCH v3 1/2] i2c: imx: Clear slave pointer on registration error
Date: Fri, 26 Jun 2026 10:58:45 +0800
Message-Id: <20260626025846.106157-2-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626025846.106157-1-liem16213@gmail.com>
References: <aj1UR5ddawsdMbZC@SMW015318>
 <20260626025846.106157-1-liem16213@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In i2c_imx_reg_slave(), i2c_imx->slave is checked at the beginning
and the function returns -EBUSY if it is non-NULL.  If
pm_runtime_resume_and_get() fails later, the error path returns
without clearing i2c_imx->slave, leaving it non-NULL.  Subsequent
attempts to register a slave will then immediately fail with
-EBUSY, making it impossible to register the slave again.

Fix by setting i2c_imx->slave = NULL on the error path.

Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
Cc: stable@vger.kernel.org
Signed-off-by: Liem <liem16213@gmail.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 28313d0fad37..17defb470776 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -936,6 +936,7 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 	/* Resume */
 	ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
 	if (ret < 0) {
+		i2c_imx->slave = NULL;
 		dev_err(&i2c_imx->adapter.dev, "failed to resume i2c controller");
 		return ret;
 	}
-- 
2.34.1

