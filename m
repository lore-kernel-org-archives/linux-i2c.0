From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c/scx200_acb: Provide more information on bus errors
Date: Sat, 29 Aug 2009 21:18:38 +0200
Message-ID: <20090829211838.6b6c67fd@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Willy Tarreau <wtarreau-w2o5dE7VsCkiY7fawQvujQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Willy Tarreau <wtarreau-w2o5dE7VsCkiY7fawQvujQ@public.gmane.org>

Upon a bus error, it's rather hard to guess what happened. Dumping the
address, length and status provides a lot of value for troubleshooting
issues.

Signed-off-by: Willy Tarreau <wtarreau-w2o5dE7VsCkiY7fawQvujQ@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/scx200_acb.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.31-rc8.orig/drivers/i2c/busses/scx200_acb.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.31-rc8/drivers/i2c/busses/scx200_acb.c	2009-08-29 20:44:33.000000000 +0200
@@ -217,8 +217,10 @@ static void scx200_acb_machine(struct sc
 	return;
 
  error:
-	dev_err(&iface->adapter.dev, "%s in state %s\n", errmsg,
-		scx200_acb_state_name[iface->state]);
+	dev_err(&iface->adapter.dev,
+		"%s in state %s (addr=0x%02x, len=%d, status=0x%02x)\n", errmsg,
+		scx200_acb_state_name[iface->state], iface->address_byte,
+		iface->len, status);
 
 	iface->state = state_idle;
 	iface->result = -EIO;


-- 
Jean Delvare
