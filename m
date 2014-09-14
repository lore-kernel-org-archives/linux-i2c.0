From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2 1/3] i2c-rcar: simplify check for last message
Date: Mon, 15 Sep 2014 00:14:14 +0400
Message-ID: <1757193.42K2JNstnx@wasted.cogentembedded.com>
References: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

rcar_i2c_master_xfer() needlessly compares the message pointers (using indirect
addressing) in order to detect the last I2C message, while it's enough to only
compare the message indexes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- refreshed patch.

 drivers/i2c/busses/i2c-rcar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/i2c/busses/i2c-rcar.c
===================================================================
--- linux.orig/drivers/i2c/busses/i2c-rcar.c
+++ linux/drivers/i2c/busses/i2c-rcar.c
@@ -453,7 +453,7 @@ static int rcar_i2c_master_xfer(struct i
 		priv->msg	= &msgs[i];
 		priv->pos	= 0;
 		priv->flags	= 0;
-		if (priv->msg == &msgs[num - 1])
+		if (i == num - 1)
 			rcar_i2c_flags_set(priv, ID_LAST_MSG);
 
 		ret = rcar_i2c_prepare_msg(priv);

