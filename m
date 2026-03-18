Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB338F24F;
	Wed, 18 Mar 2026 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823593; cv=none; b=jlwnZXgyzGlPkjOdNjXfvwOsohOEAweoGCZwq/+/uKBXjQotbBnHG8nq6wfVVusO7ag87772tGe4wmDmlyIQPNCZMWwBjwxFTEHo1L1F4t58J3OCkoBPDm/zSVgvyEefHAur05TWwl2QivhcQNilyCMo6n3Jsggs7xKUfmhOI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823593; c=relaxed/simple;
	bh=mjXXuIHewfu+iEaT2xOPWa/ssz2EyIZUkW84O7ZF4JE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2PW4J8US6x8j0MNR6usUVWkFjR+4louliuW+LXIrBJY9ozQjWp9bRYnwnKsvxZeqvrEfflzAbA3+Pj/upy8PH99+X6ixjp1D31lBZsMQxe9OP88RJ1Ty29tLOK/+53uLoQCECeQCwhS+VOU6PQjhmWyV4Jgk7BuToOAgCn60CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=toI8xKgU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="toI8xKgU"
X-UUID: f2e5bdb222a611f1a02d4725871ece0b-20260318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jNAxvMlpKbnk3xa//SsNLWzTbu90yHBu0yVq6XBO01c=;
	b=toI8xKgU2WD1t7OZU/WLbYxyU9Urz1RDYoaA9HO1DNvwkhLlP771UG/nPjdG5zJAZZZIwpHh4g0/KcxD4utzAW4rplZlgLY3+e5AqYD9lULknxZYNfsemt9KWKtoJwaXksWJ5MTWsTXp28461lEcoapikLOToe9D19f4ByWl8fE=;
X-CID-CACHE: Type:Local,Time:202603181611+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:66e843d1-788b-4b4c-9c15-f4e5fab99e76,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:8321ef93-f8ef-4ca8-bea0-143568f9ca1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f2e5bdb222a611f1a02d4725871ece0b-20260318
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <adlavinitha.reddy@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 368408986; Wed, 18 Mar 2026 16:46:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 16:46:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 18 Mar 2026 16:46:24 +0800
From: adlavinitha reddy <adlavinitha.reddy@mediatek.com>
To: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, adlavinitha reddy
	<adlavinitha.reddy@mediatek.com>
Subject: [v1,PATCH 1/1] i2c: mediatek: add bus regulator control for power saving
Date: Wed, 18 Mar 2026 16:46:16 +0800
Message-ID: <20260318084621.4127757-2-adlavinitha.reddy@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260318084621.4127757-1-adlavinitha.reddy@mediatek.com>
References: <20260318084621.4127757-1-adlavinitha.reddy@mediatek.com>
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
