Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905E394463;
	Fri, 10 Jul 2026 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667702; cv=none; b=mxV+M4o2yw2VRA++/U1vNp7aj4XUUwOzf60Fq+Cbzpqtu6WF+U4nZ1X3x3PQgzPrggGi+gdyZXiB1VBAVVZGPj5UUgDzQgUgXnZxRRvLLeRg4CwikcQeJQZfVgEF2r4D7aiUftEeg9OvPnXX+zAyPqP74KgN3Kb/PDSXkhEdSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667702; c=relaxed/simple;
	bh=2Cn35MZ8x0XVQzpU/ywbP5YqOKf1adgk6dOzj3RMaM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MSJ8k3XIGliCFX4fdt1Q1J6dsQvztOvD9qlZyw7Xp/poVAO5hcjo3IxekCMflG9/tEphJ4Ah58JLdICPMFzN4ltm9V57HkYEDwk7HjREisXiYoa7wgmKXWcmUS+sfC8JH3WsTwWUe39NN0Htbc+pl+dgg8lZZg2TUpUrtR2o2dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0c534f9e7c2f11f1aa26b74ffac11d73-20260710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3fda7a07-90be-492d-a724-fbdc6e4a7286,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:524841a8a8194384b88d989a6e4ed4a6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c534f9e7c2f11f1aa26b74ffac11d73-20260710
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 104388478; Fri, 10 Jul 2026 15:14:53 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: troy.mitchell@linux.spacemit.com,
	andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] i2c: spacemit: fix spurious IRQ handling returning IRQ_HANDLED
Date: Fri, 10 Jul 2026 15:14:49 +0800
Message-Id: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the interrupt status register reads zero, the handler should
return IRQ_NONE instead of IRQ_HANDLED. What the return value
actually feeds into is the spurious interrupt accounting in
note_interrupt(): falsely claiming IRQ_HANDLED defeats the "irq XX:
nobody cared" detection, so a stuck interrupt source would never be
caught.

Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/i2c/busses/i2c-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index c2d090f6ba80..487f23fde725 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -728,7 +728,7 @@ static irqreturn_t spacemit_i2c_irq_handler(int irq, void *devid)
 
 	status = readl(i2c->base + SPACEMIT_ISR);
 	if (!status)
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 
 	i2c->status = status;
 
-- 
2.25.1

