From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I2C_FUNC_SMBUS_QUICK on i2c-mxs
Date: Mon, 27 Aug 2012 16:32:12 -0300
Message-ID: <CAOMZO5Dyp-+GXkWZvgsFXbZv15N+4u3iuPjw-sqwLn=5bVGBsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

When using i2cdetect on a mx28 I get:

$ i2cdetect 0
Error: Can't use SMBus Quick Write command on this bus (ISA bus?)

Enabling I2C_FUNC_SMBUS_QUICK the error goes away:
---
 drivers/i2c/busses/i2c-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 088c5c1..84484bb 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -322,7 +322,7 @@ static int mxs_i2c_xfer(struct i2c_adapter *adap,
struct i2c_msg msgs[],

 static u32 mxs_i2c_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }

 static irqreturn_t mxs_i2c_isr(int this_irq, void *dev_id)
-- 
1.7.9.5

Could anyone clarify whether I2C_FUNC_SMBUS_QUICK option could be
turned on or not?

Thanks,

Fabio Estevam
