From: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa: fix compiler warning, due to missing const
Date: Tue, 15 Jun 2010 17:52:09 +0800
Message-ID: <AANLkTiksiKUecR8tVYDEsKVYE7BxF5WAu9KdJISFRBFB@mail.gmail.com>
References: <1276592205-26284-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1276592205-26284-1-git-send-email-mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 15, 2010 at 4:56 PM, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>=
 wrote:
> This patch adds the missing const to "struct platform_device_id" to f=
ix
> this warning:
>
> /home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa.=
c:
> In function 'i2c_pxa_probe':
> /home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa.=
c:1004:
> warning: initialization discards qualifiers from pointer target type
>
> Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Ack

> Cc: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> ---
> =C2=A0drivers/i2c/busses/i2c-pxa.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-px=
a.c
> index 020ff23..c94e51b 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1001,7 +1001,7 @@ static int i2c_pxa_probe(struct platform_device=
 *dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pxa_i2c *i2c;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *res;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_pxa_platform_data *plat =3D dev=
->dev.platform_data;
> - =C2=A0 =C2=A0 =C2=A0 struct platform_device_id *id =3D platform_get=
_device_id(dev);
> + =C2=A0 =C2=A0 =C2=A0 const struct platform_device_id *id =3D platfo=
rm_get_device_id(dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int irq;
>
> --
> 1.7.1
>
>
