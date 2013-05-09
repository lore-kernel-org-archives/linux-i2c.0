From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: i2c-bfin-twi: don`t free
 peripheral before it`s init successful
Date: Thu, 9 May 2013 05:07:48 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EEA618@NWD2MBX7.ad.analog.com>
References: <5187ABF6.4000907@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <5187ABF6.4000907-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Libo Chen <clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, Li Zefan <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Libo,

>-----Original Message-----
>From: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org [mailto:uclinux-dist-devel-
>bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org] On Behalf Of Libo Chen
>Sent: Monday, May 06, 2013 9:11 PM
>To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
>Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org; Li Zefan; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: [uclinux-dist-devel] [PATCH 1/2] i2c: i2c-bfin-twi: don`t free peripheral
>before it`s init successful
>
>
>down out_error_no_irq. When platform_get_irq fail, no need to free peripheral
>
>Signed-off-by: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>---
> drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
>index 05080c4..d38e05a 100644
>--- a/drivers/i2c/busses/i2c-bfin-twi.c
>+++ b/drivers/i2c/busses/i2c-bfin-twi.c
>@@ -709,8 +709,8 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
> out_error_add_adapter:
>       free_irq(iface->irq, iface);
> out_error_req_irq:
>-out_error_no_irq:
>       peripheral_free_list((unsigned short *)pdev->dev.platform_data);
>+out_error_no_irq:
> out_error_pin_mux:
>       iounmap(iface->regs_base);
> out_error_ioremap:

You should exchange line out_error_no_irq: and line out_error_pin_mux: other than.
Could you send me a new patch?

Regards,

Sonic
