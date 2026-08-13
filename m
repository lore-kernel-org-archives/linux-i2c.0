Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE243BDA3;
	Thu, 13 Aug 2026 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614993; cv=none; b=doPGlIpcQsakwdFCbY1Onu9ZZQc7NI8uodECCrhjj5gdvrXRTaNR5Lx6xU3UGAc6DoxagHpuJOZtLZ1zSkUbY+paPKgnusTPxc4oBZF17tcdCutBe324Y9utdTmUvMcO64UmpSnx7/5H7DiTMLmbGeaJbAt078ASo7/vtb+2cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614993; c=relaxed/simple;
	bh=MiedI6KaLmuxYfgnsRyGNP5dSdjEge5bxfztrNW+85Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BxFKoiDgcHUWu8PkBfh3L0LDUJ69gNPTt0Aymiw7/l6QCBzwUCtTOqWQBMASDDs8Dwo44y36NeteJjT0vpCIk15EEqqoBhlU/6BPoMJgQmi3WOEAiKpTl3mlojlAIzZs1KZC+NeuZeoM5+8k6ee3ui2cEue+aaiOgvrysAXqdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3d8f5e9896fd11f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8a3528a7-2404-4a74-ab0b-fa0eb5884abb,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:9d056551a45f0e2e2df13dc33220b1e2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d8f5e9896fd11f1aa26b74ffac11d73-20260813
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1404435259; Thu, 13 Aug 2026 17:56:22 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@lysator.liu.se>
Cc: Xiaoke Wang <xkernel.wang@foxmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkai Gong <gonglinkai@kylinos.cn>
Subject: [PATCH] i2c: mux: demux-pinctrl: fix OF node leak on kstrdup failure
Date: Thu, 13 Aug 2026 17:56:17 +0800
Message-Id: <20260813095617.2246320-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_parse_phandle() takes a reference on the parent node. If a later
devm_kstrdup() fails, err_rollback only releases nodes for indices
0..i-1, so the current node is leaked.

of_node_put() the current parent before rolling back.

Fixes: 7c0195fa9a9e ("i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 1 +
 1 file changed, 1 insertion(+)
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index f2a1f4744978..2403c0bf7c43 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -247,6 +247,7 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
 		if (!props[i].name || !props[i].value) {
 			err = -ENOMEM;
+			of_node_put(adap_np);
 			goto err_rollback;
 		}
 		props[i].length = 3;
-- 
2.25.1
