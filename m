Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0674A4839
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155166; cv=none; b=AMSKzhfFxGhFRsruFndhjjjVB56FL7F0Np9OPrgoJGbSCTDoM0itPjK/+qiCZukgIo+vI+WTJbKPGob5OB8LnulwQ0NUP3/FQm5Rj1CASnR3PjYw4CZOu6GLJrFNQvEJjorkph8Hr7NMIF1JI7+5c8pzgIhNfti8xnPb/BsUdUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155166; c=relaxed/simple;
	bh=B1VEVRlqikpPTMkVjpNttb8IvaJtjlL1JxMWlv+FinU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrpVQj3pfnF65rIXz+KcRmv/GvOki2KLEoUvC/Cq9pOX2D8ZTZiCUg+ZRYsGwjfBNvemghNs4XiSrOnxCjHFYY1dfXVJp48Avqtmh3+Oy4StOcU18BqyC6cKBqKypWmDGwSKQSQkX3wmLDZp4MIbV9d1mYgqBIo8fIrLDqgs4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5LdNN11; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5LdNN11"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c319a4a3c9aso120424866b.1
        for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792155163; x=1792759963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RdOHOeZUKsNxNoi/BkPDgmePe7PcCdsdpCL+vRvFalY=;
        b=j5LdNN11rjLwtpDyp3LeXExTmiGDfDKyv2DwfctVKW88VShDVO2c4hAsi2PVwhxwFe
         HMthaf7qXZJ5bz30TsaLEBM5fVaIp268fZbBo/8cvsK6znvmdnJSYKOfMxtFVP4UkT2v
         sAAUj0JzfFD/vS9JjeTb90xC2rxWGktRRE8e/iRuGQbgzbObVjB0kFic2430MOEtGbQG
         NovpUbrXxvoYT/TFmLVbW0c3B+Nn5pNLJi6CWqJxHsiNE0HPTpUJ45xyMm3G7VLja02m
         lQQI6FiOMbD201lHxvK3cG1sFGqHb2BUldQGPWsQvZ7s0J6stXvIlJUX2ksAoFHY2Ewh
         zLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155163; x=1792759963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RdOHOeZUKsNxNoi/BkPDgmePe7PcCdsdpCL+vRvFalY=;
        b=L3l4CCv4I4AES7Hpk1sWcflfxn1Onj4Yljd23atmU/755vj0Bc7Axl0xWiLNR2wzqK
         6+a7Xmmv3PIbUnEqWVPpQ1d3cV1/wDpo4U8AK/1Eh82Wz5PfwN8rc3S1ShTZI0EJ+49J
         rag6UJrOygcL/uwnT+cbCy/kRnGQ62z9WNKHRIHdAV3g7b1O69i6GzqCCXRhAwL9xG8K
         XK78AMtw5VO4xWMq0G9bjrD2C1GfqgW0ccK4/cipeOhPkfUK0NLaD03cXVZ8GuhWTITG
         cKbOktxE3WY7Ig0vPKJqFBWwQpsDhjBpcTmbIKG6oEJahU+uCrDPH8prnD3aQ+Yk3UKI
         hODA==
X-Forwarded-Encrypted: i=1; AKwUvByw+jNwXOT2ZlqgU83GZlHozCxsW0zvJzoccTWQPxEhiImVnh18ppCJlxy7SbvbaJhcC4bjiW68mPU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxSaFIxwcaSZNQj/IavK7ViLVuHGVmF7P8Bs9HLrFwOP3CjZl0
	g84RBsLAV5vgqvduMu/kH1EbnoCdnMLKGJITWpWT6crd7h5L9jheBFWP
X-Gm-Gg: AYBFou2ALWQ0prd1DeB5pQd1zz7MUp6SYLsxVyH7NuzzoC7igOj4qnohhSfIDJe1Ph5
	3ruoPAWq0dvw41GFs1gyuSCsOGF1Dt4Gv+bqYKN0+VqFJyJ07bFRABJV0G4eo2dz/uD2gi8Y1T9
	R7DwdJiZMpECXN9zsCizxDzbpjwlHpAjzAslfnITMZDg9P0CI0o9GYUsUtzfQiKjvLMMGsnrwr3
	4KNdDAVFrSghRPj4G3pN7GpKjMvRRSssYfxiyritT6Xkhb6NOwSj2INT6MXXkZFVIbHMyUGkrOZ
	IeJgQ5pFyA21orV9KMOek1sy9TTKBO5yNeZyfq2ZVgwCaLR6rcPhGCHsaAHdVz0xmiOD3lTysp3
	TSFCH1WspIsIXQadkNODQnz6rj1A0kz5teB1Sz4JsupsnxGdZz7F9JjTP0E9g3KjCNYgHFtfB26
	4XWazc1jjJFrzkE/3E0YiPaWwgVn9f/w5hpygHvjJmKLPvzwkZtrh/dFo5Hxxr5KuZ+rD2LXQyW
	HSN1H95ICdCpv9EkUGsIBtg8RUOqnPpyp2qKnt5Kc7UHAMJQfdpDYg8EnChvZZujhnq1vaCk1+R
	CB7d8ZblLWEJici5O2naFcVVGw==
X-Received: by 2002:a17:907:97ce:b0:c25:f7db:4bec with SMTP id a640c23a62f3a-c40205fb322mr271162166b.18.1792155163197;
        Fri, 16 Oct 2026 05:52:43 -0700 (PDT)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32876asm69433966b.10.2026.10.16.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:52:42 -0700 (PDT)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH v3 2/2] i2c: i2c-xiic: fix waiting/clearing while atomic
Date: Fri, 16 Oct 2026 14:52:29 +0200
Message-ID: <20261016125229.1798791-3-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016125229.1798791-1-thi.zirnstein@gmail.com>
References: <20261016125229.1798791-1-thi.zirnstein@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use non jiffies based waiting functions,
if in atomic context.

Suggested-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
---
 drivers/i2c/busses/i2c-xiic.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index e68e17bdf0ba..fc9a0628cb67 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -359,16 +359,28 @@ static inline void xiic_irq_clr_en(struct xiic_i2c *i2c, u32 mask)
 	xiic_irq_en(i2c, mask);
 }

+static int xiic_poll_rx_empty(struct xiic_i2c *i2c)
+{
+	if (xiic_getreg8(i2c, XIIC_SR_REG_OFFSET) &
+	    XIIC_SR_RX_FIFO_EMPTY_MASK)
+		return 1;
+
+	xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
+	return 0;
+}
+
 static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
 {
-	u8 sr;
+	int rx_empty;
 	unsigned long timeout;

+	if (i2c->atomic)
+		return read_poll_timeout_atomic(xiic_poll_rx_empty,
+				rx_empty, rx_empty, 10, XIIC_I2C_TIMEOUT,
+				0, i2c);
+
 	timeout = jiffies + XIIC_I2C_TIMEOUT;
-	for (sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET);
-		!(sr & XIIC_SR_RX_FIFO_EMPTY_MASK);
-		sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET)) {
-		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
+	while (!xiic_poll_rx_empty(i2c)) {
 		if (time_after(jiffies, timeout)) {
 			dev_err(i2c->dev, "Failed to clear rx fifo\n");
 			return -ETIMEDOUT;
@@ -383,6 +395,12 @@ static int xiic_wait_tx_empty(struct xiic_i2c *i2c)
 	u8 isr;
 	unsigned long timeout;

+	if (i2c->atomic)
+		return read_poll_timeout_atomic(xiic_getreg32, isr,
+				isr & XIIC_INTR_TX_EMPTY_MASK, 10,
+				XIIC_I2C_TIMEOUT, 0, i2c,
+				XIIC_IISR_OFFSET);
+
 	timeout = jiffies + XIIC_I2C_TIMEOUT;
 	for (isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
 		!(isr & XIIC_INTR_TX_EMPTY_MASK);
--
2.43.0

