Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9B4F85D1
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015147; cv=none; b=PXREpFV9dGWOhPbkWlyyZxqd9InMcpPUVy0+o2VIbYmBXSVCKliuX1v94QuoZbiCUI/tBBPK869i3Jgb749SBb5191HMIz9YdJj5rpCsDHmX4EZXMYdKfu5Aw+5Y+PCU1R0kfsvnN4aAOtguUPKdOKLPIu+s+ziC9KsWDHg3KyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015147; c=relaxed/simple;
	bh=3PrQCnt7nbZH4iGz2QKgl18h5LexXtxJs2Js8bqLN/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dz8CGgBUl4Aiw8kDfWORblLcaS13Xz3/6PiuUjqSC9OPnnM0G/c7Unkx6dwN36zArlKMJEBPC4iL02raOX4QWv1bZ+JyRVSuBjDfcqd83p15mKv5GEocV9fmX0cvUkOjtDXsub8CbjnUC/kgae0E37GoM9rQniKF3tgxYZv3Hx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=YeNDycI2; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="YeNDycI2"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so3659281b3a.3
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790015143; x=1790619943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bI4n9nsSaz78+BIYtu5OrBqpRPgWw2YHv3oM1NI7hyQ=;
        b=YeNDycI2+4f6RI3ZJHgpYqE16crQHERefAt/AwaHe/g9vPyw6/FMj47Z+iwFcBSz/j
         43uyyRjnB9kanAlAq6jGclTt0Y+RZmnDvqQK3Br+0eNfXczZcEE1oHqaYHcKEZHWfCPb
         bEoNYRyKDDoq4RxvScubIK3v+btx2NnomvH++7em++rilGP1yLhPEJm9IKyLOH3lFl8e
         FHsLyg8A9BItbuq8+X8Volc2f+oWQUXjIhzZqIyzPEzFN1HgWxg+PLkmJSV5nQZ1CByo
         iWSM1AX/TYvOWf1YPhfqucD3wErYuogSCXV8BMlCKHVDkON3P3O43Noo+/pY3DZNI6dK
         uNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015143; x=1790619943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bI4n9nsSaz78+BIYtu5OrBqpRPgWw2YHv3oM1NI7hyQ=;
        b=luiRaFOwenYe2QGWBudKGMqkQNVxOkP0RLDqUZ+f93WBmQ/R9hRIocppJZVpTnfgsX
         zJyaaG9t04FFL52OwB7gOqAjfHSCkJVOHYS0923jw2+un5p8ZaCBr78e0MyCOJO4aZMx
         VIAT0fGWxQrZ0WfNVXRuypGpXEASmU4GCED2DvdMr4USX2PixbBRFUkj9Ja2ZerSBV+B
         dKcaaNtsCvpOVBuhtuhD7itJR51orjW7vysHKuxuOtrXvQRe93emHzvB1jGfe3xG7S6v
         tUymQh/CsAs+1jiCV5FeS3SvUTnUROVBjWDsaTSXN6JmfCL8dmu8ry2CIgTJhi5yfFzz
         kQ0w==
X-Forwarded-Encrypted: i=1; AKwUvBwkN202AgJ5X3Vfb1A2B2B1HY4WPnJdj6phdLtzzrpoIJlZ/tbZxriVNbTWB9DWkkFSr5XvUM2k1Vo=@vger.kernel.org
X-Gm-Message-State: AFuF++m8avYZu+nBIBMf46WbKC+y7cBekYv4JxOxskVxdSxUY5tC4Va7
	BUbyL2/89EIpRgt8LTTHydlW54+Yi3aJtKso5B/EVGTW9rH60bZ7+TzQbGpyS/6/M9s=
X-Gm-Gg: AYBFou0wb9v/es6meA2sf6pRs1bwxKZgmFkWe2+EkAckY5LV0Rq6jU4qd4OREJAkCPZ
	J1RE7G/tVT6vmrunEbSNFughLWiVB1dGcrAVdVEG4HXI0HhkbA1xNMEFHIzIdQMxdewQ25Ap1I8
	XFGnGa+LB+kbCR3RKh+6vzFOV//+JPu2oykapDrs9Hx+8BBYScZiHJGRJBZ94uyYeGwGOGqao8/
	7msCS7leOiHhrowiCXhnyUL/2q2TIRTh0VZNgQVUpUSW4UbcBrwR9EP7PvfADgLKPXezkWBd878
	6RsDCNyR3Uy/xdY6bDl8sT9THl8jOOW9EkrGXBhPBEJZRSxS+1fHZT0E92DIPhCeCH9w9884F+J
	LN2NguY3fGNrWDoz5YJ7vXJDn5awhdeDWOFF1L4vZzQR/rfNC1j+ePTNHAcVoQICee+WCUO+5j9
	PUJO/wSMCfzHTidArBM11aTnLLqmZBRgkTK8hepsnZjYpj4TuBAyvOqr+M6VhHivM3Fm0WI9yzQ
	Rmw6yaJGZ3U
X-Received: by 2002:a05:6300:48:b0:3dd:a197:cf1e with SMTP id adf61e73a8af0-3dda197d894mr11470586637.66.1790015143079;
        Mon, 21 Sep 2026 11:25:43 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144df9ad683sm12408974c88.6.2026.09.21.11.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:25:42 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 21 Sep 2026 11:25:38 -0700
Subject: [PATCH v5 3/3] i2c: xiic: don't clobber msg->len to signal
 block-read completion
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-i2c-xiic-v5-3-2fca81e810ea@nexthop.ai>
References: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
In-Reply-To: <20260921-i2c-xiic-v5-0-2fca81e810ea@nexthop.ai>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790015138; l=2009;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=3PrQCnt7nbZH4iGz2QKgl18h5LexXtxJs2Js8bqLN/I=;
 b=QpYMk3wrZCPsBPJzi7e5IC/yKs9xc3WDRsvHMvbgmZ/JbIufqHEZJ+oMndO7RLskhkFHF8Dfm
 W10xBDmcpW3AiecVrKdpTJV3FKT6eEkSAmnb6uidqNVds4cIB9Kssiz
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
index 15fd17b703bc..d5e7b089a2b8 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -879,8 +879,11 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
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

