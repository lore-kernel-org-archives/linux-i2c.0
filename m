From: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
Subject: [PATCH] i2c-mpc: generate START condition after STOP caused by read
 i2c_msg
Date: Thu, 14 May 2009 10:10:03 +0200
Message-ID: <4A0BD1DB.4090305@doredevelopment.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This fixes MAL (arbitration lost) bug caused by illegal use of
RSTA (repeated START) after STOP condition generated after last byte
of reads.

Signed-off-by: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
---
  drivers/i2c/busses/i2c-mpc.c |    9 +++++++--
  1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 4af5c09..9fe05d9 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -456,17 +456,22 @@ static int mpc_xfer(struct i2c_adapter *adap, 
struct i2c_msg *msgs, int num)
  	}

  	for (i = 0; ret >= 0 && i < num; i++) {
+		int restart = i;
  		pmsg = &msgs[i];
  		dev_dbg(i2c->dev,
  			"Doing %s %d bytes to 0x%02x - %d of %d messages\n",
  			pmsg->flags & I2C_M_RD ? "read" : "write",
  			pmsg->len, pmsg->addr, i + 1, num);
+		if (i > 0 && ((pmsg-1)->flags & I2C_M_RD))
+			restart = 0;
  		if (pmsg->flags & I2C_M_RD)
  			ret =
-			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len,
+				     restart);
  		else
  			ret =
-			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len,
+				      restart);
  	}
  	mpc_i2c_stop(i2c);
  	return (ret < 0) ? ret : num;
-- 
1.6.0.4
