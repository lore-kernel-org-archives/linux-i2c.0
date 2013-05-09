From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v2 1/2] i2c: i2c-bfin-twi: don`t free peripheral before
 it init successful
Date: Thu, 9 May 2013 08:31:33 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EEAD4A@NWD2MBX7.ad.analog.com>
References: <1368088044-20408-1-git-send-email-libo.chen@huawei.com>
 <1368088044-20408-2-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1368088044-20408-2-git-send-email-libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Acked-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

>-----Original Message-----
>From: Libo Chen [mailto:libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
>Sent: Thursday, May 09, 2013 4:27 PM
>To: Zhang, Sonic; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
>Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org; Libo Chen
>Subject: [PATCH v2 1/2] i2c: i2c-bfin-twi: don`t free peripheral before it init
>successful
>
>down out_error_no_irq. When platform_get_irq fail, no need to free peripheral
>
>Signed-off-by: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>---
> drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
>index 05080c4..6617645 100644
>--- a/drivers/i2c/busses/i2c-bfin-twi.c
>+++ b/drivers/i2c/busses/i2c-bfin-twi.c
>@@ -709,9 +709,9 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
> out_error_add_adapter:
>       free_irq(iface->irq, iface);
> out_error_req_irq:
>-out_error_no_irq:
>       peripheral_free_list((unsigned short *)pdev->dev.platform_data);
> out_error_pin_mux:
>+out_error_no_irq:
>       iounmap(iface->regs_base);
> out_error_ioremap:
> out_error_get_res:
>--
>1.7.1
>
>
