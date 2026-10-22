Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697951;
	b=rrVbzGpWjZH1FUaKBj7WH0r01R4obku63WIf7V+7+LvTxYfZmU8HKHexN21A3iHq6VXr
	 0QB4nOB+iu4vJ6iII7YUc2gykxgo6fiTmYYQYK9K7kc3eN9t28etE/a6on/ZDYb4BcY9L
	 ZRx652b75bOYKUtLp8d/sIHkWZm2iRlmBjg7A5iX8lehym0hc+xOxuBzNBg7kduMDwsDt
	 aoYeZSyWrQM7A6/dJnBuDQRLT4NS7pzdMgDjUj8WP8O/9+YuwJIbpkhZmbsd/JDjmihZm
	 OlNq5RdhfXxOE+BpSbBMj9256VDep9lgbhjd/Y9qtS14NWqIhqwez1ygEHS6K7I+aRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b6uibeAd1xqDy+X+4zICpkfe89xnFGYtmkkgNj7URCQ=;
	b=QivFQCsl8KAujFu6NltfmK8xL4A1o+DQ8Bs66jwMt8P1JxR5pScLaG5Xm7sOvd+5Yfd3
	 ua7XQUJ+l8VlLmKHsElbR1W8523sDqr3+HTBZjZ6Jn8hrt80RWNFueZT5LYZm8Jpsj/um
	 YrAjhUK3k7ogLT+gNCQ9WkVmky1KsAHVQT3xOThKq+OfZyswYDG2ovuc6sM0GE8hYcFK+
	 5bVNSJWEGVJEp0w28pyXabOrP2jFXP6ZVyj2/fWK0BIRAc0oTMoXLP4PjRXcPbQUX4uWK
	 fnYMM71Qo0FI382/TDc1YZL2/vJBSEHT3eI4wiYC2YEAOb5/6k3etMWIdz5E8GpLoIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="T2Sn3/UE";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4E606A31B
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 19:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C4E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T2Sn3/UE
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4be28b82so116912f8f.2
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792697949; x=1793302749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b6uibeAd1xqDy+X+4zICpkfe89xnFGYtmkkgNj7URCQ=;
        b=T2Sn3/UEFIQ1gguvi01Rzg/SOPhtehuu7dboerUrQmiNO46RHQNB2EhECSbVnGsKQn
         0Jp9c1ai2rMR21RCZjCHOm0uGTam9CvOm9oHHbd9TbWetuY2R+h9GDqlxiBHrOXZELmx
         12jv2oDL1jo272xUoP8GUf9/h1PY5KmFMBqtvd7MsGuaJSPYApXVqT18ySivJR/gStyp
         5LW+1+kWLs6RiIJ+SDl5MAw/oNFs9LAVgY1IhxS2z+YrVXmUqqJqGd95bxpOKIJyxJxA
         b0ENTpfmQpfQKQyuha5XV9uuJJ0foKhVQ/MY013ia3gB943uAFVAgljj0rX9U+YT2BYZ
         LNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697949; x=1793302749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6uibeAd1xqDy+X+4zICpkfe89xnFGYtmkkgNj7URCQ=;
        b=FlyXSRVq9+COs7VTYWc0rsPIR88NTWTAKxiu/xNz50DcEPMxNna0wqAxXQLGWXwzeU
         0GH0PIwucwbigx4823Cchgkb/5Qo6z8DfRtCV/o2wJBGxW0t5qog79kFFfNB7U7xZlhS
         Ey4rbkGVzExJs5lH4ezVZugejIwrIq+5ulMhEQY67x/tqvLtKf5tUHyMUfMr+lK/HxiU
         UTC6CBvSNXpH2zm34HNUPFZOagncdxLpV7EEoPWylCSfoMkfgc7PftXDdAHU8MFFecCt
         q74qrHnoQZXa4yhDK//rkj0lAvVxdCa+/BtWpmTPN/4hrau52G21A9inWAWH1DJUrqKs
         CQ9A==
X-Forwarded-Encrypted: i=1; AKwUvByk/1Y60lfe3q5x02cUTbytotogzwvJlxaZwbj4yD6sxBZY+CTPaK6MNdOjpGeHGrAHgJVks42bGco=@vger.kernel.org
X-Gm-Message-State: AFq9FYIapICyOEMi0bIpbWbaAkHLUvOwl1kP16rGqXNdF+eJ/xFXC2oo
	5A23MPIwYWmhI7bdqTwFUXw2i+3GsSYRVSCP9mWIzhIVpqJa0VI7Pv7d
X-Gm-Gg: AYBFou2664rNuwyQzGN/niMtwihkAhWyhVtocnBwI8ILhFn19nY2DIhvqXwO+MJne9t
	tFiuTti+DAWrqG0MVUwr+NyW8hU5K74Gp0/av6bJkTFO/bc3p+UtKkJ8TNJHdOypmS4qin8lvaK
	75VShu6TVc9UMoIYaYa9lIke7PQcWnDHvyZOnAdmcM/xvyb501N8bnHrBEbvp6sjheYXcNfzTNv
	GcZLP+dRa73iPG0Lhhp5tE99I5dg0ZMTF58jTxoD2nXOT+GgeeXbiA3kbbIsbIluK2d0ZdIPmng
	xZ7HgCQc4zFVca8mMphNqZuaSzXO+eSs3KsE/nzSCZq3sbQgd2D6qKg5XGt/WGFfyPTNTFvSRDL
	EM8VnD4cio3zpScS54oKwtTo3L+E76G8d9f4qvJmtx0/neqpI11plS8bsqRXR+f21waUuG//lJ+
	F4oXn39qFEZemyWo9Vg/hsGGSRhU13UaAEQdhkmmJI+wJKBvJSYPAgxfbi1bh1suDafLJLzMoKl
	W2JIWKxL+jM2agPWKw4K2Krxufuh1eGmemIMejKHAgbBlKMpZ9lo9X4YyHkJo2rZ9jbhQ6FA2B1
	ebpUgwOgUiH4ML4HMNhxjU6Zs144BLVpzweZYlSWAmdI68IGs9XrmeD4qlC7
X-Received: by 2002:a05:6000:46c8:b0:48d:eec6:308b with SMTP id ffacd0b85a97d-48e264af00emr8712598f8f.21.1792697948972;
        Thu, 22 Oct 2026 12:39:08 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e38026a7fsm69730f8f.15.2026.10.22.12.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:39:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH RESEND] i2c: mt7621: fix copying uninitialized kernel stack with reduced page_len
Date: Thu, 22 Oct 2026 21:38:51 +0200
Message-ID: <20261022193853.670625-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
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

When a page_len is less than 5 bytes in mtk_i2c_xfer, uninitialized kernel
stack data is copied and written to REG_SM0D1_REG. Equally on the read
part, an unnecessary read is done.

Guard these extra copy/write and read for the page_len to fix leaking
uninitialized stack memory.

Fixes: d04913ec5f89 ("i2c: mt7621: Add MediaTek MT7621/7628/7688 I2C driver")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/i2c/busses/i2c-mt7621.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 0a288c998419..9ea5e3f9a763 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -144,7 +144,6 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	u16 addr;
 	int i, j, ret, len, page_len;
 	u32 cmd;
-	u32 data[2];
 
 	i2c = i2c_get_adapdata(adap);
 
@@ -186,6 +185,8 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 		/* transfer data */
 		for (len = pmsg->len, j = 0; len > 0; len -= 8, j += 8) {
+			u32 data[2] = { };
+
 			page_len = (len >= 8) ? 8 : len;
 
 			if (pmsg->flags & I2C_M_RD) {
@@ -194,7 +195,8 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			} else {
 				memcpy(data, &pmsg->buf[j], page_len);
 				iowrite32(data[0], i2c->base + REG_SM0D0_REG);
-				iowrite32(data[1], i2c->base + REG_SM0D1_REG);
+				if (page_len > 4)
+					iowrite32(data[1], i2c->base + REG_SM0D1_REG);
 				cmd = SM0CTL1_WRITE;
 			}
 
@@ -204,7 +206,8 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 			if (pmsg->flags & I2C_M_RD) {
 				data[0] = ioread32(i2c->base + REG_SM0D0_REG);
-				data[1] = ioread32(i2c->base + REG_SM0D1_REG);
+				if (page_len > 4)
+					data[1] = ioread32(i2c->base + REG_SM0D1_REG);
 				memcpy(&pmsg->buf[j], data, page_len);
 			} else {
 				if (!(pmsg->flags & I2C_M_IGNORE_NAK)) {
-- 
2.55.0

