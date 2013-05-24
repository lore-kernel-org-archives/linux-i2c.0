From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH RFC v3 1/3] i2c: i2c-bfin-twi: convert to devm_* API
Date: Fri, 24 May 2013 02:49:35 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE010634@NWD2MBX7.ad.analog.com>
References: <1369310405-21112-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369310405-21112-1-git-send-email-libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "guz.fnst-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org" <guz.fnst-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Libo,

>-----Original Message-----
>From: Libo Chen [mailto:libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
>Sent: Thursday, May 23, 2013 8:00 PM
>To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
>Cc: guz.fnst-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org; Zhang, Sonic; uclinux-dist-
>devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org; libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
>Subject: [PATCH RFC v3 1/3] i2c: i2c-bfin-twi: convert to devm_* API
>
>peripheral_request_list has got free if any one faild, so no need to free again in err
>case.
>aovid this, convert them to devm_* API
>
>Signed-off-by: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>---
> drivers/i2c/busses/i2c-bfin-twi.c |   38 +++++++++---------------------------
> 1 files changed, 10 insertions(+), 28 deletions(-)
>
>diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
>index 05080c4..2b99c48 100644
>--- a/drivers/i2c/busses/i2c-bfin-twi.c
>+++ b/drivers/i2c/busses/i2c-bfin-twi.c
>@@ -621,35 +621,27 @@ static int i2c_bfin_twi_probe(struct platform_device
>*pdev)
>       int rc;
>       unsigned int clkhilow;
>
>-      iface = kzalloc(sizeof(struct bfin_twi_iface), GFP_KERNEL);
>+      iface = devm_kzalloc(&pdev->dev, sizeof(struct bfin_twi_iface),
>+                      GFP_KERNEL);
>       if (!iface) {
>               dev_err(&pdev->dev, "Cannot allocate memory\n");
>-              rc = -ENOMEM;
>-              goto out_error_nomem;
>+              return -ENOMEM;
>       }
>
>       spin_lock_init(&(iface->lock));
>
>       /* Find and map our resources */
>       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>-      if (res == NULL) {
>-              dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
>-              rc = -ENOENT;
>-              goto out_error_get_res;
>-      }

Why remove the resource mem check?

Regards,

Sonic
