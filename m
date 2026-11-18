Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996738;
	b=QX3PAjcJSR2IIxMynsTZsv+GAbRBHFHh7fwmgYIFSErX1aeEy5JnIfgQDSsIWLJ7Z6pa
	 PVnKWuALBNvUaRwxm3m+oUkSDLnDJzDRb1907k3JGMKkI8wDRJ8PyeBCoJVcgPUApwGbK
	 CmPU6Z45LLJcvuY30y5XWwzt5o5x+qhrHibLFfdlYrjEP2MSRTPYFQLmusrECVrGkyPFX
	 72Funk3LwSD4qE+OeakQ597jrcT/ByUSqwflb3CpSS6LTUUnB6v26HjxtSlwutzyeDLYa
	 rVzuWTXLt6yOOK/1Qk0PsGlcCBh7hk/6gThJAay74W4U7jg8fM4JT/P+CbdykfuX9wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eX+gYgE+oCqAhhfCHZGXtaEXZcvdSf5VXn9A/wbFEZ0=;
	b=mkL9pk8/sh9z0+9RfRQ0en0dlExlR9Vi9Kh5Z6KRGhXm2KakI4+dX6iEMQ2z4adMYl67
	 WI3GlTLCkO7I5GH2nIj0vcKHCvKI6Zxk7ptOoeYzJhPbqqOIeyCOLms1iiXkEU+BRarvo
	 htwRfgru3CU3rppu2oHDhXX1tYVXEHivjX+e8TKEmF6s/YXoJUyMK1B80f30qoD4dQ6lB
	 4ALNbUVn0YRlIeyBYvwf4aqLBVC+cddygr6b6sUkPZ326K5/IeDiS9kx/xcxiy0BdsZl0
	 R+6qcOT0uN8AjZ0RTPPy1yv/ootIZfWnxbshBKxgmIeV2lpR6K/iELXGZo++SaPC7lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wAmvKmgc;
	arc=none smtp.remote-ip=74.125.228.74
Received: from mail-ed2-f10.google.com (mail-ed2-f10.google.com [74.125.228.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE552606A880
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 10:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE552606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wAmvKmgc
Received: by mail-ed2-f10.google.com with SMTP id 4fb4d7f45d1cf-6b85f086202so391028a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996736; x=1795601536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eX+gYgE+oCqAhhfCHZGXtaEXZcvdSf5VXn9A/wbFEZ0=;
        b=wAmvKmgcySfA1/6DZJLDxhW3fn61N1O/dX1OSSFhxKQfcArXR7Fg7+74pdtKc8+tOH
         cGhzn5eqKIolmDUnaRbHZTC4jKq0NuYg6dBKujlrZYSsDcl91gMGcRlVDLrU+1Ahsu/5
         zaJzROR2qS31KdMQdohlECSGcH9GBkLjxaIpD3JBmvxY3MqNEG0TmieYc8rs11vNZaqW
         XgeU98Z5c2kVlOxvsFIb60KzKCtb9muNDFLLJ80p7IEIvmbFwkJqsLD+H+R2/lBAfcLQ
         icFOPhqWd7HiWuBmfgmAzIn/3siu5/889YRPC1su2uDn+Ib6mZPVf0VfVCcr4pYAoVPz
         A9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996736; x=1795601536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eX+gYgE+oCqAhhfCHZGXtaEXZcvdSf5VXn9A/wbFEZ0=;
        b=kIFiT60+lh7gdQ6dKF+gYDbm46g8Ldz/CE98UWgtG2vbZnHkfX1pZ+HyqYPnJz6Yw7
         DxQIaVQuyNsVPG+1YJAFoPwlyTQFPvzTc6vKLPsX7TZYetktae7L786lBPOgEnRQ3tnL
         LqC0sMRp4kWot/inp4ArqitoDfLtR7ow2g0QluywULVUNUvcU1fndBYpVckOUS5zl5lV
         3L+5+moCdZx4zDq93Tb6keIa0dcX7jSknp1XS1hr2o1kzyCuxqKcQcCOOtZVrQmLlbN1
         jN5GEPtFLluWXONlp1XVg7bx2/GSDwVqjjJ8j7KJ2Yq+JRloI+mhIbi+v4DIW5ZOFKVc
         wk6g==
X-Forwarded-Encrypted: i=1; AL+hErHAb7xRegmg/BpkApoNG6c1jmmpfbaDKvAgLNgSQvhx3egtijlOhw8kdfDbLMDNUt5BtiouqSoGkm0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/onAh2lYQARKIzTQgkIuKqvIO2bxfFA6fw/9PVAvCUbCE1xnpa
	Vh+EJNAuq/cszqSnQz9YBdVb+jF8CEcwfbsEh88A3/6DdLzye3FJp3kp
X-Gm-Gg: AYBFou1VOQLoT1Go8YtSkJbJswU3jxQdPHo55BCTPT0/qMM/9zELWc7+u0J74MUkHUx
	R1xs6XXZa7knpXt0YfqekRckFUP5zRlXUcv3ybf96Ns+pAgdkwCtkXGgMrDf1tkmeHKDOM2cdY2
	cJXdNkpj6HDRAhdutl9vPbZ0IfLUBFSdwwxs6htxDGkFvuTZR9iyb1t59wwtS59bRyMV93J/iEE
	UnJ2LaFeyLGYJ4K/JNlm4NwTozh93iUuIEy3XuPSpj5/ohyqWWGaL/OlfofiaN44Fn3S1RCAmGI
	Fz0BhyEwO3DcIRwBxavABA4ZCC/uMThkHrjv/gHe29m7hfPluT4iLCDWXmJGGMrfRKBJ6R+DZzd
	vlYRKAjfGrz1Mao2v3Vl2Cx7rDgcninHDZ9vUGzfOlOsexduxih7Ahrb5VCiMs1ijhLRwbJT0bg
	dL8U+5A6kfd/s2oN7AUUQYmF8kMPH3O04WkKFGuaoYZ2F6JgRHXtiZ4uamiQP6TsJa2iKBudV2b
	Pw7A1oU9vCEES3+p0ownpsg6aTj8y3PokvZebju9oLgGORE0H41p6ROOARIUtSdjLw4U8pwd5mO
	7Azh5rf0+Us5qseYpXRsAYta0cvahda40VD1qsMeZovIu4QtLqkUkhJkccLXxmyfr35f6XMozKT
	PtDUobxVmBsIbJiqV7jALZKWTsrU8pnm+f30GgFocvouiyvYEnTGE6G9c
X-Received: by 2002:a17:906:f5a5:b0:c46:6a50:40c2 with SMTP id a640c23a62f3a-c510e5024c3mr167941566b.39.1794996736224;
        Wed, 18 Nov 2026 02:12:16 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f332sm78436366b.7.2026.11.18.02.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:12:15 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>
Subject: [PATCH v4 2/2] i2c: i2c-xiic: fix waiting/clearing while atomic
Date: Wed, 18 Nov 2026 11:11:47 +0100
Message-ID: <20261118101147.3350796-3-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118101147.3350796-1-thi.zirnstein@gmail.com>
References: <20261118101147.3350796-1-thi.zirnstein@gmail.com>
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

