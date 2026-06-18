Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C53D890F
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788915; cv=none; b=VU1i3khzog4FNIiE6/hrwJ0IN1DqX9FJ0e7UG6jFlR4KF1BzoEqp5XQgri37v+VRpUoks9NAJi7Md2yl1St/2HAalMN5SfvztOhftsuVCjsvpZM9zo9OsvN5to2oCamqQXkTCVisicCf6nyrwk4+ccl18BUHYHTgvQSLYOk6qO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788915; c=relaxed/simple;
	bh=44O5xzVX89ZE0VHmF+rs/KTPfz/ziGKAGmb4RhPOxz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjuV9iFMdcGLzTSRCvV1hEJWAghe3Twtv2pdg3DmV1xswq5QnG22I0oFzZdqW+4TvznAMTvcXdPf3imJRO4EO52u+XByh2dvTEZbL990c3Qn323eOtlGhkpujqKTNGuQme/P/StR6QYNpwU1r6jdZ4Ap44nm7VQ4gpoc+m675Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbMYu3NF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbMYu3NF"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so385652a12.2
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781788908; x=1782393708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tT13A6NAYZuTx/YyXo5jPcQ9raZMcUWUjalNNtxI2PQ=;
        b=AbMYu3NFGQZnCl0Y2h3KA/CttLxc7CArNUEWnnl3tuKlBUI23/n00yjAoqlpo0nCzu
         VY8csf7IwaWqo556PwSBPfEO/KDfK26/6ANW78fJf7Gx4Cnd0/xm6dM2a+XTXUdbi2Zi
         4Tlj9NnkUQu8/+lz3C0qxsqnERQVZZnhb81IEqYiFTAeUsm/H+f/4l0zqfKr3I5qyHem
         HKOtIhdiu/JN3KYac7FH0DEg6rikCKgCXUV+DakOedkk1RZNzTz8lQ7bMXmjw6LOyiD9
         aPnWfGU4BjUVzQjyacrQgq6LCNwfiTo4xJpvpi3pNh/nwdJRYGP/czHgB9wiqrhZkrIQ
         58pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788908; x=1782393708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT13A6NAYZuTx/YyXo5jPcQ9raZMcUWUjalNNtxI2PQ=;
        b=MQkuz6acf5S2H3b2W/bDUT32MmBO6ivaQ3ANddBIAB5dIDSl24KnEU0ohN2arXALFR
         qMOVc9BPt+d9aeDKxZ6XeVx4YAjHx29UNKFDFMmLgQWmIOjUlwtnuDF3orF4WoGUY6Nj
         xyPvGMZ7ZIar4GvnWVcoyF3R0TakAOOZ0G2K28aqPdgEAUVHDdA4mx7+3muF4qXF7J5U
         /v2UQlaegIh9V3iJUCnu5/OWf2zVxxe8isnAdthdPt4NVG8D97IHI55Msolvc2LC2Jj4
         LIYSr+YyQmb5SxD/lQvdLb8LXJoVkd3jfaBfjnIVOl85wsiRxWeLugl8NHwS9gHkeBG7
         Ik5w==
X-Gm-Message-State: AOJu0Yw6kjOkP0TIt+RjMnEUGUJPlzEMrGLaP0eobdrXmUFKeCItj4CD
	UPwlZvry9j+giVSlX3VH5hPml9bt/2XcysRECorWdnEIzWukU4YkUzgg
X-Gm-Gg: AfdE7cntRu49PWyDTJtF0FwATNkzr2fmCDbeJ0wYosgLSoDpoJL82eXpQrjs0pgKb5o
	2HFVmg6N9sLPOUSMJsZO3JkkcP+u/a7KKSYkBZA0baPoT21Kz8VzmM1Y5mQObYQTu4wY04XHokD
	CYGd5USQ5JurcyUWVhg/+rYzKy1uuRX2v3Xgll7KKkc9BiGevOGxXLfdwvh/is0HDAQxYD4VlTW
	CHznS9baAWvKEAYFuO5m+DzDsFqUw1C1A1uwYfrT9oM9gm7TIVdFApZu2kPON0a/3a7suzYFK+a
	RrHG/LisnKyu8vyuB1XzjbDXxuC7bvU3X5M5JtX8Tn895nzvZK4kYN5K25MhofbonW8z9sG4UFo
	WhS0cEgkGpx0apl15G272jCHwojO3Oh4QllFXletKXdgOQnv4P84lZy6t22vF9g3FTh4vXwgdxc
	JXh1OqMvPOXQmY+q/onA97i1bL6QJNZMWwY0dHQ5X/
X-Received: by 2002:a05:6a21:a89:b0:3b4:6265:3788 with SMTP id adf61e73a8af0-3b9e7bdf93cmr5194540637.21.1781788908183;
        Thu, 18 Jun 2026 06:21:48 -0700 (PDT)
Received: from steellegend.taila75641.ts.net ([2401:4900:1c19:e45:6f99:fe25:8bbb:3a22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5ccafsm17676098a12.2.2026.06.18.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:21:47 -0700 (PDT)
From: Uday Khare <udaykhare77@gmail.com>
To: andi.shyti@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Uday Khare <udaykhare77@gmail.com>
Subject: [PATCH 2/4] i2c: sun6i-p2wi: Fix device node reference leak in p2wi_probe
Date: Thu, 18 Jun 2026 18:51:39 +0530
Message-ID: <20260618132139.11114-1-udaykhare77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In p2wi_probe(), the device node reference obtained via
of_get_next_available_child() is stored in childnp. This reference is
never released via of_node_put() - neither on the error path when
of_property_read_u32() fails to read the 'reg' property, nor on the
success path after the target address has been read.

Fix this by calling of_node_put(childnp) on both the error and success
paths.

Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support")
Signed-off-by: Uday Khare <udaykhare77@gmail.com>
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index dffbe776a195..1ef0e82eeb63 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -220,10 +220,13 @@ static int p2wi_probe(struct platform_device *pdev)
 	childnp = of_get_next_available_child(np, NULL);
 	if (childnp) {
 		ret = of_property_read_u32(childnp, "reg", &target_addr);
-		if (ret)
-			return dev_err_probe(dev, -EINVAL,
-					     "invalid target address on node %pOF\n", childnp);
-
+		if (ret) {
+			ret = dev_err_probe(dev, -EINVAL,
+					    "invalid target address on node %pOF\n", childnp);
+			of_node_put(childnp);
+			return ret;
+		}
+		of_node_put(childnp);
 		p2wi->target_addr = target_addr;
 	}
 
-- 
2.54.0

