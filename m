Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A73939D7
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666982; cv=none; b=AtuHeXQJ9qHGeDnsX4NhvWjBFoc7GNPlh8UsgjhD/9H6Vq0Kz+nmJv8r444rAeRM2Dc/OlqnX9ps/b7xlg2MeAdxnLl/WeIBqbS1XfsdqJdtQiMi1esWgkcBV+9J+oeetVsL4XXer+2aRUab5qydIhXf3UhhPzxh70tXA0QdcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666982; c=relaxed/simple;
	bh=WXSe6TYxSA7cz0PPKHt43EUa98Bkkw8i7qMhYy8i0xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRrIsm9pZjNe40YOz63T/OjBAGqJN37UJDnFmqtwDzNrsaUAC4axJ1B7oNjktBNLtosKZb35GIoAm3MNMQ86RFlba417DetjfvFW68VXB0sbPBOUGEPKRPX3OLwBooKMRDGMDxNqveDbZNpdn8zU/Z8FNu/E59xpAlmR0RHhB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=lEfbOyct; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="lEfbOyct"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c1a170a50so8970418c88.0
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778666968; x=1779271768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8Lg0hsn02D6K83qdccj9lMg9u6Gq5mDY/7w097Ma/I=;
        b=lEfbOyctJ0RpVtHm7BMAMnR65q/sSl2sURS+aH/dziXNYI6Y1Qxgl4/8MqOvrOzxD4
         I+KJWCvINiLvxifkx/uSPvJwGDtHVqKpN6A0u1PM0bQ6wAUvtSsQNQC6eVmncstK+m5Y
         vQIIYj30C3730Rh7rkU8L+F1HJivfbWMnzg24FKavU6dalljuHAj6hsk2fAMOBuKbDjQ
         BZ9s2CIbvptXguq1yoZ3ZyVCJRRFozRMaGFJJH/9rDHa5n1wTpvTsKEcLy5zcWsOC234
         rPoKsqRqXHy3lWzHfT/bJygStSJTqoo0oeeQ251Ak1Y5DYoPKqrI2kHMm424jPFoPh0/
         FeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666968; x=1779271768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w8Lg0hsn02D6K83qdccj9lMg9u6Gq5mDY/7w097Ma/I=;
        b=AAX3h2OHPWSKUY6rMAikbR7lBtOoYdUsRctMsg/DMn5nSjGQ7uENbYlEHI+AaK6vUl
         wEycF2Q8SYo1AvNL2MdeABjUBTP5x+vbhioMyqzZae80Nnh4I7HgxfVxllItTVqb33D5
         tRnaCz8LQJ0jOeSzzXktAMiK4HAJpm+WhicmKEnKY+1ztcVSspWVgdVplRoTRAxxkZe/
         swKxwoX2pQgrcDUHGw5v07XfI1V7CPwQD52pwsdoz65w2/OB/WyAopcb1gEPb+vXiOR1
         wkItFfx3IEEWy4bqjyrS4vs+30WeNcq8+n8rGYdKQ6BkF7dMbHa1pzKCsdsKKn5j0/Et
         4yuw==
X-Forwarded-Encrypted: i=1; AFNElJ9IWTfg05fqPIFK7TFL/jyMxs+VrJCLY44ogeiY3oJQRC1UcSFNZFiILtvKvIxnmTj9Nd7kXmmj5L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5uSJ4BCbUhEZMOwr6hFJoHgADLEVykEQZV/o6j2ashMmo1nGV
	8xqPrdYXKOYy3AovzUVGtebLW4aA2Ua3qY9StwkSUsq/K9S9jcdMJtZSBP0SujEahw4=
X-Gm-Gg: Acq92OGQEgurCdajKExQhTj7Kcd8Iakbc8Q4dSbsl9gf/Ydbf8ZDfbUD17WzQ6ipHCW
	Sqk2T8nV0rMyrSRUXNR0RGsb2psBOHkuZKPPJFyxLqBjQ+4jDZuRbGCtipUKX0RA6wGzHNcBDCF
	ez14yiT1t9GmuWPbDHDRVJg8nJoGi0+0XMI/lGpeqZrT6WzQujtsAQYf7+815/IfinBp5l7k2EB
	jA61zv8shUYU5SYcDd55+95ux9RB7VNusQAwL1KE6FpW0MdzIEfplXqNJ6UX1H7ZJ1Pu/2GiCNA
	UlkG5efhToXZhcI1cQQgEIqeGwB9AX1MtBOt/gx+k0nIOqgi9jk+KnEWBSKCMUgeieZ9blSMQWg
	Rqwa9+joUX/5DmTMhmg//cCKsctHeVh2UwPDeNz+GYEPo5wx8UBwbOs2+2RT0ZZUj+18tlYLFic
	PyGdeMOZl9bY/8KGV8kyCWzFNtPA==
X-Received: by 2002:a05:7022:6708:b0:12a:6c4b:9cf0 with SMTP id a92af1059eb24-1349a703b16mr1350615c88.3.1778666967710;
        Wed, 13 May 2026 03:09:27 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm29430265c88.15.2026.05.13.03.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:09:27 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Wed, 13 May 2026 03:09:24 -0700
Subject: [PATCH v3 3/3] i2c: xiic: don't clobber msg->len to signal
 block-read completion
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-i2c-xiic-v3-3-ccb3cf70ba03@nexthop.ai>
References: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
In-Reply-To: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778666964; l=2230;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=WXSe6TYxSA7cz0PPKHt43EUa98Bkkw8i7qMhYy8i0xs=;
 b=WGfE3HlylYu1y1xmIHtQZzvpw9th09pMwA0Y4vyVl8BGkwjAtyUp96PqN67x0uuiupEKbK6oz
 R0jz1Y0juSGBFyB35Ui/ugENU02Y5ivWGOV0+/Ggo071jjetC7yVmGJ
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

Also clear smbus_actual_len here so a subsequent non-SMBus transfer
does not see a stale trim value from this completed block read.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 2bdba6c0931f..8eaa411411c1 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -889,8 +889,17 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		if (i2c->tx_msg && i2c->smbus_block_read) {
 			i2c->smbus_block_read = false;
-			/* Set requested message len=1 to indicate STATE_DONE */
-			i2c->tx_msg->len = 1;
+			/*
+			 * Defensive: reset the per-transfer trim state in case
+			 * the rx phase completed via an error path that
+			 * skipped the trim site in the RX_FULL branch above.
+			 */
+			i2c->smbus_actual_len = 0;
+			/*
+			 * Drive xiic_tx_space() to 0 to signal STATE_DONE
+			 * without truncating the rx_msg length.
+			 */
+			i2c->tx_pos = i2c->tx_msg->len;
 		}
 
 		if (!i2c->tx_msg)

-- 
2.53.0

