Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FD37266C
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499457; cv=none; b=obEIRsx7y2e9zbLZF13iu76OoJWnZeON3TPHPoXjpbuFuhtSJhN9n1VVGl8x47asGCHBB9A7gbRq7SEdQaeA+wm/uXPW53PFMSX4Jhwn/YDIIDW1bYuKzPelCA/x4dEqW6kFrEpUwEcA7caASdtvVEhdRWI5yCrJwIAOAtjGzgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499457; c=relaxed/simple;
	bh=ULSxsA99WtOVeyQnnnWwi4Szn0714xC40QbXKSsl18o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK8UzRwaJG9VgyhuxTSXKS8RaddjSTwvLZu2+a/uE0TVAXumdkbbrv2OLoxrQY3oc4Zog0/GlPkQ2h7yydtd1qZ7OHm5bSiXEA0hkh5EQGnBnazT/SIZVM+3dhmWuNaSSzWppwZNqiG+oL8eV8mBP0XwrUt4peW6aGm0vVTw5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY4FAfIA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY4FAfIA"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a860667fabso3774149e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778499454; x=1779104254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk/ryGv+w8weiU5QHQuVNcKF565C/DJ9GpiFb4c/EJM=;
        b=aY4FAfIAP5iGjoRSa+GybgKWTQ07w7xp7My0SKkySC4RGZqFV9+rb0bnnr5ZPMkKkd
         dwhcwQyeejK8WoP6aKyiS51LuSs0cuZut2OGqK5NS+lMA73B09XDzv/JCakxpN5SRA9a
         PnAjg7Ew/TNYkynei1bCg2oryDPQK0KRzy/wCR0qDOe3ccfzykDpunWQkfOvFy2MnE1B
         JG5gc7RzBwYyRQsC4ohhDvWGjoYeApI8xicJL5d7Y/ALL8GIazSDo6m5EpVuIDa4ovNw
         TeIrwHEypSd4HYN3W0BVexaKnYQoQjTV1VRHHG0AAEuijtBNLWHZsqYnQqGmXu2+3aSA
         Oa3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499454; x=1779104254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pk/ryGv+w8weiU5QHQuVNcKF565C/DJ9GpiFb4c/EJM=;
        b=VuJNZPxfbiKhbnbXschfrPJpEYl4dGyqDxJH92VFq13rTuxTet2GZRKtnPMZha7R9a
         koitzvzynxxRLHw+wHGaBxP4RoEeYz5/+/nKSS90RBt2Vhe7qmkC9cJ5hw/W051fU+XB
         5XaeAG3RT65su6QFR1o4VNUFg23utd236sQk3Pot4D/oe+zJW4j06FUQG6iKEb175IY+
         Y3YmvhcgY1qT8oTV61qheiti2hbQjOrLkZhI9ESlXfkPjXqzqNZrEhUZv5C0GM0/9J77
         r/123C+++d7uc0MDlaLQAjKDxcpsnMGip/bJ+a0XZqzCg+p5VqYGWhrBtEeSwCguUU3R
         eJ8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+wgP0IXYWzPrCRM9AetHkBLh9fdVNe+tEyYz/4qUpx+bMFk5D5NNB4MpCmozJ1SysTkKVv+sQDJPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4eefrVtEfmI2LVMvxf0qRgx6A1Vicx6U/o7KuIzogiNChDtP
	2+UuOEocOCGOb8fWIjHRVLL3SbvUW1gon9BfR0YPwXDDAKgjqlyA7dM6
X-Gm-Gg: Acq92OHHh+3CxbIiab2GLLB6kVFd3FbU55OeIzlSCiDcEb24FrxcOFbVUyCRb4zV9Es
	lsg0VvwvgoCuGmG+oTktLSoEGNgvtSoXhTIHEagcUDgx70SvopyButYr8ky0HrSXNckaAdhzQCk
	u+2soZOMiBqJx3+r8aKRAzHZN3v8f1wygD7QAPlRqU7PtSm5ynEGA7UPKVFDeb/SVlw4qnVUKsB
	f7l/ZJ3gAVwDNDyd+yG7rtjNqEPDMymc+zNMSrQecTu3+FHB32rtALZtFOnZeU80e1k57feLG/U
	VNe+cJslgDYU7/nXZKBjCeuVAVmRLtCRXE0Z72DWVcsD3TynCsAlbw391BWGFbkpgeOCodEYw0G
	fsQzEJUtet6xEneExMmuOTGNhdGO/xQmI6fDUZiprx2Hm2eZnzb6QWrdNIt7PYy1CJAfya6QKsM
	ka5hG1YkGP6hf0xWBmRkdQY1RfqB+dXfe8zaK7TdgSQLV2yQ==
X-Received: by 2002:a05:6512:2252:b0:5a4:52d:4abc with SMTP id 2adb3069b0e04-5a8a949f19amr4681273e87.8.1778499453886;
        Mon, 11 May 2026 04:37:33 -0700 (PDT)
Received: from C-PF5D4647.localdomain ([147.161.186.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a956b1cfsm2593967e87.73.2026.05.11.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:37:33 -0700 (PDT)
From: Jie Li <lj29312931@gmail.com>
X-Google-Original-From: Jie Li <jie.i.li@nokia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Li <jie.i.li@nokia.com>
Subject: [PATCH v5 2/2] i2c: core: support recovery for single-ended GPIOs
Date: Mon, 11 May 2026 13:37:26 +0200
Message-ID: <20260511113726.49041-3-jie.i.li@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511113726.49041-1-jie.i.li@nokia.com>
References: <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com>
 <20260511113726.49041-1-jie.i.li@nokia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, i2c_init_recovery() only assigns the set_sda/set_scl
hooks if gpiod_get_direction() returns GPIO_LINE_DIRECTION_OUT.

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
Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9c46147e3506..a3c33e804d47 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -445,8 +445,8 @@ static int i2c_init_recovery(struct i2c_adapter *adap)
 		bri->set_scl = set_scl_gpio_value;
 		if (bri->sda_gpiod) {
 			bri->get_sda = get_sda_gpio_value;
-			/* FIXME: add proper flag instead of '0' once available */
-			if (gpiod_get_direction(bri->sda_gpiod) == 0)
+			if (gpiod_get_direction(bri->sda_gpiod) == GPIO_LINE_DIRECTION_OUT ||
+			    gpiod_is_single_ended(bri->sda_gpiod))
 				bri->set_sda = set_sda_gpio_value;
 		}
 	} else if (bri->recover_bus == i2c_generic_scl_recovery) {
-- 
2.43.0

