Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B036495F
	for <linux-i2c@vger.kernel.org>; Sun, 18 Oct 2026 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792294523; cv=none; b=J2p0JYWWqQd963fJkb210M/yqNPsqhYhWIe1T9wW3hy9HPi2kbBENzUBjO4UKk2x6dJ3Ydss1zZQn7ybLhnpuItoZp0C6TuOE5vVosO5zT9DuEdnFJkMslDZGmrwd4TKOhnT4iB2YH33ivMq2XEWouYBZIzMzmA64WAZGVz/4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792294523; c=relaxed/simple;
	bh=uVe06ph1k3Llybni+lMeg6xSZx4jOd56Z9/GOX96LFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hn6k2o5UztIE79sA4tHNbA/AItyyWUdqOfK9wp4iWN+hsfqlut0etsb9MwUFqrHcD4gMxLlptRje/p7q2JY83/Ou33JDpc3GLyfudy7hUuwVwJjpULsFPTFHUSq9+tK7xG9oUbfsVQk+4O43rTemwhTRxZcl+eGRwyQZpyHLRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaqZd1dD; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaqZd1dD"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b89c6caffso8285736d6.2
        for <linux-i2c@vger.kernel.org>; Sat, 17 Oct 2026 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792294521; x=1792899321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jo+tzeeZkBh4RG0xMA+gejZb3NXKmCwEGSYhVavfNxk=;
        b=jaqZd1dD3ekx3Y/lZc6tlO6oBw9eeomgmN8XNuFuKuUKK1lG/5bfGKz54Qh8iJpPk/
         ygH7ZZ/njk2nAvOtp6Zx9H68us5jUGCggQcaaOUrD+40Sl4O5HzKUGqyydvjJbdNrJPG
         lXVwNelDrWDXWGb80/RdA2XOjYerN8kHPRauHax33bFZsMVx0f/y8T0QaJ5QcNL8h8ph
         Xb0UMJhrpdJnx9OIhv6cMIINtqIqn8AlVenI6wurc0hu4fcoJouuiRr5XwscNJpa3QOu
         p+2ZItx6oyY2TmDd7krzYbvo0u1k4MiSmRVzxVD3yjSSzl39LdFkZyPjJ8FzoGx1zpkq
         N0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792294521; x=1792899321;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jo+tzeeZkBh4RG0xMA+gejZb3NXKmCwEGSYhVavfNxk=;
        b=h1DtEW+w5oeQfotPoplGPxEUSgCr/iY0UhtRFbhAicffhWysux297rIPY9E2Ykmr8f
         uZ19O5Xd1A5UlP7IuUjaGBAb7x7/msZNcOuEcK5MeKZjIhASE5PuEuU8xUTZPW1ViZaB
         fm9bCPFRiM/1OzdJ5ZRJIgFXIivJyy+Jq/AONZsxHMJLqeFD+6Bv8MTREs/eFOA7K2dA
         mR+WgvUCCGoj7+Ij0ZoZUcRIjTwUo6Jg6pTVnuFreqwmArUDoCxy7R8R8D4KJzLiHGPc
         bd/k4JUf5OHQv9baSAPWOSvAy22fNaWoQuZFA5LtA5QgLhxsel6ZkT2kPVlnhFBKpwch
         WdrA==
X-Forwarded-Encrypted: i=1; AKwUvBxog6V1efWxP6dcPokMiENfoLDKeAMQ+1c/ttcxLjlF11JPQgp+CGrcfNtYfqLOQ7L+AB9Wpb5DkLg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKt2y8Ge2pILJPIglmFATVNvF3UlMVi3b+Q6Kdv42bIu20rZvzC
	F8Q31tRg108tb08/SfTj5wN0x3Zfi4HFujZDCjsYKNU3CVvNOJCPvew=
X-Gm-Gg: AYBFou26IRzp+OdyjCHzuueJc1CYEkqm4K7FGsHCoiASkq6p+sONwc71O90AtQF14Uc
	+5trdvFuXr4jH9mzZB+bLAxW4VFwF0YUJlSbqsHCm9bqBmwG4bmQ6eITPlopy70UjcbhegMVhPu
	9Af8XDGGWICQ8DybxkxVdr3RBfZGnznQ9WU0+aFpbpC5pbsf/Vs2fzVI+2r7AIoQT4cKDlrIy99
	wnT+triiaclSmM3Mm2ARnRtiHz8dlxdTxTmhL6gL17mB4yz8mJL50AWlqwnV6yTm2dnORFRpZX+
	3DK0OCn403lqZyfvMU6uk/pOOl1dFUpwqfwT0NCCBLURPXoRxmjod9+T/SJ2SUPahjL0+8ZRUsY
	p9fWb2i9SG+My5jg6tqCCQbX5/Igq0vyxMfE5kiF9wYv2iwMq1vmGr7C+pDM1PhjJf9e50OyEou
	VE3zJL2HB5mzhuDwA9Dg2jWCXc3MHCE1kk3ZgGCpQU67bKFloQ10H9hC3GTukJOdnKVdL9ZBqvf
	QznLitT05802T/ZJYxHHX/KdMkhZb8nJI4Vzx+ikpjHqMOG94OB1WPA9bIquslDJ/0DURopRW9X
	WnouWTemu8yTQqRS7JkJrmF7uiuj
X-Received: by 2002:a05:6214:451c:b0:91b:8d12:bac9 with SMTP id 6a1803df08f44-91bde9285c2mr73080246d6.0.1792294521002;
        Sat, 17 Oct 2026 20:35:21 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbaa841asm62175456d6.18.2026.10.17.20.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:35:19 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ae878000@gmail.com
Subject: [PATCH] i2c: sh_mobile: request IRQs after mapping registers
Date: Sat, 17 Oct 2026 23:35:16 -0400
Message-ID: <20261017233416.47b09ffff48f.i2c-sh-mobile@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The managed IRQ handlers are acquired before the managed register
mapping, so devres unmaps the registers before freeing the IRQs. A
transfer wakes its waiter before the ISR's final register read, and
unregistering the adapter does not synchronize these IRQs. An in-flight
handler can therefore still access the mapping when it is released
during driver detach.

With forced-threaded IRQs, the handler can be preempted after waking the
transfer waiter and before its final ICSR read.

Map the registers before requesting the IRQs so that managed cleanup
frees and synchronizes all handlers before unmapping their registers.
Keep IRQs available while unregistering the adapter because client
removal may perform transfers.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: 7fe8a9993337 ("i2c: sh_mobile: devm conversion, irq setup")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
Compile-tested with Clang, W=1. No hardware runtime testing.

Based on mainline 0fcb05b72344f40806cbe810de8872f1698bf053.

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index dae8967..3a55f80 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -880,10 +880,6 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		return PTR_ERR(pd->clk);
 	}
 
-	ret = sh_mobile_i2c_hook_irqs(dev, pd);
-	if (ret)
-		return ret;
-
 	pd->dev = &dev->dev;
 	platform_set_drvdata(dev, pd);
 
@@ -891,6 +887,10 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	if (IS_ERR(pd->reg))
 		return PTR_ERR(pd->reg);
 
+	ret = sh_mobile_i2c_hook_irqs(dev, pd);
+	if (ret)
+		return ret;
+
 	ret = of_property_read_u32(dev->dev.of_node, "clock-frequency", &bus_speed);
 	pd->bus_speed = (ret || !bus_speed) ? I2C_MAX_STANDARD_MODE_FREQ : bus_speed;
 	pd->clks_per_count = 1;
