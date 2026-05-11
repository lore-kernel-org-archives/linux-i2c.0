Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DB3A5E7B
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485596; cv=none; b=L1tAbF08gOzam1c+EEmlvRqMhmrfBJy6BLzFcSXP4e+qqb639oWbbQo+bTky2UqCYNS6PJZe9AQ/XPSp+Cm7EcB2w8il7OhbxwtUZ6gGRAdT2KwMUV/Kpn9Rfpv3aK+mGToKm0ifvvk5+zWaEKkoVaTGXrnEkA/51530NWsENhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485596; c=relaxed/simple;
	bh=YQInRzCWVXJBbGUOGvO2DPhTx2lGcEJzvpRvFC2WTNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdJKsVjcOH45y9Zrq9gYul1h7ndBXVJKIEQxRIz30ZB8lRrmRLFTU2GYqZj6yGufaoPCNMZ2BTuVb+GOFbBBpNB+yn3sxPS7azV57yurjMwXgcOH9UKg9zzGiA1C4PyWEu/LE0Qij06fMuv0Nd6dAFsoTIW+iQdqL18czxzpFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=fVNW3/Ip; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="fVNW3/Ip"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6881718eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 00:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778485585; x=1779090385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIDyOEViNLE4KPweGmgFctKJ5qfBRnVS9bTwCoRCqcc=;
        b=fVNW3/Ip4sFUdErC7HVZXaqwKSGSzla3LwOlXhvX9LrWvPoy/1/Y9iaAYnn9sl59XN
         0iFZ3xMC1328jj/oNbW5//CsC4/lNXpFF9srlEbsGtwyF6tAX5AHX/A81C8vCmr6XMoj
         mkv3sSf0bX7+Ae43gW9oNJMbdv3yNXajY2d8YFAvZgVALAhefNLetpeSW4+TnltMUYXE
         GqCwoXIvMsnFvKhLAqmy8Oj0CGkJhqIUCnYozPQTtcbKNLWHR1CIvohs2xmDQ47nA4Z8
         SuzycaIKIjKFjxZ8O2m/ihO/lAX2HwlDoQzqe4H75lxCsspwskutCI8VlXpd46OHS3Q+
         zUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485585; x=1779090385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIDyOEViNLE4KPweGmgFctKJ5qfBRnVS9bTwCoRCqcc=;
        b=KvJQRKcnIxu8zrTU9ROhwUP5P93W7xu0dt4wA5ryVJkvEILVC1o3EJff6CgRJsUqxy
         hGIrNiZM6hQfJNM0EVIcJZvI53t/otpzPukodT04VircRnUpASpsKfUsvh1F437cxSjU
         SIcNUgiQPLCoouvR1PzmH+3S7F1vbEZTlt3UfZNL1/812aApGcD8UQ6bQgVdQNwLC9U6
         vdloavVNavAQ3MRggz7WCFpk9k0rWj4nQzGijY1twvNgwSZatJv2dRx6jwGNmIp0/bbT
         GQ+u4K/noeoUyUSjRor/T9sTw476D6zMscUzyDhzLI24LNiGs5eDHWh45VmflUelJMMG
         CVVA==
X-Forwarded-Encrypted: i=1; AFNElJ/1KwgCL0Oa3amDsX0T8J5rDKeZ5vY4LNtPtVQOx3/0x5ViF397jWIORNn/7bs5/YCZVFwiNmHtDog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtDWfuxPu7jXVfaOON656FYyK8AhlLZUA5WaAMzBE49Nbloqt
	LRAkVS6MkJ2ils54UigEJjfMSxgw1A7PaAtaJiAHDgkFbdyCy9OzjgPp0GbA09Nq/5I=
X-Gm-Gg: Acq92OEdeXNzAyhyMpSPfTm3BK6jDub483yf0DtoKqbXjFQUnpbAxjW4TFhbwR8Kzru
	zHEwP1E/kr1pY1eAOyQzwPthUF23XL8plsVNC90OaFT1ARsracJjFa9xL2wXtCVK83O1PWkIQvo
	i3q/ZKujLq1mGjkP7fxBMzKuvw/6Cw+UIBGnSHksWl3743Wuadb+Got5+S4FpDowQPxg4ctGqSN
	KN3vEXuGetrQZ2Y4bo3mz5QOjI2XJdo85FZFzYYBniueocxML4JLtAX8xynflJA84owJcLuG9EI
	nsURP5M4++OKBfAB2KYhiWcmz/V8yYmkOpUgaJlSIQ+TE/JOFBzquGCHam7vOyG+tJ3/lg1pRe3
	I+TVSXt2Q1ztjJJbbzu0gAwhh31Hdds4wmLkZBnAbMrgJGroiCyWi1rJb5iwQ3CUzMCs85CyIiA
	VLsUOcdb6xoeoarYgN0QLrJ6/p5Q==
X-Received: by 2002:a05:693c:2c01:b0:2de:c5ca:c1e8 with SMTP id 5a478bee46e88-2f54d696d50mr10433842eec.4.1778485585334;
        Mon, 11 May 2026 00:46:25 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm12205702eec.26.2026.05.11.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:46:25 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Mon, 11 May 2026 00:46:13 -0700
Subject: [PATCH v2 2/3] i2c: xiic: defer RX_FULL until all trailing bytes
 are in FIFO
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-i2c-xiic-v2-2-c16380cb1594@nexthop.ai>
References: <20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai>
In-Reply-To: <20260511-i2c-xiic-v2-0-c16380cb1594@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778485583; l=2814;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=YQInRzCWVXJBbGUOGvO2DPhTx2lGcEJzvpRvFC2WTNM=;
 b=dHsiGR14XxL9FvZ3NefbWYmUQ8oOcT+goVAwocjGBRlTlbew/67kGcPRS7gfnnbVhFNbdSGXD
 3xPF0HIIm95AWgaRGjDwtxs57YOhEBTVb42qu8U6FH7RXHBH/uRdLSE
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

For the normal path of xiic_smbus_block_read_setup() (rxmsg_len less
than IIC_RX_FIFO_DEPTH), RFD was programmed to rxmsg_len - 2, which
fires the RX_FULL interrupt while the last payload byte is still in
flight. xiic_read_rx()'s bytes_rem == 1 branch then sets NACK on that
byte still on the wire, truncating the read in the PEC-enabled case.

Raise the threshold so RX_FULL fires only once every remaining byte
(payload plus optional PEC) is already buffered in the FIFO. That
routes the drain through xiic_read_rx()'s bytes_rem == 0 path, which
reads everything out and emits the stop cleanly. For the non-PEC path
the full payload is still read out through the same bytes_rem == 0
branch; the only user-visible change is that the controller waits one
extra byte-time before servicing the interrupt.

The deferred-fire formula is rxmsg_len + pec_len - 1, and the RFD
register at XIIC_RFD_REG_OFFSET is a 4-bit field. Widen the
chunk-vs-defer guard to (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) so
the boundary case rxmsg_len == IIC_RX_FIFO_DEPTH with PEC enabled
cannot write 16 into that 4-bit register; it routes through the
chunked drain instead, which already caps RFD at IIC_RX_FIFO_DEPTH - 1.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 959a47b645a5..a9452eca26df 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -542,10 +542,11 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 		unsigned int pec_len = i2c->rx_msg->len - 1;
 
 		/* Set Receive fifo depth */
-		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
+		if (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) {
 			/*
-			 * When Rx msg len greater than or equal to Rx fifo capacity
-			 * Receive fifo depth should set to Rx fifo capacity minus 1
+			 * Trailing payload (data + optional PEC) exceeds Rx FIFO
+			 * capacity; drain in chunks. Fire RX_FULL when the FIFO is
+			 * full and let the ISR re-arm for the remainder.
 			 */
 			rfd_set = IIC_RX_FIFO_DEPTH - 1;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
@@ -559,11 +560,8 @@ static void xiic_smbus_block_read_setup(struct xiic_i2c *i2c)
 			rfd_set = 0;
 			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
 		} else {
-			/*
-			 * When Rx msg len less than Rx fifo capacity
-			 * Receive fifo depth should set to Rx msg len minus 2
-			 */
-			rfd_set = rxmsg_len - 2;
+			/* Defer RX_FULL until all trailing bytes are in FIFO. */
+			rfd_set = rxmsg_len + pec_len - 1;
 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);

-- 
2.53.0

