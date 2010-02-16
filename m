From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c/cpm: drop NO_IRQ
Date: Tue, 16 Feb 2010 08:59:54 -0700
Message-ID: <fa686aa41002160759g6abb34a0t3bca718655822a88@mail.gmail.com>
References: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-3-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1256245888-25210-3-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 22, 2009 at 2:11 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
> (http://lkml.org/lkml/2005/11/21/221). This change is safe, as the dr=
iver is
> only used on powerpc, where NO_IRQ is 0 anyhow.
>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
> =A0drivers/i2c/busses/i2c-cpm.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cp=
m.c
> index 9c2e100..16948db 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -441,7 +441,7 @@ static int __devinit cpm_i2c_setup(struct cpm_i2c=
 *cpm)
> =A0 =A0 =A0 =A0init_waitqueue_head(&cpm->i2c_wait);
>
> =A0 =A0 =A0 =A0cpm->irq =3D of_irq_to_resource(ofdev->node, 0, NULL);
> - =A0 =A0 =A0 if (cpm->irq =3D=3D NO_IRQ)
> + =A0 =A0 =A0 if (!cpm->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0/* Install interrupt handler. */
> --
> 1.6.5
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
