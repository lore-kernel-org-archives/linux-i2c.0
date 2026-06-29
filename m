Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B437B023
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700766; cv=none; b=lquFtUAmwTit3A0aLuSz3kEv01DaqcyZD1YNy016TV07xwk3453z5w5euJRIYslvHMe79g/pS2uKjQAGv6CVvqdkycpRA8ZLKv0qnDUJlq6ACYyDNjyMtsmTkg/KQMb5NBVnp0PPJI9a3QCqo3pK/OkF2KI9vu0vryTz8fbj+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700766; c=relaxed/simple;
	bh=3yf/BQq8y+lBmy/U8Na/4Wdy8IPK1JZVpOtqu+QvhLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MijY5D5zlITdpn6w/Nf97frYe+r6KXcWiiF9GLfSnQxzTdj/PgiOYw52IdCpALhv672MDA3gL6Y3zlDw7SD+0p+H3U36T+4zqzE9VT1foBsWruRs4e3svA2MJKpM9Vhwb544Cyl0nNHZx3/paSQG4y6RmaAcXTl6NEAY55/o6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKN7a8QK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKN7a8QK"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c892a0ef503so1250752a12.2
        for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 19:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782700764; x=1783305564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjYx+8tIMWDajKptnVsnfbgFJjxKrPWEBY6WEuIFPcI=;
        b=aKN7a8QKQ4Ho/XkIWEqscBKMNUxMMxQEra4nYjbhtTt6246gZO+1SM9MmBcXSkwuE6
         EmxOx+N157uKaaCcZXsw49iS0rJvIHnoGfG8gUGhSt4shpm+hVKmGzB32uqygtGMr6xI
         GKBA0J5QWx71dwLUMckmPhR9W8K2E0M04uzJ1lBLw8ah7gB6PTKek6ikVQJhrufWjPxH
         qs2EzVHcTw+WOAPGJv2b+2RxHIDlk9iH/lrcEkWA2DWgbKFM0YdTSPJ94otdUdmt4ZLy
         xNNZQPgnWvgMzeRvSJ11KrxTrgcunl/78eU5W8+0HiOwlu0bv1METBTuIHHJmu4Jgswd
         rn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782700764; x=1783305564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pjYx+8tIMWDajKptnVsnfbgFJjxKrPWEBY6WEuIFPcI=;
        b=CyIkQqM7HzWjjP5BUm8JBpJQBGj1JwkXTDLbBeFpbeaNKXcXE+OGaA/k6lf+FVAimQ
         +RbgnOMFrg1bRfjVW93dhzMZYlyfaXH3LR8c2q+fh8jGyNYI4Yb/740T3pTzcjGeUSH1
         DvG0HoZnp2P5pHyAtsWSJjn0EuqL+EIIsqhMINteQyOL4kX8usS3IOJfQAqYowVMA3cc
         eY9NF/89+IfcxmLXKoYaoVRlEx9gVh8OfodHx1ofYDV4ftL9o1cjAxunjAOmWjHNd5/i
         Y0ZkWabcK6RmpxDibA/ZGmc5k36xowzuZIiRTNTJ7ZPim95HBNfWaAmAW4uM4yFpshVA
         1gTg==
X-Forwarded-Encrypted: i=1; AFNElJ+ABG84IlEPz3RisbhW6brCgdepdxULvM4sy8Ncn0/Enbf02bNehtpOSeQkNTLN9aZaSFbibyfgtA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr528uAKwV27bew30PM1vpApOUntHTa9dwjjMzqUpFN5De1fEI
	n9StKLWHq3QNPEb5X/kowGGxpfzycq1Ja+q9irNyeVxmBvym/FAFKWdq
X-Gm-Gg: AfdE7ck/RaTe8VbaIpfQxvmwU3tp0q1g/9gtcyg3SvZNzc9pf94D2zLnMA35KR+XiuS
	FMFPHWowxG3yttdXRl07S0ij8hXRWCT0HkeW00cUPiKeCR3GvU/EWvwhLbaBuKXPItMqR0dmsqI
	rzP24S+woTym6Bnidm/3OPjPZXanmEaLk2TDtw47PEoeRkM9GFnwuPmNl4EO4aoP3iMwRpRuftc
	ZSCD3sOITMbVyGtYGCsZzXBmbFHWnlFzunvRKOkNbOTZB4y5qoFDGsyFZdOPcqFeT86331YKu+t
	nnz7NteLwOt7v4kY5lLqxjFZtOL82xisKFw0qvLSsk5Tn8bHG/7tpSxIVZaoUjJ0+tWAaUqPrBe
	bgiuf5Mf2EvoXwPrklbneI/Anbgt3mj56qCXtnA5lvQ882C0jQbtXm94LvAeY18GIEeWthw5I6D
	SgO3GPeygOXZp8m/0Hvo7qgA==
X-Received: by 2002:a05:6a20:a10e:b0:3bf:6c08:fb8d with SMTP id adf61e73a8af0-3bf6c091306mr7342972637.47.1782700763765;
        Sun, 28 Jun 2026 19:39:23 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9dc216csm6914869a12.9.2026.06.28.19.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 19:39:23 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: carlos.song@oss.nxp.com
Cc: andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
	frank.li@nxp.com,
	frank.li@oss.nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	liem16213@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	stable@vger.kernel.org,
	wsa@kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v4 2/2] i2c: imx: Cancel hrtimer before clearing slave pointer
Date: Mon, 29 Jun 2026 10:38:29 +0800
Message-Id: <20260629023829.152651-3-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629023829.152651-1-liem16213@gmail.com>
References: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <20260629023829.152651-1-liem16213@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
disabling interrupts.  However, a pending interrupt might already
have started the hrtimer (i2c_imx_slave_timeout) before the pointer
was cleared.  If the hrtimer fires after i2c_imx->slave is set to
NULL, the timer callback i2c_imx_slave_finish_op() will call
i2c_imx_slave_event() with a NULL slave pointer, which results in a
use-after-free / NULL pointer dereference.

Fix by canceling the hrtimer and waiting for it to complete after
disabling interrupts, before clearing the slave pointer.

Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
Cc: stable@vger.kernel.org
Acked-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Liem <liem16213@gmail.com>
---
v3 -> v4: No changes, added Acked-by from Carlos Song.
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 2398c406e913..b1c6581db774 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -960,6 +960,7 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
 
 	i2c_imx_reset_regs(i2c_imx);
 
+	hrtimer_cancel(&i2c_imx->slave_timer);
 	i2c_imx->slave = NULL;
 
 	/* Suspend */
-- 
2.34.1

