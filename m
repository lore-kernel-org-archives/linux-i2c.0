Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104D3ABD8D
	for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730691; cv=none; b=MpGdP5vlw7E3MIPF4UxpdmtBy0DZgowVcqhuOWqgBHW+gB0EKY2ehzFGuMA0AonrLmH674lnzSFOqgUYrkwIvYplT0QaHPK6JtTGRh3F1Ok0JPP8IOA4Xzx/qB0WdzwA2nlBR1wJWExhEhcCUM3j5ugYGQxwnmjcYVKNnbknYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730691; c=relaxed/simple;
	bh=GnYmCwQgQCpd5MzyBxd1AugHi3QfIrsoUxrijxoLXTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PAfIugYjzQI9I06MKbNDGyCNSfrEN33+LkwHgeMCv6gAKIsbznWGsDS1JABjQBClLZoM+hQH7BhNHA7U7IHs8VNrfiFCGhMEYAMDdwoYvlLh5BLTbHlz5v1boHS9szCUP7QV7GWum5mJnb0226jA8yykRCNvso96VWVBjXRLuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=QjZ3ueL+; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="QjZ3ueL+"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80bb41f7f3cso12355827b3.2
        for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 11:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1786730689; x=1787335489; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mI5zeet+gBSiudx0x2vL4qWV0S+lI4JZhzArM16nmM0=;
        b=QjZ3ueL+Lv4O2X670VYceU7SqJP10mblyrOFVvYi5nHpgxLfUnKZ2gbL9NOOCHnPAN
         doIDhNdDOT2MX653yoVkdo+d5be1Lt0xgBMAkmUNY8YpQ7OHkEQLpNqmi3JrNM1g5A28
         Cz8vPPir2pU/iChCmVlQDBrMQQ1w/USKt9SlJ79U8krwKh7uHKjZWr0Uzu9AgLfHjJkb
         FVPIoklAZyzltVlDWJU7vdvOE4YO5O52VZvsXgoNahqo0RZTxTkyYs8V0AxQiQh4z6PY
         HAPmuhtJR/MY2polrFu0IoB4B+L8hez60Ltssh/k8xQpMGoiOsd4ZXfFuXRKv5fdmpBg
         uX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730689; x=1787335489;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mI5zeet+gBSiudx0x2vL4qWV0S+lI4JZhzArM16nmM0=;
        b=e5J9xa2QYPvmlU4Ufkm59E3g60Wo4T/BWTNO/Zaha7ARnEMP9LQr2SlCd/NhAbY0rx
         tae2MiOSgve37SE7K+ohA+ocfHe+4mrY+5FxyyT0AmGU9OUFzirbtkHlTrrsFPVlA5vG
         GzfH+c5/Tduh6GlM+06+zx2/5lrr309rbGm/eNcCUEgOIcXhTdEgHjwrawbsI+8f4heR
         ANUkEeBi8lq+uZ5fOcnHuZ8nzOMbYevs1MeXsMTuqROMz/FDSQJBed029WUMulRZsa3l
         PchUypsDSFA76yQv/bE9ztp8XPGUu7Eeqc6X6ja47F1nDnitJqAl7w8Z5whoMpJ8Yg8f
         k4ug==
X-Forwarded-Encrypted: i=1; AHgh+RqBdf8O5P1JNzuNRUtgrGcNrmWBGj3VTZ9SS5t74UCvPvXvhSSABi5q10Gu5p6IhzfZ3TJq90FVXhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9RyZv0dedtEUUtGDa+4StkCQhRT9bV+Yp1hYm5ydnE7+N1Qps
	GseUniqsttQ9Iq5TjLQXBcrTTsApEDL9Ko1+GAaPMjLWSvyPwNPax31VDGcWlEL8QV8=
X-Gm-Gg: AR+sD10x5hOcUeI4A3lYEDK6ovzZtbS9e8xWEtgtfC3jUyOxU0iOiQHIszxaTznKyo4
	4b0YokDoSUpbPgmbU3yyiqUKL0jHcLQE5CPygk6NEgDus3XB/yjHI+ud6n9m0VHfYMlCsUhDTTx
	rYfN5Q71i4PhxxT8Lz/qtDufYPAYGxBnD5Gks5ORsBnEzrmoXrSJjgrZLvwn/ps0DiU/fiFr9Cl
	WIE0W9JW/qYD15NX1gQQv+s0lpO1zmu6PK5o1kV0JbXBpK18PelSQaIAb61MQx28UttDuh5RXew
	8Q9CJJn50iXMnRg2ArI1xpGaUlJKYns+ysGj32NNqwnYT2hhspHFH5gYM8IOPDfonDVbL/TmHiQ
	MSJ5ko0ATqsN6rQzxm5Wmy5gCkS580y4Hw5/V8JOfwUEwKcUnXkQdODB3KyVQlrJI5/5Fepbh3N
	gS0LX131A3zsoHZ/aiZwEgOqBKQiLS/z191miWmreUZl7nzI4hBhBdpvccmCouNj5MRV8kI11CL
	tw=
X-Received: by 2002:a05:690c:c3bb:b0:812:be92:6ea6 with SMTP id 00721157ae682-837124e6359mr23590307b3.28.1786730688893;
        Fri, 14 Aug 2026 11:04:48 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c38a6f52sm16030937b3.48.2026.08.14.11.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 11:04:47 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Fri, 14 Aug 2026 11:04:45 -0700
Subject: [PATCH v2] i2c: xiic: restore runtime PM teardown in remove to fix
 clk WARN flood
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-i2c-xiic-restore-runtime-pm-teardown-v2-1-7ae5d0c30ff2@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOTQ6CMBBGr2K6dkw7JqCuvIdh0Z9BxoSWtAUxh
 LtL8QQuX/LlvW8RiSJTErfDIiJNnDj4DfB4ELbT/knAbmOBEit5UWdgtDAzW4iUcogEcfSZe4K
 hh0w6uvD24JzURjmDVqLYVEOkluc982h+nEbzIpuLuyw6LrbP/mNSZfdnclKgQFLtWoOyqq/y7
 mnOXRhOmkWzrusXmG0wgesAAAA=
X-Change-ID: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786730686; l=2172;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=GnYmCwQgQCpd5MzyBxd1AugHi3QfIrsoUxrijxoLXTI=;
 b=l9OeeV4dVLTJ+bgHuE/r1D5jfYkVCkfb0Y+shzLfB/PdbNOK6DSZD+rDjM1otPTZRlFd8ZyJK
 UgJGjl2kcC4AleJYd1OTjPXd1CBglegsNByDqcLLtn3wh+XDB+FTlaL
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
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v2:
- Move the Signed-off-by into the commit message proper; v1 had it below
  the '---' cutter line where it would be dropped on apply (Andy).
- Link to v1: https://patch.msgid.link/20260813-i2c-xiic-restore-runtime-pm-teardown-v1-1-0e7dfb206790@nexthop.ai

To: Michal Simek <michal.simek@amd.com>
To: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
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

