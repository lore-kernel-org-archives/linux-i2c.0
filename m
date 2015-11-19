From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 03/11] i2c: rcar: remove unused IOERROR state
Date: Thu, 19 Nov 2015 16:56:43 +0100
Message-ID: <1447948611-2615-4-git-send-email-wsa@the-dreams.de>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36906 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934186AbbKSP44 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 19 Nov 2015 10:56:56 -0500
In-Reply-To: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index efc8de6cc8a2f9..746406923a5825 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -94,7 +94,6 @@
 #define RCAR_IRQ_ACK_RECV	(~(MAT | MDR) & 0xFF)
 
 #define ID_LAST_MSG	(1 << 0)
-#define ID_IOERROR	(1 << 1)
 #define ID_DONE		(1 << 2)
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
@@ -541,11 +540,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 			break;
 		}
 
-		if (rcar_i2c_flags_has(priv, ID_IOERROR)) {
-			ret = -EIO;
-			break;
-		}
-
 		ret = i + 1; /* The number of transfer */
 	}
 out:
-- 
2.1.4
