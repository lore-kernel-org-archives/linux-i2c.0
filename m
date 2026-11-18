Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009263;
	b=ZXNKOKEu0+Yh/y5huygOa6uvtUJWOl8jhlCIuR99JPxmADlJt/RtZRTrLNCqRvlH8j00
	 G7k44fqIEuF5WsWMHHsehrz2mHs2XHjQNBRKUiGYnUOWXKTi06vB9SRWFT2PvYCtPBZYY
	 ZqJI9KeRx5VWKp1fdFwqABqOFO0c9c1EJlqSw7cylYjeHGFmt+EOrmViLicfMOLlac0jf
	 E2WGW40TBIniH63cTNsWe3WusN/Z8xsT/7tC4ZyPl4ILoxd4rBBaEkYofGqfrtZhTkKbq
	 BNWfBSw7I1NSW32+2/FRZJDmEAtVRTiWqxzmjWhG56DA7bIKlUv41QXNmefvWB7e2Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009263;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=KZ5BCkqNb6oprSxD68qfjURy1vbangKtIh9R21+lBIo=;
	b=lQS7U6zyzP3pijuIDFf5jjqT3zEWQtSUAkPdU/W9gOvJSsDmqJ/IFBeTMHUXyRWPisIY
	 vVTko3FQrvF5psmVVRvxN8LASGI1MCETfJGcjqadZRl7jOtQ3Tg9O0/tKGo8hnaP+E3ZY
	 MGdG+6FA0jZaMuPa/VX91DeyGYU2WTQMSkEPyB/pN5zU+Fj5ug/whi/eUr7Km/11o5DWH
	 KgknxkEZifyVVzFCDWp7UWKTHVO0UPHQq+2TKpG8MjVLlVr20aHy0mb/EA8curZiuLqzy
	 5dHDN214jOmdPlTZaV4wi0fg2BCp8Cyo7FqSCrRQmE8y9ieC3ewUXbB+B13KVc0P4SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=r3MLFCNN;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23B606A335;
	Wed, 18 Nov 2026 13:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D23B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=r3MLFCNN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E20974E41636;
	Wed, 18 Nov 2026 13:41:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB8CF5FE9B;
	Wed, 18 Nov 2026 13:41:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8834A11BC209B;
	Wed, 18 Nov 2026 14:40:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795009260; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=KZ5BCkqNb6oprSxD68qfjURy1vbangKtIh9R21+lBIo=;
	b=r3MLFCNNbOt7LAY/0Shsphf2JysXbMTTxlI6pjahqSeJOIpEoWHsZ72hJ9SVTdUEYfx5MM
	CyhKadqlFZGzPzO8uRobZuylYQG8UM+jnVRgEiuwryvQBf73WaX0wlBOo5R5JjlEh7PoNw
	q9XXblIb3tOIEdCxR7tm+5yFOUwI1WZlY57bEhGCBdAParAdmtY4KLDB6kYEDOzV1TXiuz
	M+w45OoaaT8boo+b8w/8RITpIS6x+BF4uxoGfdVsxlhg4j/GDnaw8EwqOG8EtWnx6hJzuq
	1BDZ5SHei/Ar6iqy4xbOMmhJZVs4IAUX9wBuqZW/PeviATCKggWIuDzfof1WFQ==
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
Subject: [PATCH v10 5/6] i2c: atr: Set adapter physical device
Date: Wed, 18 Nov 2026 14:39:14 +0100
Message-ID: <20261118133927.366482-6-herve.codina@bootlin.com>
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

For i2c atrs, the parent of the atr adapter device is the adapter device
the atr is connected to.

This parent is not necessarily the physical device related to the atr
adapter. An ATR can be used in a split serializer/deserializer topology
where atr->dev is the deserializer, but the ATR channel adapter is owned
by the serializer device passed as desc->parent.

Fill the adap.physdev with the desc->parent device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/i2c/i2c-atr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index b98442ffff94..7c599d2d09c4 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -824,6 +824,7 @@ int i2c_atr_add_adapter(struct i2c_atr *atr, struct i2c_atr_adap_desc *desc)
 	chan->adap.algo = &atr->algo;
 	chan->adap.algo_data = chan;
 	chan->adap.dev.parent = desc->parent;
+	chan->adap.physdev = desc->parent;
 	chan->adap.retries = parent->retries;
 	chan->adap.timeout = parent->timeout;
 	chan->adap.quirks = parent->quirks;
-- 
2.56.0

