Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.205.14.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181304;
	b=lxFD6dUNYLDnXMh/FJxyyoxaZIAAC+5qlhH4+RNA9j+cp0BwxOcpVo71GcUTtjdCyQwi
	 6miSGxHRsy9zy8Dbv/y4sliLjBjumIfVnHc1DZ8uiMp5Mg/kaGbexkYNTRJJh1V8+gUg3
	 04uu4p7BUvqT6S5AfqFPEQD6AdeufkfoQCOHkrpmfYktch3sxH3KrchobCepFqdRcxGZh
	 3X91xHVwORB6edMTBOcahEyXOoKy/8ozKGYpVnDc/XS21Rtrp0Ebp27hTPhIdJk5fjlQd
	 NCqbzx6nf04YrzVx2zYMxEJba4EiGcznmUQoMvI7dsYgWSdMxuiQdsRwuBeyJXAt/ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181304;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DZS77L59Ek2ViaC60oqLxuW4xt6QbgAdQEKfk+T5Eaw=;
	b=MJe5+EWVKCMVAK8D8LUdvcFVgGSitpnOTBLdGFEGxXgHJqGQ9eMBqVczMxn3Q2V1QP2o
	 k8+Xsy0KYqPrBzDOprK2Lr+7iT/jA51uCih6P9tRkl9F71H9npuPvCTHqIcPVioxXfWNE
	 lJIK2cV3xOfIaZSfsxwS0LX/ZNu6cJe4+z6Eedc2/igp6bFRO3Ux2EZ7Es1B++Y6KzqBA
	 2VanoCQLUeuYOI/na5qUXt2MAvBsBdXOvCxZGCQDw0xEjge18pALux+n42Nj9eguAMFHk
	 aP5XJUhgbi0gxDKgwy/ONZypCqk/QdD8H7x3nhZAVrC37uMx5W5ogLp/Dc1alowgRnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gpxsee.org;
	spf=pass smtp.mailfrom=gpxsee.org;
	arc=none smtp.remote-ip=37.205.14.76
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D486606A32A
	for <linux-i2c@vger.kernel.org>; Fri, 20 Nov 2026 13:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D486606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from localhost (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id B8517BCF4E;
	Fri, 20 Nov 2026 14:28:18 +0100 (CET)
From: tumic@gpxsee.org
To: Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 0/1] i2c: xiic: Fix broken PM suspend/resume
Date: Fri, 20 Nov 2026 14:27:30 +0100
Message-ID: <20261120132731.9920-1-tumic@gpxsee.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Changes in v2:
- Fixed copy&paste error in the commit message (XDMA -> xiic).

Martin Tůma (1):
  i2c: xiic: Fix broken PM suspend/resume

 drivers/i2c/busses/i2c-xiic.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)


base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854
-- 
2.56.1

