From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/5] i2c: sirfsoc: support reverse direction of address
Date: Tue, 13 Aug 2013 17:11:30 +0800
Message-ID: <1376385091-30597-5-git-send-email-Baohua.Song@csr.com>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376385091-30597-1-git-send-email-Baohua.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Rongjun Ying <rongjun.ying-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>

if users set I2C_M_REV_DIR_ADDR, revert the direction of address.

Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Rongjun Ying <rongjun.ying-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/i2c/busses/i2c-sirf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 746388f..d2b7913 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -195,6 +195,10 @@ static void i2c_sirfsoc_set_address(struct sirfsoc_i2c *siic,
 	if (msg->flags & I2C_M_RD)
 		addr |= 1;
 
+	/* Reverse direction bit */
+	if (msg->flags & I2C_M_REV_DIR_ADDR)
+		addr ^= 1;
+
 	writel(addr, siic->base + SIRFSOC_I2C_CMD(siic->cmd_ptr++));
 }
 
-- 
1.8.2.3
