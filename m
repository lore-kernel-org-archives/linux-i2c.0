From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] [trivial] i2c: Fix typo in i2c-bfin-twi.c
Date: Wed, 29 Jul 2015 03:01:57 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE6828B45B@NWD2MBX5.ad.analog.com>
References: <1438081883-23883-1-git-send-email-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438081883-23883-1-git-send-email-standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Acked-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

>-----Original Message-----
>From: Masanari Iida [mailto:standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>Sent: Tuesday, July 28, 2015 7:11 PM
>To: trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Zhang, Sonic; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
>Cc: Masanari Iida
>Subject: [PATCH] [trivial] i2c: Fix typo in i2c-bfin-twi.c
>
>This patch fix some typos found in a printk message and MODULE_DESCRIPTION.
>
>Signed-off-by: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> drivers/i2c/busses/i2c-bfin-twi.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
>index af162b4..025686d 100644
>--- a/drivers/i2c/busses/i2c-bfin-twi.c
>+++ b/drivers/i2c/busses/i2c-bfin-twi.c
>@@ -692,7 +692,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>
> 	platform_set_drvdata(pdev, iface);
>
>-	dev_info(&pdev->dev, "Blackfin BF5xx on-chip I2C TWI Contoller, "
>+	dev_info(&pdev->dev, "Blackfin BF5xx on-chip I2C TWI Controller, "
> 		"regs_base@%p\n", iface->regs_base);
>
> 	return 0;
>@@ -735,6 +735,6 @@ subsys_initcall(i2c_bfin_twi_init);
> module_exit(i2c_bfin_twi_exit);
>
> MODULE_AUTHOR("Bryan Wu, Sonic Zhang"); -MODULE_DESCRIPTION("Blackfin BF5xx on-chip I2C TWI Contoller
>Driver");
>+MODULE_DESCRIPTION("Blackfin BF5xx on-chip I2C TWI Controller Driver");
> MODULE_LICENSE("GPL");
> MODULE_ALIAS("platform:i2c-bfin-twi");
>--
>2.5.0
