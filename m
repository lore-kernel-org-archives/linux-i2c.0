Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30539D6CC
	for <linux-i2c@vger.kernel.org>; Thu, 24 Sep 2026 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214347; cv=none; b=tcxGMtu7kAIKNky5jghqfunQqUvctVM3nlbb2Q0pGYyQtfs1muxGN+2ZiiQ/dumZ5nnnSYmpgFCUM4VStWjMsc2PX3BK7tzgi2wxEGHcrBUKduye4UD7iifCJpsyeJFg15xp8zQDJGIUyFfj4NeHD6kxsHJ5D+wlH4LMhhA4ais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214347; c=relaxed/simple;
	bh=Bg5NkWAAvHyt3A3yj80XS79ACYShmuxSKGVO43oYPz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMB5fM9mzmdfQaavTFKSrA9ozbyYVl3ijHUKGa2xL2uOlq6vUZ/e5s+m2jJ3cNQUUvixgyO0TMLvHsYPMN3Cf24m0OCxyKtTj7TBcUv0HutYAzNwejGlSl7rC1gYu5v7CqFIJ9o5wc8LtT0ZA5EARgjzE2jcXRAkYN/T2D0wCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=kHCm+ey9; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="kHCm+ey9"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f089b1e3so1384116c88.2
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 18:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790214345; x=1790819145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ieebBEdwgRwM6KekZkohbUAIizHwSaKZe32zZn7go7M=;
        b=kHCm+ey9tiS053NLeXnGp46mTEX4CTJb9QuEhkXxKw6I8JBkGNgHfv0tsLDP/6BQFU
         M3dcpbflKjO2Om2Hv14M/ar3boanePYHXyMEyrdt+N8a0zt3Kt9qSwjH63/QxqjBD8mA
         xrBmHe7l09etko7gSr68m9uWVeMPYcWhmbM93tcpXnI4L3lC3lRn8dufad6xR60HIfjW
         RVQfPdMgWXuuXgjMJyddV00trLDo/lTqj4IztxCxVJMCuEwD1hrciEx8Nfz5QFyKfmCp
         Uffk+MlpHZhhBEregW7m1na7vn7jdI3dRuKZzpyJXx6fnP1HEoDf3YXjhzIJEG/BmXDX
         0c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214345; x=1790819145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieebBEdwgRwM6KekZkohbUAIizHwSaKZe32zZn7go7M=;
        b=Rx7cc5fzCshUV2hOqgpJPiGPVI/4+pkAmgr1C3NThhbGaKGLAKS5YsNW8jGxQ35Hlc
         6MdfdNprRpo2MLJen73H63aBg2AwWDCDNlIx1g+yPlpVyZZ2HgI/yODpXxKUcfmWeZzM
         5wriYlQM7vdAhOzdkptoTsRUa8X7K6tD6eE2k/MEr0duCZ0CquCENUQBUJ+fKKNYydLg
         e9wdGBdLOBySm9KdomD8DYjMGTjI2Ge+zMm+YNng/GiZBMm1JnYskCfr4JZIdo/PRXXl
         0vPJX3Dsmd547OhqV51Om2DE03m0hI5mGnivZYziJNXgsRZM2tlN2QXec0mUnXh0rLgN
         /7Dg==
X-Forwarded-Encrypted: i=1; AKwUvBzcjdwIwfkrE42okIgOz+RzZD0wgITSmksMqyMafgzN/t6+kYbGKxjiqlK729UzuqODNUM2kKL6LOs=@vger.kernel.org
X-Gm-Message-State: AFuF++l7tUzITaKzhpbUuOZEPQ9fSJrEMfd/oNuvmTxAEB4QWf7WeLgk
	FvIEKNSxlZW+o2dSz0SzpM7EDonvnkrZqd24VcKOeBVNbeG/68DSRBh59emX5/T4RqY=
X-Gm-Gg: AYBFou20WwXEFG98FUXtI+m52K8+3kgNcDm8IMV8z+2lCXzQW6wIiUYxKyRNzGq2EyI
	XvXx/REDk8OXqxLzA7126qIkrHqGIwuayKDo/fhvmiaj43fAO6dDe38KeBqURsgoodTq4w7xc+h
	wcRw23ura5/i06MWWJKkC57CiKKi75ngNV13Fjw3++brZxKO0bwBLCMb8Kr0Ik8E+wzgacqNcVi
	63mJECkmvttELh3+JwCUpQdqLA4aWJ2PMzgy+NWYbwT86BkWtU0TYOkxu7pofcyjokmjDGArvbl
	f2GIEJ78E/TKkH7BopHGsJ7QDxJJM/CC2XhwZ76SHaTLSOrYOL6sBOsJEwkFBfljisdDe1BbjTt
	Asy0do3UPb/vWJAFYV+JyEI+f2GSYNPpLdb1dLZx0Wj0kBqb10Jbqtg/qdyxtKnezj6BDoQqQuy
	YOM16CfPTPTkjz3Lfugv8PgzuIihPfbThVbFQZehxJm94FuccsslVmwRZ5qJkWdAV652UvJ75Hz
	D6L1/br/W9j
X-Received: by 2002:a05:701b:464d:b0:13b:975d:74e0 with SMTP id a92af1059eb24-14503f2ecb5mr605349c88.8.1790214344742;
        Wed, 23 Sep 2026 18:45:44 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14501794269sm2927598c88.8.2026.09.23.18.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:45:44 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 23 Sep 2026 18:45:38 -0700
Subject: [PATCH v6 3/3] i2c: xiic: don't clobber msg->len to signal
 block-read completion
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-i2c-xiic-v6-3-3a15b6397f5a@nexthop.ai>
References: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
In-Reply-To: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Raviteja Narayanam <raviteja.narayanam@xilinx.com>, 
 Wolfram Sang <wsa@kernel.org>, 
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790214340; l=2009;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=Bg5NkWAAvHyt3A3yj80XS79ACYShmuxSKGVO43oYPz4=;
 b=qFUA265qvuxhLpUmsONKjmI+890eW6TegPL4ejNVHCxg7BhwfRvUx5J2mId0Q73bl+JzaU3da
 kKnVPT0LVT0DtRfa/MazyqQI6uHZayGN/ngRyqxPV6aCXGvGTo4zlf3
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

At the end of a SMBus block read the BNB handler force-set
tx_msg->len = 1 to push xiic_tx_space() to zero so the STATE_DONE
branch would fire. Two problems:

1. tx_msg and rx_msg alias the same i2c_msg struct during a receive
   (see xiic_start_recv), so overwriting tx_msg->len also changes
   rx_msg->len. The i2c core's i2c_smbus_check_pec() then reads the
   PEC from the wrong offset -- buf[0] instead of buf[rxmsg_len + 1]
   -- and either mis-validates or returns -EBADMSG.

2. xiic_start_recv sets tx_pos = msg->len (typically 2 when PEC is
   enabled). xiic_tx_space() is unsigned msg->len - tx_pos, so
   setting msg->len = 1 with tx_pos = 2 underflows to 0xFFFFFFFF and
   xiic_tx_space() never compares equal to 0 -- the STATE_DONE check
   falls through to STATE_ERROR, giving -EIO.

Instead, advance tx_pos up to msg->len. That drives tx_space to 0
without touching msg->len, preserving the buffer length that
xiic_smbus_block_read_setup() already grew to cover the length byte,
the payload and the optional PEC byte.

Fixes: e4c1ff772e1a ("i2c: xiic: Add smbus_block_read functionality")
Cc: stable@vger.kernel.org
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index b4177d655cce..5d8492ed25f1 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -884,8 +884,11 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		if (i2c->tx_msg && i2c->smbus_block_read) {
 			i2c->smbus_block_read = false;
-			/* Set requested message len=1 to indicate STATE_DONE */
-			i2c->tx_msg->len = 1;
+			/*
+			 * Drive xiic_tx_space() to 0 to signal STATE_DONE
+			 * without truncating the rx_msg length.
+			 */
+			i2c->tx_pos = i2c->tx_msg->len;
 		}
 
 		if (!i2c->tx_msg)

-- 
2.54.0

