From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c-i801: Check if interrupts are disabled
Date: Tue, 11 Nov 2014 11:58:54 +0100
Message-ID: <20141111105853.GB3794@katana>
References: <20141110222655.13660613@endymion.delvare>
 <20141110223139.02aafde4@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141110223139.02aafde4-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 10:31:39PM +0100, Jean Delvare wrote:
> There is a control bit in the PCI configuration space which disables
> interrupts. If this bit is set, the driver should not try to make use
> of interrupts, it won't receive any.
>=20
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> --- linux-3.18-rc4.orig/drivers/i2c/busses/i2c-i801.c	2014-11-10 22:29:44=
=2E416991298 +0100
> +++ linux-3.18-rc4/drivers/i2c/busses/i2c-i801.c	2014-11-10 22:29:46.9150=
45662 +0100
> @@ -110,12 +110,16 @@
> =20
>  /* PCI Address Constants */
>  #define SMBBAR		4
> +#define SMBPCICTL	0x004
>  #define SMBPCISTS	0x006
>  #define SMBHSTCFG	0x040
> =20
>  /* Host status bits for SMBPCISTS */
>  #define SMBPCISTS_INTS		0x08
> =20
> +/* Control bits for SMBPCICTL */
> +#define SMBPCICTL_INTDIS	0x0400
> +
>  /* Host configuration bits for SMBHSTCFG */
>  #define SMBHSTCFG_HST_EN	1
>  #define SMBHSTCFG_SMB_SMI_EN	2
> @@ -1235,6 +1239,23 @@ static int i801_probe(struct pci_dev *de
>  	priv->adapter.timeout =3D HZ / 5;
> =20
>  	if (priv->features & FEATURE_IRQ) {
> +		u16 pcictl, pcists;
> +
> +		/* Complain if an interrupt is already pending */
> +		pci_read_config_word(priv->pci_dev, SMBPCISTS, &pcists);
> +		if (pcists & SMBPCISTS_INTS)
> +			dev_warn(&dev->dev, "An interrupt is pending!\n");

You think it is better to not clear it?

> +
> +		/* Check if interrupts have been disabled */
> +		pci_read_config_word(priv->pci_dev, SMBPCICTL, &pcictl);
> +		if (pcictl & SMBPCICTL_INTDIS) {
> +			dev_warn(&dev->dev,
> +				 "Interrupts are disabled, will use polling\n");

I'd say it is more info than warning?

> +			priv->features &=3D ~FEATURE_IRQ;
> +		}
> +	}
> +
> +	if (priv->features & FEATURE_IRQ) {
>  		init_waitqueue_head(&priv->waitq);
> =20
>  		err =3D request_irq(dev->irq, i801_isr, IRQF_SHARED,
>=20
> --=20
> Jean Delvare
> SUSE L3 Support

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUYevtAAoJEBQN5MwUoCm2Z0sP/1W+FfQJPahPrio1TVeRUmZA
Ltdk8YJBIDmqvjkNhZh8B6PPIGNpENyTakPgpmPhNC0vPLgVL0cjW6USk7lUwbl0
utItkYRYtwD9RrCSFC1cdSK3VpMyMPaaMHGQrfWW9m/D41tdoEBczE/rB6crEebx
5jlVF9N3Gvkhzt+Ote0nXyxPPWtaWFFMLWxGpKDckej0S2tbC33E4SaMd4LStqlI
7icJayZQAsgwJM6iprnENd5n9Q/0tRArGGjLTkT+Sco4i+lN9szlhmTK9I9m8BAA
OPgSlXveCCubiMGfZUNesZEdwX1JguA8NQIpJ30mTMQ02Nz3CuxHBQ35LHliYehH
XLDz/m/v0Pth4xyxhRhKv8k04Odbv/kMrVzUgNHSULvMExTx8xXbWUYcFr7lj3VG
42gaZ917CQkW1G+95UiZAwkxNRLyWNT72SwEeujuOg0AbsX3cCTCGoX/VRwrC793
X9Rm45mdiie6yMTuUDErTJHAC2WrIfch0nAN1nc2kPJAak6alDZ79ChDzxcXl+YI
r+zy45DjvpXTcnfhyVCOBKmZvlbxp5hiBnQMV6biVN/j8sn6O0nNN+qaQiZXrhOh
kFAjWN0M/aOP93qmTS3N3I/+CXfRZohsDftfmFgnEIxTTWF1Sxa/Rwqc+Tw08I/b
t/kdJeL6io2Oy5vAG3Ef
=qD5V
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
