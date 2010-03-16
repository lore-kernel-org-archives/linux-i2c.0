From: wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 1/3] i2c-pnx: Limit maximum divider to 1023
Date: Tue, 16 Mar 2010 15:55:35 -0700
Message-ID: <1268780138-10019-2-git-send-email-wellsk40@gmail.com>
References: <1268780138-10019-1-git-send-email-wellsk40@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1268780138-10019-1-git-send-email-wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: vitaly.wool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Limit maximum divider to 0x3ff on divider computations. On high I2C
parent clock rates, the divider can exceed 0x3ff. This will help
prevent some very odd clock rates.

Signed-off-by: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-pnx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 9532dee..77919fa 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -632,6 +632,8 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	 */
 
 	tmp = ((freq / 1000) / I2C_PNX_SPEED_KHZ) / 2 - 2;
+	if (tmp > 0x3FF)
+		tmp = 0x3FF;
 	iowrite32(tmp, I2C_REG_CKH(alg_data));
 	iowrite32(tmp, I2C_REG_CKL(alg_data));
 
-- 
1.6.6
