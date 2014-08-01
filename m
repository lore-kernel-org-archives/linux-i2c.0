From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c,designware: add new bindings
Date: Fri, 1 Aug 2014 19:52:31 +0200
Message-ID: <20140801175230.GD3277@katana>
References: <1406117217.2895.12.camel@acox1-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406117217.2895.12.camel-wU3TRTJX3O1FGiH78xh5akvbDziVy8sZEvhb3Hwu1Ks@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Wed, Jul 23, 2014 at 01:06:57PM +0100, Alan Cox wrote:
> This may appear as PCI or ACPI depending upon the firmware so we
> have to list both. All share the same ACPI identifier but not
> the same PCI identifier.
>=20
> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c  |    9 +++++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/bus=
ses/i2c-designware-pcidrv.c
> index 3356f7a..d31d313 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -188,6 +188,7 @@ static struct  dw_pci_controller dw_pci_controllers[]=
 =3D {
>  		.scl_sda_cfg =3D &hsw_config,
>  	},
>  };
> +
>  static struct i2c_algorithm i2c_dw_algo =3D {
>  	.master_xfer	=3D i2c_dw_xfer,
>  	.functionality	=3D i2c_dw_func,
> @@ -350,6 +351,14 @@ static const struct pci_device_id i2_designware_pci_=
ids[] =3D {
>  	/* Haswell */
>  	{ PCI_VDEVICE(INTEL, 0x9c61), haswell },
>  	{ PCI_VDEVICE(INTEL, 0x9c62), haswell },
> +	/* Braswell / Cherrytrail */
> +	{ PCI_VDEVICE(INTEL, 0x22C1), baytrail,},
> +	{ PCI_VDEVICE(INTEL, 0x22C2), baytrail },
> +	{ PCI_VDEVICE(INTEL, 0x22C3), baytrail },
> +	{ PCI_VDEVICE(INTEL, 0x22C4), baytrail },
> +	{ PCI_VDEVICE(INTEL, 0x22C5), baytrail },
> +	{ PCI_VDEVICE(INTEL, 0x22C6), baytrail },
> +	{ PCI_VDEVICE(INTEL, 0x22C7), baytrail },
>  	{ 0,}
>  };
>  MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 402ec39..915ce6c2 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -106,6 +106,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[=
] =3D {
>  	{ "INT3432", 0 },
>  	{ "INT3433", 0 },
>  	{ "80860F41", 0 },
> +	{ "808622C1", 0 },

Why are 22c2 up to 22c7 not added here?

Thanks,

   Wolfram

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT29PeAAoJEBQN5MwUoCm2z28QAJmuOkRIKxPjdqZIj3ycwpWF
8B8p4GV/bPGtZa2pbSUMTtXlrgAAKYDoBrsDXSg07nA8dwJAdMJp5OBtWt22UJAS
yr+hJB4s6/Rvgncd9bUp1ZMI+MJXoQtIMmGUeNGcd56mYqK06eBJeta/0naCLktV
VcfExb9+9z96LzeAE/zvsyeu2ab53zkF0upgX/gr5VnVKUBsjwJAsi7BdkI7LTY9
ZNboNZYev02+be7F19rbuN6j/C+QxjgybUxIuQLYlZzGAVgPIFIWOoWLeMB9DqhZ
hohDLqPDZecea7DsK/ph6GWnVbpba4GebmjjHs9BniwLpEI7UkFu3UomZ0gNPqjo
6CSODp30NS5uJBv1e+lu0j4vjLAEgLsqGEYLPS7/etonN35DfIifbLwftLW3V7I1
8GsE3aIJENZ/M7RyOBDPPY7Q8gfW8C/RMbWfc0cgMTPAlMH/xdmOP7S1O4ilIKfY
DUHHXFYppGQHNmku+KbRwN2iEg3CYLR13z+jza4XCp3xR0yYTj0hWDn2KdOWbuQF
hoYvWiZlg6QRJEFGdz7tjG3FexDYdeVx2pCYtyjy0lcZBdwz4y5RVMmuQqsZO+jm
XnST0h5Dq2Sk08L8agFVjXD+2Zq9GOceJdUa/o44s8jbkIz41ExUDCb/gnl/pKwx
gTTMB+sl5YvKR60vjI2r
=RQjg
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
