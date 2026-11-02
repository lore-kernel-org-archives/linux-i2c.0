Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611974;
	b=cJ9/PbnV6UdfdRnOlTnGfV77gWujAqs7iIY1gLIDRU4bIRX0J0s0ZtZoFxuLB1kNKc3v
	 C+zH5huLOgOlypTWAxUE/ACHMTw8md9zIlQ4mSDbp8MHcMdSkX4WocujRghmzH+bh6bnb
	 +FJMxt8XerAPRc5LiGNoZiNHAo/zJkBIBf4A5PooxO8YtvduLnKf7rogXGD0PyoqznLeZ
	 nrIlRCj+f2xEVLgPjKijb+zX5/ody63CNjaPMKhOaWYafDCWOf8nbmXGjc1K8HZj6F0MI
	 6lZt5qJKhnS4eOfKa520e9Fdy57yf6mjm9GNpTqV7flm6xgB2tWFWi0qNgeaUlq3zvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eX+gYgE+oCqAhhfCHZGXtaEXZcvdSf5VXn9A/wbFEZ0=;
	b=s4kl/P3vAk7Awoyxvcf3acM3MyP/oJS8Fzx0N/RPp3Ozo+/XQrKAGchs3eykYLoVIWfq
	 0PkQgVsXVftF2fEOw0yfMvI+ohWG4QmjyzlKKW1gJJRI/DP73kAHWSEUMwkUVlmGYsXhx
	 pOwENdqjLMlcYy3oI32WUiWHkhJHL2Tiybj8j+XkQRfNtBHc8Osvromip5KcOasRP5sDz
	 shBog90YKwY55UukD5TM5JshqDXEAFJ0EttVbHsjsF5Co0/CTR5AqANObCMaiQ5JeuNvY
	 aonG2KMonfNq4QurKjB7CBFDBXBV9u1DzXnTJc86qNwnK3/R43jrRUyhVYMHMXbUjxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xZcN2r9i;
	arc=none smtp.remote-ip=74.125.228.72
Received: from mail-ed2-f8.google.com (mail-ed2-f8.google.com [74.125.228.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039E606A337
	for <linux-i2c@vger.kernel.org>; Mon,  2 Nov 2026 09:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2039E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xZcN2r9i
Received: by mail-ed2-f8.google.com with SMTP id 4fb4d7f45d1cf-6af61a7c893so743940a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793611972; x=1794216772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eX+gYgE+oCqAhhfCHZGXtaEXZcvdSf5VXn9A/wbFEZ0=;
        b=xZcN2r9ievYSpEm95jkBkRFxV04MOndzBITWcUHrPOYE2XmKvBy6oZOXZzzkA3uT+L
         spNxsW9mqXFhWfvhsXkoVvi6GLkJPWPHhgDlA8a6IqUVhQT8cuJyyKxMg/YdE67W0uHR
         VKIwAy03ByUGj92NdfeGVCbHGwwtJhbR2ezq9lXl9YEgRM9ztFTRqFSvZVqpA8aO97qh
         eXC8K1O+d9A/DaczOa4VJSSFe0UsDzI41af0SBrQsxJQidBZC948KWdf2BfOIkeYg6PY
         u/7zldp2slK4+vRiTy8Hw2gnbPDoMCpKbW2Pq2u+9I8jqXS0AXdEo+wlqCXthCUXEnZv
         nP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793611972; x=1794216772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eX+gYgE+oCqAhhfCHZGXtaEXZcvdSf5VXn9A/wbFEZ0=;
        b=WCj2Q7Q1kVH58sNun0+WwG7YbSlEnW5DFnJ1b3xTRnFb1fKgov54ZFoLKEyKPYZQ8T
         IajeRX8fiE5SgR3xideKrW8F1OC/3ch8WSMhWYbcWQElI/0CCf5VgeAlTwuxp4Nzs9hQ
         N6uJnD4cntYr9CSXoBwJm53NKTfKSuBvUyCB2cxd8nSHlKX8grkMxkZMmcuRPMmTuSHW
         AT0qz2oBvYLjP4uffJvo7RHus7QwjAuf+EQ030+05LD9bsK1sYshpzmAYNL703x0WnBY
         6Htja9WVa2aoRKvnakW66i3KbvZDmgl1odgvgEduuh0jfFjz8I7J2Zdr0qPJxxniYZYH
         kR+Q==
X-Forwarded-Encrypted: i=1; AKwUvBz3loAhrhap6Zv0aJY/p6vmE5OWeYpZ7DfDzYdCRnD4/R0UPT9bD0wyUWSKzPqTQ5Am4aEahabuEpY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/edDtlx6oFv6A2RuPIsv3+ney4Pum7vfqfgQKo/MI6zD3ry0rO
	Le93PolsW3zh3U+He4+DqRgvp9MDdePVDDw3Xu3Kt5fMvQz+jnVT+E6DWSRM77FD
X-Gm-Gg: AYBFou19st9UBUb6HVlOFepZWLn3iYJUIoS3pp+v4waPKu5ELOcdQ6pEG+vj738vhet
	qCrDskr98h0ykbKd6+UMG2P90rMAKMrn/52AtJlxUMUUUCxcRl5da03vuNp8LLOispJIwt+R/kE
	LsEveVehgc6fKfCpbptDxCxgI78Z26iAvGaYklcAUrF44eIFmojtqRj3n3pDCaOBxg5Bnnc/wk1
	Piih/BpylspMUcAnCickrpfiFEvSLD0GPbNAHFYL8Pr+Ip62Gw17UCef6YqMCA9ZIg1TNJ/lNcT
	JHPSJXCYXd21mo9QwzSBzfBbLz3dOughiW2SBGG74CjKxmGFXnmjO9Sik3fuT1tqm6VPQ6n3zY5
	4oRLDFJEqOGLBri8CHgK4EiL3rXrGud2E1vbt8xCiP5OdID+toxgUwDrWmXUl9xQsF1unheTRRy
	y+dTVx/KJCA+0holr5biCPi70WYTppTNdeTLKCOdf+EPV/IjhV/Fm+3YPK07BLWgPdKuz4nglPS
	VWXbiHsyWO0pyKEdvQuQTsA5DFbOS/CHtHOXn359X6LCKU2l61EDnyo6ZQopyJTM7KDWe+Tb54u
	ZcFYWuMg6vylCtP1Kld++ej3+Ton0zQBZc9M+ig9UEdUHCGvAEOULKV7XeiyyNfYaHTeMP7Or0f
	36fPjucJKoOABkEyinknLKk0tZhn+8CyLQEY+KT9UYmyacPxRg/AuwNkr
X-Received: by 2002:a05:6402:b26:b0:6b1:ca87:c588 with SMTP id 4fb4d7f45d1cf-6b4d4d74c9bmr4790145a12.37.1793611972469;
        Mon, 02 Nov 2026 01:32:52 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca0f2a0sm3214273a12.25.2026.11.02.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:32:51 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH v4 2/2] i2c: i2c-xiic: fix waiting/clearing while atomic
Date: Mon,  2 Nov 2026 10:32:28 +0100
Message-ID: <20261102093228.2751576-3-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102093228.2751576-1-thi.zirnstein@gmail.com>
References: <20261102093228.2751576-1-thi.zirnstein@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use non jiffies based waiting functions,
if in atomic context.

Suggested-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
---
 drivers/i2c/busses/i2c-xiic.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index e68e17bdf0ba..6bb8d66e8969 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -237,6 +237,8 @@ static const struct timing_regs timing_reg_values[] = {
 #define XIIC_BB_TIMEOUT_US	1000
 /* timeout waiting for the controller to respond */
 #define XIIC_I2C_TIMEOUT	(msecs_to_jiffies(1000))
+/* timeout waiting for the controller to respond in micro seconds */
+#define XIIC_I2C_TIMEOUT_US	1000000
 /* timeout waiting for the controller finish transfers */
 #define XIIC_XFER_TIMEOUT	(msecs_to_jiffies(10000))
 /* timeout waiting for the controller finish transfers in micro seconds */
@@ -359,16 +361,28 @@ static inline void xiic_irq_clr_en(struct xiic_i2c *i2c, u32 mask)
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
+				rx_empty, rx_empty, 10, XIIC_I2C_TIMEOUT_US,
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
@@ -383,6 +397,12 @@ static int xiic_wait_tx_empty(struct xiic_i2c *i2c)
 	u8 isr;
 	unsigned long timeout;

+	if (i2c->atomic)
+		return read_poll_timeout_atomic(xiic_getreg32, isr,
+				isr & XIIC_INTR_TX_EMPTY_MASK, 10,
+				XIIC_I2C_TIMEOUT_US, 0, i2c,
+				XIIC_IISR_OFFSET);
+
 	timeout = jiffies + XIIC_I2C_TIMEOUT;
 	for (isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
 		!(isr & XIIC_INTR_TX_EMPTY_MASK);
--
2.43.0

