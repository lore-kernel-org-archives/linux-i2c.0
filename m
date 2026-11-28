Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795858930;
	b=wGSw75MJxssls3Y9sshJQaEYrjAySxRobfqxCNNiqv5zqSZew5Inr8CujU/hPETM7AGR
	 arpVNGnJHHxwrlw4cwufI5zOWb+eGB2FgFf6pv76gCBmzWl/BnxsKtMDlMIa788MsQILW
	 ASkzbVDFpBH8dBRRtDDiIFI0kNBj113eywmGwtWaP87MdR2TY2moNxfMTcQi9xCSUxxqc
	 VyLUYe77KBv9qISupjTmz7+lqQtKwef0JVubS7g/vfikXUIf6m9K5qRN5UWOf4+zyRw2a
	 yAoikAo914Mv1scP/kd17OtdE3/n0E8O05AYVjbEQm7CKYGi9y8Llu9hrar4WTK4sLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795858930;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=LeTJPQ8F+2oDfibSjW4LKZzG+pGWKb7dMHJ7EBLdZmQ=;
	b=hsNyy6ku0dwElm1Q2iwyPo2b30XLdQ9kkteTjuSWYWAczIehvSnTUbpMhSJM+DYjT6yj
	 nPva4IOptRXxriq2LN8lCns35vOCrJjV6fqbtRM6TF3ao5nKzX6aC4mHHO0CaD9epg3he
	 LYsUEPPw/B9ha13nv9jb13fJjsDbgq1bklvlawQ3PinxunW0DkwAuFUK3hXnPMuxJgk+z
	 1aQMc6pXZoIg43WEdkr2EKvkG/qx54nLclVRc2vZSaQE/jKt7P+s4b3Gd8ilgmEyCwvSp
	 CGqXr5ogoJf8H6Rn9KqnplTkm9wZda4vVmlRU9ZWNh814Jw3cEN4oIqClPYi/np0tzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=L16Tevyz;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D1606A31C
	for <linux-i2c@vger.kernel.org>; Sat, 28 Nov 2026 09:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D9D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=L16Tevyz
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5655b0816;
	Sat, 28 Nov 2026 17:42:06 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: andi.shyti@kernel.org,
	afaerber@suse.de,
	mani@kernel.org,
	wsa@kernel.org,
	peda@lysator.liu.se
Cc: linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org
Subject: [PATCH] i2c: owl: Fix potential adapter use-after-free on unbind
Date: Sat, 28 Nov 2026 17:42:05 +0800
Message-ID: <20261128-f81b700d6c-u02-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa221888ad103a1kunm52475e97451dd4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGU9KVkgZTx9CHRpMSkNJGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=L16Tevyzygb2yz/VcuIPL0qFotMEHbXNTzdWBL9fGrBOo6rEFjXrOrIbu6AfDStzCybqmVnFbevCN+ofwx4tkLUf4f6lrKBAa0sZ9EECAUcvlWB5ofCAZq8dYJGFaGg+F4ox4oZTZ+2LFTQfDiUHQVWGB03BUk22mpD6GBmYjko=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=LeTJPQ8F+2oDfibSjW4LKZzG+pGWKb7dMHJ7EBLdZmQ=;
	h=date:mime-version:subject:message-id:from;

owl_i2c_probe() registers an adapter embedded in device-managed
private data. Unbinding the controller frees that data while the
adapter remains registered.

Use devm_i2c_add_adapter() to unregister the adapter before the
controller resources are released.

This issue was found by our static analysis tool under development.

Fixes: d211e62af466 ("i2c: Add Actions Semiconductor Owl family S900 I2C driver")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/i2c/busses/i2c-owl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index 1937a2467512..f122a60b24a6 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -495,7 +495,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return i2c_add_adapter(&i2c_dev->adap);
+	return devm_i2c_add_adapter(dev, &i2c_dev->adap);
 }
 
 static const struct of_device_id owl_i2c_of_match[] = {

base-commit: eeb63983deb23d68ddc47e5d1944a7d64acdaf22
-- 
2.43.0

