Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106461;
	b=fOzCM4NcuCxIBrDuewSoKey0+hC0lc/IJbYgPDtILRboe22mKcyLzGV7VAzUjqPlHcpS
	 WizZ4/q0/8ubVq6SUA/KnDWS/LhMrhfRzLHnvexTvGnSGY9hgr1tBWvtdY0OlI++wdoVI
	 /XIyCBOIJjZM3o4OIMf+OFrbrVRzNGX1KTFTKMswMiQOuPnJPXWY1iOc353Ag99C4Z8Y+
	 o5STjoQ2ScwGm7QrUVv0kNlXApcMbMknpH77jfmZ9Pp8VhHAg7WfQNX8oSoFFvT7wOrm8
	 GT3NvcAPhFKlxjHwcsm46T8vdKe1TkVPkJo9ilJzRl5/xRHlaR7/4dCCju++w0z7eJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106461;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=ScFT/OtpxKSo3knUou8IYhnwGsI32WdaoJ4b5AsUsn0=;
	b=Rs6GI1YVwyZZqpEqkhqJEChcOZ2EdZY5pqBWdzI2rcv4BQEASxexEq4IxPZQQNend+88
	 fZrNYse7hzKUw5RHAqK+ObWoQOgEazwakjACrxJoG/45cwawDkvRElYleNsWRlBYIph99
	 5VCRW9giQ8a3UPdDcVWUhup8hmPSrk8RPuXLUcDY1qP82KAhL3twH9LGDThzIfGwZ/q+I
	 VLT1/w/KzAGu8aW4lwsDXlavIBPwTnwSBvUv9od2HUWel1NG+J6ifqoDUQuivGTiPSWgd
	 DHlgXFNBmNkMEtULZkdWeMd9us+1ODhPi0mM/BwLeIzXElY1k2yxOYEddbnXAMzMSVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=none smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=pDkUyqW0;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900D606A320;
	Thu, 19 Nov 2026 16:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2900D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=pDkUyqW0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FB3057727C;
	Thu, 19 Nov 2026 17:40:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1795106453; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ScFT/OtpxKSo3knUou8IYhnwGsI32WdaoJ4b5AsUsn0=;
	b=pDkUyqW05WKCxSsJVLoK9XaiqWAtEkKz6crQuWs/4qzCMnyvIe/weziSyHmWGqHNK9QbG1
	smmYmdl3CqOpPj8TKaLg2y5DgQZFVO7Uwdi1EvzhS7j2q+qzV1XuXqbexgn1cmH3XQ246v
	Lq+HPukbnQ0nTIL1JDctLARKxBVRu4NPPVpkDo4N0PNx37yRVjo1Gpvi/khb8TfvA+qDT4
	nyDkRaJJd4YAk+COtLwSuAi047+E7IuPafoYqwDQxMzgxoZ++rQ/LACOFVEEn8WR+hZfrL
	UA/tgQClPJfqUmgxu/DJthw+4BRSHc6roAOiVEBlDBuZurKURG6zKmiOgdQ+Uw==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: linux-i2c@vger.kernel.org
Cc: sr@denx.de,
	andi.shyti@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH 1/2] i2c: mt7621: support big endian processors
Date: Thu, 19 Nov 2026 16:40:39 +0000
Message-Id: <20261119164040.2400580-2-cjd@cjdns.fr>
In-Reply-To: <20261119164040.2400580-1-cjd@cjdns.fr>
References: <20261119164040.2400580-1-cjd@cjdns.fr>
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
X-Last-TLS-Session-Version: TLSv1.3

Data is copied to and from I2C by way of a pair of IOMEM registers.
When sending, the data is copied to an intermediare buffer and then
written to the registers. However, the data is nominally little endian
but the registers are in CPU byte order. Make the buffer explicitly
little endian and use little endian read/write to support I2C on big
endian CPUs.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/i2c/busses/i2c-mt7621.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 826abb9252e31..c79a47b293ef4 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -185,7 +185,8 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 		/* transfer data */
 		for (len = pmsg->len, j = 0; len > 0; len -= 8, j += 8) {
-			u32 data[2] = { };
+			__le32 data[2] = { };
+			u32 val;
 
 			page_len = (len >= 8) ? 8 : len;
 
@@ -194,9 +195,12 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 					SM0CTL1_READ : SM0CTL1_READ_LAST;
 			} else {
 				memcpy(data, &pmsg->buf[j], page_len);
-				iowrite32(data[0], i2c->base + REG_SM0D0_REG);
-				if (page_len > 4)
-					iowrite32(data[1], i2c->base + REG_SM0D1_REG);
+				val = le32_to_cpu(data[0]);
+				iowrite32(val, i2c->base + REG_SM0D0_REG);
+				if (page_len > 4) {
+					val = le32_to_cpu(data[1]);
+					iowrite32(val, i2c->base + REG_SM0D1_REG);
+				}
 				cmd = SM0CTL1_WRITE;
 			}
 
@@ -205,9 +209,12 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 				goto err_timeout;
 
 			if (pmsg->flags & I2C_M_RD) {
-				data[0] = ioread32(i2c->base + REG_SM0D0_REG);
-				if (page_len > 4)
-					data[1] = ioread32(i2c->base + REG_SM0D1_REG);
+				val = ioread32(i2c->base + REG_SM0D0_REG);
+				data[0] = cpu_to_le32(val);
+				if (page_len > 4) {
+					val = ioread32(i2c->base + REG_SM0D1_REG);
+					data[1] = cpu_to_le32(val);
+				}
 				memcpy(&pmsg->buf[j], data, page_len);
 			} else {
 				if (!(pmsg->flags & I2C_M_IGNORE_NAK)) {
-- 
2.39.5

