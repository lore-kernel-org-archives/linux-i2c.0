Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D744781E;
	Thu,  3 Sep 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434079; cv=none; b=m5Vcr3C0ca+NLlclUSjRaj/FFjQ2Q5oXZqCVTMXsaJfxSvTt+M5gKj4oVULtcH9KTV88r/Pieo/mVWUxGlgFCNGaE4c9IVcY40NIojJRp7dzfDrZyDSwww72/4ferYB4yQJue+HmOCdmxEAYopK14QKWhBZTC2+40tFiNAlcw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434079; c=relaxed/simple;
	bh=G15+ORPn+dU9CywoDSRKd0f5+vpXAUFGBgzrL2py14c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GJjFhtV4liq+VRE/H0a+QgJSygKvE9QhIDr3EV++Rs0Bs6Sds1FbUCMd0u5UzGLDh/WtPFhZbSk3RWCcyPjzRb8CG7b0l4G7A4JI/oHOKUzajQ3ZJZ26C5SdwjB+Byo59lB/uNZg8vJIUcqjkILLeUqbBdbArfshEoMfK2Kpp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 08234C3EEAD7;
	Thu,  3 Sep 2026 13:05:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 08234C3EEAD7
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Andi Shyti
 <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-i2c@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix i.MX I2C driver zero byte read kernel panic
Sender: khalasa@piap.pl
Date: Thu, 03 Sep 2026 13:05:22 +0200
Message-ID: <m37bl2d28d.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Generally, zero-sized I2C read requests aren't valid. After START,
SDA line ownership is transferred to the slave device, and the master
cannot terminate transfer at this point.

Passing zero-sized read request to i.MX I2C driver causes a NULL pointer
dereference in i2c_imx_isr_read_continue() here:

i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] =3D imx_i2c_read_reg(i2c_imx, IMX=
_I2C_I2DR);

Fix it by rejecting zero-sized read transfers.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index c44452449a75..1f0f72386912 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1637,7 +1637,9 @@ static int i2c_imx_xfer_common(struct i2c_adapter *ad=
apter,
 		if (msgs[i].flags & I2C_M_RD) {
 			int block_data =3D msgs->flags & I2C_M_RECV_LEN;
=20
-			if (atomic)
+			if (!msgs[i].len) /* invalid, would panic */
+				result =3D -EINVAL;
+			else if (atomic)
 				result =3D i2c_imx_atomic_read(i2c_imx, &msgs[i], is_lastmsg);
 			else if (use_dma && !block_data)
 				result =3D i2c_imx_dma_read(i2c_imx, &msgs[i], is_lastmsg);

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
