Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35AB4195A6
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620451; cv=none; b=jRLKDIQurvnzLNzevsE0GaEh7VJOMmC4G42BJgPxKlDE2+xyU0mSdmKmejHhDrnj+YjklIZudW4WREMbjYVZHV0vF2ezmbyds55L6kJavc+X0cJBCS0CihMLO6QQfGnVIg5nvCEQZSBSSaCmJMdOmb9ed+UnXMsSMBozD/IRMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620451; c=relaxed/simple;
	bh=2aTFqtE74mVxCKzF4QnPnvxUaPaVEshhhNvwJjbpygI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLRxa/jVwUjnisJr24+YCbhV2IWZucUscp6hN+4NI07SZLzBG1khdwiWrpkK9tfjOwb6wpo/J0/E/Jl5qSlJKt2H/YKXwP9ZepQ8pZSch9HlDgO51UxhLpGCM1P9ylgjhaRXfeBZC7wGRGyHOLnM1a6q2yhnanrS81dY7RCEhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QCREa322; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QCREa322"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacf197759so125162215ad.2
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 00:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620449; x=1785225249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CGtEOhOpR/1OiCj9qufh1O1atPkJph2JTGUTc+kCL1E=;
        b=QCREa322kDGkOIcVNmQA7ZLYuVCx0ATnZ6BtEAahiV7+gMVUOGJbT0KgwZj8rUG4FV
         0PKCCg9P4rU2izCqIKLUjN2rfkjI45I0/QtUQvZlDxVwpF5OLDkPK9o/ictCmGddzeFL
         QUFL4Fi4tKNER+1+xEoRDWJfqVDytzdsoLeoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620449; x=1785225249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CGtEOhOpR/1OiCj9qufh1O1atPkJph2JTGUTc+kCL1E=;
        b=cd+fA9ZM/qsGxaNeYm/4WysalkZ7VnnsQ94+aG0PzZAXe3gu61F8Xkqkb8LfPhlQUt
         hkL2Jd3WVuLuJciDgeUu/Uk/ctuD+uDGByyITRHKAw+uH5s9ptgGAFnqZUXM3Usi3m7R
         LpyH1eAfCj8ZBnmnxTY7pgeLRinXpzSzUddQzu4qSY6IPaOIDztGkZqi3bEXHryzHRdN
         9hn61PLc0Hef1PxN9HOvL+zSoa6NUVTCPFd9+GPgs1L+9PyIqv5m7QOl9vBrrJCEs1VI
         Mkor5kzrOoNdJ5hLaJxy/Rzk7Vt13t/C4cArn2rDxe7+4VOs91uuoJr7NpBAifGiN31Y
         uU5g==
X-Forwarded-Encrypted: i=1; AHgh+RpdXRNDj+4ZAspCsTOKdbAKziVTOYDkTZ93XIW1DvQ49RIkpKbdAYjWKt9pVlIQMrmjT1WmQtktDgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgX7KR3A1/nFvRxHFrGun2UtMgGooBPecgeB82URaBpd63NCkv
	pqX1Ds+xYkYlaY521TICf5ZB+rSYORfWpt92Xny586WFgX3/Am0tudlQGqP2WnKEdg==
X-Gm-Gg: AR+sD117+YkwPf9kSigE3PD/BDcU135qjnY6jxf5wS0jCdcEUxuAPaaozzGZAXKhXM3
	RLWBmTPq5XQbPUDqObvTM3+KMqzBqW7MjMNGXGYg5chz8vUhhwJ/Xxh8l4MoB1Elnr11PJbq22W
	1zIYAPB/YIADyjpniTnwgQVkUUqZgFhBjhUv6fLzrSAdOscuItGsB0qrTD7AIKnUOb3RkhiMXzD
	o8kZY3+fi0KkhfMjeZgEQ9sSPAFkpj83AE3oXPKW4nIgkRaTMI/c7X4bwizRZQAxut8aSuHIO9J
	V/kkXbUnmqYiG6GSwIR/CiYReQzcyYXs3QyhoItyvz4k7TFi0El3vbdQb/iHLrQNPp6++HiUDpH
	ph3ixC6iFrLcKE09T4Wet19mIxroE/p1BlKZ9ny9b6/i+Nx4GiNpNgzLpfZpsV8+D5gJlyubkKw
	E/4UJNseK1FJWcr0gFs5Meg62fFb1UiI6BwQfUgHb0RjK7lf+v53Smk40Pa0M=
X-Received: by 2002:a17:902:e748:b0:2c1:98b7:ecf3 with SMTP id d9443c01a7336-2cf3494aebdmr189718205ad.23.1784620449012;
        Tue, 21 Jul 2026 00:54:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:08 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] Input: elan_i2c - sort include statements
Date: Tue, 21 Jul 2026 15:52:16 +0800
Message-ID: <20260721075226.2347933-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721075226.2347933-1-wenst@chromium.org>
References: <20260721075226.2347933-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the include statements before adding new ones in the next change.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- New patch
---
 drivers/input/mouse/elan_i2c_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f93dd545d66b..9f024a435dbf 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -16,27 +16,27 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/string_choices.h>
-#include <linux/input.h>
-#include <linux/uaccess.h>
 #include <linux/jiffies.h>
-#include <linux/completion.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string_choices.h>
+#include <linux/uaccess.h>
 #include <linux/unaligned.h>
 
 #include "elan_i2c.h"
-- 
2.55.0.229.g6434b31f56-goog

