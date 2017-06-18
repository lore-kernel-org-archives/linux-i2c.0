From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: add sc18is600 driver
Date: Sun, 18 Jun 2017 17:18:53 +0200
Message-ID: <20170618151853.GA4927@katana>
References: <20170613154748.7018-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170613154748.7018-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	switch (dev->state) {
> +	case SC18IS600_STAT_OK:
> +		break;
> +	case SC18IS600_STAT_NAK_ADDR:
> +		return -EIO;
> +	case SC18IS600_STAT_NAK_DATA:
> +		return -EREMOTEIO;
> +	case SC18IS600_STAT_SIZE:
> +		return -EINVAL;
> +	case SC18IS600_STAT_TIMEOUT:
> +		return -ETIMEDOUT;
> +	case SC18IS600_STAT_TIMEOUT2:
> +		return -ETIMEDOUT;
> +	case SC18IS600_STAT_BLOCKED:
> +		return -ETIMEDOUT;
> +	default:
> +	case SC18IS600_STAT_BUSY:
> +		dev_err(&dev->spi->dev, "device hangup detected, reset!");
> +		sc18is600_reset(dev);
> +		return -EAGAIN;
> +	}

Please have a look at Documentation/i2c/fault-codes. Most look good, but
the NAK cases probably need fixing.


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllGmdgACgkQFA3kzBSg
KbbjSw//VQWH2fkxxQj/1d6EGgAKjxSqxalKwihusPlp1TroTr9r38j4SE0VTPsT
NqoFADcPcH2sDGg2OAs98KgE9gjPHA1aRIEiC4hCU76Wg6K8JKKxuvJjU9bGGYdc
SgTXVLCpRaRMwjaebcnvfLLUBqxJoEBR/fDfBSgmXhlWyajHzxVY7lmW14NNUX/W
jqqyN0iWRc87Kc10B8MqEd8hshwD3d7CfEsprusSsN6qP0pbH1uEGVvpiq31O5P7
5uA042YwMwItDCHgg8/StDvmQTYwE1pftHYgBd7mEC4Y3aJ2+YCMujD3StEWQyIG
upusj+MxCYmNDyirSbHSdcLmcqrsbjMx9xp4kbh0CJhB3uyeUZmgwk3ROxhJmhhf
t0v3GJYJflf4YOzdj8OpIAz/Vf63ecg7f83ETaqN6jxi+QlNngl3Fy+s6egr1489
Xdxa2B4Pski3L34sI+iEk7UESWOpFdP++Ig7tu69ZRend0Zm15KAM+r8+6y2goGb
RUgjrC8TRV9VPog1Y8xTjK7p8zkCHc32cnixycGjHElwOR4EUaC0Sv1lFU2oEBmX
Mi5gIGPFwZj8fg4wVgXbyAoEF01GrfSRx98LCmqkf3lktDvuMkP95R2alORrIqgT
x6DuG0hNkbEGq5wIMagI9+Cw0K6WxPewVEvJPtN85bop58uL+Vo=
=XC1a
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
