From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH v2 4/4] i2c: slave-eeprom: add more info when to increase the pointer
Date: Mon, 23 Mar 2015 09:26:39 +0100
Message-ID: <1427099199-3628-5-git-send-email-wsa@the-dreams.de>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427099199-3628-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

It is a bit subtle when to correctly increase the buffer index when
reading. Make this clearer by adding some more comments and pointers to
the docs.

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---

Changes since V1: new patch

 drivers/i2c/i2c-slave-eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 3fb45d894d8072..8223746546093c 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -48,12 +48,18 @@ static int i2c_slave_eeprom_slave_cb(struct i2c_client *client,
 		break;
 
 	case I2C_SLAVE_READ_PROCESSED:
+		/* The previous byte made it to the bus, get next one */
 		eeprom->buffer_idx++;
 		/* fallthrough */
 	case I2C_SLAVE_READ_REQUESTED:
 		spin_lock(&eeprom->buffer_lock);
 		*val = eeprom->buffer[eeprom->buffer_idx];
 		spin_unlock(&eeprom->buffer_lock);
+		/*
+		 * Do not increment buffer_idx here, because we don't know if
+		 * this byte will be actually used. Read Linux I2C slave docs
+		 * for details.
+		 */
 		break;
 
 	case I2C_SLAVE_STOP:
-- 
2.1.4
