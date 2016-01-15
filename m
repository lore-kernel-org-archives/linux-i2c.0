From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v3] i2c: imx: make bus recovery through pinctrl optional
Date: Fri, 15 Jan 2016 16:46:06 +0800
Message-ID: <CADRPPNT=+amxRcea=N7m96=wKgdbRmU8R5cBACvTn7XffKofzQ@mail.gmail.com>
References: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
	<20160115075356.GI24441@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160115075356.GI24441@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Li Yang <leoyang.li@nxp.com>, Gao Pan <pandy.gao@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 15, 2016 at 3:53 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Fri, Jan 15, 2016 at 01:27:24AM -0600, Li Yang wrote:
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-i=
mx.c
>> index a2b132c..1239bfa 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -1081,8 +1081,11 @@ static int i2c_imx_probe(struct platform_devi=
ce *pdev)
>>               return ret;
>>       }
>>
>> +     /* optional bus recovery feature through pinctrl */
>>       i2c_imx->pinctrl =3D devm_pinctrl_get(&pdev->dev);
>> -     if (IS_ERR(i2c_imx->pinctrl)) {
>> +     /* bailout on -ENOMEM or -EPROBE_DEFER, continue for other err=
ors */
>> +     if (PTR_ERR(i2c_imx->pinctrl) =3D=3D -ENOMEM ||
>> +                     PTR_ERR(i2c_imx->pinctrl) =3D=3D -EPROBE_DEFER=
) {
>>               ret =3D PTR_ERR(i2c_imx->pinctrl);
>>               goto clk_disable;
>>       }
>> @@ -1125,7 +1128,10 @@ static int i2c_imx_probe(struct platform_devi=
ce *pdev)
>>                       i2c_imx, IMX_I2C_I2CR);
>>       imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, I=
MX_I2C_I2SR);
>>
>> -     i2c_imx_init_recovery_info(i2c_imx, pdev);
>> +     if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
>
> I'd prefer to set i2c_imx->pinctrl to NULL if it's not used and then =
use
>
>         if (!i2c_imx->pinctrl)
>
> here. (Or maybe make i2c_imx_init_recovery_info aware of this situati=
on
> to keep the caller simple?)

Setting not used pointer to NULL might be a good coding practice
generally.  But in this case neither the driver nor gpio framework
checks if the pinctrl is NULL before accessing it.  We still need the
driver to make sure pinctrl is not used in this situation.  The
benefit of the proposed change seems to be pretty limited.  :)

Regards,
Leo
