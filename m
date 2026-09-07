Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DB409285;
	Mon,  7 Sep 2026 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765072; cv=none; b=jmbBs+FYXcsS3vzPch/IGltNcAylS6YRtc4yekfg3dOQmWmfKYIn2ujSV/QbSzMpPCVKiu1uDMgoikTuxVrusQLqiXdb5uoLQQa1eLMKJWF+AEYUinFWZMG/QHbVHT+QygJd2dZ0RRGNpORw1JeR7EzDZRAYGQdQJrsTfkTRHbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765072; c=relaxed/simple;
	bh=stKdDENq4FBrWsQ2w2yXCmKAWsJ/eyYa+AVK9g6EpcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/TFKn1USHuzFjtiiuuWyKirysq/NreW2pReP5VHXcGl//ySCoMae3xxX+ei3umhZXLVANmJGnEFZqytieJ3/R06qT8qQ/QVNcfaSthYBPPEpw/11fOBqkrM2m7I3h2R0yXkSl9eAFSzNR2AMytDwaQQjnMa9aoXlDA6NNV4ajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4a6542e4aa8b11f19a56ed5b684f684d-20260907
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:13e6a1e4-e9d8-44ae-a833-fd8965984f6b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:9a3d817c95918b6f2dfeba7d3983ecc5,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a6542e4aa8b11f19a56ed5b684f684d-20260907
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 730491310; Mon, 07 Sep 2026 15:11:05 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Andi Shyti <andi.shyti@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: atr: fix dangling adapter pointer on add failure
Date: Mon,  7 Sep 2026 15:11:02 +0800
Message-Id: <20260907071102.1080840-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806073545.2071006-1-gonglinkai@kylinos.cn>
References: <20260806073545.2071006-1-gonglinkai@kylinos.cn>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2:
- NULL the slot before the error print (Andy)

 drivers/i2c/i2c-atr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index e6d2af659d81..ca29633dcd62 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -855,6 +855,7 @@ int i2c_atr_add_adapter(struct i2c_atr *atr, struct i2c_atr_adap_desc *desc)
 
 	ret = i2c_add_adapter(&chan->adap);
 	if (ret) {
+		atr->adapter[chan_id] = NULL;
 		dev_err(dev, "failed to add atr-adapter %u (error=%d)\n",
 			chan_id, ret);
 		goto err_free_alias_pool;
-- 
2.25.1
