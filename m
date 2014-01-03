From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 REPOST 2/4] i2c: i2c-ibm-iic: perform the transfer in
 the interrupt handler
Date: Fri, 3 Jan 2014 16:04:16 +0100
Message-ID: <20140103150416.GA7132@katana>
References: <1387552376-12986-1-git-send-email-jjhiblot@traphandler.com>
 <1387552376-12986-3-git-send-email-jjhiblot@traphandler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387552376-12986-3-git-send-email-jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jean-jacques hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

thanks for the submission!

> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -58,6 +58,8 @@ static bool iic_force_fast;
>  module_param(iic_force_fast, bool, 0);
>  MODULE_PARM_DESC(iic_force_fast, "Force fast mode (400 kHz)");
> =20
> +#define FIFO_FLUSH_TIMEOUT 100

100 what? The unit is missing.

> @@ -167,8 +170,8 @@ static void iic_dev_init(struct ibm_iic_private* dev)
>  	/* Clear control register */
>  	out_8(&iic->cntl, 0);
> =20
> -	/* Enable interrupts if possible */
> -	iic_interrupt_mode(dev, dev->irq >=3D 0);
> +	/* Start with each individual interrupt masked*/

Space at the end of comment missing

>  static irqreturn_t iic_handler(int irq, void *dev_id)
>  {
> -	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)dev_id;
> -	struct iic_regs __iomem *iic =3D dev->vaddr;
> -
> -	DBG2(dev, "irq handler, STS =3D 0x%02x, EXTSTS =3D 0x%02x\n",
> -	     in_8(&iic->sts), in_8(&iic->extsts));
> -
> -	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
> -	out_8(&iic->sts, STS_IRQA | STS_SCMP);
> -	wake_up_interruptible(&dev->wq);
> -
> +	struct ibm_iic_private *dev =3D (struct ibm_iic_private *) dev_id;
> +	iic_xfer_bytes(dev);

Is iic_xfer_bytes later used when polling, too? Otherwise it could be
simply inserted here.


> +	if ((status & STS_ERR) ||
> +	    (ext_status & (EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA))) {
> +		DBG(dev, "status 0x%x\n", status);
> +		DBG(dev, "extended status 0x%x\n", ext_status);
> +		if (status & STS_ERR)
> +			ERR(dev, "Error detected\n");
> +		if (ext_status & EXTSTS_LA)
> +			DBG(dev, "Lost arbitration\n");
> +		if (ext_status & EXTSTS_ICT)
> +			ERR(dev, "Incomplete transfer\n");
> +		if (ext_status & EXTSTS_XFRA)
> +			ERR(dev, "Transfer aborted\n");
> +
> +		dev->status =3D -EIO;

You could consider returning different fault codes for the different
states. See Documentation/i2c/fault-codes for a guide.

> +	if (dev->msgs =3D=3D NULL) {
> +		DBG(dev, "spurious !!!!!\n");
> +		dev->status =3D -EINVAL;
> +		return dev->status;
> +	}

Does that really happen?

And it introduces a build warning:

drivers/i2c/busses/i2c-ibm_iic.c:410:12: warning: 'iic_wait_for_tc' defined=
 but not used [-Wunused-function]


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSxtFwAAoJEBQN5MwUoCm2JawP/RmKkHkt42bBdrgHMUHJGK/G
4kHlCIcmBBe8DDMl6EmKWBzM33A8gyrNTolszKjziqDNgQkp+fU13/y1fwupiYQZ
eHQGwmIpj+4CGnilI1thtayvA/tIt80vHU6ZId3SOmNcoD5yUtcDy9WpJmeMTKbC
9F2yQrjUgPfTHqpcF0UBxuhG61Y6VEBr1CLjoQKGB9RJZuPl41vTJZZ2r1LKGDr4
5C/dJTcI9Xb4n1Qtg4OA2OSKOvAY1dQVETVCV7iCKtRhi2s1AlGqgxrcktiUc7+1
1hb0sIOFfVc8M5JNAlVKiPYQYKJ/CRaRW9Eg4RmJjJLMX0cot4zQb80/t0AuZx6C
T+2KYxF8nHc3SoGgSO400tzCha0y+i4u1J2I19bmoRUpIAtYYqTreDp26w+RsOJ8
o29sdlLIx5m4OX4kfON5Y4O/IWvtcKz+W9SudSS7Va8P9os+fYQPfjOscYL60A7M
92ppRO9T7cMgNS+DfTQ52Kj0h0W60uWeqp1MQYdg9yiyxlo1Vs/298hVxJQhvEkG
IEGO+Dit5R/Du4pKqAl0mWfLRvP9SbvgwH2IqYe9FpIj0psGSaaY/ypwqcHCklQ0
n0+bWvRcEhkKGaGZTGkrSt20DDYZIMwUI4gCRtQa5Fccz7dYZn/GldzsYJhCixBu
CQfdw2aiVXQcaM62TnZY
=pQPj
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
