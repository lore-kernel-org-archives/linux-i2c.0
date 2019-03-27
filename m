From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 2/8] i2c: iproc: Add slave mode support
Date: Wed, 27 Mar 2019 23:14:52 +0100
Message-ID: <20190327221452.GA15396@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-3-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190214175725.60462-3-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Michael Cheng <ccheng@broadcom.com>
List-Id: linux-i2c@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +static void bcm_iproc_i2c_slave_init(
> +	struct bcm_iproc_i2c_dev *iproc_i2c, bool need_reset)
> +{
> +	u32 val;
> +
> +	if (need_reset) {
> +		/* put controller in reset */
> +		val =3D readl(iproc_i2c->base + CFG_OFFSET);
> +		val |=3D BIT(CFG_RESET_SHIFT);
> +		writel(val, iproc_i2c->base + CFG_OFFSET);
> +
> +		/* wait 100 usec per spec */
> +		udelay(100);
> +
> +		/* bring controller out of reset */
> +		val &=3D ~(BIT(CFG_RESET_SHIFT));
> +		writel(val, iproc_i2c->base + CFG_OFFSET);
> +	}
> +
> +	/* flush TX/RX FIFOs */
> +	val =3D (BIT(S_FIFO_RX_FLUSH_SHIFT) | BIT(S_FIFO_TX_FLUSH_SHIFT));
> +	writel(val, iproc_i2c->base + S_FIFO_CTRL_OFFSET);

Will flushing FIFOs work when a slave is register while a master
transfer is on-going at the same time?

> +
> +	/* RANDOM SLAVE STRETCH time - 20ms*/

What is a "random stretch time"? 20ms sounds like a lot. Also, missing
space before comment terminator.

> @@ -224,22 +473,25 @@ static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_=
dev *iproc_i2c)
> =20
>  	/* put controller in reset */
>  	val =3D readl(iproc_i2c->base + CFG_OFFSET);
> -	val |=3D 1 << CFG_RESET_SHIFT;
> -	val &=3D ~(1 << CFG_EN_SHIFT);
> +	val |=3D BIT(CFG_RESET_SHIFT);
> +	val &=3D ~(BIT(CFG_EN_SHIFT));
>  	writel(val, iproc_i2c->base + CFG_OFFSET);
> =20
>  	/* wait 100 usec per spec */
>  	udelay(100);
> =20
>  	/* bring controller out of reset */
> -	val &=3D ~(1 << CFG_RESET_SHIFT);
> +	val &=3D ~(BIT(CFG_RESET_SHIFT));
>  	writel(val, iproc_i2c->base + CFG_OFFSET);
> =20
>  	/* flush TX/RX FIFOs and set RX FIFO threshold to zero */
> -	val =3D (1 << M_FIFO_RX_FLUSH_SHIFT) | (1 << M_FIFO_TX_FLUSH_SHIFT);
> +	val =3D (BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT));
>  	writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
>  	/* disable all interrupts */
> -	writel(0, iproc_i2c->base + IE_OFFSET);
> +	val =3D readl(iproc_i2c->base + IE_OFFSET);
> +	val &=3D ~(IE_M_ALL_INTERRUPT_MASK <<
> +			IE_M_ALL_INTERRUPT_SHIFT);
> +	writel(val, iproc_i2c->base + IE_OFFSET);

This block looks unrelated, but I won't be too strict here...

> +	case M_CMD_STATUS_FIFO_UNDERRUN:
> +		dev_dbg(iproc_i2c->device, "FIFO under-run\n");
> +		return -ENXIO;
> +
> +	case M_CMD_STATUS_RX_FIFO_FULL:
> +		dev_dbg(iproc_i2c->device, "Master Rx FIFO full > 10ms\n");
> +		return -ETIMEDOUT;
> +

=2E.. however, this looks really unrelated to me. This is about master
transmission, or?

Rest looks OK.


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyb9dcACgkQFA3kzBSg
KbYvFQ//Z+N9U4yZ41ffQw2ciDW9/bABxl29fya7wzHtKzk0h1w0WYA174nmWoZX
GLr9ulh+NL5aAmQuLBoawUsn0Z7Yh+Pf2yLWv9LbRVqfnuEzIrQE9nzk4I5eG0VE
7XBO08s+LMpyx+L55+dlztYqWCfa1+CvCsH4q4bMlMLjL3dQDnEP0i6L2nbtUs/S
yyQOZa7mPF1ISETxDyMeaqZa+NiJNC+T2r2QH2utnKg6eDBFybQ79NtaBdxxbCMq
ZP5NKUrTcl4c+yHEtpZIfpcHfZwASlp9t8kFXthb0ohRorhDHoXmjFLTLnebteEJ
I3CzhREgiZqc8YYnduJ/um1O8H1+EwQ3HxWt+q4LFZ0Ldnr/H3vvBQwGjmyUNwwP
VOm/ETtwyRoN95Pv9Ny60rRY1Ht6nCqJpbWI8uatozb0DzdXldD0gBbGrXBujwDR
so1131GoaEM0Di32fR1QbkckswrFMCRWEAqP2m93ajpppFoCM4u3HNsX+XKuz0rS
ufQqhAVoFa1yzdPnfVniz1wkagbZ6/kBDet3LGYNIeeCvw3ZaZw0Pu+N5L685Me5
Z1qpwni5g1ukEkyCNx3F/2+TM9ROXMmaR/WwTEJVm72bpDU9NUP8yXeFBovhiO7M
7wZKkII2VNA3KG1MJd/wykhxcVDbNpo0l59N1XEBM/DuODhaE2Y=
=AuIn
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
