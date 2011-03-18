From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 18 Mar 2011 12:49:32 +0100
Message-ID: <20110318114931.GA2155@pengutronix.de>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300444824-13713-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1300444824-13713-2-git-send-email-waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Waldemar,

On Fri, Mar 18, 2011 at 11:40:24AM +0100, Waldemar Rymarkiewicz wrote:
> Add new driver for MicroRead NFC chip connected to i2c bus.
>=20
> See Documentation/nfc/nfc-microread.txt.
>=20
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>

Besides the stuff Alan mentioned...

> +struct microread_nfc_platform_data {
> +	unsigned int rst_gpio;
> +	unsigned int irq_gpio;
> +	unsigned int ioh_gpio;

=2E.. you should request and setup the GPIOs before using them.


> +free_irq:
> +	free_irq(client->irq, info);
> +free_buf:
> +	kfree(info->buf);
> +free_info:
> +	kfree(info);
> +
> +	dev_info(&client->dev, "Not probed.");
> +	return ret;
> +}

When respinning, you could consider using managed devices (devm_*);
this error path could completely go then.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2DRssACgkQD27XaX1/VRuPcgCgsux9JZGU4YdKQxrO5VrQCCS5
v3gAoJiibsZy+ufsGGKqIrVmeU6TJTTt
=M1jq
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
