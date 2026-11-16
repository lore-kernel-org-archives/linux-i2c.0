Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851640;
	b=y6wkO/e5Zz6plBmpKUclxD8KawW4yA6VpHv3rRa7io/zajFGlKzTmnk2HrEcmnc/zoAL
	 fwmkxiSQ0fV/o7B/7Td/G/I/Zs5fKZhfyq/AcOmag/lQbznuWkbQ06AbdX0H5yEkf5FIG
	 hnf6CwExdJ6TqBBv3LGiZd+k5KZDJvj3nMyzRSjLwRW67VTGbwInFGtmAv9hT7Ai2i2Nx
	 DwpYP5o8MOpG4O/0csTiAIrX5xhYye7Huxi9pwhuRIAq23yQ/QednlOzi0X5hc3x6VuMH
	 oFqSm2PMapY1x5jcO0sxKjt/3IhE/H6ntlQVuxEQoMHKqVOeO0Hvs2p21gCySwVwC3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851640;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=htPpsj1ZCqMRn1NtlL8aj52+oY3mSts/TrS2vw7Er68=;
	b=5dtQUwCJtJ7JrxM2PveiQ4KbJEI17PSSlEP2UlRNkn19qH0osTrC0Vt2EnepWETvWaae
	 JG70Gy9trsjkBhER/kGqVQndP5QwrHCsQLzASwASjOlRNJ4Ds4p17qdh/5S5WxuoS/CxO
	 HnpXt9K8ScfIuKrmMFcL1+M9XxUO492XI916ZpV8WdKV0cwEpea7f7eE7PlvrokHUY6Bd
	 Y1Z3houKP4A9SRvNFKgIChXjsF76sbZlZZsVmoIrq52oeEX3w6ytm3OE8EXGL6y8WrayE
	 uokKWHd2v64NJeJP6JlI5lJcuzaLn2Di3llP5vp83eGDMv1z+JK1w0YUu7lIAhWUgDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA9606A885;
	Mon, 16 Nov 2026 17:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBA9606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1403:e6fc:5f71:2c1e:7d62:945f] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xT0tq-004GoI-03;
	Mon, 16 Nov 2026 18:53:50 +0100
From: John Crispin <john@phrozen.org>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org,
	lei.dong@airoha.com,
	Linqi.zhang@airoha.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Rajeev.kumar@airoha.com,
	upstream@airoha.com,
	Weifeng.xu@airoha.com,
	zhengping.zhang@airoha.com
Subject: [PATCH v3 1/3] i2c: mt7621: assert and deassert the reset line
Date: Mon, 16 Nov 2026 18:53:41 +0100
Message-Id: <20261116175343.344425-2-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116175343.344425-1-john@phrozen.org>
References: <20261116175343.344425-1-john@phrozen.org>
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

The driver resets the controller with device_reset(), which needs a
.reset operation in the reset controller. The EN7581 reset controller
implements assert and deassert only, so there every call fails, logs
"I2C reset failed!" and leaves the controller as it is, also after a
transfer timeout.

Get the optional reset line at probe and assert and deassert it. The
MT7621 and MT7628 reset controller does the same in its .reset
operation, with no delay in between, so nothing changes there. A board
without a reset line no longer logs an error, and a reset controller
that is not ready yet defers the probe.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: John Crispin <john@phrozen.org>
---
Changes in v3:
- Add the Reviewed-by of Philipp.

Changes in v2:
- New patch. It replaces "clk: en7523: add a reset operation" from
  the clk series (Philipp).
- Link to the discussion: https://lore.kernel.org/r/0c96f978571c569de6552fc11131e45b55cada1b.camel@pengutronix.de

 drivers/i2c/busses/i2c-mt7621.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
index 9ea5e3f9a763..7a31cc8b89ce 100644
--- a/drivers/i2c/busses/i2c-mt7621.c
+++ b/drivers/i2c/busses/i2c-mt7621.c
@@ -65,6 +65,7 @@ struct mtk_i2c {
 	u32 clk_div;
 	u32 flags;
 	struct clk *clk;
+	struct reset_control *rst;
 };
 
 static int mtk_i2c_wait_idle(struct mtk_i2c *i2c)
@@ -85,7 +86,9 @@ static void mtk_i2c_reset(struct mtk_i2c *i2c)
 {
 	int ret;
 
-	ret = device_reset(i2c->adap.dev.parent);
+	ret = reset_control_assert(i2c->rst);
+	if (!ret)
+		ret = reset_control_deassert(i2c->rst);
 	if (ret)
 		dev_err(i2c->dev, "I2C reset failed!\n");
 
@@ -288,6 +291,11 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c->clk);
 	}
 
+	i2c->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(i2c->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->rst),
+				     "Failed to get reset\n");
+
 	i2c->dev = &pdev->dev;
 
 	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-- 
2.34.1

