Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953146D0A2
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655219; cv=none; b=GwfKwfk9v42kZSjc8yM0qZNwSUzB1RO7T7cewe/dqA5TzlbxcjbVHC61taBPMaw/nt70SDoPmaMnPOBUe+QASMMX2iy5Eyr2UI8gee81TJ60h+mtBJ8nbg4qXMUfzesjZ9lKy0NsxrKfr/bQ7wBH3Cq+Abz17LXL7tddlKgTT3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655219; c=relaxed/simple;
	bh=+Iyoqht06orAWWu+u7sHJGc4N1C/gzIr5LzUDuiY8Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FMKyEkLgJBLyI7Z3mHRjJd6tLeO3N8BV147kiylH2yEIzxNYbd7kH+e9V5qAfTNeIM3mq++zW26Snl/Md/SUslaQevswVuAVwcg0EUz+UZ8yfIs/m41MLe0v3kTItw7L71JWWvIXkghkxkuB/N2vSUaJTQDMdfrV4lxgyrhxCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=YRJrVvYJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="YRJrVvYJ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbed97fa26fso174674a12.0
        for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 14:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1786655206; x=1787260006; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ultvd+YwB2CCLSLTdZwfLPvD251NBr4TYb3rtNreqUc=;
        b=YRJrVvYJ41jpJFl3nnKHGmmdguXAwWSgdgAymXvI66PrLPTfImx5XAK1lGMAtFtcJc
         cutf5XEL2QjR8cuan55gdbxOk7Z24mZpvj04yu6YMlhDXHkJniKU22h5VYRBbKK7NqAu
         rpgczz5iJBxIaFRuTtKI0zaUW9f7YjrdG3zIoPSxYI6mdJ1tT82bsS6INfNUCLyY1We6
         mt9ym0eW4WYy7VIwczI14tV+YTWquID+gzu4hT4s2wUDqGByFdcYTaWDGH4E2CT5wAIF
         JFFE5QS8FSPDWAibxbRCbCt4EQj4oSoBLqlOwBRUurN5yyAlrv9sQXTtz8Akqb2Rf9iM
         //gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786655206; x=1787260006;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ultvd+YwB2CCLSLTdZwfLPvD251NBr4TYb3rtNreqUc=;
        b=I4GBm5dO0mnOxgfet+WSCaxYentyn5xpmbLQER8IxgCyosWjlQk5ZyqRveo1YoMRA5
         G42t/r611bGT1ynTpHJ+Yiuw2O48fuboohMB1o3lLLP+zBCdAx3HV7CvHFqyjcPdradS
         73VpjkDVzPiZWghJbPQpiVanGTFxeVbZtX8Bz46UeeJapKEUraDOyg3yxYmKGjxrKOAv
         L5RqpiNegCwNDDkw4OwcTuXsBmoeRnjb1UWotHyhY1K9K3/1AS3Lx/3oOw6dBY1Voc7+
         dGV/Y7D/cRLF8BVewGFH75/rMwtkJyl2ZJDfXjQ3v0lZJHmQOpp5vAQvlyAPx5wmqRXa
         1ULQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/bruH0y324h0+Scsa7nvlNsNIzOfct7HYufQDe8Ld3cv9aGBR10UyGF3xs69HM501Ch+WWk0jT4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AyNBIul6lG7N6YKyfFGHuew0RY87NP0+P0c0eD56+QfYf+rq
	u1CTtUcac35PWAP+6o8Gq6QzM0Fd6rbsfKn7oxHdMJYbNfe9uYC/4sDqc2nLIWhPtE0=
X-Gm-Gg: AR+sD12CqpxUTTb79tOEKLS0Xoon/lDQsWVPptg44zRSRtvlCHS3r6cnQs7Z+hcD6Np
	U9wJoBuKghI3/5Wvt18jpZfrJIMGOmGLzxl6vviB7mvxoPGWh7o0vM7Vs9KO3ysREhqYCjTpeht
	oi9yHcbhdPBh/RpIMY/GamuEto2qcYnXukPsRRp5oqfvCSRKMtdOqHRjTatw8YYkyBmn3gTeocQ
	N7rRmA90osnYUuFXdVgY9oeXKsAv2kj9wAsGQo4aO8b78luSMDsGJL5QjypnheWjLARZu8PZAQe
	9eH7dLrliBrb4z2AvkzedbmxOdIat7fN+DFr6r+9WrnmFC5risoI3FT9Fp7X9P4DD7iO7GPwp3p
	GuXHP0qUqWyWzVx6nbV3UV48DsV+XqxRfDImLmqN/vAOK45yxacqDb7DjGicAvKwTYa99njexOj
	BR2rpSzOrRMo9sEOa0h5JJ33qlWyjZAL8Ah4u8TVeCm1Vwbp6m5R47NU9pm4P4OL0=
X-Received: by 2002:a17:90a:e7c8:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-3931f5b9ec6mr4934140a91.16.1786655206294;
        Thu, 13 Aug 2026 14:06:46 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebf732526sm9841832eec.19.2026.08.13.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:06:45 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 13 Aug 2026 14:06:40 -0700
Subject: [PATCH] i2c: xiic: restore runtime PM teardown in remove to fix
 clk WARN flood
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-i2c-xiic-restore-runtime-pm-teardown-v1-1-0e7dfb206790@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMAyA4VcZORtoK4j4KuKhTaNGWDuSbg7G3
 t2qx+/y/xsYq7DBZdhAeRGTWjr8YQB6xvJglNwNwYWTO/sjSiBcRQiVrVVl1Lk0GRmnERtHzfV
 dMGcXk88pkAvQU5PyXdbf5nr72+b0YmrfNuz7BzsuC02IAAAA
X-Change-ID: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786655204; l=1608;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=+Iyoqht06orAWWu+u7sHJGc4N1C/gzIr5LzUDuiY8Bc=;
 b=aZPjAYgXpSdHMLsS5PSsc0LoM9SiqlcTXDl56EtQPLQhYYNTWWCUoXuF4aTG3wyNCHQg0xcQ/
 UbKAg7bvJgxBmyzrDURg6yFE93cZkVoIsmJ3HkhI3eAvhqCeGMUFeD6
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

The devres conversion dropped the remove-time runtime PM trailer
(pm_runtime_disable + pm_runtime_set_suspended +
pm_runtime_dont_use_autosuspend). devm_pm_runtime_enable's release
action then calls pm_runtime_dont_use_autosuspend() while runtime PM
is still enabled, triggering an immediate runtime suspend: the suspend
callback clk_disable()s the clock that the devm_clk_get_enabled()
release is about to clk_disable_unprepare(), and every device teardown
WARNs in clk_core_disable() ("clkN already disabled").

Restore the trailer: with runtime PM disabled and the state forced to
suspended before devres runs, the suspend callback cannot fire and the
clock enable count stays balanced.

Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
---
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 3e7735e1dae0..89636ca36915 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1545,6 +1545,9 @@ static void xiic_i2c_remove(struct platform_device *pdev)
 		xiic_deinit(i2c);
 
 	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 }
 
 static const struct dev_pm_ops xiic_dev_pm_ops = {

---
base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
change-id: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

