Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9A246BCD;
	Wed, 18 Mar 2026 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821501; cv=none; b=AqLuulGfBHo0mV/DUJxIDV+6m89ExSJskznDMq7+HCjsF4IGo4igTayu6/xBjoXP61YIcn/7iPhUVG07hFJ5FqfU1XK/HUgjut8Dv4pOdHMQ327fOEdLqkfIHwljsEIoNBKka2j0qxxzLQmMy2+YxpQnrWz5OxsNrsr49YV2v5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821501; c=relaxed/simple;
	bh=mjXXuIHewfu+iEaT2xOPWa/ssz2EyIZUkW84O7ZF4JE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwWvaKurOPnH1+L77t2KyDg6/Yx+Oyk0BKvi4uRS3p9nNcEzk6xFswp9a99vziRT7UHeTvXS9UpZsM/Hm6P2WbBjZwgyRlHOf31Szmu5fhD+ONxdgjgMuI+YGVg30p0oPn2LXEv7ppz5UmV+YSbuZiycJi5lqZRVZz/DHQGfXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XZl7k9n1; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XZl7k9n1"
X-UUID: 125ef3ca22a211f1a02d4725871ece0b-20260318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jNAxvMlpKbnk3xa//SsNLWzTbu90yHBu0yVq6XBO01c=;
	b=XZl7k9n1mKsqSw/bMfl5uThekhr/yZA5hP/NpHlomg4BPJSfxkHJhKZGXftrR974MOKKGddhmb4/JD4KUX1YvrBQbAmo1NY+NtjXeiYXXITWAreLvPXJGwhM19EZE59kz/J0z/CoFMzruOUUNSKZBJEjc7lolYAWCryqzLJOmZk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1d9843d8-e908-4a83-80ca-dacde0d8d2b0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:13c2dbd4-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 125ef3ca22a211f1a02d4725871ece0b-20260318
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <adlavinitha.reddy@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 673715874; Wed, 18 Mar 2026 16:11:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 16:11:29 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 18 Mar 2026 16:11:29 +0800
From: adlavinitha reddy <adlavinitha.reddy@mediatek.com>
To: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infraded.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, adlavinitha reddy
	<adlavinitha.reddy@mediatek.com>
Subject: [v1,PATCH 1/1] i2c: mediatek: add bus regulator control for power saving
Date: Wed, 18 Mar 2026 16:11:19 +0800
Message-ID: <20260318081126.4098146-2-adlavinitha.reddy@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260318081126.4098146-1-adlavinitha.reddy@mediatek.com>
References: <20260318081126.4098146-1-adlavinitha.reddy@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add conditional bus regulator enable/disable in mtk_i2c_transfer()
to support I2C bus power gating for platforms that require it.

This implementation:
- Enables bus_regulator before clk_bulk_enable() if vbus-supply is defined
- Disables bus_regulator after clk_bulk_disable()
- Only activates when vbus-supply is provided in device tree
- Has no impact on platforms without vbus-supply defined

This approach provides power savinggs for platforms with an extra I2C bus
regulator, while avoiding runtime PM complexity.

TEST= Build and boot on MT8188

Signed-off-by: adlavinitha reddy <adlavinitha.reddy@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index cb4d3aa709d0..126040ca05f1 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/scatterlist.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -1244,9 +1245,15 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 	bool write_then_read_en = false;
 	struct mtk_i2c *i2c = i2c_get_adapdata(adap);

+	if (i2c->adap.bus_regulator) {
+		ret = regulator_enable(i2c->adap.bus_regulator);
+		if (ret)
+			return ret;
+	}
+
 	ret = clk_bulk_enable(I2C_MT65XX_CLK_MAX, i2c->clocks);
 	if (ret)
-		return ret;
+		goto err_regulator;

 	i2c->auto_restart = i2c->dev_comp->auto_restart;

@@ -1301,6 +1308,10 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,

 err_exit:
 	clk_bulk_disable(I2C_MT65XX_CLK_MAX, i2c->clocks);
+err_regulator:
+	if (i2c->adap.bus_regulator)
+		regulator_disable(i2c->adap.bus_regulator);
+
 	return ret;
 }

--
2.45.2
