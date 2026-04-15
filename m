Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0CC387569
	for <linux-i2c@vger.kernel.org>; Wed, 15 Apr 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286237; cv=none; b=CYdQHuj5QHV3J2MDSSx7Tv8NWA+CEHyOidtUNddm5JREF5W8BSo3FjbNjxO5NQCPqho283/akVOnpS+ZqVUPL91XQs9nMpQg9iNhCoY2VjIBytbVWbTn9QERWTHHYj6cueyV+EVUNefc6g2Yb0Ugdy/Wp09AX5cFDBpQ8/FXqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286237; c=relaxed/simple;
	bh=xUvGExRn1JIMhaMrVeZ8FlE5z2gqEEdKQ9vRaXSYa/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzDwdyzGlxrudJJI4tlY4A31FpAHmC/lrrx+xU/RCpu64WgXAUhbBNAqQUuwZLVLmUrbXI6ar/3/x4gqBTYysW9PZdNi8LID/VvFCMIrcDnrY8mHl3FIxlGKxd/lO1tufrcbxStOvckL7xFpXyHKbXVwikF6njVzo2RI1QdF6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqlwaBma; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqlwaBma"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b150559bso57152985e9.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Apr 2026 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776286234; x=1776891034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5UjgvnDtHGKM9cTBMyUbG1NygpM0dsNdRiJlKXvD/0=;
        b=PqlwaBmamoBcMvYTKR/0JijP1Na64KaSm+TpsQjWZTIG1EfLv5e09ej/IocvvqdVCp
         fZBUclCJsNHTGGmlnT+7N3zsxxWhnzdaVzH3+Y08haMpKROwY+gpLc9I9ahEMQpEDkq+
         zVekzLVxHfnct92mSzaAf2EqQaVs1h8MUFxLOMfx9HOt7PLfcDvQwz+Xs2hoVQOg3AoH
         9oVNCSuJBDxaZUvOVi9WXB+UaUDMoDD26ib2bRYtWBDppHMoSHX2hdc3sqyiCYfvao/o
         UQW20fKh6BEaw2OW75M+axgNofkH40YS67/DvCOd1O+qtygE1mNtW4Aehw0M+fRUvxXQ
         0TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286234; x=1776891034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5UjgvnDtHGKM9cTBMyUbG1NygpM0dsNdRiJlKXvD/0=;
        b=ZA0LW6vyYGe1C2OOQXAnheWNHSAx3+oLMn8iKngYOONx7BubnjF22YLzeeJHfUf/Y/
         HC3j3hZSAw6ZajASxhBTkBP1dhLIOGY/D2/jG9MuTZZJd4dmbNvt6dfJ2qKiViv21tqF
         H/nS8uvkjtyRAfJFnnGCJU1FJNA6+FZILLsPIJyMz8V+Ee758Sh03wJJL1b85YpKGjig
         4y/HAuQsMe/6ZCF/qbRscXI0L0QMfF0dh3LujuMLmbKkZ4l3jMten3D/9tqW0RaK+t8L
         YA/vTRonPiJwrosQyjCn/EB5oBBLC20GdWp2mRDu1iF8gfdfywezY0k3VUgktxw4HBb9
         oRZQ==
X-Gm-Message-State: AOJu0YymUsnl7SdwP7rpN5kHAUscLF3no7JnddWJb+AoO50VxxLVBjxL
	wEArbmDuCu6rRYLYnyr9ogX3c6Dp+KwqANiJL/qlpFAqU+o1qGjH/+Ub
X-Gm-Gg: AeBDiev3vzjDJ/EBgrdOeNK3DRoIAWS/oNC13RnaAmMQQaOF3Vp8yptT+gbEYImFh1k
	rgW8dWKu60FFPLv5sZRLajeytbiidaIjfq4Auax7LBPgfxrRViy/vWx/4CsBVv1urAbMH2YWzbF
	jB/Pt2JbR6Nn4uig3XtUxDDX/amI9AJHK/oQQHl6Ca37AEx8cRjuTQNjdl8T/8nKE/GWXxhjZox
	dlBTG1yLeaGIPzCUDaUEJvYuJoBlLhaWc2A8RKmHY6ThSxrCPG8dfubtXr2L3PVnSymi6u0AIAo
	kkR+UOKvoGRm5mdo1Akp+740Yn66506I1I5yPPCDnNorRdXZPGbiyHVteQlC2m8lTmckdjvWyP4
	J78LJVfnM1hSmlDK6qKMpavZTuqkwgmLRRxTA8LX4J+qMIZhVQypzgKQuoQGwhMowuTWn0oBVtu
	MFobqHdub8ijGwOk7MXOOxCUM+/X4yyA==
X-Received: by 2002:a05:600c:c0da:b0:488:b187:d898 with SMTP id 5b1f17b1804b1-488d685b6e8mr280744715e9.14.1776286234407;
        Wed, 15 Apr 2026 13:50:34 -0700 (PDT)
Received: from fedora-dev ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9c668sm43399925e9.4.2026.04.15.13.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:50:33 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH] i2c: Compare the return value of gpiod_get_direction against GPIO_LINE_DIRECTION_OUT
Date: Wed, 15 Apr 2026 23:50:21 +0300
Message-ID: <20260415205021.1174764-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO_LINE_DIRECTION_* definitions have just recently been exposed to
gpio consumers.h by breaking them out in a separate defs.h file.

Use this to validate the gpio direction instead of the hard-coded literal.

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 drivers/i2c/i2c-core-base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9c46147e3506..a2132d70fb36 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -445,8 +445,7 @@ static int i2c_init_recovery(struct i2c_adapter *adap)
 		bri->set_scl = set_scl_gpio_value;
 		if (bri->sda_gpiod) {
 			bri->get_sda = get_sda_gpio_value;
-			/* FIXME: add proper flag instead of '0' once available */
-			if (gpiod_get_direction(bri->sda_gpiod) == 0)
+			if (gpiod_get_direction(bri->sda_gpiod) == GPIO_LINE_DIRECTION_OUT)
 				bri->set_sda = set_sda_gpio_value;
 		}
 	} else if (bri->recover_bus == i2c_generic_scl_recovery) {
-- 
2.53.0

