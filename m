From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: bcm-kona: fix inconsistent indenting
Date: Mon, 15 Aug 2016 00:47:22 +0200
Message-ID: <1471214842-25877-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40209 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbcHNWrc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 14 Aug 2016 18:47:32 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Ray Jui <ray.jui@broadcom.com>, Tim Kryger <tim.kryger@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

smatch rightfully says:
drivers/i2c/busses/i2c-bcm-kona.c:646 bcm_kona_i2c_xfer() warn: inconsistent indenting

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index f98743277e3c74..258cb9a40ab349 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -643,7 +643,7 @@ static int bcm_kona_i2c_xfer(struct i2c_adapter *adapter,
 			if (rc < 0) {
 				dev_err(dev->device,
 					"restart cmd failed rc = %d\n", rc);
-					goto xfer_send_stop;
+				goto xfer_send_stop;
 			}
 		}
 
-- 
2.8.1
