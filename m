Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878DD17D6;
	Fri, 10 Jul 2026 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668088; cv=none; b=tLnA3YnaBs0nJI9MRbkEeeDwVsAtgzBDAuh6wQRzuAfg8oZeC7eP+uFKnvwZ6SYts/u4S8k8nmsWeKbFUiLmcbWeshXH6PhLGbp1NXrb7ekOPE25PZXpk1oO3KUetSBHAFL5e5qYRMue9ntE5iHp1itEciaRUK8eDteKJ0puvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668088; c=relaxed/simple;
	bh=z4L4ZkQYHyig4URT0kCVt9O/hFGJluUXU4oaiBSG8Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZEbm5WMxZ6a+3Y1gsM4rmAxZtNyp7k8hqmS+8UYXgaUFRTGBJX4qLDIfhMDcGWuulwq79IKffiLs1GzCFWQrHUMXJ1DZ9KexWSz+n5u1KjXCY2ZHy1qsc6FEQ3BGKGBMt78hdDDIwuSNt2O1gGTGgMfiDiL/6qBjETG2EblzNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f0e909327c2f11f1aa26b74ffac11d73-20260710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:36a2410f-9e0c-452c-8314-d28fac6f15b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:014e708fb9bc66c8bc41b1640a6d7c68,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f0e909327c2f11f1aa26b74ffac11d73-20260710
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 288467373; Fri, 10 Jul 2026 15:21:17 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: xiaopei01@kylinos.cn
Cc: andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	troy.mitchell@linux.spacemit.com
Subject: [PATCH v2] i2c: spacemit: fix spurious IRQ handling returning IRQ_HANDLED
Date: Fri, 10 Jul 2026 15:21:13 +0800
Message-Id: <ef8b623f45d4e430721e46572c2598d882044aed.1783667875.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn>
References: <ef8b623f45d4e430721e46572c2598d882044aed.1783667603.git.xiaopei01@kylinos.cn>
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
changlog in v2:
modify gitlog for Modify the incorrect Git commit message to match the reason for the modification.
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

