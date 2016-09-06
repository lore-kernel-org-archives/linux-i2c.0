From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5] i2c: imx: make bus recovery through pinctrl optional
Date: Tue, 6 Sep 2016 20:58:49 +0200
Message-ID: <20160906185849.27pjhawadca5pwow@pengutronix.de>
References: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Li Yang <leoyang.li@nxp.com>
Cc: Gao Pan <pandy.gao@nxp.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 19, 2016 at 05:05:22PM -0500, Li Yang wrote:
> Since commit 1c4b6c3bcf30 ("i2c: imx: implement bus recovery") the
> driver starts to use gpio/pinctrl to do i2c bus recovery.  But pinctrl
> is not always available for platforms with this controller such as ls1021a
> and ls1043a, and the device tree binding also mentioned this gpio based
> recovery mechanism as optional.  The patch makes it really optional that
> the probe function won't bailout but just disable the bus recovery functi=
on
> when pinctrl is not available.
> =

> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Cc: Gao Pan <pandy.gao@nxp.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v5:
> Revert the last minute change of recovery info initialization timing, it
> will cause problem if initialized after i2c_add_numbered_adapter()
> =

> v4:
> Remove the use of IS_ERR_OR_NULL
> Move the condition judgement to i2c_imx_init_recovery_info()
> Change the timing of recovery initialization to be after bus registration
> =

> v3:
> Rebased to Wolfram's for-next branch
> Added acked-by from Linus Walleij
> Update to use new nxp email addresses due to company merge
> =

>  drivers/i2c/busses/i2c-imx.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 1844bc9..7ae7992 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -989,6 +989,15 @@ static void i2c_imx_init_recovery_info(struct imx_i2=
c_struct *i2c_imx,
>  {
>  	struct i2c_bus_recovery_info *rinfo =3D &i2c_imx->rinfo;
>  =

> +	/* if pinctrl is not supported on the system */
> +	if (IS_ERR(i2c_imx->pinctrl))
> +		i2c_imx->pinctrl =3D NULL;
> +
> +	if (!i2c_imx->pinctrl) {
> +		dev_info(&pdev->dev, "can't get pinctrl, bus recovery not supported\n"=
);
> +		return;
> +	}
> +
>  	i2c_imx->pinctrl_pins_default =3D pinctrl_lookup_state(i2c_imx->pinctrl,
>  			PINCTRL_STATE_DEFAULT);
>  	i2c_imx->pinctrl_pins_gpio =3D pinctrl_lookup_state(i2c_imx->pinctrl,
> @@ -1081,8 +1090,11 @@ static int i2c_imx_probe(struct platform_device *p=
dev)
>  		return ret;
>  	}
>  =

> +	/* optional bus recovery feature through pinctrl */
>  	i2c_imx->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> -	if (IS_ERR(i2c_imx->pinctrl)) {
> +	/* bailout on -ENOMEM or -EPROBE_DEFER, continue for other errors */
> +	if (PTR_ERR(i2c_imx->pinctrl) =3D=3D -ENOMEM ||
> +			PTR_ERR(i2c_imx->pinctrl) =3D=3D -EPROBE_DEFER) {
>  		ret =3D PTR_ERR(i2c_imx->pinctrl);
>  		goto clk_disable;
>  	}

devm_pinctrl_get might return the following error-valued pointers:
 - -EINVAL
 - -ENOMEM
 - -ENODEV
 - -EPROBE_DEFER

There are several error paths returning -EINVAL, one is when an invalid
phandle is used. Do you really want to ignore that?

IMO error handling is better done with inverse logic, that is continue
on some explicit error, bail out on all unknown stuff. This tends to be
more robust. Also the comment should be improved to not explain that for
-ENOMEM and -EPROBE_DEFER we bail out (which should be obvious for
anyone who can read C) but to explain why.

Also I'd put

	i2c_imx->pinctrl =3D NULL;

directly after devm_pinctrl_get() which I consider the more obvious
place for this.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
