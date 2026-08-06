Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD43DAADE;
	Thu,  6 Aug 2026 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001762; cv=none; b=jX9yR7VmuUGxRMFwEdeECRIV0DAcC+Ju9jY+h4ITpA9h4RO8vCHnpPAjIHFyveVK9nke2bnjPs1jIwXByr3lJZAuNrOopwn7txAxNL1DXfzHjcqMND5e0VQgG4LMrtVacUxiX1LT3VYH+IjelvYaHpWLfFG/uyTaHXzCd/RN+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001762; c=relaxed/simple;
	bh=n3CgQc6cr8NIPWAvu2gNIr+czxIWXuX7zNEnrFyF0JM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ob94GV5fFWXERkJ02kkBoqSaq+wqq2KJ+kWXaCLwsbG+xap6YDhyZcaf6p41PGcp2BTUiEoNuKZ84UYG5wK7xASTtq9Cuhc29tD4WyjNDt8VaniGl8/PXyNs+66JJ+iUSU2k6pd5xubEj1STbuWHDnd/nt1wTmawpscn+mYQ9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 729fbb76916911f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:292a5f31-a8e8-4978-b914-960b1a9fd88c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b8043f765498b3bee6be253de84e874b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 729fbb76916911f1aa26b74ffac11d73-20260806
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1608544811; Thu, 06 Aug 2026 15:35:50 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Andi Shyti <andi.shyti@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linkai Gong <gonglinkai@kylinos.cn>
Subject: [PATCH] i2c: atr: fix dangling adapter pointer on add failure
Date: Thu,  6 Aug 2026 15:35:45 +0800
Message-Id: <20260806073545.2071006-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_atr_add_adapter() stores atr->adapter[chan_id] before
i2c_add_adapter() so that the I2C bus notifier can match child clients
during registration. On failure the channel is freed but the slot was
left pointing at freed memory, which can lead to use-after-free in
i2c_atr_del_adapter() / cleanup and also block reuse with -EEXIST.

Clear the slot on the i2c_add_adapter() error path before freeing chan.

Fixes: a076a860acae ("media: i2c: add I2C Address Translator (ATR) support")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/i2c/i2c-atr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index e6d2af659d81..729d6d88a39d 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -857,6 +857,7 @@ int i2c_atr_add_adapter(struct i2c_atr *atr, struct i2c_atr_adap_desc *desc)
 	if (ret) {
 		dev_err(dev, "failed to add atr-adapter %u (error=%d)\n",
 			chan_id, ret);
+		atr->adapter[chan_id] = NULL;
 		goto err_free_alias_pool;
 	}
 
-- 
2.25.1

