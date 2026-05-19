Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFA36C0CB
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229993; cv=none; b=Z3Z707un2Wbs59U73D0zNB+cX27cJya3wIE1cYbxAlpWcwo7ojL5B0KbAsOoulkl4cU2mL/l8pwmH1H+h9sG89jVNWTExoFa5mwyDOOLaiTa+z8J5zn/jNOdG7ibWXlX0kcylDTx8VzSWBTHiv5edDWuM1+eHliMy/3Eju9VR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229993; c=relaxed/simple;
	bh=pT5fXYUM/Vg8EfvGNeN1D8rz2V2b+bxX2V18x1wlzJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL8e3PaGDLeKzBQee3MdlRzo7WZS7AnnXVpuAPKmsiDQ8bZULhWQCh6Tyyfsyfa8svEEYPFIo2RUENOerkr8X4cfR58+U3ra6OUGSnfTlGZQALbhuAMaj6VAJKSuUKqsmDgcLSvrAYC4Mm+w0w/0cFgxEd4+nZatZY85STzRW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzBx9D4B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzBx9D4B"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso43715285e9.3
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229990; x=1779834790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaMDXwQVRtxROg0BHKiUws/Sbvb5VHpQ+LiARB3jO4c=;
        b=lzBx9D4B1VPuchGF6gpWopplbAdE76pui76OdaNBec5+8KT2lj1jZunmqZ7PlgEmWn
         sPWUTjPaqwF6nc0/3/FEpPeb+UN1pldn1SQ/5JKxD9kBpf6PFl+sGp88qorNyMeAZVKY
         nvMTCJXtlhwa5LEjhzrTNUHBZTcMAo+XYZMUgnrm0wOEzzH9177hiRbzTHyynDhsmwAK
         BeT3h3slV050bk/3rpGYvywHvtbHWzG4sM9NOLJAJQO9EoCbuBMjvOsHmHJGmaS7L7sY
         7s6Ddqx0o3h1TAuXY5ygrCoUcOsOgMQYpzigqOXrjSqJBCBI2IDd2URJqO1JBE01EI+A
         ltHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229990; x=1779834790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BaMDXwQVRtxROg0BHKiUws/Sbvb5VHpQ+LiARB3jO4c=;
        b=YGzeYRKDVold/GM/ZI+R9mpJZGXt6u15Eej/DknWrR73UXy6czIutvEoOU3ncMIAKA
         kbC70dqNkuJOmh61Un3InYk9w6DFF+6tEaYz2AxVX50lGwUzx1WdvmvCQbL+x2Zh7Il9
         ChPNAIPBaQ0KVNpKYj9gTB8oJqLbbYKZ5718s57qaLrOCIjzq7tkD1ULB89C4giGo09j
         jtGdF8YU1tL5Qc7VSJqG3ZAwqjX+1EXT/h4p45CIwJlcBnuMFWeFn1hDiyKKlyyXilv3
         9HCQp6GisgASN0O0xSeWwnox3e9yjddTjEj1xmaiqLiWjWLTm7+luEbA707qTOriWd4g
         98Lg==
X-Forwarded-Encrypted: i=1; AFNElJ9GcuWQ0H4Za7mkxgwp+sVUQegtqimIkMZN7eb7CFMd90en1VAIRKDx18UFXJTYC+/lyAbHILMnyRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIHmLbK3uBlh2oNe38ONwnpMEI8WAw4r8JIKKZq6J+yeWaC6f0
	oTDwErpZUyrEPbyMfFqbA2S45byICSC/ckP4eFzwUTFtIOE+flSsNtz6
X-Gm-Gg: Acq92OEsld/Zsea+4So6qR8RRBuGFY1M0AcUZOs0NVy82nNxGQkgr73o2bNPhcV/Ih7
	298o270uRNx0Y1lMLTksediOCNzl+AsWnhOW2EGDYZYhumyQfrSrIE4qmH6IrQPHWgM40861sS9
	y+0S9Y/3EgIt3WT4t5AiVxQ8RsvTeyuHmOoIAOJIjoqdq6ZqWy32GTwclrcPSCSzL29oApwTxsN
	FutjUqwpWOsYfJ4LfTAVTcyL7SU6ONoErtbt0yrpxND9WjKTuXM7f4YRv3ZNZi6FV9MX0LN3Imo
	zs2FnZ6A67QdsQ3h2LlMFWnIsZoSUFbsK1NgfdORXAE4IzkH3MifKacdAXyKrWXY2EhP4iaOJ4S
	xIybyICDQ+DXmNPzNUfKMvH/oJMWUHHHGCdVoW928ccfKnK7tcX0QmhyBRWhdLp+SizM/Foj0I0
	N2A7rroX1x0Xp0lXOBXtsuMHsb10GaxOIlXyHx++Vry4cd2eGtdI6VeXwpnp3LcFuzPIHUBTLhr
	UqtXWPj4w==
X-Received: by 2002:a05:600c:82c3:b0:490:778:4fe4 with SMTP id 5b1f17b1804b1-49007785080mr183034005e9.26.1779229990354;
        Tue, 19 May 2026 15:33:10 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm346659955e9.4.2026.05.19.15.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:33:09 -0700 (PDT)
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
Subject: [PATCH v3 2/5] i2c: mt7621: clear pending interrupt on i2c reset
Date: Wed, 20 May 2026 00:32:44 +0200
Message-ID: <20260519223253.1093-3-ansuelsmth@gmail.com>
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

On resetting the i2c bus, clear any pending interrupt to have a more
consistent state on the next operation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/i2c/busses/i2c-mt7621.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 700beb9e7b1a..d8fa29e7e0fa 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -101,6 +101,8 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
 	iowrite32(((i2c->clk_div << 16) & SM0CTL0_CLK_DIV_MASK) | SM0CTL0_EN |
 		  SM0CTL0_SCL_STRETCH, i2c->base + REG_SM0CTL0_REG);
 	iowrite32(0, i2c->base + REG_SM0CFG2_REG);
+	/* Clear any pending interrupt */
+	iowrite32(1, i2c->base + REG_PINTEN_REG);
 }
 
 static void mtk_i2c_dump_reg(struct mtk_i2c *i2c)
-- 
2.53.0

