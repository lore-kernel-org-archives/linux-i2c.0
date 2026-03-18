Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462633DEDD;
	Wed, 18 Mar 2026 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823591; cv=none; b=JV/o5Iod6CP3NI8ESmvxgWmeKXFDjqXVMx80Gv5E7oB3oE2H+aX7AdWFu8JGqGdnx+yskTUxJQ0NQhP4gpXNA5Fb94PjvLkmafXcXH+z8lAN/FC7u72HY7kNDTMxOkmueb/toZ2DDl8ZG1BAuYteKtHpoFH6m1IG6P+lztlYhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823591; c=relaxed/simple;
	bh=9byYKUji0cE7A/nKmZVXfVChA0vx+cBsLfTFs/W3+O8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/p0HV4eF5E2IQ+cfuPcS01FhoRaXmOb08bpu3JLLgka1y0IxdSw8c6PGxMybCqTcO7xBYS6HsuKn5GJ5Y8cNz2+B56UVHe0DaJWpk1D/ys7ZD0ST+P08tDGKPwYclQvQGbUxy+5xMpG+FsbD6vi8pyIBjmr96P95EcLyPgcqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gAEamYto; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gAEamYto"
X-UUID: f22d444e22a611f1a02d4725871ece0b-20260318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZSzv/o3IHhli9mGR2+OsPwYiHpuhmCGiETm1UfYWuuI=;
	b=gAEamYto2n7vPERXQDRlqsWFU+ali0IJSPILdHd3HRXXn5vB4hUTKQDvBCGjtjVAD3aNv+MTEUc290cLVqeLNnhmtY+ACbzT1un44AZIRupD8IKzDQGO1Z8t5cVvGp6JteyudcbV7SPAK9ckTfaaRAoljrTHF7BK+r/AjYfhudY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:de17a95c-5253-45ed-96ad-c615dfe46e1a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:ad61d716-aa6b-4b2e-be76-373ef1a42b04,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f22d444e22a611f1a02d4725871ece0b-20260318
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <adlavinitha.reddy@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 796346240; Wed, 18 Mar 2026 16:46:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 16:46:23 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 18 Mar 2026 16:46:23 +0800
From: adlavinitha reddy <adlavinitha.reddy@mediatek.com>
To: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, adlavinitha reddy
	<adlavinitha.reddy@mediatek.com>
Subject: [v1,PATCH 0/1] i2c: mediatek: add bus regulator control for power saving
Date: Wed, 18 Mar 2026 16:46:15 +0800
Message-ID: <20260318084621.4127757-1-adlavinitha.reddy@mediatek.com>
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
