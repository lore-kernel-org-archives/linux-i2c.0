From: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] i2c: imx: Add arbitration lost check
Date: Tue, 2 Sep 2014 02:53:30 +0000
Message-ID: <41a897c8ddf046a5a1629154711fade8@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1409561920-9939-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409561920-9939-1-git-send-email-haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Haibo.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Haibo.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org> Sent: Monday, September 01, 2014 4:59 PM
>To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
>Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Duan Fugang-B38611
>Subject: [PATCH] i2c: imx: Add arbitration lost check
>
>According to the i.mx spec, for multimaster mode, if I2C is enabled when
>the bus is busy and asserts start, hardware inhibits the transmission,
>clears MSTA without signaling a stop, generate an interrupt, and set
>I2C_I2SR[IAL] to indicate a failed attempt to engage the bus, which means
>arbitration lost. In this case, we should first test I2C_I2SR[IAL], and
>clear this bit if it is set, and then I2C controller default to slave
>receive mode.
>
>This patch check the IAL bit every time before an I2c transmission.
>if IAL is set, clear it and make I2C controller to default mode.
>
>Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>---
> drivers/i2c/busses/i2c-imx.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>index 613069b..144b620 100644
>--- a/drivers/i2c/busses/i2c-imx.c
>+++ b/drivers/i2c/busses/i2c-imx.c
>@@ -268,6 +268,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct
>*i2c_imx, int for_busy)
>
> 	while (1) {
> 		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
>+
>+		/** check for arbitration lost **/
>+		if (temp & I2SR_IAL) {
>+			temp &= ~I2SR_IAL;
>+			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
>+			return -EIO;
>+		}
>+
> 		if (for_busy && (temp & I2SR_IBB))
> 			break;
> 		if (!for_busy && !(temp & I2SR_IBB))
>--
>1.9.1

Acked-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Thanks,
Andy
