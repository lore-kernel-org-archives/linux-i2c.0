Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.4.11.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509914;
	b=1SHmIOBrqbscNv2J0W5Bm3LiiS7FMkKS6X03uAOP8iGKpK3eOKEpGnYRbO8CUjAEz2n/
	 4wrsv7v09LwcU0sNXm8h/6Un5fTR1rYBnCaWa6EzYc3siox1IZWYmP2VqIM+q0wzuj5uJ
	 WnkR3Gou/J52Dy29eA62XEQWMLF6E46nur2C4rvI5vv73I6QSjtMAbwXowDhjyqewob9o
	 EsiBpy8A2KkCjPHUhraNManP4eCpbqltE/EyF+UIdUO5pi+8aG91MpHDXrziX9Pl5qmZp
	 9WthXd5PfpS+YwAXko4UkRpmfAwy9r6EXeXG6O5Q0d3wdEIBbebK4l90GUiPCe/cAkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509914;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Wh6e5KCC0TYqtKn5VL+37AXMoQzEPx5YcWH45hh6xlg=;
	b=ghh0TCoghmSEZDLSbT6N5OSN11yANmIqV5XRwh7WM6yZ3QJtR/zejjkV/hSXw4vo//kN
	 arBiSohRcl3etXUjQIuP9e8g69MFR6UiIicN+ct8hQ+n1eS7U041a+kLsNIRNBq/T3gFH
	 7wCaf0srVlIjXbzvOhzgxGJPVYmZU+bFtQf+uLni8JK5nVNynsQRg8HO4hWbc4hS1sxoH
	 4x0jcLJUYqbzFUQvmJbsTf412yi6Awz6vfLucbr8mndiMFRLBmr+20B2Pxj4T4wC4DONY
	 LV7jebPvCUrYTmOVNMVb3SyMLI9al1vflqFxpQG7nB/vzs/gDVuYp/Jb+MKdzkmwuYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phrozen.org;
	spf=pass smtp.mailfrom=phrozen.org;
	arc=none smtp.remote-ip=46.4.11.11
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B7F606A323;
	Thu, 12 Nov 2026 18:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B7F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1403:f2fc:83ce:6656:246:c906] (helo=bertha10..)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xRa0B-002Xe4-0W;
	Thu, 12 Nov 2026 19:58:27 +0100
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
Subject: [PATCH v2 1/3] i2c: mt7621: assert and deassert the reset line
Date: Thu, 12 Nov 2026 19:58:18 +0100
Message-Id: <20261112185820.1315718-2-john@phrozen.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112185820.1315718-1-john@phrozen.org>
References: <20261112185820.1315718-1-john@phrozen.org>
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
Signed-off-by: John Crispin <john@phrozen.org>
---
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

