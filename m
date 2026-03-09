Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5E36A03B;
	Mon,  9 Mar 2026 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042661; cv=none; b=TeklD+XzH5LeyOH3hY+kDBO4k9x+qDQNDtUIJf4VTRkhIwAdhxHdaI9a63BfwjQIvH9fNyxKFBtirL+SSXZM1TGh8HcxaipPnC2APPIaaY0k3fMhNkwyhzTLaWSorgCpd8b3HrlLSewzaNNTFpdH7KoC536jh87s0/7Q9oSENHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042661; c=relaxed/simple;
	bh=shRqt4ibkDpO8IGfX/VGms0fW0dbkx0Md28XAYFFVAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8mJ3ei5V+a7vFn1rdc6Gqbdhek9pHowRbtZKEDyqrRFoSoPH2duJo+GJxRV6ff3GZYUdH1/42u2WTN2Ie+aQPT0MlXp3ue37CdcNbbhhEYQYx7C8jSWmytrO5VGN5gt8c4lXBpUVfjDKzTKmPvrecyV1B/XLjrzxwUzVE+th4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXh9L2tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXh9L2tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF3DC4CEF7;
	Mon,  9 Mar 2026 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773042661;
	bh=shRqt4ibkDpO8IGfX/VGms0fW0dbkx0Md28XAYFFVAY=;
	h=From:To:Cc:Subject:Date:From;
	b=WXh9L2tfBJq5rOmW1mre07xqFt6LJUyjbACnY0a8kWSEwOZSFHD3n5SdBkmwqYTV+
	 R/IM2ykuhzrKcdgNR+jLhLqTyyAF+PRwehLuwdZFpME6k/6wu0PPg2Z/bpvhpBfUx5
	 SIFH1iTeDFXS7VvKTEThR+oycUYRaI2bHVf/3qg4QQaK76cXWJi/8C3vgzd5yzBOfb
	 ySQxTPU0FNmMMhb942pNp6XoqPrxpTShon0BvBLDS1SYobJqJnHbaMJ6cVz0A9KISu
	 /UAlhIMt9v3bI+gk35D5xpsCQ5ztx6u90O/aZakmuz/qr3tSC3e2WB0UITNc2qwQzg
	 Z35c4csTeOfRQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vzVOE-000000006fn-37jD;
	Mon, 09 Mar 2026 08:50:58 +0100
From: Johan Hovold <johan@kernel.org>
To: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: cp2615: fix serial string NULL-deref at probe
Date: Mon,  9 Mar 2026 08:50:16 +0100
Message-ID: <20260309075016.25612-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The cp2615 driver uses the USB device serial string as the i2c adapter
name but does not make sure that the string exists.

Verify that the device has a serial number before accessing it to avoid
triggering a NULL-pointer dereference (e.g. with malicious devices).

Fixes: 4a7695429ead ("i2c: cp2615: add i2c driver for Silicon Labs' CP2615 Digital Audio Bridge")
Cc: stable@vger.kernel.org	# 5.13
Cc: Bence Csókás <bence98@sch.bme.hu>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/busses/i2c-cp2615.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index c1dbf7961a02..951de6249834 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -297,6 +297,9 @@ cp2615_i2c_probe(struct usb_interface *usbif, const struct usb_device_id *id)
 	if (!adap)
 		return -ENOMEM;
 
+	if (!usbdev->serial)
+		return -EINVAL;
+
 	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = &usbif->dev;
-- 
2.52.0

