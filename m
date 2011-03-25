From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] i2c: pxa2xx: remove ifdef CONFIG_OF
Date: Fri, 25 Mar 2011 08:56:14 -0600
Message-ID: <AANLkTimyX7dcsON49uKrX55BqM3R0w5PTUCLPHdBKp5w@mail.gmail.com>
References: <1301060286-30353-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301060286-30353-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 25, 2011 at 7:38 AM, Sebastian Andrzej Siewior
<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> Since commit c9e358d ("driver-core: remove conditionals around
> devicetree pointers") there is no need for CONFIG_OF around of_node a=
nd
> of_match_table. Grant removed this ifdefs from all driver which were =
in
> tree at the time, this one was merged later.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

This should go via the i2c tree since there are no device tree patches
depending on it.

g.

> ---
> =A0drivers/i2c/busses/i2c-pxa.c | =A0 =A02 --
> =A01 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-px=
a.c
> index f59224a..91c4c15 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1138,9 +1138,7 @@ static int i2c_pxa_probe(struct platform_device=
 *dev)
>
> =A0 =A0 =A0 =A0i2c->adap.algo_data =3D i2c;
> =A0 =A0 =A0 =A0i2c->adap.dev.parent =3D &dev->dev;
> -#ifdef CONFIG_OF
> =A0 =A0 =A0 =A0i2c->adap.dev.of_node =3D dev->dev.of_node;
> -#endif
>
> =A0 =A0 =A0 =A0if (i2c_type =3D=3D REGS_CE4100)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D i2c_add_adapter(&i2c->adap);
> --
> 1.7.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
