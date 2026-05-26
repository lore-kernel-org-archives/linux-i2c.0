Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E03FE660
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805086; cv=none; b=MfTUGAqtGbe4tacBYlLRZlWjo8Mc/B29qHFJtXyb2fvQz7T6PVb8P0N9JKOPzYvrhEdmjHGHA8Gmd9d6tJs9vthsdtgZZFAq2Y4dWYU/nSjJzfoIYKexrgAONCrB/bnKqfNOLlX44kd6AQyBawlkE4PD9ryGrfkf5af8k5DjWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805086; c=relaxed/simple;
	bh=wKCmxu4eGkF3WcN/PVgoFtXX14Flsa2TKrGv+0O+/Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIo6/4IJ7Qa7wwKX6sHNiAxNy9l0IqRp6QqnQIEZF+9w9kPtEQr2/K/reCIdUW+DRFYaTcYA0G6/Sk+sIyirPCsRS9m0/ULlKTAYr1CcW92R3Z1cYlspkFa/oYi7qTRuo78NATPrQ6HamUR0JjSNlrFdpKg8F1fTcOQ1tv3IffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=iNKg8kE9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="iNKg8kE9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d146705b4so112750335e9.3
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779805082; x=1780409882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjSTfw8hd2DUAbCsC0PRSZ2dw57NRb+ytH2a+7S6Oy8=;
        b=iNKg8kE9XgjzKxuDUYkqUu3LicHAf9CgDfmQAcntFtKyT74+mINloOrtfZV8g5Xz0F
         Sqc3Eq+hoht+WvXItQOR/XzQnsU5cqo1SRWsHwx95d/s8vLUuGu+TAv/R6UU/rct8hCj
         k4Ophb5g2mc+o+xaU3WZJV3s0S/er+FfHHcn67X2coNlhEGZZyBwCeVpBBg1PvFTsmej
         4aCRJXWJs57NZtOBfe+dKzr0cOdXTSIW9UoOewEUpyyStO/Yujs/6lYoyBebkM0zqxd5
         3HZjC6C3NEpVONsVro8vYvs56knQjd1Uy+588+ZNe6OzaZg9MV22bfw44/IfkYUwHWHk
         nC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805082; x=1780409882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zjSTfw8hd2DUAbCsC0PRSZ2dw57NRb+ytH2a+7S6Oy8=;
        b=GWLMCn7OfuQBxVEIcPNkeyLjME6IOV3AeHjEKRTliT9zPDpEGBIY+/rRdnj1mkN8yC
         0SV8GdYj+sNtbJZoVKl0awivfiKHl1jCo4npwq+ePKQVU0DsW0EQKawTcjKJkaA/ET3s
         CDh4ApeUURqaiPQwFslMTODpMhyYDzF1S91mth3p84u3QDG9QBmnj3wbriapZBziz0Pw
         QbjPGswr1Qz2SyZ5YZ/YLK1lDt6voeHL2ZUgWSfVaKXOZhplJkYNMS7K3MD7W4E1AMG2
         5FUNgJvjhk59xKt2X/5M0+4q08ccl6OHBMNTV7dCPEjcRnKdNqhEepJSNZNWtGhTFC3i
         dubw==
X-Gm-Message-State: AOJu0YwNpDCWlbgjXbjX6WadCkFMk5JRdPh9aclUeEKvcmYNEBVXIiws
	mM3MgBit83d35JFvNqFJmjgcY74PeBOTPxjDeZAmEIl31Ls3ApLWyFTLht5LNBM1s4o=
X-Gm-Gg: Acq92OHIntiaiqK/2dr1PLVmQVH52m/lUlo/OUiNn8Irn3UeSJrcxyiXW5LCART2ojh
	CK7XXWY07z1oNm1tHLauqduEgVvV5Y5+YNT1dKetcnr1M706KrQO8YnBQG4gd1FQia0G+S55Pdd
	nGoLUtH/3rL/JQvk6yf1KbLqKpyfoNDvQa3/8u519Irwvruowjj94AWX8cXcI2u/LjR/jLCJPI4
	q+cSpEtKJIB5icSGDpkmc/WI1gbvjqMn4oVFKAZVtpNdDf32LRAzi2Luf4kwcCamYQiYVA/E8EA
	czAskLScwmHF2Ritve5E9sUmN3sPxbTkbL2okF6BxaCRK4cg8EPOVi1GDI5Xhve+PfMDnQ71Kpz
	rgVg5IGWwIi0lznPnQOsVkD94n+YkdUnzR4AA7KAVoIar1HMOLvd5a9g28H6BGdw7CKkcA3nUqF
	fhKMs45DHxaNI9fhjcIWtKZVX8ECXAV/75dfx4cu7aPCqgYKggiile2rsqp8nZwKRrb2BQFYWaY
	AwGsyDs7XiHu/k=
X-Received: by 2002:a05:600c:4e0d:b0:490:58ef:ce9b with SMTP id 5b1f17b1804b1-49058efcfbfmr220400605e9.16.1779805082510;
        Tue, 26 May 2026 07:18:02 -0700 (PDT)
Received: from localhost (p200300f65f47db04a716d2bdeddb4813.dip0.t-ipconnect.de. [2003:f6:5f47:db04:a716:d2bd:eddb:4813])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49054638d7fsm81057325e9.6.2026.05.26.07.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:18:02 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Max Staudt <max@enpas.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 4/8] i2c: icy:pick  Use named initializer for zorro_device_id arrays
Date: Tue, 26 May 2026 16:17:30 +0200
Message-ID:  <3d7690c7a8948f977d6c50bd0c8010efb715fbdc.1779803053.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=wKCmxu4eGkF3WcN/PVgoFtXX14Flsa2TKrGv+0O+/Yk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqFat/tAXc9tABs5ijVzlOY1OYUpuZsyoD2hmEh ILeBu0bh5mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahWrfwAKCRCPgPtYfRL+ TnaoB/0d1xQvc5YSkBTrnPeeaHiaC7esFNf8x8IQr2K5Hzi6Ae79ZjfE6Ojx9JEjKm+n1Rk4KwE Ql/16xqi52kbiaF3wrzAmwPej3JsxhGi35OiZfPXPM94YMvyDRK9/klQSjUsJCn5OGshCBJhkXY 39ZdJMA7tQx6FFJ8aStDyN31UN6d682IExxxhWhyEedefuvIvyPJ2X28xvy0kjdyijMql5dz9fj HwhyJj2ptrAvgC9EW+YGiJdw1Dbng9XhFoOhBr9Uw09X4R+sr38aT80qBtRiYBVdkcVwYZInvmJ W9dL/+l1+vtFNSeG4h0Hni85qRYXuIjDv8APqpxhEfPHMtYq
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Using named initializers is more explicit and thus easier to parse for a
human.

While touching this array, drop explicit zeros from the list terminator.

This change doesn't introduce changes to the compiled zorro_device_id
array.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/i2c/busses/i2c-icy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-icy.c b/drivers/i2c/busses/i2c-icy.c
index febcb6f01d4d..55496e48ccd1 100644
--- a/drivers/i2c/busses/i2c-icy.c
+++ b/drivers/i2c/busses/i2c-icy.c
@@ -193,8 +193,8 @@ static void icy_remove(struct zorro_dev *z)
 }
 
 static const struct zorro_device_id icy_zorro_tbl[] = {
-	{ ZORRO_ID(VMC, 15, 0), },
-	{ 0 }
+	{ .id = ZORRO_ID(VMC, 15, 0) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(zorro, icy_zorro_tbl);
-- 
2.47.3

