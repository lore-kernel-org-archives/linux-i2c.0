From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 15/21] i2c: ocores: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:24 +0200
Message-ID: <20180514145330.4857-16-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Peter Korsgaard <jacmet@sunsite.dk>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-ocores.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 8c42ca7107b2..a540916689b2 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -222,10 +222,7 @@ static int ocores_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	i2c->nmsgs = num;
 	i2c->state = STATE_START;
 
-	oc_setreg(i2c, OCI2C_DATA,
-			(i2c->msg->addr << 1) |
-			((i2c->msg->flags & I2C_M_RD) ? 1:0));
-
+	oc_setreg(i2c, OCI2C_DATA, i2c_8bit_addr_from_msg(i2c->msg));
 	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 
 	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
-- 
2.11.0
