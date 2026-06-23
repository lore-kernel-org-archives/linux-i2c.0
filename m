Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF083A7F69
	for <linux-i2c@vger.kernel.org>; Tue, 23 Jun 2026 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193658; cv=none; b=m41Qq2e2/3awED8oVxdpb/+pfEcXTvZk1RvMC54SzuV8b4K8usgWtaglfqTeHroH+LfenvgXRKewnCbzZZJdcqgujIftWT8yzu5Cfg06piRSss/+aM4Ay6A0ASSxYG3gDK8ieN5vQgRCbNrlZ+VFcI0QUuXOoCzEeQ+h60UY9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193658; c=relaxed/simple;
	bh=mYtIyNfT5VfpHe3MUf+iAsvxxfqV6WV/ViuGdha/rnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RaJCa/KSnx6VCmwrE0tpdkgtQxS6RvfG3KT1hiRBKiaTbqwckD9DPNlklla+FeYNUZ65R0QW7t6TkyNV9eYtn3YkEuK7zX8xCnpgsBe/aJGiVTQlGX5Hx2sKhlAqlNnvwbhRHFUW2uDYyMO0yJgfyCbrj7uKZpQrnj9vFiDr+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJcbnvLI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJcbnvLI"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so2849253a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 22 Jun 2026 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782193656; x=1782798456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sRMU+kgRpHS0jEZ+Rz/PmPVUD26Z4UtlWktthJUcyQ=;
        b=iJcbnvLIZMkeBi2+4uebNrz21N4y4G1OH1iUWIEm7v4CM6JdHLAdyCEfb7JCS08r3X
         Qg+viEiqGpKY++vxjQF52J4XQunatomD20Gp2f2PNnhSzFc40P6nIRDkGF+VnWFknFNh
         /MWjIHeuzRgtWFpulvPN3W/IjkANaydTjMfqOOTZiGV8zkM8ru5R8HFEOn7Sp8hUh5Sh
         LhT8/isDM80gRlaFimtJh8ILg+4DTSiLY2SJopn2R2G1LnkBgmuA/HEFPcH4IJW5mheA
         OKh3MKLv84jz7aI4s/JvqpGOp/6aE86iVPOXEXHSEVnUM+jSP9DUpXUELqgmpqdZyShU
         aPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782193656; x=1782798456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1sRMU+kgRpHS0jEZ+Rz/PmPVUD26Z4UtlWktthJUcyQ=;
        b=FGZxLxz7WGCMlBV88vY+8H6EVBhV0XoHppGBb6ZprSjTG+t1q4Rl/GRiXNq3OOp1VQ
         z/zS2ewmX3CH3SebQt8nDq4csXPq2F9eGYMn63JaIt8n0ZpCH6duvRZBJdnm4Lq6IpW2
         9zxG6hz8jWwjRJvaRwVFM+NYFMB/vaNSxdh+rGVz1VM/Jg3JNLUOgMxBi/pyRWK2JtBC
         OCYWGptrN+Bnsr2dv71xE04KjwE0SoY/B4dDjnT12Ouk3/N9M5wj74UHTcpYPpFt3gZc
         g0LzAhClINJqqc8XKRuInn3OfQGX2vPcJQrd4I642vfZkqFNydbPt5+j7FlPZ4ZSScj9
         cHiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYfGeFKUlpqHoQuHmKOWSby+kK/g5lheGnHqOX4CFHCJysKSlAwjnmSwMd9JNzXOORbPJYQvbb5eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/1Mt3JsoV2U8rU01rvdRpn7Ne1qQQtPoLox4dCW5KWYUxCkS
	/bI/P2NMZOLRtDP8GQGnfLKmUurVqqDm1NkZOh2BeLpb86FNdgwsedZp
X-Gm-Gg: AfdE7cltRlPM80m1HyjH3uPwbx4W4XcSAr0iJU0iWWxAygdIcVymaVxrYNPWCSegbA/
	YB7evGT6SUMJCo1N/Naz/vNMahJeGQdn5BE0qrQhcoSGVxY7Fb2TLJRi8WFthaLuVtD843cB5Jr
	SpJAH88iJuuW0tIBTc3Y+Wu+a8X3ytMf8tJVx53BDVha7f3e4LMplNkt8oV5VZYE7wFr0acTyPD
	hUHCVSDhL5+Uax+oCY/1BEcF228wAC8GPYdAqKKFeYheqA78uIhTkMD3iTq/mpSLNMoSJKwyf12
	tQNcSiQaIx5wk7pGop60QUd6oS5xqxRoxKOZb192JZhuQ1pqoGMI8I/+C2HvoJ4stwP3ynbHGj9
	6TNZAKrHIkpIWfgPTxreHYIwkOufmt+dWE9gRDr44Zhtt6Wn50vLSuKfbz3K2lSDkS4IjO6fLL5
	Eat3qLmwsfw6c7OYvQP9wJHJvtBHZKvdqaDqwK7HX4D8uyb+cANyGM
X-Received: by 2002:a17:90b:5444:b0:36d:81b3:61a1 with SMTP id 98e67ed59e1d1-37d160479a6mr18032176a91.7.1782193656231;
        Mon, 22 Jun 2026 22:47:36 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15df8b8esm11506913a91.16.2026.06.22.22.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:47:35 -0700 (PDT)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	andi.shyti@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kwliu@nuvoton.com,
	kfting@nuvoton.com,
	kcfeng0@nuvoton.com
Subject: [PATCH v1 1/1] i2c: npcm: unexpected SLVRSTR IRQ in master mode
Date: Tue, 23 Jun 2026 13:46:35 +0800
Message-Id: <20260623054635.1214525-2-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623054635.1214525-1-kcfeng0@nuvoton.com>
References: <20260623054635.1214525-1-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

SLVRSTR IRQ occurs even when BMC acts as master role only.
This case was not handled in the master IRQ handler,
resulting in IRQ storming.
Handle this condition to prevent the spurious interrupt.

Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 drivers/i2c/busses/i2c-npcm7xx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index f667a873b81e..02dd8c3ba44b 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -593,6 +593,7 @@ struct npcm_i2c {
 	u64 nack_cnt;
 	u64 timeout_cnt;
 	u64 tx_complete_cnt;
+	u64 ab_slvrstr_cnt;
 	bool ber_state; /* Indicate the bus error state */
 };
 
@@ -1709,6 +1710,24 @@ static void npcm_i2c_irq_master_handler_read(struct npcm_i2c *bus)
 	}
 }
 
+static void npcm_i2c_irq_handle_ab_slvrstr(struct npcm_i2c *bus)
+{
+	u8 val;
+
+	if (bus->ab_slvrstr_cnt < ULLONG_MAX)
+		bus->ab_slvrstr_cnt++;
+	npcm_i2c_clear_tx_fifo(bus);
+	npcm_i2c_clear_rx_fifo(bus);
+	iowrite8(0, bus->reg + NPCM_I2CRXF_CTL);
+	iowrite8(0, bus->reg + NPCM_I2CTXF_CTL);
+	val = NPCM_I2CFIF_CTS_CLR_FIFO | NPCM_I2CFIF_CTS_SLVRSTR |
+	      NPCM_I2CFIF_CTS_RXF_TXE;
+	iowrite8(val, bus->reg + NPCM_I2CFIF_CTS);
+	bus->stop_ind = I2C_BUS_ERR_IND;
+	npcm_i2c_callback(bus, bus->stop_ind, npcm_i2c_get_index(bus));
+	bus->state = I2C_IDLE;
+}
+
 static void npcm_i2c_irq_handle_nmatch(struct npcm_i2c *bus)
 {
 	iowrite8(NPCM_I2CST_NMATCH, bus->reg + NPCM_I2CST);
@@ -1777,6 +1796,8 @@ static void npcm_i2c_irq_handle_ber(struct npcm_i2c *bus)
 	if (npcm_i2c_is_master(bus)) {
 		npcm_i2c_master_abort(bus);
 	} else {
+		/* Clear the FIFO */
+		iowrite8(NPCM_I2CFIF_CTS_CLR_FIFO, bus->reg + NPCM_I2CFIF_CTS);
 		bus->ber_state = true;
 		npcm_i2c_clear_master_status(bus);
 
@@ -2237,6 +2258,10 @@ static irqreturn_t npcm_i2c_bus_irq(int irq, void *dev_id)
 	}
 #endif
 	/* Clear status bits for spurious interrupts */
+	if (bus->fifo_use && FIELD_GET(NPCM_I2CFIF_CTS_SLVRSTR,
+				ioread8(bus->reg + NPCM_I2CFIF_CTS))) {
+		npcm_i2c_irq_handle_ab_slvrstr(bus);
+	}
 	npcm_i2c_clear_master_status(bus);
 
 	return IRQ_HANDLED;
@@ -2487,6 +2512,7 @@ static void npcm_i2c_init_debugfs(struct platform_device *pdev,
 	debugfs_create_u64("rec_fail_cnt", 0444, bus->adap.debugfs, &bus->rec_fail_cnt);
 	debugfs_create_u64("timeout_cnt", 0444, bus->adap.debugfs, &bus->timeout_cnt);
 	debugfs_create_u64("tx_complete_cnt", 0444, bus->adap.debugfs, &bus->tx_complete_cnt);
+	debugfs_create_u64("ab_slvrstr_cnt", 0444, bus->adap.debugfs, &bus->ab_slvrstr_cnt);
 }
 
 static int npcm_i2c_probe_bus(struct platform_device *pdev)
-- 
2.34.1

