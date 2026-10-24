Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877125;
	b=4/carxQl3YRXnP67Q3LNa2n0SR/Z55f7DXwZkwIjay6c2g2rV8wayeXK47cJKjORRFpz
	 cn5JE+o3VEiIr+2SuUO8cfy0EbY24kEREePtTEHXKTBnlWtsmnYYcp3ienR8I+7rs5ajf
	 6DZwugKzfxr3UNb+LJHIycP4+e+bE70AhhTR94Qs8ER8UclFJ0cuKy5P1xwgjVdBdeKjn
	 ilQt14LdjsoZ6wxdo3M4Xtj92C0WD5sB5Tmep0PP+Cj//7uFNiImjUTlxxx6xxtVm+VMp
	 aoK7oH23Nb8ZaxO8S7TcVdZS5A0vgXnW32dKE+GzP2HSpZIwhk6/myYSWUssoRdpavA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nGZIgux4dcF0wxVmKrgwbkWNzR5F3QBaO3xEg5nVzkA=;
	b=vAKkjClnmzRfuLS7Z/rgjwx16GrCZZyNpNnL9sTsn0+zqmkTomDtWNwoZBqDmBPta+/J
	 bT7rH7DCPm0Alxg97Flqvo6rn2rfYbdGzX6stkCqIn0rKpLLiR6c8T2I5aZZzWWhJy9Om
	 gbJA3pLTA43Rh6lIelKRB+Zp41/CBOdOOmZCpCnNuXX9KmfhI+WQv+3yvGnf8doENIxBw
	 WUn8OgVxrLRz/PYAnLxr17tFkqVvtQ35rI90ZfbLmAJLBZivKr+3me5EFbYYLCNvOiumk
	 k2iB/UsxT7/qtnn7X2/VnTtmjIqn49QBXEtFdCZoaUkqtocs/GMbKkKmCQJHfysfwEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Ywz6jNWt;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C49606A31F
	for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 21:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C49606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Ywz6jNWt
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so926545e9.0
        for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 14:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792877123; x=1793481923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nGZIgux4dcF0wxVmKrgwbkWNzR5F3QBaO3xEg5nVzkA=;
        b=Ywz6jNWtzsxRtkyFVBhZshPwrQunRMgUPILFsH9evTboAM4skABoL/yKaEo5E0o+tb
         xAOll3XcJQ0vKhHihRUGQ9EE+WJRcspfcTS16eR2rf9W2Xq7bRyS8PGHjbDfaeNwfgH4
         j+GS4ApmTH2N3Y5F7Z8RtqhXrJ6aQMOj6fMBu2PZXsetcmZTcl49d3WO1AuJcxueokHr
         AdCWEGD22+1xV1Q2b44q5EYWs91G/CnZVa+ZKJukfEt/Jw8bIdQtl4VjT1XGuH5oPa4c
         FI8JypqIIwpUQ1LORLO3eE8dMNrthJdc5qJjS8sffwuMx0YrrTGDPF3ZfWfEkz8gVL8r
         dmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792877123; x=1793481923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nGZIgux4dcF0wxVmKrgwbkWNzR5F3QBaO3xEg5nVzkA=;
        b=Ov3yLYPfZpGumHvFlcTrSknxOf3LfY1bMYxQ3p4a2eOO/GaGWqzYcmZ0JyJL/m6jww
         59GkC67f16rREzm2d6eCzMzv5Pbg7Z0DB61nEnBa02TSd90qltlfoJijACB+HU5sMntE
         /VnMEjncj5ju1A6Xr2Y2M5Qt3MUvGD0aP1v+fSmkVuRzBx8TqPZOh2fsWFvcKqXtrSSE
         KqRomk3Q2ATyjvqZDiflYp/YRKPBUTp3PtAo/p2+nK+jiwqOmfzl/nu//1jdS02EMcEu
         qYmK61d57S00Za4dcTYMwTy6dBTWgC2Ics+3LxQxT6wlat3NYZ2NNozUJZAsoI1MuYwJ
         KBhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxzVbc0g+WSSY7+lJ6M8r7AYmM2QJxzXyvJQOdjrFfkFeT2Sncv/8DGbrYkRe6HojFj46pRUX9n3c=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0P/ZxaeSRwVPhwJ12g0bBj20txSpQCvvsesQP71/kSAWC7i8B
	TA0UW0/bAy1FlhxkUfgusSKUKILpVBdV2u3tiLT7ij+/M68pRxBSCE+X60EUOinpUYM=
X-Gm-Gg: AYBFou0LCr9Lkq317O1r4KoPRrfeaOaINgCyTuhfvQRlpTywxXUyXMASCSIf1V2SEnG
	CIY7ttrQ40wFODOD4qCOro/Ig0EwUSMCZ18emNepd87ISdY6SBxTelxPRbVvvA3OzdL1AHLQx4W
	MVzKHSZTPTmeqgx48zTwwwGHGqbrPfeL5edQIbsozGcKxw7FqFTlbYBx0iGPlAI+54PIX0m808V
	5UQHXkq+dgUe36pOvxdxB/s6zk+68EH+az9Q9RcwbOh8emr8HdCCjOrF0W7AhJww+X2UJ1srxFa
	sCSdpK9gBXc+gonD4a0R9+gJfTiil9vsV5uWECpK5+zjifm85LrlcSBhfe6ChuU7ViNqvewhPlK
	px/Hfkjn0AMTl6LtsnUbNL3XcCWAQ2gzzJuqUgTR1MmcjgAPXSRsLnxx2242W4E/+of0+RkR+2z
	LTp4gfiGAwSlAPWQJsRp3l4yhRUXU/zA80tj6DYPKviL4KeHvSDsu7RBFJH0ZwV8eNWU+PnXcdX
	UfRFtkLzSjdMObNbYYrZRsaP9jOcbRU63n9jbSd1lEqxOrBdRHhSsVJ37sxHM1H77ctmBFqYND/
	E5cVDhS71N1b93lWbstWfQCo5+QPuf1yZtbEdFH+CmVeaZU8+iyozr8D/53GvEe9/+TB97hT1Uf
	ZQX726ue7rhH+9/7ESVc=
X-Received: by 2002:a05:600c:a00c:b0:4a1:fe55:88ef with SMTP id 5b1f17b1804b1-4a35aca4b9emr44250765e9.20.1792877122809;
        Sat, 24 Oct 2026 14:25:22 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2ed5a2sm79597135e9.15.2026.10.24.14.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 14:25:22 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 1/2] i2c: jz4780: Program the spike suppression length
Date: Sat, 24 Oct 2026 23:25:19 +0200
Message-ID: <20261024212520.91401-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024212520.91401-1-olivier@mgcrea.io>
References: <20261024212520.91401-1-olivier@mgcrea.io>
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

The X1000 and the SoCs after it (X1830, X1600) have a spike suppression
register at 0xa0: I2C_FLT in the X1000 programming manual, SMB_FLT in
the X1830's, FS_SPKLEN in the X1600's. It holds the longest pulse on SCL
or SDA, in APB clock cycles, that the controller filters out. It resets
to 1, and the driver never writes it, so it keeps whatever ran before.

On a HiBy R1 (X1600) started from the vendor kernel, the register held
116. At 400 kHz with a 140 MHz APB clock, SCL is high for 102 cycles,
so the filter hides the controller's own clock and every transfer ends
in a lost arbitration (TXABRT 0x1000). Driving reads by hand on the R1
with the filter set to each value: they work from 1 to 100 cycles and
fail at 110 and above.

Program the 50 ns the I2C specification sets as the longest spike to
suppress in Fast-mode, rounded up to whole APB cycles (7 at 140 MHz).
With it, the R1 reads back 7 on both controllers; after setting the
filter to 116 by hand, the next transfer puts 7 back and 50 reads out of
50 succeed.

Suggested-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 drivers/i2c/busses/i2c-jz4780.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index 695be3b21460..d1bb75d9a102 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -58,6 +58,7 @@
 #define JZ4780_I2C_ENSTA	0x9C
 #define JZ4780_I2C_SDAHD	0xD0
 #define X1000_I2C_SDAHD		0x7C
+#define X1000_I2C_FLT		0xA0
 
 #define JZ4780_I2C_CTRL_STPHLD		BIT(7)
 #define JZ4780_I2C_CTRL_SLVDIS		BIT(6)
@@ -253,6 +254,7 @@ static int jz4780_i2c_set_speed(struct jz4780_i2c *i2c)
 	int cnt_period = 0;	/* period count of the SCL clock */
 	int setup_time = 0;
 	int hold_time = 0;
+	int spike_len;
 	unsigned short tmp = 0;
 	int i2c_clk = i2c->speed;
 
@@ -356,6 +358,16 @@ static int jz4780_i2c_set_speed(struct jz4780_i2c *i2c)
 			jz4780_i2c_writew(i2c, JZ4780_I2C_SDAHD, 0);
 	}
 
+	/*
+	 * The spike filter keeps whatever ran before left in it, and one longer
+	 * than the SCL high period makes every transfer lose arbitration. Use
+	 * the 50 ns the I2C specification sets for Fast-mode spikes.
+	 */
+	if (i2c->cdata->version >= ID_X1000) {
+		spike_len = DIV_ROUND_UP(50 * dev_clk_khz, 1000000);
+		jz4780_i2c_writew(i2c, X1000_I2C_FLT, clamp(spike_len, 1, 255));
+	}
+
 	return 0;
 }
 

base-commit: 03a5cffc818695157414456dec695f7c30b9ffff
-- 
2.39.5

