From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] i2c: rcar: use dma_request_chan()
Date: Thu, 19 May 2016 10:29:17 +0200
Message-ID: <1463646557-22489-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:52735 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbcESIbE (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 May 2016 04:31:04 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: arnd@arndb.de, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

New drivers should not use dma_request_slave_channel_reason() but
dma_request_chan(). The former is a macro to the later so this change d=
o
not effect the driver in any way.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rca=
r.c
index c42d52a..cf82438 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -626,7 +626,7 @@ static struct dma_chan *rcar_i2c_request_dma_chan(s=
truct device *dev,
 	char *chan_name =3D dir =3D=3D DMA_MEM_TO_DEV ? "tx" : "rx";
 	int ret;
=20
-	chan =3D dma_request_slave_channel_reason(dev, chan_name);
+	chan =3D dma_request_chan(dev, chan_name);
 	if (IS_ERR(chan)) {
 		ret =3D PTR_ERR(chan);
 		dev_dbg(dev, "request_channel failed for %s (%d)\n",
--=20
2.8.2
