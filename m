From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Fix SMBus port selection for AMD Family 17h
 chips
Date: Sat, 12 Aug 2017 13:33:57 +0200
Message-ID: <20170812113357.ijna5riha7uechja@ninjato>
References: <1500162686-21682-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nvnixaxytllym2dm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42750 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdHLLd7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 07:33:59 -0400
Content-Disposition: inline
In-Reply-To: <1500162686-21682-1-git-send-email-linux@roeck-us.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--nvnixaxytllym2dm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2017 at 04:51:26PM -0700, Guenter Roeck wrote:
> AMD Family 17h uses the KERNCZ SMBus controller. While its documentation
> is not publicly available, it is documented in the BIOS and Kernel
> Developer=E2=80=99s Guide for AMD Family 15h Models 60h-6Fh Processors.
>=20
> On this SMBus controller, the port select register is at PMx register
> 0x02, bit 4:3 (PMx00 register bit 20:19).
>=20
> Without this patch, the 4 SMBus channels on AMD Family 17h chips are
> mirrored and report the same chips on all channels.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I need input from Jean for this one.

> ---
>  drivers/i2c/busses/i2c-piix4.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix=
4.c
> index 0ecdb47a23ab..01f767ee4546 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -94,6 +94,12 @@
>  #define SB800_PIIX4_PORT_IDX_ALT	0x2e
>  #define SB800_PIIX4_PORT_IDX_SEL	0x2f
>  #define SB800_PIIX4_PORT_IDX_MASK	0x06
> +#define SB800_PIIX4_PORT_IDX_SHIFT	1
> +
> +/* On kerncz, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
> +#define SB800_PIIX4_PORT_IDX_KERNCZ		0x02
> +#define SB800_PIIX4_PORT_IDX_MASK_KERNCZ	0x18
> +#define SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ	3
> =20
>  /* insmod parameters */
> =20
> @@ -149,6 +155,8 @@ static const struct dmi_system_id piix4_dmi_ibm[] =3D=
 {
>   */
>  static DEFINE_MUTEX(piix4_mutex_sb800);
>  static u8 piix4_port_sel_sb800;
> +static u8 piix4_port_mask_sb800;
> +static u8 piix4_port_shift_sb800;
>  static const char *piix4_main_port_names_sb800[PIIX4_MAX_ADAPTERS] =3D {
>  	" port 0", " port 2", " port 3", " port 4"
>  };
> @@ -347,7 +355,19 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_d=
ev,
> =20
>  	/* Find which register is used for port selection */
>  	if (PIIX4_dev->vendor =3D=3D PCI_VENDOR_ID_AMD) {
> -		piix4_port_sel_sb800 =3D SB800_PIIX4_PORT_IDX_ALT;
> +		switch (PIIX4_dev->device) {
> +		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
> +			piix4_port_sel_sb800 =3D SB800_PIIX4_PORT_IDX_KERNCZ;
> +			piix4_port_mask_sb800 =3D SB800_PIIX4_PORT_IDX_MASK_KERNCZ;
> +			piix4_port_shift_sb800 =3D SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ;
> +			break;
> +		case PCI_DEVICE_ID_AMD_HUDSON2_SMBUS:
> +		default:
> +			piix4_port_sel_sb800 =3D SB800_PIIX4_PORT_IDX_ALT;
> +			piix4_port_mask_sb800 =3D SB800_PIIX4_PORT_IDX_MASK;
> +			piix4_port_shift_sb800 =3D SB800_PIIX4_PORT_IDX_SHIFT;
> +			break;
> +		}
>  	} else {
>  		mutex_lock(&piix4_mutex_sb800);
>  		outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
> @@ -355,6 +375,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_de=
v,
>  		piix4_port_sel_sb800 =3D (port_sel & 0x01) ?
>  				       SB800_PIIX4_PORT_IDX_ALT :
>  				       SB800_PIIX4_PORT_IDX;
> +		piix4_port_mask_sb800 =3D SB800_PIIX4_PORT_IDX_MASK;
> +		piix4_port_shift_sb800 =3D SB800_PIIX4_PORT_IDX_SHIFT;
>  		mutex_unlock(&piix4_mutex_sb800);
>  	}
> =20
> @@ -616,8 +638,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *ada=
p, u16 addr,
>  	smba_en_lo =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
> =20
>  	port =3D adapdata->port;
> -	if ((smba_en_lo & SB800_PIIX4_PORT_IDX_MASK) !=3D port)
> -		outb_p((smba_en_lo & ~SB800_PIIX4_PORT_IDX_MASK) | port,
> +	if ((smba_en_lo & piix4_port_mask_sb800) !=3D port)
> +		outb_p((smba_en_lo & ~piix4_port_mask_sb800) | port,
>  		       SB800_PIIX4_SMB_IDX + 1);
> =20
>  	retval =3D piix4_access(adap, addr, flags, read_write,
> @@ -706,7 +728,7 @@ static int piix4_add_adapter(struct pci_dev *dev, uns=
igned short smba,
> =20
>  	adapdata->smba =3D smba;
>  	adapdata->sb800_main =3D sb800_main;
> -	adapdata->port =3D port << 1;
> +	adapdata->port =3D port << piix4_port_shift_sb800;
> =20
>  	/* set up the sysfs linkage to our parent device */
>  	adap->dev.parent =3D &dev->dev;
> --=20
> 2.7.4
>=20

--nvnixaxytllym2dm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmO56UACgkQFA3kzBSg
KbaOvg/+JxdVulVohn8VRnHS5ufgGWatPR/lZyBDCnV4hXXTI1RRJfixJBw5I9jU
7miHItST+Wvs2Fod6z7Z9MObgfGkx/Q1qGnHrY/4qJFb4HNte2w7JJVswkxoFeOg
OI5OXEATmNQnnmbTAkctMIs+GkpLyE1XwfW+I5bwP9er0FI9y0Lyc5X0csu8E6Xj
GbBjnYRRC1PYvmnrqBaVuW/wnnSjZx+d7hhgVajpsMAuM0VDFhsAdBh85ZJtrHyF
EXDhdhmyswoKB4ANr2YmsVmynf/xv3KDcMtTj4q9Fy9eNsIsqpr8sceYrO92Ov0m
T093P9FzpHQA3cNimWOnnEy0+SWg5cdxJtwPLgSovxRbcCikmmdM6NKq295Jrmou
I3QBqjSO6OkuBxUCZ3S0ZaqZpaGhXY9NUF6mGFyg8bpIZYWJITAh+kh7Mh+ThxxK
cUC4siq519oGqRIIFWVtJVKoKnfoO66FBzbnWr8MLKG04DX/JtWJ+de2fc1UkWVc
Kg+dvPnt95D55cpI+8sY1ec7LW5BYGNisDrnmHnyQPDZOBHURwU8AoH9glIOCC/f
k085TXORVqLbguReJJlxU+fHqw/YMGrjDASVpxVDWxqGy5ibPx5DiLjyfzcx+/eJ
fv+ElsVTN/UKyqko08YAiGUvdD+zdzQoIcNQUlyEkfrKkFH7sKU=
=XkU/
-----END PGP SIGNATURE-----

--nvnixaxytllym2dm--
