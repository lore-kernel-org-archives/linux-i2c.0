From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 i2c/for-next] i2c: i801: recover from hardware PEC
 errors
Date: Thu, 9 Jul 2015 18:59:39 +0200
Message-ID: <20150709165939.GB4744@katana>
References: <1432332868-12705-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432332868-12705-1-git-send-email-ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2015 at 03:14:28PM -0700, Ellen Wang wrote:
> On a CRC error while using hardware-supported PEC, an additional
> error bit is set in the auxiliary status register.  If this bit
> isn't cleared, all subsequent operations will fail, essentially
> hanging the controller.
>=20
> The fix is simple: check, report, and clear the bit in
> i801_check_post().  Also, in case the driver starts with the
> hardware in that state, clear it in i801_check_pre() as well.
>=20
> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
> ---
> Update: fix typos in commit message, otherwise the same as v2
>=20
> This is essentially the patch from Jean Delvare, which handles
> the polling case while my original version didn't.  (Thank you!
> Please add appropriate attribution if you wish.)
>=20
> I tested all the additional code paths by selectively commenting
> out code: with interrupts, without interrupts, relying on check_pre()
> to clear CRCE, no clearing of CRCE at all (baseline).

Jean, any comments or tags to add?

> ---
>  drivers/i2c/busses/i2c-i801.c |   53 +++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 5ecbb3f..fa50df0 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -125,6 +125,10 @@
>  #define SMBHSTCFG_SMB_SMI_EN	2
>  #define SMBHSTCFG_I2C_EN	4
> =20
> +/* Auxiliary status register bits, ICH4+ only */
> +#define SMBAUXSTS_CRCE		1
> +#define SMBAUXSTS_STCO		2
> +
>  /* Auxiliary control register bits, ICH4+ only */
>  #define SMBAUXCTL_CRC		1
>  #define SMBAUXCTL_E32B		2
> @@ -273,6 +277,29 @@ static int i801_check_pre(struct i801_priv *priv)
>  		}
>  	}
> =20
> +	/*
> +	 * Clear CRC status if needed.
> +	 * During normal operation, i801_check_post() takes care
> +	 * of it after every operation.  We do it here only in case
> +	 * the hardware was already in this state when the driver
> +	 * started.
> +	 */
> +	if (priv->features & FEATURE_SMBUS_PEC) {
> +		status =3D inb_p(SMBAUXSTS(priv)) & SMBAUXSTS_CRCE;
> +		if (status) {
> +			dev_dbg(&priv->pci_dev->dev,
> +				"Clearing aux status flags (%02x)\n", status);
> +			outb_p(status, SMBAUXSTS(priv));
> +			status =3D inb_p(SMBAUXSTS(priv)) & SMBAUXSTS_CRCE;
> +			if (status) {
> +				dev_err(&priv->pci_dev->dev,
> +					"Failed clearing aux status flags (%02x)\n",
> +					status);
> +				return -EBUSY;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -316,8 +343,30 @@ static int i801_check_post(struct i801_priv *priv, i=
nt status)
>  		dev_err(&priv->pci_dev->dev, "Transaction failed\n");
>  	}
>  	if (status & SMBHSTSTS_DEV_ERR) {
> -		result =3D -ENXIO;
> -		dev_dbg(&priv->pci_dev->dev, "No response\n");
> +		/*
> +		 * This may be a PEC error, check and clear it.
> +		 *
> +		 * AUXSTS is handled differently from HSTSTS.
> +		 * For HSTSTS, i801_isr() or i801_wait_intr()
> +		 * has already cleared the error bits in hardware,
> +		 * and we are passed a copy of the original value
> +		 * in "status".
> +		 * For AUXSTS, the hardware register is left
> +		 * for us to handle here.
> +		 * This is asymmetric, slightly iffy, but safe,
> +		 * since all this code is serialized and the CRCE
> +		 * bit is harmless as long as it's cleared before
> +		 * the next operation.
> +		 */
> +		if ((priv->features & FEATURE_SMBUS_PEC) &&
> +		    (inb_p(SMBAUXSTS(priv)) & SMBAUXSTS_CRCE)) {
> +			outb_p(SMBAUXSTS_CRCE, SMBAUXSTS(priv));
> +			result =3D -EBADMSG;
> +			dev_dbg(&priv->pci_dev->dev, "PEC error\n");
> +		} else {
> +			result =3D -ENXIO;
> +			dev_dbg(&priv->pci_dev->dev, "No response\n");
> +		}
>  	}
>  	if (status & SMBHSTSTS_BUS_ERR) {
>  		result =3D -EAGAIN;
> --=20
> 1.7.10.4
>=20

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnqh6AAoJEBQN5MwUoCm25QMP/3Cjmo2YmvhOegQe0T6Z9QWg
vQPvKdLV+ETwWz23SySlFXU31D78P/eaHgqVhcwLQBGEcstP7KEY0FTW+7k159rn
IYByHDMyJZHgnIevFUd6uy3JsNIZ4XtN6gAnZX6KZx5q0KE3YYnLEv6oxeu9KX8H
jzELtdmglQuUsGO68CXC1D0ED17BDbNKg4z67aRSWlOi5cioC9xETeKTkv2Iv5uy
jP6TkSNcIx61GMAfMt98caXyQG1aTnMfnIWVXSSliwELZOmQk1Ytf7z67Duc7yBR
JJD/DzztJ8YLRfdvroOrJ0PodELUpUevjOM3FbM95KWwJJ3TYDBmWLiegHoz4w5Y
NoDdXDOxaOHmuP0DpUJkTAuVm92hGoBoAQ2r7Bk+pyroxiz3wRHEyER1N18nx+3E
x2swhv8S3ZN4A1FV807jOaCD8KGxY7lIUVKnohw95JlgPzK40tV4rcxAtodupGbc
49BbiYvafgaxOEUwYwy6VcHIaqppdtPZgaCTooZK09Gpi+KYvaZeKEeOKFYPGkhb
VZQXUp7G+HFaALYPnaTJZAa0UBOzN2aj9XKWrHOOyq1XeCL8XiYpUXvUfJwrGAXs
iSdka5O2AwQPPo5UfoSy32JfopZur0o7yT4UZC/9KfVIGRTPlVzRQSKLLqtKi6dm
emJSULRwvadNtsCTlYNV
=vUYp
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
