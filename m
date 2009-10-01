From: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] i2c: imx: disable clock when it's possible to save
	power.
Date: Thu, 1 Oct 2009 15:56:29 +0800
Message-ID: <4e090d470910010056n56bff9f4l1fec703c2dde9edf@mail.gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	 <1254359613-21210-2-git-send-email-linuxzsc@gmail.com>
	 <1254359613-21210-3-git-send-email-linuxzsc@gmail.com>
	 <1254359613-21210-4-git-send-email-linuxzsc@gmail.com>
	 <20091001073434.GY27039@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091001073434.GY27039-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 1, 2009 at 3:34 PM, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> On Thu, Oct 01, 2009 at 09:13:33AM +0800, Richard Zhao wrote:
>> Enable clock before START, disable it after STOP.
>
> The clk_diable/enable calls in suspend/resume should be removed also.
>
> Sascha
>
>>
>> Signed-off-by: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-i=
mx.c
>> index 87faea4..72ddea3 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -120,6 +120,7 @@ struct imx_i2c_struct {
>> =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 queue;
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 i2csr;
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0disable_delay;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ifdr; /* IMX_I2C_IFDR =
*/
>> =A0};
>>
>> =A0/** Functions for IMX I2C adapter driver ************************=
***************
>> @@ -210,6 +211,8 @@ static int i2c_imx_start(struct imx_i2c_struct *=
i2c_imx)
>>
>> =A0 =A0 =A0 dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
>>
>> + =A0 =A0 clk_enable(i2c_imx->clk);
>> + =A0 =A0 writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
>> =A0 =A0 =A0 /* Enable I2C controller */
>> =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2SR);
>> =A0 =A0 =A0 writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
>> @@ -254,6 +257,7 @@ static void i2c_imx_stop(struct imx_i2c_struct *=
i2c_imx)
>>
>> =A0 =A0 =A0 /* Disable I2C controller */
>> =A0 =A0 =A0 writeb(0, i2c_imx->base + IMX_I2C_I2CR);
>> + =A0 =A0 clk_disable(i2c_imx->clk);
>> =A0}
>>
>> =A0static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx=
,
>> @@ -273,8 +277,8 @@ static void __init i2c_imx_set_clk(struct imx_i2=
c_struct *i2c_imx,
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i2c_clk_div[i][0] < div; i=
++);
>>
>> - =A0 =A0 /* Write divider value to register */
>> - =A0 =A0 writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
>> + =A0 =A0 /* Store divider value */
>> + =A0 =A0 i2c_imx->ifdr =3D i2c_clk_div[i][1];
>>
>> =A0 =A0 =A0 if (cpu_is_mx1()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> @@ -555,7 +559,6 @@ static int __init i2c_imx_probe(struct platform_=
device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "can't get I2C clock=
\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
>> =A0 =A0 =A0 }
>> - =A0 =A0 clk_enable(i2c_imx->clk);
>>
>> =A0 =A0 =A0 /* Request IRQ */
>> =A0 =A0 =A0 ret =3D request_irq(i2c_imx->irq, i2c_imx_isr, 0, pdev->=
name, i2c_imx);
>> @@ -604,7 +607,6 @@ static int __init i2c_imx_probe(struct platform_=
device *pdev)
>> =A0fail5:
>> =A0 =A0 =A0 free_irq(i2c_imx->irq, i2c_imx);
>> =A0fail4:
>> - =A0 =A0 clk_disable(i2c_imx->clk);
>> =A0 =A0 =A0 clk_put(i2c_imx->clk);
>> =A0fail3:
>> =A0 =A0 =A0 release_mem_region(i2c_imx->res->start, resource_size(re=
s));
>> @@ -641,8 +643,6 @@ static int __exit i2c_imx_remove(struct platform=
_device *pdev)
>> =A0 =A0 =A0 if (pdata && pdata->exit)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->exit(&pdev->dev);
>>
>> - =A0 =A0 /* Disable I2C clock */
>> - =A0 =A0 clk_disable(i2c_imx->clk);
>> =A0 =A0 =A0 clk_put(i2c_imx->clk);
>>
>> =A0 =A0 =A0 release_mem_region(i2c_imx->res->start, resource_size(i2=
c_imx->res));
>> --
>> 1.6.0.4
>>
>>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0=
 =A0 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5=
121-206917-5555 |
>

I don't think we have any suspend/resume routine. And we won't need it =
any more.

Thanks
Richard
