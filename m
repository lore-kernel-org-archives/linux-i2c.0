Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40112F99B8
	for <linux-i2c@vger.kernel.org>; Sat, 27 Jun 2026 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782574542; cv=none; b=HokloNfCxI0ol/oOnye1ReguJtQecuZZAfV/Mym3H/7KXy2C7Zj6/AypAB/ebODG9JVo4MfISGWc50Wng/1ai+LhgczANpmUNeF+LAhToOusOdVjhvE5e3ikNBkZRZ6sB6tOmP/N3E9PH/1aCz04p63GsdqV0EOtxOazBs6n2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782574542; c=relaxed/simple;
	bh=KewN3u6Gz4JcSCHQS9sgydHkBx7wiNEAQRRyJg6iIIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5j27U4HixS5sX7qJtTiU8d7ad262YSHXzpkXvDPELUXDIZOf0Cnde4w57M57X1L/VIh2TuQhVjWEwQiVcnDLKC/K8gDeCYQdmn+LDWB0sbLJXjZiDGdO2/iLLJEVwgElee1m6ouSRM0/fxauc+I1mDWSeE9Tb1sYOVddhCKOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b60s1Xkp; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b60s1Xkp"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30e7eb50b83so330134eec.1
        for <linux-i2c@vger.kernel.org>; Sat, 27 Jun 2026 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782574540; x=1783179340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26fZRDnY2YIHaW3dI6zHmFrI0wJ7v//cQRa+/PWgmig=;
        b=b60s1Xkpskcttv3Gt4xEs7fiRUOzd+AJVJ3bxSNOFTyPeU0t6NwZ05wgTRd4+QGKi5
         3VZjPRroPTXrFCO4H8LYAcUakmT2aMXAbBtnED5Iss7/uTCVTmN9P9D+I4Z1SG98DkaD
         4wxMB8s4DDyMEDGiTuYQUY3lm8QzootxsRJpB+IXMgIpQK0K96TTrN2OE0V3djJrINnu
         3RhY6qZ6WTddRO5quutWawMVsPcsdEhIu50/PT2qssGw3Y+V668ervMLr3FKMf10FUu8
         WCM4dhjOU1X/biMuDxHHLmLN3wmuZ2nB9c8LLbW6auzTZK3BIVXlvGkWj1+5C9if3S6e
         hs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782574540; x=1783179340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26fZRDnY2YIHaW3dI6zHmFrI0wJ7v//cQRa+/PWgmig=;
        b=R52X/vNqXfTH3dcI5TMt0Ii0I0ELmJWRqanxcs+laYaNCK17HUi9TsmqDFIatmOKQo
         wuS/VJnv14AfpbWYxdfdLgSgEp7XvT93fOCq+8IbyCAxkRN6z6k4XhTSQKy0+lTCanM7
         Iuw4WhcKy0R41B7SMkhVgGiqty+/dFHET9o8eDlWzQWEIOAwy9Cm+mXqLYTeAbqfM7Tm
         PdJse2Rw9V61JDGsoFpeapbAtdQOvL1m/N7GsZeETbPS4eq8L+TsC3Rh7PH50quCIXsN
         ALxdjpAE7d/V0wSAOj8TUkOIvXB9wL98tpFyx8TXQxQq3KcvifF2Z8iApxIgSpHOM/wu
         UmHw==
X-Forwarded-Encrypted: i=1; AHgh+RoWkhouZW81qEs8oSM5mmNf7nNvTbNj9EDgU7o8uIbyCD09xPZT8iMupekgqa+bAEppikGIFVftziU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxssJzuRL/dySJ7lHbP3Nq7j3bEjTPqDDwRCYllvmXmuOaoN8/f
	1DojaQm8+wmfz9Z897QlETKCdyhbiJPYHglcowT4I5+0F8Er7GPLHPLe
X-Gm-Gg: AfdE7cm0Mie9UgL30nMGeTshJG06OMinGDXKnh0q/ScaLKJmqKQwQtm/VPAJnzRdKAp
	hNhQzjviknqeK88QQf/e2yewfEUUZS75ieXT5Wux4X5P7N0+q5LDLyqfGBfKX12QiwSCn7w5Vjl
	1XNqK7uvt72HYTkj4n0T1SqApc/BUBFi+WwvMrdk4/CKnNUtNH0R/4UlnL7KoiBqJGop2LFuobL
	NkwaR1BrFIyJ8uc1j5VmTcrvzDbpVzGFMaBoCgoJfo+Lv9hXHCTOm8L1ZpknMOEqaof0ze1n1Ru
	tLAQuKEZQ0pxafFXBqPfWYgG/i4kp0ZHtPpGX38aLvSIFAASrfupj/88abBd43rnyzwz6pDTZYr
	ZaMYOUhUcgZx8u2I8LpzAmdX3zMs0yoJQVyoQ9xaVvVEZCYrQrEEdC1CeyA4jAGC/u4hBbhDPkz
	NMYx6LR6cz1lFt98dh
X-Received: by 2002:a05:7300:8b85:b0:304:d835:274 with SMTP id 5a478bee46e88-30c84cfb442mr9198462eec.24.1782574539807;
        Sat, 27 Jun 2026 08:35:39 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c58831asm31970846eec.13.2026.06.27.08.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 08:35:39 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: andi.shyti@kernel.org
Cc: shyam-sundar.s-k@amd.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>
Subject: [PATCH] i2c: amd: fix SMBus block header and PEC handling in the RX path
Date: Sat, 27 Jun 2026 15:35:32 +0000
Message-ID: <20260627153532.547719-1-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Strip SMBus block header bytes from the received buffer before
forwarding the payload to the upper layers.

Handles the optional PEC Byte at the end of the received
payload.

Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
---
 drivers/i2c/busses/i2c-amd-asf-plat.c | 34 +++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd-asf-plat.c b/drivers/i2c/busses/i2c-amd-asf-plat.c
index e1699da838c2..daf318ce3bbb 100644
--- a/drivers/i2c/busses/i2c-amd-asf-plat.c
+++ b/drivers/i2c/busses/i2c-amd-asf-plat.c
@@ -46,6 +46,8 @@
 #define ASF_BLOCK_MAX_BYTES	72
 #define ASF_ERROR_STATUS	GENMASK(3, 1)
 
+#define SMBUS_BLOCK_HEADER_SIZE 2
+
 struct amd_asf_dev {
 	struct i2c_adapter adap;
 	void __iomem *eoi_base;
@@ -61,7 +63,7 @@ static void amd_asf_process_target(struct work_struct *work)
 	unsigned short piix4_smba = dev->port_addr->start;
 	u8 data[ASF_BLOCK_MAX_BYTES];
 	u8 bank, reg, cmd;
-	u8 len = 0, idx, val;
+	u8 len = 0, idx, val, offset, data_len, payload_len, has_pec;
 
 	/* Read target status register */
 	reg = inb_p(ASFSLVSTA);
@@ -110,12 +112,40 @@ static void amd_asf_process_target(struct work_struct *work)
 	if (cmd & BIT(0))
 		return;
 
+
+	/*Below is the SMBus block header received on the wire:
+	 *     Command       --  1 Byte
+	 *     Data Length   --  1 Byte (number of data bytes)
+	 *     Data          --  N Bytes
+	 *     PEC           --  optional, 1 Byte
+	 *
+	 *     PEC, if present, is the final byte of the transfer
+	 */
+
+	offset = SMBUS_BLOCK_HEADER_SIZE;
+	if (len < offset)
+		return;
+
+	payload_len = data[1];
+
+	if (payload_len > len - offset)
+		return;
+
+	if (len == offset + payload_len + 1)
+		has_pec = 1;
+	else if (len == offset + payload_len)
+		has_pec = 0;
+	else
+		return;
+
+	data_len = len - has_pec;
+
 	/*
 	 * Although i2c_slave_event() returns an appropriate error code, we
 	 * don't check it here because we're operating in the workqueue context.
 	 */
 	i2c_slave_event(dev->target, I2C_SLAVE_WRITE_REQUESTED, &val);
-	for (idx = 0; idx < len; idx++) {
+	for (idx = offset; idx < data_len; idx++) {
 		val = data[idx];
 		i2c_slave_event(dev->target, I2C_SLAVE_WRITE_RECEIVED, &val);
 	}
-- 
2.43.0

