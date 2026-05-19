Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3935C1A9
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229991; cv=none; b=tC8fTakjQ6XDJWtrbumACl28cneAMDEVhpXwKejLq4lZZAc1Uufl6FxMejuwYltXrDVR03HD0bTf53C1jBZy59MKVHbkWURZMxitwnizRPHn2iKrVS3RQgT5nBIj+x8x1ZINx1ZOlxir+ApQ3wcTze8LqkJd3+5H28pTIvdgcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229991; c=relaxed/simple;
	bh=eJkiww197X5VvhHmztEPAYPU7b+NTaIrdSyFEi3Aoog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtnnVgH5ew3tRuswdS6P44F91e7yHni6b5evwc8AcJ7YXknyxnbxUCcu+K8I8iRHg7WjxxGfPzUOFqeehpKti+k1vpRlEJNqBUJiccWLx8IfgSrt6908L3UW35pIsyS5mrfbceI0DPpISnoNgOS6nKraIzBPXkG7RFkWhxaGg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adVInQR3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adVInQR3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so45153455e9.0
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229988; x=1779834788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSWJVKglNpMUeLvf2TMVSbIheMkylfB7P/Qb2Y04AtU=;
        b=adVInQR3z4AgxfN8AUkKYgnj2t4mR6f9PkDUE0CauBNuApu3D6GNaJLKinNXS4gOZn
         IY/d8RCxJdcbaM/6jan7gG124I1rvIlHQnybdD5z/+/vtJ3ACIt7FqU4QB46XvoW35Av
         qHLfkpGF68opluyyJ1p0mNdCbRpr8Y5L/GxAcv+6xC5u2RjKZX9tVu2nNBBUk9NWHG7j
         /rGY/XBfXingwVNTKcb0o5n4CeqcfWiIVqZZ9jLsxnYpZy0xqu3KHfUDXS4Ph+QRKbTB
         9Kh/Ot/vlqPDiWlop+jykeGZhuBdUpyMPEWNpZ6QXgWeD84GmdYRXMcYBzWMaDv91psR
         B+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229988; x=1779834788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rSWJVKglNpMUeLvf2TMVSbIheMkylfB7P/Qb2Y04AtU=;
        b=GYN1iapT7/XFvNarjuBgQDPdFBW18B5mxahuvWPABACuWeb8dafR2f7Gaje0Okgy1a
         QF5iQEzRWFnV1p+JN/9HVgj6a8AgmBTDav0OfmL2l3XS5mzcVCQu4CczFNHSGej8ZPfy
         /NWsMcS1awlIHldVDtNQCKVT18hFLr2SbZGOSP2fAQdKlBICL3Q2IuCiHO+KooFvRdUI
         xHNKErOg4u8m25nWOoZyFsQ088V1iT3NHA3Z+cuOCbIfqfwFfbBwxh/49P7OROVbVPaF
         MFvU9YwadapOaxhsM/WhSdp1hT9mwijehK4o6IL2ruCiqkTOuShkFvRGzmqXb2zjLxWC
         46SQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jdyyukfUaFetEI9PRZivEct17u64vRl3/Hp8M20dzqhFywTArdZ+jfQPeewznr2On0jO4gL71JJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWp2sHf8ZE+e54Oe1kGH02tNEBLi7YHmNh+trPiyW7k+k4xsMa
	qDOby4EX7eWaoX9TWMWXApXL8x3PEBETmuNdxGAT2QGNkr1bXYCP6arZ
X-Gm-Gg: Acq92OFwECbk/VCgMGridY34cHWqOLW8ARlrjXqAnSMfryUq4wzNAm7FQliTgCR79DT
	AOR75+kPuVhK+Vw0UuDOcnW/bXIFWoN1FsIudsDCvv+Pl/cq3Qu7mFaMpi4Fq8gO8/dgg439rwG
	ieDS9een4SmBLiOY3sVnBgUXKmh1qdaZQTHJq0RrYkxNXH6q0v2k7fwhHttj3sWQgFBhB/RuJ8p
	kkeJMIz9CG+nFPfB/5N1UuqTViBN/wQwpnrtLcct3YgpZTolzPW5TBWblm3H5C7+89QolxyU1K1
	m2orxh0w254cZh33UdmHBFW1RLNL6jv/fSQIUIFTUXUtJKRoqJowzHu0OAUf0no6BG4YRMjBt+a
	VFuYa7h/yMM0WTcjvPYkGXvd6gVYjj9DxSY9WVJ6AIXKymWE6J1sL5FcSH8Jd8H3Jb5VVaHR+zE
	igSPe7cld4tkudADmaQvrTutEQqS6dmdWIV/5uukldAnnIxjTcvb8LY8OxXJZyhUn5nglLALs=
X-Received: by 2002:a05:600c:4504:b0:48f:d1b8:9a9c with SMTP id 5b1f17b1804b1-48fe60e14bamr314706265e9.7.1779229987604;
        Tue, 19 May 2026 15:33:07 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm346659955e9.4.2026.05.19.15.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:33:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 1/5] i2c: mt7621: rework cmd/wait OPs to support atomic afer variant
Date: Wed, 20 May 2026 00:32:43 +0200
Message-ID: <20260519223253.1093-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519223253.1093-1-ansuelsmth@gmail.com>
References: <20260519223253.1093-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported the need for atomic operation on some Airoha SoC that
makes use of I2C bus. Rework the cmd/wait OPs to suppor the xfer_atomic
variant. To support this it's mainlin needed to do the readl poll in
atomic context.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/i2c/busses/i2c-mt7621.c | 56 ++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 0a288c998419..700beb9e7b1a 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -67,14 +67,19 @@ struct mtk_i2c {
 	struct clk *clk;
 };
 
-static int mtk_i2c_wait_idle(struct mtk_i2c *i2c)
+static int mtk_i2c_wait_idle(struct mtk_i2c *i2c, bool atomic)
 {
 	int ret;
 	u32 val;
 
-	ret = readl_relaxed_poll_timeout(i2c->base + REG_SM0CTL1_REG,
-					 val, !(val & SM0CTL1_TRI),
-					 10, TIMEOUT_MS * 1000);
+	if (atomic)
+		ret = readl_relaxed_poll_timeout_atomic(i2c->base + REG_SM0CTL1_REG,
+							val, !(val & SM0CTL1_TRI),
+							10, TIMEOUT_MS * 1000);
+	else
+		ret = readl_relaxed_poll_timeout(i2c->base + REG_SM0CTL1_REG,
+						 val, !(val & SM0CTL1_TRI),
+						 10, TIMEOUT_MS * 1000);
 	if (ret)
 		dev_dbg(i2c->dev, "idle err(%d)\n", ret);
 
@@ -117,27 +122,28 @@ static int mtk_i2c_check_ack(struct mtk_i2c *i2c, u32 expected)
 	return ((ack & ack_expected) == ack_expected) ? 0 : -ENXIO;
 }
 
-static int mtk_i2c_start(struct mtk_i2c *i2c)
+static int mtk_i2c_start(struct mtk_i2c *i2c, bool atomic)
 {
 	iowrite32(SM0CTL1_START | SM0CTL1_TRI, i2c->base + REG_SM0CTL1_REG);
-	return mtk_i2c_wait_idle(i2c);
+	return mtk_i2c_wait_idle(i2c, atomic);
 }
 
-static int mtk_i2c_stop(struct mtk_i2c *i2c)
+static int mtk_i2c_stop(struct mtk_i2c *i2c, bool atomic)
 {
 	iowrite32(SM0CTL1_STOP | SM0CTL1_TRI, i2c->base + REG_SM0CTL1_REG);
-	return mtk_i2c_wait_idle(i2c);
+	return mtk_i2c_wait_idle(i2c, atomic);
 }
 
-static int mtk_i2c_cmd(struct mtk_i2c *i2c, u32 cmd, int page_len)
+static int mtk_i2c_cmd(struct mtk_i2c *i2c, u32 cmd, int page_len,
+		       bool atomic)
 {
 	iowrite32(cmd | SM0CTL1_TRI | SM0CTL1_PGLEN(page_len),
 		  i2c->base + REG_SM0CTL1_REG);
-	return mtk_i2c_wait_idle(i2c);
+	return mtk_i2c_wait_idle(i2c, atomic);
 }
 
-static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-			int num)
+static int mtk_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			       int num, bool atomic)
 {
 	struct mtk_i2c *i2c;
 	struct i2c_msg *pmsg;
@@ -152,12 +158,12 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		pmsg = &msgs[i];
 
 		/* wait hardware idle */
-		ret = mtk_i2c_wait_idle(i2c);
+		ret = mtk_i2c_wait_idle(i2c, atomic);
 		if (ret)
 			goto err_timeout;
 
 		/* start sequence */
-		ret = mtk_i2c_start(i2c);
+		ret = mtk_i2c_start(i2c, atomic);
 		if (ret)
 			goto err_timeout;
 
@@ -173,7 +179,8 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			len = 1;
 		}
 		iowrite32(addr, i2c->base + REG_SM0D0_REG);
-		ret = mtk_i2c_cmd(i2c, SM0CTL1_WRITE, len);
+		ret = mtk_i2c_cmd(i2c, SM0CTL1_WRITE, len,
+				  atomic);
 		if (ret)
 			goto err_timeout;
 
@@ -198,7 +205,7 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 				cmd = SM0CTL1_WRITE;
 			}
 
-			ret = mtk_i2c_cmd(i2c, cmd, page_len);
+			ret = mtk_i2c_cmd(i2c, cmd, page_len, atomic);
 			if (ret)
 				goto err_timeout;
 
@@ -218,7 +225,7 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		}
 	}
 
-	ret = mtk_i2c_stop(i2c);
+	ret = mtk_i2c_stop(i2c, atomic);
 	if (ret)
 		goto err_timeout;
 
@@ -226,7 +233,7 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	return i;
 
 err_ack:
-	ret = mtk_i2c_stop(i2c);
+	ret = mtk_i2c_stop(i2c, atomic);
 	if (ret)
 		goto err_timeout;
 	return -ENXIO;
@@ -237,6 +244,18 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	return ret;
 }
 
+static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			int num)
+{
+	return mtk_i2c_xfer_common(adap, msgs, num, false);
+}
+
+static int mtk_i2c_xfer_atomic(struct i2c_adapter *adap,
+			       struct i2c_msg *msgs, int num)
+{
+	return mtk_i2c_xfer_common(adap, msgs, num, true);
+}
+
 static u32 mtk_i2c_func(struct i2c_adapter *a)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
@@ -244,6 +263,7 @@ static u32 mtk_i2c_func(struct i2c_adapter *a)
 
 static const struct i2c_algorithm mtk_i2c_algo = {
 	.xfer = mtk_i2c_xfer,
+	.xfer_atomic = mtk_i2c_xfer_atomic,
 	.functionality = mtk_i2c_func,
 };
 
-- 
2.53.0

