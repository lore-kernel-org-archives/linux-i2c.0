From: Leo Li <pku.leo@gmail.com>
Subject: Re: [PATCH v5] i2c: imx: make bus recovery through pinctrl optional
Date: Tue, 6 Sep 2016 18:14:42 -0500
Message-ID: <CADRPPNQNFyAE3Thn+LYUVU5m-RPwkMAkfGfZ5PkNj8Dno-p7Rg@mail.gmail.com>
References: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
 <20160906185849.27pjhawadca5pwow@pengutronix.de> <CADRPPNQ+1qBNL5WA=Jo_keE7BPnoOs7a2T6CpTuciiF16qK6xQ@mail.gmail.com>
 <20160906210735.6wl5x2mdhnhdnh7y@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160906210735.6wl5x2mdhnhdnh7y@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Li Yang <leoyang.li@nxp.com>, Gao Pan <pandy.gao@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, lkml <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 6, 2016 at 4:07 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Sep 06, 2016 at 03:06:41PM -0500, Leo Li wrote:
>> On Tue, Sep 6, 2016 at 1:58 PM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > On Fri, Aug 19, 2016 at 05:05:22PM -0500, Li Yang wrote:
>> >> Since commit 1c4b6c3bcf30 ("i2c: imx: implement bus recovery") the
>> >> driver starts to use gpio/pinctrl to do i2c bus recovery.  But pinctr=
l
>> >> is not always available for platforms with this controller such as ls=
1021a
>> >> and ls1043a, and the device tree binding also mentioned this gpio bas=
ed
>> >> recovery mechanism as optional.  The patch makes it really optional t=
hat
>> >> the probe function won't bailout but just disable the bus recovery fu=
nction
>> >> when pinctrl is not available.
>> >>
>> >> Signed-off-by: Li Yang <leoyang.li@nxp.com>
>> >> Cc: Gao Pan <pandy.gao@nxp.com>
>> >> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> >> ---
>> >> v5:
>> >> Revert the last minute change of recovery info initialization timing,=
 it
>> >> will cause problem if initialized after i2c_add_numbered_adapter()
>> >>
>> >> v4:
>> >> Remove the use of IS_ERR_OR_NULL
>> >> Move the condition judgement to i2c_imx_init_recovery_info()
>> >> Change the timing of recovery initialization to be after bus registra=
tion
>> >>
>> >> v3:
>> >> Rebased to Wolfram's for-next branch
>> >> Added acked-by from Linus Walleij
>> >> Update to use new nxp email addresses due to company merge
>> >>
>> >>  drivers/i2c/busses/i2c-imx.c | 15 ++++++++++++++-
>> >>  1 file changed, 14 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-im=
x.c
>> >> index 1844bc9..7ae7992 100644
>> >> --- a/drivers/i2c/busses/i2c-imx.c
>> >> +++ b/drivers/i2c/busses/i2c-imx.c
>> >> @@ -989,6 +989,15 @@ static void i2c_imx_init_recovery_info(struct im=
x_i2c_struct *i2c_imx,
>> >>  {
>> >>       struct i2c_bus_recovery_info *rinfo =3D &i2c_imx->rinfo;
>> >>
>> >> +     /* if pinctrl is not supported on the system */
>> >> +     if (IS_ERR(i2c_imx->pinctrl))
>> >> +             i2c_imx->pinctrl =3D NULL;
>> >> +
>> >> +     if (!i2c_imx->pinctrl) {
>> >> +             dev_info(&pdev->dev, "can't get pinctrl, bus recovery n=
ot supported\n");
>> >> +             return;
>> >> +     }
>> >> +
>> >>       i2c_imx->pinctrl_pins_default =3D pinctrl_lookup_state(i2c_imx-=
>pinctrl,
>> >>                       PINCTRL_STATE_DEFAULT);
>> >>       i2c_imx->pinctrl_pins_gpio =3D pinctrl_lookup_state(i2c_imx->pi=
nctrl,
>> >> @@ -1081,8 +1090,11 @@ static int i2c_imx_probe(struct platform_devic=
e *pdev)
>> >>               return ret;
>> >>       }
>> >>
>> >> +     /* optional bus recovery feature through pinctrl */
>> >>       i2c_imx->pinctrl =3D devm_pinctrl_get(&pdev->dev);
>> >> -     if (IS_ERR(i2c_imx->pinctrl)) {
>> >> +     /* bailout on -ENOMEM or -EPROBE_DEFER, continue for other erro=
rs */
>> >> +     if (PTR_ERR(i2c_imx->pinctrl) =3D=3D -ENOMEM ||
>> >> +                     PTR_ERR(i2c_imx->pinctrl) =3D=3D -EPROBE_DEFER)=
 {
>> >>               ret =3D PTR_ERR(i2c_imx->pinctrl);
>> >>               goto clk_disable;
>> >>       }
>> >
>> > devm_pinctrl_get might return the following error-valued pointers:
>> >  - -EINVAL
>> >  - -ENOMEM
>> >  - -ENODEV
>> >  - -EPROBE_DEFER
>> >
>> > There are several error paths returning -EINVAL, one is when an invali=
d
>> > phandle is used. Do you really want to ignore that?
>> >
>> > IMO error handling is better done with inverse logic, that is continue
>> > on some explicit error, bail out on all unknown stuff. This tends to b=
e
>> > more robust. Also the comment should be improved to not explain that f=
or
>> > -ENOMEM and -EPROBE_DEFER we bail out (which should be obvious for
>> > anyone who can read C) but to explain why.
>>
>> What you said is true for normal error handling, but in this scenario
>> it is intentional to ignore all pinctrl related errors except critical
>> ones because failing to have pinctrl for an optional feature shouldn't
>> impact the function of normal i2c.  We choose to catch -ENOMEM because
>> the error could also cause problem for i2c probe, and -EPROBE_DEFER
>> because it's possible that the pinctrl will be ready later and we want
>> to give it a chance.  The i2c driver really don't care why the pinctrl
>> was not usable.  I thought I added comment before the
>> devm_pinctrl_get() to explain that the pinctrl is optional.  Hopefully
>> you are not suggesting to explain what -ENOMEM and -EPROBE_DEFER mean
>> in the comment. :)
>
> You wrote
>
>         /* optional bus recovery feature through pinctrl */
>
> there. I'd expect to read something like:
>
>         /*
>          * If pinctrl is available it might be possible to switch the
>          * SDA and SCL lines to their GPIO functions and do a recovery
>          * procedure in this mode. If there is anything wrong with
>          * pinctrl we cannot do this and simply skip it.
>          */

Thanks.  I will use this.  This does looks more clear.  And more verbose to=
o. :)

>
>> > Also I'd put
>> >
>> >         i2c_imx->pinctrl =3D NULL;
>> >
>> > directly after devm_pinctrl_get() which I consider the more obvious
>> > place for this.
>>
>> On the other hand, put it together with the actually judgement can
>> make it clear that it is catching both IS_ERR and NULL returns from
>> devm_pinctrl_get()?
>
> When you do it immediately, you have:
>
>         if (i2c_imx->pinctrl)
>                 use_it();
>         else
>                 ignore_it();
>

But you suggested the other way last time "Or maybe make
i2c_imx_init_recovery_info aware of this situation to keep the caller
simple?"  :)  Either way I think it is just personal preferences with
both subtle pros and cons.  I don't think we should spend too much
time on this.

Regards,
Leo
