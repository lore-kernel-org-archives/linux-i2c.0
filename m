Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1432FF662
	for <linux-i2c@vger.kernel.org>; Sun, 25 Jan 2026 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769370707; cv=none; b=pMuJgBdxcIU0grGD4eZ/0qsGhLq1HSRkqOvZpGd7luA4H1obNznrdirLmK8CUeApKvxnjblRrFaaf7enoHYoW1pPiec29NBHhKPbLj7uS761gP8ULRQRrRO40BhNF+bJSdeiCrpzk4kqn4+8m8SKzm+BuNH8VecENnOawYegFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769370707; c=relaxed/simple;
	bh=yOJ54pYpL2f9TTcF6tyIQse6Pob6FYPNHJ3RzR+Wm5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHFg8hbB8mY6RkVNwUQtyMWxxQJSc5bIslOzjI1qhO7s6oNFDGoZarXy372UFTpDLYGIs7pvUz7EEtEWZNOIb9r2WTu9xEp4JOCKq3xnTWyuYHlwZSWMYKeydiEcnsb/KPB3vL6zF4VQXUbyoQ4pwakcbX7cLhUCjjCQrCNr28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av0Hlmsx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av0Hlmsx"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso6147409a12.2
        for <linux-i2c@vger.kernel.org>; Sun, 25 Jan 2026 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769370704; x=1769975504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1NkWW5tAbnDHrUHLuon+4jkp7FZIlzNu5NjUea5Lk8=;
        b=Av0HlmsxmAQXgP6vapbuxYcC4Wm4OtQoveFCE3TEGHbei/JKjzp3nq7fNiEA21DTxf
         HaSajvsn/ZgT8Zw3eM1G0NLvrdafqxKSadRI489sWFNGHSpPfh/KIO78RYEGjgG+zhK4
         s/mZ5G/gDIKfKe3CeSwPFeQY9koON+y6C1Xf6VcCTvhpOJjFRcuhF+2IHPutRaCUbLqx
         g4t2dJTqwQ2w7+0YzGIx+KG/EFURZJfgeN9XxL+UZ6OZFLmVRiKOWhDIS/U6z3/k5Y8p
         1YyUvVRbJYbZdMpl5+ruKSC4kuIiKNpX8hEbXfSdrYD56Q8IwstNN/GWLrjzID0d6zCb
         yMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769370704; x=1769975504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p1NkWW5tAbnDHrUHLuon+4jkp7FZIlzNu5NjUea5Lk8=;
        b=sk6HcIjgHTEE72KHXrZzFEHWjLQJcmRMAazMTZJJDczAiWBlHT3FhtOyxyr43mozRh
         joOMLHBhMpWj+052grEJikv6iunp9pD8aaCaQ77yRdaqr+/6b+zGdNQ0RK8+LuIsqW5m
         7FrqnV54/T+eAt/B+mJ+Xn5RsyYyS86FqFeMqqsgJG+Mmx/yDJsEtUWN8sEmoQ5wQdLf
         kRmqSNGWw+wMCHe1n2RotBUxcJVfx4+Pkmxa1NSNzPvJ8HhkTl9behBWoq+YrhvbScF5
         Um3/dWAkdKzSlizhDk1mvtNFhuC6zGYPHsi7aq+KnT9kqsHPSwK3F2P2h02E9RBYnqjz
         H1lg==
X-Gm-Message-State: AOJu0Yz7GVKpg6onzAK4c7jZE6gUuGoA1etRBgkLCAV+nkN04zY5IbM4
	ek9z3gljvQQM9np0VRfgdVU8b36chKpkoJUHQPxD0FGQkCfNjQsDIZxL
X-Gm-Gg: AZuq6aJV+ROEPV2jwTWG+uYiuv2phfTHdbv1Wjl/OUvanrgU89roaX4ccajEDOzafzg
	IIWmF/3i86haHf79oFSsRuMwj65M3IsYX/RFbVc7X1OtluHQXs3dY+kSTaFE7I0zTks+Au6uLDN
	v4ZjOQ9ZnJsfCjwu9u5ZPtJFmLb1Gn2tj40bh9N7EhyIm+jQGR5p5yfgFibSh0y/Mb7lGkGDCsN
	DqHRJ/zZH1/685S733T8N0G5DwM5qadrQ7FV2j3T6g+zLMe8qBpCXd3zMjcihIJQteshjr7OGTt
	3M7ZNe9fT9XPA6ENuFPfv16R4ZNj8rY/zBQ0pji44uo0ZcZPQnRf2qhWklgJRUulmhHtakyDDWP
	wwSH3HUyA+Xfk3xn1WMiOcJyZ7p9iVfUOFxA19lV8NW8kBwSdKuAahFQ8LAVjguB4GW1iYC8EvH
	5Uqw52+qKuSZ/UWHKysCymA/E=
X-Received: by 2002:a05:6402:26c7:b0:658:1b1b:15a2 with SMTP id 4fb4d7f45d1cf-658706aa73emr1572957a12.7.1769370703967;
        Sun, 25 Jan 2026 11:51:43 -0800 (PST)
Received: from C-PF5D4647.localdomain ([147.161.248.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b965df4sm4010232a12.31.2026.01.25.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:51:43 -0800 (PST)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: wsa@kernel.org,
	linus.walleij@linaro.org
Cc: linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v2 2/2] i2c: core: support recovery for single-ended GPIOs
Date: Sun, 25 Jan 2026 20:51:23 +0100
Message-ID: <20260125195123.248798-3-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125195123.248798-1-jie.i.li@nokia.com>
References: <CAD++jLmGMWjCD0gUcaJPuK0UzJa7nX1bdoVu-BA7aHAgcLTSpg@mail.gmail.com>
 <20260125195123.248798-1-jie.i.li@nokia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, i2c_init_recovery() only assigns the set_sda/set_scl
hooks if gpiod_get_direction() returns 0 (output).

This logic fails on certain SoC controllers where open-drain lines
in a high-impedance state are physically reported as inputs. This
leads to a "deadlock" where the I2C core refuses to assign the
recovery hooks because it incorrectly assumes the pins are
input-only, even though they are fully capable of driving the bus
low for recovery.

Update the recovery initialization to use the new
gpiod_is_single_ended() helper. If a GPIO is configured as
open-drain or open-source in the firmware, it is safe to assume
it can be used for bus recovery, even if the current hardware
direction is reported as input.

Signed-off-by: Jie Li <jie.i.li@nokia.com>
---
 drivers/i2c/i2c-core-base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index ae7e9c8b65a6..11bd801418e8 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -446,7 +446,8 @@ static int i2c_init_recovery(struct i2c_adapter *adap)
 		if (bri->sda_gpiod) {
 			bri->get_sda = get_sda_gpio_value;
 			/* FIXME: add proper flag instead of '0' once available */
-			if (gpiod_get_direction(bri->sda_gpiod) == 0)
+			if (gpiod_get_direction(bri->sda_gpiod) == 0 ||
+				gpiod_is_single_ended(bri->sda_gpiod))
 				bri->set_sda = set_sda_gpio_value;
 		}
 	} else if (bri->recover_bus == i2c_generic_scl_recovery) {
-- 
2.43.0

