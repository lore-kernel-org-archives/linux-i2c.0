From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c/mpc: drop NO_IRQ
Date: Tue, 16 Feb 2010 08:59:38 -0700
Message-ID: <fa686aa41002160759k360e55bdkbb3fd67ba523b027@mail.gmail.com>
References: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1256245888-25210-2-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mp=
c.c
> index d325e86..7e58443 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -115,7 +115,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned=
 timeout, int writing)
> =A0 =A0 =A0 =A0u32 x;
> =A0 =A0 =A0 =A0int result =3D 0;
>
> - =A0 =A0 =A0 if (i2c->irq =3D=3D NO_IRQ) {
> + =A0 =A0 =A0 if (!i2c->irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (!(readb(i2c->base + MPC_I2C_SR)=
 & CSR_MIF)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies=
, orig_jiffies + timeout)) {
> @@ -520,7 +520,7 @@ static int __devinit fsl_i2c_probe(struct of_devi=
ce *op,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0i2c->irq =3D irq_of_parse_and_map(op->node, 0);
> - =A0 =A0 =A0 if (i2c->irq !=3D NO_IRQ) { /* i2c->irq =3D NO_IRQ impl=
ies polling */
> + =A0 =A0 =A0 if (i2c->irq) { /* no i2c->irq implies polling */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D request_irq(i2c->irq, mpc_i=
2c_isr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 IRQF_SHARED, "i2c-mpc", i2c);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (result < 0) {
> @@ -579,7 +579,7 @@ static int __devexit fsl_i2c_remove(struct of_dev=
ice *op)
> =A0 =A0 =A0 =A0i2c_del_adapter(&i2c->adap);
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, NULL);
>
> - =A0 =A0 =A0 if (i2c->irq !=3D NO_IRQ)
> + =A0 =A0 =A0 if (i2c->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(i2c->irq, i2c);
>
> =A0 =A0 =A0 =A0irq_dispose_mapping(i2c->irq);
> --
> 1.6.5
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
