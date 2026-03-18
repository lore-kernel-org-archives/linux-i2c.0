Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C93988EE;
	Wed, 18 Mar 2026 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823350; cv=none; b=WT9c80pX0BK7vwWPjBYcBwfCfxHopIQVUsAuuaV6v31iycRgALoEtRN9LMj9gmWQkWANADtHNPhttMXv7qb+Atj8kR54ylzBuxv4uaIfKsS2aWzp9wqPJ6WeXa1Ld1ajIcT4s6XThWQ08irqQIus3b/AeIxQ+3sYF2izKxPqrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823350; c=relaxed/simple;
	bh=9byYKUji0cE7A/nKmZVXfVChA0vx+cBsLfTFs/W3+O8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SJo707QgZAuIHnt7P1+s/1W3Aql3BYF/f4zi0i2G1PN+jFucM4VMoSgd2oUL3dLD879LUFfIUKf50mg3ZR660QdUVW20ARArw25afwfRxnhpnzx+mm3GjCirqY3vyCQtzFJ6KnWw6KEQmj6QzagfKJYeI7fyr9u42ynYcc0dsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tBywKN3u; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tBywKN3u"
X-UUID: 601554ca22a611f1a39cd589f645bc18-20260318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZSzv/o3IHhli9mGR2+OsPwYiHpuhmCGiETm1UfYWuuI=;
	b=tBywKN3u1G/ya7u7NhO0JzqS+GRymu1zzTEShI2kVKvj7v82Qr2tKRc9zaP6KFSSlPmNR9koSS/A0QSQOxvR14i4RpZ5nByq0xoqUPDmvU8ian5rBZasxI4LHUC3t9y08P4pJFjbS6h+D8FMWNNfCkh1g0vMbnEHQCmGZGTIlDo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:520411c3-1f5d-4fae-a0e4-bcd1c3dbdfca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e57eef93-f8ef-4ca8-bea0-143568f9ca1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 601554ca22a611f1a39cd589f645bc18-20260318
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <adlavinitha.reddy@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1926677355; Wed, 18 Mar 2026 16:42:19 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 16:42:18 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 18 Mar 2026 16:42:18 +0800
From: adlavinitha reddy <adlavinitha.reddy@mediatek.com>
To: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, adlavinitha reddy
	<adlavinitha.reddy@mediatek.com>
Subject: [v1,PATCH 0/1] i2c: mediatek: add bus regulator control for power saving
Date: Wed, 18 Mar 2026 16:42:05 +0800
Message-ID: <20260318084216.4124272-1-adlavinitha.reddy@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This patch adds conditional bus regulator enable/disable support in
mtk_i2c_transfer() to allow I2C bus power gating on platforms that
provide a vbus-supply in the device tree.

The implementation:
- Enables bus_regulator before clk_bulk_enable() if vbus-supply is defined
- Disables bus_regulator after clk_bulk_disable()
- Only activates when vbus-supply is provided in device tree
- Has no impact on platforms without vbus-supply defined

This approach provides power savings for platforms with an extra I2C bus
regulator, while avoiding runtime PM complexity.

Based on linux-next, tag: next-20260305

adlavinitha reddy (1):
  i2c: mediatek: add bus regulator control for power saving

 drivers/i2c/busses/i2c-mt65xx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--
2.45.2
