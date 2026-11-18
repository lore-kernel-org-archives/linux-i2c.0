Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009247;
	b=1spue5RFh8RSQ4ghhCAOUfm90W4CcNICqun1j0LaAt0+gWtXiZE31s6eMD4BeDPeuXhB
	 n83/gS6EIWr/M0gWvlXfS1uJwTh7rfRlen5J1Ecg6+ctabF/4HDLK21+4E/Ivc3kKKmWT
	 macQ939X+ceeUwomzb6i8W/vxP4dDn7T/zHg2/ZrJ2hhNYt6iV/hFBe9R9hAc2eB3MjeT
	 KjHzgUmS1xbHb9JXj8sNRXd2dY8ccr9g6mqpDm3baMjFU6uCpOl6j1m0fGA0TeaQOiyXR
	 xS96UP3wm/cM/q3dNd4CTAxlPpLvm1h3EAPFE80tthiJ3Y00tLCTIjkmSNVLxG/gOgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009247;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=2qVAOETeikmfZ9XOZTrGBSYB6uryKL0euE5eUgu0EAw=;
	b=u1QQ6SNJauZQgLxI/5cYUahUwAvaIGOnstOhQeQmT11tYkYp/g/jROnE7lz00FMrNKYz
	 vpJ97SikJpjwMI5PXeJtxwJJuHDoya/eTLpyoJf3NqkXmSYz98W7DfaIf43eC1cPpJz0i
	 OXVNBNcBnpRtLN0vRjFQuNtuRF3/U2+X4uux0CdzSP46i1obHLDhLSl5cKMt1b34LeM3k
	 xuAf5KOnfDHdiArc5SZ4rTyh5NN7keZvR2S+bYHYUXd10Wqm/G65E4SsuAm6Y/BFQTCPH
	 1i4CelwNQHKrR6H/b3TqWHBZLbw6KfMlwxI1uxzuHupWBSo3nwZyqN0XYMGdaKgx8pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RlL5Ebr8;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C5606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 13:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 733C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RlL5Ebr8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EFEFEC4CBD9;
	Wed, 18 Nov 2026 13:40:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1EBE35FE9B;
	Wed, 18 Nov 2026 13:40:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F66611BC209F;
	Wed, 18 Nov 2026 14:40:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795009240; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2qVAOETeikmfZ9XOZTrGBSYB6uryKL0euE5eUgu0EAw=;
	b=RlL5Ebr8lJ/Zs6rK0GvCXL8/1oNAm5sQA6NVYDu6fuUaLzXNpcVAl4oM136GigLbBBLCwN
	rNFTXjaXxawWwLVr9HgtiTuJlj8iCBSVxoJUnCl0dbN46x1WEXdC9BTeOcjDmgf7mbf7+F
	C+Zx/7mlcfVMqRXiABr7+Vy9rdDxYg1BqGCnTT6C4mfcpk7JABpweBdMPFpAFdDOXS4ogw
	5WGRUarH3Xi5wg5kQc4vl1oatarZIZZ+4dxfT6HYrHhX5q88GM1kguWBLfi0FraheTAAM0
	9eQaDC5dCoYmo3MNdn5Qgsl/qQ/m5qsxlfemNMO5LRhvNdzelADsGLq128CIFQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v10 1/6] media: rtl2832: Use I2C client device as mux device
Date: Wed, 18 Nov 2026 14:39:10 +0100
Message-ID: <20261118133927.366482-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118133927.366482-1-herve.codina@bootlin.com>
References: <20261118133927.366482-1-herve.codina@bootlin.com>
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

rtl2832_probe() currently passes &i2c->dev, the driverless parent adapter
device, to i2c_mux_alloc().

This leads to the mux device set to this adapter device instead of the
physical device handling the mux, the rtl2832 device.

This is an issue when consumer/supplier devlink are involved. Indeed,
the physical device with a driver attached need to be pointed to by
devlink.

Use the rtl2832 device &client->dev instead, as done by the other DVB
demodulator drivers.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/media/dvb-frontends/rtl2832.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index b31cdb44b383..57707d84701b 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -1075,7 +1075,7 @@ static int rtl2832_probe(struct i2c_client *client)
 		goto err_regmap_exit;
 
 	/* create muxed i2c adapter for demod tuner bus */
-	dev->muxc = i2c_mux_alloc(i2c, &i2c->dev, 1, 0, I2C_MUX_LOCKED,
+	dev->muxc = i2c_mux_alloc(i2c, &client->dev, 1, 0, I2C_MUX_LOCKED,
 				  rtl2832_select, rtl2832_deselect);
 	if (!dev->muxc) {
 		ret = -ENOMEM;
-- 
2.56.0

