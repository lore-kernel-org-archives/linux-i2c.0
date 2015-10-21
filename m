From: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/9] i2c: brcmstb: fix start and stop conditions
Date: Wed, 21 Oct 2015 11:36:57 +0900
Message-ID: <1445395021-4204-6-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fixes conditions for RESTART, NOSTART and NOSTOP. The masks of start and
stop is already in brcmstb_set_i2c_start_stop(). Therefore, the caller
does not need a mask value.

Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-brcmstb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 53eb8b0c9bad..dcd1209f843f 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -464,7 +464,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 			pmsg->buf ? pmsg->buf[0] : '0', pmsg->len);
 
 		if (i < (num - 1) && (msgs[i + 1].flags & I2C_M_NOSTART))
-			brcmstb_set_i2c_start_stop(dev, ~(COND_START_STOP));
+			brcmstb_set_i2c_start_stop(dev, 0);
 		else
 			brcmstb_set_i2c_start_stop(dev,
 						   COND_RESTART | COND_NOSTOP);
@@ -485,8 +485,7 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
 			bytes_to_xfer = min(len, N_DATA_BYTES);
 
 			if (len <= N_DATA_BYTES && i == (num - 1))
-				brcmstb_set_i2c_start_stop(dev,
-							   ~(COND_START_STOP));
+				brcmstb_set_i2c_start_stop(dev, 0);
 
 			rc = brcmstb_i2c_xfer_bsc_data(dev, tmp_buf,
 						       bytes_to_xfer, pmsg);
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
