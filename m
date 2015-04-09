From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Device tree driver loading
Date: Thu, 9 Apr 2015 14:28:41 +0200
Message-ID: <20150409142841.47e6f67a@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

sc16is7xx declares two device id tables, one with OF ids:

static const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
	{ .compatible = "nxp,sc16is740",	.data = &sc16is74x_devtype, },
	{ .compatible = "nxp,sc16is741",	.data = &sc16is74x_devtype, },
	{ .compatible = "nxp,sc16is750",	.data = &sc16is750_devtype, },
	{ .compatible = "nxp,sc16is752",	.data = &sc16is752_devtype, },
	{ .compatible = "nxp,sc16is760",	.data = &sc16is760_devtype, },
	{ .compatible = "nxp,sc16is762",	.data = &sc16is762_devtype, },
	{ }
};
MODULE_DEVICE_TABLE(of, sc16is7xx_dt_ids);

and one with i2c ids:

static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
	{ "sc16is74x",	(kernel_ulong_t)&sc16is74x_devtype, },
	{ "sc16is750",	(kernel_ulong_t)&sc16is750_devtype, },
	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
	{ }
};
MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);

I declare my device in DT under I2C controller as
>	compatible = "nxp,sc16is740";
However, the driver does not get loaded automatically because its
i2c id table contains "sc16is74x" instead of "sc16is740".

I have two questions:

(1) What are the rules for loading drivers based on DT?  Why is the
    driver not loaded even though its compatible with one of the OF ids?

(2) Is it OK for the driver to define incompatible strings or should I
    correct them like this (keeping the old entry for backwards
    compatibility):

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index eaf0008a39cb..efe286d00174 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1219,6 +1219,8 @@ static int sc16is7xx_i2c_remove(struct i2c_client *client)
 
 static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
        { "sc16is74x",  (kernel_ulong_t)&sc16is74x_devtype, },
+       { "sc16is740",  (kernel_ulong_t)&sc16is74x_devtype, },
+       { "sc16is741",  (kernel_ulong_t)&sc16is74x_devtype, },
        { "sc16is750",  (kernel_ulong_t)&sc16is750_devtype, },
        { "sc16is752",  (kernel_ulong_t)&sc16is752_devtype, },
        { "sc16is760",  (kernel_ulong_t)&sc16is760_devtype, },


Thanks,
Kuba
