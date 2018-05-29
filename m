From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 3/6] i2c: rcar: remove unused IOERROR state
Date: Tue, 29 May 2018 14:33:13 +0100
Message-ID: <1527600796-25901-4-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 90f779e565bdc18dd4f79d81cf11f43a7266010b upstream.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
[fabrizio: cherry-pick to 4.4]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 drivers/i2c/busses/i2c-rcar.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index b8ff5f2..7510733 100644
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
2.7.4
