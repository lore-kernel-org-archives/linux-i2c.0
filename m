Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013982;
	b=1L3XANhhkql8Ne+Oht6V7p/k8vuU0rr087F5jjWEKp9AAW5HyDFVJBKslPg4DSghIRyE
	 wb+5ZKeObTysjtHetfkCkuh2OH01Q0hyI/CKyrU+gsQrX/7weDy9wVM9wh5diAMteTWXQ
	 9ueCWDqzGq97UfJIlrZt80DgO9ZLZLnEGUEhG6uabDuehAgfqrDqAKQVuzpqXlcuHVDuj
	 0fXLrcpUhW6b5XCLKVu+GLwVmLoq5gMMLTFWqxlxNkCyfqfA893qXG7N3RmEgEW/amwkN
	 aixqZJtdmLjunPcCd7apIUIypGEcJUhs+I3cPhRcYRqVAi4i65PFv6XoMPa/0zyp8/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013982;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=00NRVCjpBr/GQbeNssIlABrei+k7HVVzsoFigaJcfqg=;
	b=IzHLQAmSj8YB2I9aUGM003TlXDPY4TNLXUy+LCA8Tm4caAPF4tKFRhq6uGasMAtUgN7+
	 3FhnTXrZXhu+PHVm/DJRDeEtYHNNJZzgYrpLj8wJGEqc6iXKFC3HrEXlD43S/8KKcIZAM
	 dSQXKau3YeY6nlOWkUvjuUYcQuh5XjzLas1UzsmurAbkvdhfFQp9cpx2V3H5qD85kJffM
	 T0/9123Ik94i3MiXkBN/STKMGFyQf67LIqoBDgQE8PxJwuMJownbuCZQ3MKWojEUyWCei
	 qi1/QW3d3K3O4/3ap737X0secZoPRJyVwrR4Id009gkrvYmDT3TrKztC/zSVNsiApVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="HbTM/tPk";
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E871606A31B;
	Mon, 26 Oct 2026 11:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E871606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HbTM/tPk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=HbTM/tPk1ukSNOGklNtWQp+Au48uO6yaJH6xxvmAmpU3t30ZK/5YJJUYngnL3u76U1PvT+rySbAQx
	 u+pYigXEmNanb8WoTBJsjuq6cklcRxn0w0JQ6nsycsJ2mGIlgrb8CO1tjeTjfet++E4lpRPsCP2/DB
	 I7gagOsq+rUwTRUQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86adf38cdeed-ee43f;
	Mon, 26 Oct 2026 19:26:10 +0800 (CST)
X-RM-TRANSID:2ee86adf38cdeed-ee43f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W6400298 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16adf38d00d3-b1450;
	Mon, 26 Oct 2026 19:26:10 +0800 (CST)
X-RM-TRANSID:2ee16adf38d00d3-b1450
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangbin@cmss.chinamobile.com
Subject: [PATCH] i2c: hix5hd2: check clk_prepare_enable in runtime resume
Date: Mon, 26 Oct 2026 19:26:08 +0800
Message-ID: <20261026112608.2767-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
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

hix5hd2_i2c_runtime_resume() ignored the return value of
clk_prepare_enable(priv->clk), then ran hix5hd2_i2c_init() (register
access) and returned 0. On clock enable failure the hardware is accessed
with the clock disabled (bus hang) and the matching runtime_suspend()
clk_disable_unprepare() unbalances the clock count. Propagate the error.

Fixes: 9242e72aaea0 ("i2c: use dev_get_drvdata() to get private data in suspend/resume hooks")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index 95ab910b8..90d38c478 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -486,8 +486,12 @@ static int hix5hd2_i2c_runtime_suspend(struct device *dev)
 static int hix5hd2_i2c_runtime_resume(struct device *dev)
 {
 	struct hix5hd2_i2c_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(priv->clk);
 	hix5hd2_i2c_init(priv);
 
 	return 0;
-- 
2.52.0.windows.1



