From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c-i801: Fallback to polling if request_irq() fails
Date: Tue, 11 Nov 2014 11:57:34 +0100
Message-ID: <20141111105734.GA3794@katana>
References: <20141110222655.13660613@endymion.delvare>
 <20141110223104.6419229d@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141110223104.6419229d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 10:31:04PM +0100, Jean Delvare wrote:
> The i2c-i801 driver can work without interrupts, so there is no reason
> to make a request_irq failure fatal. Instead we can simply fallback
> to polling.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> --- linux-3.18-rc4.orig/drivers/i2c/busses/i2c-i801.c	2014-11-10 22:29:42=
=2E788955868 +0100
> +++ linux-3.18-rc4/drivers/i2c/busses/i2c-i801.c	2014-11-10 22:29:44.4169=
91298 +0100
> @@ -1242,9 +1242,11 @@ static int i801_probe(struct pci_dev *de
>  		if (err) {
>  			dev_err(&dev->dev, "Failed to allocate irq %d: %d\n",
>  				dev->irq, err);
> -			goto exit_release;
> +			priv->features &=3D ~FEATURE_IRQ;
> +			dev_info(&dev->dev, "SMBus using polling\n");

Shouldn't this message also be printed for !FEATURE_IRQ? I'd think it
should be moved to another place. We can also deduce from the dev_err
above that polling will be used, no?

> +		} else {
> +			dev_info(&dev->dev, "SMBus using PCI interrupt\n");
>  		}
> -		dev_info(&dev->dev, "SMBus using PCI Interrupt\n");
>  	}
> =20
>  	/* set up the sysfs linkage to our parent device */
> @@ -1272,7 +1274,6 @@ static int i801_probe(struct pci_dev *de
>  exit_free_irq:
>  	if (priv->features & FEATURE_IRQ)
>  		free_irq(dev->irq, priv);
> -exit_release:
>  	pci_release_region(dev, SMBBAR);
>  exit:
>  	kfree(priv);
>=20
> --=20
> Jean Delvare
> SUSE L3 Support

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUYeueAAoJEBQN5MwUoCm2aLEP/RCvoM5Hvab83I0qD3SGsPZb
HkyzOClSvUA46IztxB1lK8IsLkYRNDjvLarpECEivpSWXEjgDde3TT7eVqb0sRTC
zrBSaensDbCx2yAkS4U39IISmS8b5H5ZKx/stO4OtLEM2fxVnS6SWDSys/aN6m5C
tma4wK4wIvIzpkgCv1CjyCma/2jg8GyJz++b9k1DV0vzMgTw6iMRulpIDClhhOyQ
9JeR+6EgUDNPr8NHdpeiKqJlRNSZAGaLLf+tk/HLf2dACm3ex5FDAjGOwSl/Er2b
EdLkUrNwMeh9hUBT0giB0iuwkNQyVYGCRnlPbDBaMfvWimCUFWPjvZ2KsWG+2+H1
7x4FAwwADRl1StCZt0k8M7wT7nxsIlQq5mp7K2KivNpWAzmdHaasmw7bHzT8Jiwz
GDCharGwtPnYxXvc0s8ZW6KlH666WBWIUXqdK5N+x6bw27E/HMqebTOwCbAOc7hg
ay6Y43N8cWcVy7KjZ0TgSbpUEyprXHver8pcTT0xlFCAKBB5b3k1oA0wAq1RXZcb
2u+IqCRIBrL17iBM/eOr5AMZnvEj6yqqtZZ4Au0jUMp3hVwXcjrM2UafH9FTvCpd
ivb4aKiCEU9mDYDjPHgZRfs0AxBE86vZp0OGRjaRUf7gQXSV4BkT7QRHCLWuDMRE
eyr2CCACCBZWMeV6gmQ9
=RfZM
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
