Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789374;
	b=0jiFxhMcnj80gucMVMEIQF2BD3IzFdfTi0IFMsYjlmZxjLq+GbzT7GULlbQr/UA6iNwc
	 Dyb7xME9vqwpLQZiuMea3W5UJbdYkh8SQzItEa+qahjlRaQuzHvQzGIb5YkMyq+/Mdq9n
	 +NYi1ofiM6n+BBOUHqtZqZClrkHoW1qrycHuOIUYpPChZTwSUnS6cyKnoaYQeqaAaulMi
	 z7uHUr7zSeRZ7zMIOolqqDo5g2hxIX+vtaOlYHZvihnF+A+6wi1CUYBr7ukKDsWBjC01c
	 5RTRgWfBxB4E7Oa4EWShYSqhJSC6vGTQdY0OavAPxmW3e+jhx89nTp/F6qY2V//lqsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789374;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=aI4EIZNxMoprUdCGvASntRDiuaop22syyWJWgaD/hhQ=;
	b=32fzCK/6urQHwWzbSDJqonZnHsjYgfSZIZUlrvaslYf+qMbj3C3eYEOniZb2aAmULQL4
	 RQF8rCl6hD8AU+RyQoH2DuoX7sTkzyZtLYQr89VhihCuN/Fa/J1vl2QYUsNBeAyzhJt3q
	 MXLhQLkkIySPcGkf/I8RISwWpsqxZgWgl0qgJEqQzS08HFiq7hs8gK0hWnsytpDet/TjB
	 qrb+tn7dS9DTCTeWNeek9ZbBkJX34WjIp4rQ24dgjmCjdv0EL1eBf1dJYSSVkCxqBFFFV
	 tezLiU7xO1ODWlnbuGo5gG9H5LWTD+qc2Yomhf4CLs66YZKUrUPFn3VO8eqTzBDVEGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Nc9ijgvo;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D47606A326
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 10:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D47606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Nc9ijgvo
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0C69E1A1455;
	Wed,  4 Nov 2026 10:49:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D624060770;
	Wed,  4 Nov 2026 10:49:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BD42103291D2;
	Wed,  4 Nov 2026 11:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793789370; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aI4EIZNxMoprUdCGvASntRDiuaop22syyWJWgaD/hhQ=;
	b=Nc9ijgvoOPaVD3JjNxp4TrkUWCXvJfVSA7Gz//GSu7l6f9iaXiLK61WkKNRKyRlUIwR7zo
	7FE0kZGM+RBek+cuVSC3SygzmeA1EpvWUVScm+CsZoR3Apou0U1tVBSCCVybXjchfyo6ve
	sDJ8D6sd9uPlY/MS6cGjDxVNaBwQmCUQkVjGNlY2d2W3W7OYYtS2L2HRoBZFuBYhPZ+bU5
	Y0UXcGVahaD6nXpiziHX2SruZBIQ/wtBb11y+giOIFBU3XDJTbs2TNMtTD0PA0caWgiugm
	m/BeUkOcGBK6XBh+pFl/tOkhk20XG9SAxTgUG5DsLtobbtnR1wHf2eUzIAvv7Q==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Robert Richter <rric@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Umesh Kumar <ukumar@marvell.com>,
	Shashank Gupta <shashankg@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 2/3] i2c: thunderx: Set DMA mask
Date: Wed,  4 Nov 2026 11:49:11 +0100
Message-ID: <20261104104912.166301-3-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104104912.166301-1-paul.cercueil@bootlin.com>
References: <20261104104912.166301-1-paul.cercueil@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

Without it, MSI-X initialization can fail.

Fixes: 4c21541d8da1 ("i2c: thunderx: Replace pci_enable_msix()")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index 3959f23fc440..2208337e649b 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -198,6 +198,10 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 	i2c->hlc_int_enable = thunder_i2c_hlc_int_enable;
 	i2c->hlc_int_disable = thunder_i2c_hlc_int_disable;
 
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
+	if (ret < 0)
+		goto error;
+
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 	if (ret < 0)
 		goto error;
-- 
2.47.3

