From: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c: muxes: fix sizeof(ptr)
Date: Tue, 8 Jan 2013 15:43:19 +0100
Message-ID: <CAH7P7Nh2S9pHyKs=eQ-9YRXeGnH6OV+oZDJAAfbC8y+eaQNLnA@mail.gmail.com>
References: <1357652409-22907-1-git-send-email-laurent.navet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357652409-22907-1-git-send-email-laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is not really a bug as mux->busses is a multilevel pointer, so
the result of sizeof(ptr) is the same as sizeof(*ptr).
But I think this is more logical and according to CodingStyle rules lik=
e this.
This is also what is done for mux->states a few lines above.

Regards,


2013/1/8, Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> sizeof when applied to a pointer typed expression gives the size of
> the pointer
>
> The semantic patch that makes this output is available
> in scripts/coccinelle/misc/noderef.cocci.
>
> More information about semantic patching is available at
> http://coccinelle.lip6.fr/
>
> Signed-off-by: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/muxes/i2c-mux-pinctrl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c
> b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> index 7fa5b24..f958d0f 100644
> --- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> @@ -167,7 +167,7 @@ static int __devinit i2c_mux_pinctrl_probe(struct
> platform_device *pdev)
>  	}
>
>  	mux->busses =3D devm_kzalloc(&pdev->dev,
> -				   sizeof(mux->busses) * mux->pdata->bus_count,
> +				   sizeof(*mux->busses) * mux->pdata->bus_count,
>  				   GFP_KERNEL);
>  	if (!mux->busses) {
>  		dev_err(&pdev->dev, "Cannot allocate busses\n");
> --
> 1.7.10.4
>
>


--=20
=C2=AB On ne r=C3=A9sout pas un probl=C3=A8me avec les modes de pens=C3=
=A9e qui l=E2=80=99ont engendr=C3=A9. =C2=BB
=C2=AB You cannot solve current problems with current thinking. Current
problems are the result of current thinking =C2=BB
