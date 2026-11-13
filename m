Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577313;
	b=yzRy+sdy2pFKMYFJk6Y+PM698df4XNnYHC/M/evWueITNSZP5KODVtq4qC5Eichibl+v
	 zbZYFAAY4qC8Mtx32rlsDsyDUjU99K8NNEtGpf5M2LeC3Dki040UyPZa7cZHL7cOsL5u2
	 cfemnNYb0pm2BnqFMIz7LAnJuBdrcPU0lXP+yGJ9jEeGbQy0lWRMFEVvSHVCe7IzbW/ti
	 IEhKNXHm6ZSiia2JxbLIxTdPhTbPs8kLHB2OncaKKbUtBdktrCXm0KGFy+L50CvMghJJr
	 RMCEMpXNLNOpUaZKreK89zQii4tnQFiYnpHpdq4GKphSindqMpo741zidm4HtjPNkaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577313;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=U9bMuLXFJ2FMsWM0GwJ1iaBpzWhxug/BUnB7/e9omcs=;
	b=0RQhfoF008Ik5SOgrZccz+swVDYKif/Gj5A9rNBNCqRofkA9hpGpOO6TObp0qBtR+089
	 u3suPIyqWCsc2P9uvPUK5ETENiqS0Ksie9iU9dFUvkBJ+md0HibEgANd+PL60qAyso1gV
	 jR8FvHySLhZ2MSRMznuzM3W3LE2QnS5hoThAPbBmJi2nIQJv6e6fYkHqEf1LKD1vMOmbg
	 MrSh30duLAlTlHBFZoZ+wgfE+IOitkxV0fasgXR5/rXlvSFERivTmzn0kyXVR5ebNSMQR
	 x3tn9tPmNZXMesvV80algKHKHKgGr4vv2dbewKL0wydQ7tJl84LbfixdNZpTw8VR9pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VDKzo3vq;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4304606A8AB;
	Fri, 13 Nov 2026 13:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4304606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VDKzo3vq
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AE5D71A164B;
	Fri, 13 Nov 2026 13:41:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E41160015;
	Fri, 13 Nov 2026 13:41:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6DB611BC0565;
	Fri, 13 Nov 2026 14:41:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794577310; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=U9bMuLXFJ2FMsWM0GwJ1iaBpzWhxug/BUnB7/e9omcs=;
	b=VDKzo3vqjNJODs1o0rUYqfBm048cTbsp7TpmEu1SgW6Q3Klc81rmUyZkLUo//irAzW5tF9
	7hp2QxInvt3tfdKaSR6P9QdYuGWxrTRcijvV43K4VfkwRdaWT6PPINlcDb/cDEFD1v4iO2
	ZYE6FLaz+cUkmaRHYUu0tnPNLTSUirI83rpixdfuy7l7yG8/ZKWwVonhcRCOVssDbewaaC
	yTqdwkAHQdJzqDPwT4aq3zBeqzHVPVluhMp9pNcLxxPlb0ro3cvfVEJ8TlRswq0dKV0kby
	CwVCvlqiv7C+elDBejHs5i0VbJ7mAKtWjS4NiqMdDhpwfQe5xTJzSCresk28zw==
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
Subject: [PATCH v2 3/4] i2c: thunderx: Set DMA mask
Date: Fri, 13 Nov 2026 14:41:27 +0100
Message-ID: <20261113134128.58826-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113134128.58826-1-paul.cercueil@bootlin.com>
References: <20261113134128.58826-1-paul.cercueil@bootlin.com>
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

v2: No change
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

