From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c/ibm-iic: drop NO_IRQ
Date: Tue, 16 Feb 2010 09:01:20 -0700
Message-ID: <fa686aa41002160801k7a277567r50d71fb9d827203b@mail.gmail.com>
References: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-3-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-4-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1256245888-25210-4-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 22, 2009 at 2:11 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
> (http://lkml.org/lkml/2005/11/21/221). This change is safe, as the dr=
iver is
> only used on powerpc, where NO_IRQ is 0 anyhow.
>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Ben, will you pick up this series of 3, or would you like me to merge
them through the powerpc tree?

Thanks,
g.

> ---
> =A0drivers/i2c/busses/i2c-ibm_iic.c | =A0 14 +++++++-------
> =A01 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2=
c-ibm_iic.c
> index b1bc6e2..2bef534 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -668,12 +668,12 @@ static int __devinit iic_request_irq(struct of_=
device *ofdev,
> =A0 =A0 =A0 =A0int irq;
>
> =A0 =A0 =A0 =A0if (iic_force_poll)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> =A0 =A0 =A0 =A0irq =3D irq_of_parse_and_map(np, 0);
> - =A0 =A0 =A0 if (irq =3D=3D NO_IRQ) {
> + =A0 =A0 =A0 if (!irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&ofdev->dev, "irq_of_parse_and=
_map failed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Disable interrupts until we finish initialization, =
assumes
> @@ -683,7 +683,7 @@ static int __devinit iic_request_irq(struct of_de=
vice *ofdev,
> =A0 =A0 =A0 =A0if (request_irq(irq, iic_handler, 0, "IBM IIC", dev)) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&ofdev->dev, "request_irq %d f=
ailed\n", irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Fallback to the polling mode */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NO_IRQ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return irq;
> @@ -719,7 +719,7 @@ static int __devinit iic_probe(struct of_device *=
ofdev,
> =A0 =A0 =A0 =A0init_waitqueue_head(&dev->wq);
>
> =A0 =A0 =A0 =A0dev->irq =3D iic_request_irq(ofdev, dev);
> - =A0 =A0 =A0 if (dev->irq =3D=3D NO_IRQ)
> + =A0 =A0 =A0 if (!dev->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(&ofdev->dev, "using polling m=
ode\n");
>
> =A0 =A0 =A0 =A0/* Board specific settings */
> @@ -766,7 +766,7 @@ static int __devinit iic_probe(struct of_device *=
ofdev,
> =A0 =A0 =A0 =A0return 0;
>
> =A0error_cleanup:
> - =A0 =A0 =A0 if (dev->irq !=3D NO_IRQ) {
> + =A0 =A0 =A0 if (dev->irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iic_interrupt_mode(dev, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(dev->irq, dev);
> =A0 =A0 =A0 =A0}
> @@ -790,7 +790,7 @@ static int __devexit iic_remove(struct of_device =
*ofdev)
>
> =A0 =A0 =A0 =A0i2c_del_adapter(&dev->adap);
>
> - =A0 =A0 =A0 if (dev->irq !=3D NO_IRQ) {
> + =A0 =A0 =A0 if (dev->irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iic_interrupt_mode(dev, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(dev->irq, dev);
> =A0 =A0 =A0 =A0}
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
