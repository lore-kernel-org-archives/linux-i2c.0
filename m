From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: driver for the Conexant Digicolor I2C controller
Date: Wed, 18 Mar 2015 22:07:30 +0100
Message-ID: <20150318210730.GA12960@katana>
References: <7da767503ac6085c10fbd1953ffd36621b8bf0c5.1424092804.git.baruch@tkos.co.il>
 <a106023efa9fd648f46021cd063437df798528de.1424092804.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a106023efa9fd648f46021cd063437df798528de.1424092804.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 16, 2015 at 03:20:04PM +0200, Baruch Siach wrote:
> This commit adds a driver for the I2C master controller on the CX92755 So=
C. The
> CX92755 is one SoC in the Conexant Digicolor series. This driver should s=
upport
> other SoCs from that series.
>=20
> Only 7bit slave addresses are currently supported.
>=20
> Tested on the Equinox CX92755 EVK, using i2c-tools utilities to read and =
write
> the on-chip (sic) audio codec.
>=20
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

Looks mostly good.

> +static u32 dc_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}

You probably want to advertise I2C_FUNC_NOSTART here, too?

And if you could rebase to something after 4.0-rc1, that would be much
appreciated.

Thanks,

   Wolfram

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCekSAAoJEBQN5MwUoCm2rdgP/02PDA9QYm0EqMs27Eaeul3r
Xcsn/LwyZqs5Vr0naZFprzUyjvnPux0MLNg6oVcSz2ciqR1/5JwBOgWDtjZtNEsW
GsqQVZiD94sysPPhlhdWAA7Mp8QxnkUjNhZyF9ppoLI2ATaSVcpFR/P2xWhT+EBu
DTH2J0uaQy5/hMgXa28uU4uiSQGkInL9xCrfyDe+CbSVMfALL6cKWTt4+os0cIyv
L3k5P0yG8UNIW5gSpiDB1gl05aU5jz4+uwm4MhE9jFv4/kNhp7vCjQWvBe6HCKfQ
z5N7D76GyGsvXGI12TrAwi82ugrDiS2ZvJQrmRr5MrSxgYa6F8Cf+aDxQwpm9e03
3/IHktBPh++a1R9c0nBqXSDhp2e9WBpWyc6AJVrgXDBpGk1Rp1gERll9YEMAHwTL
M4Hesh7Lcu+S3+5Vd+4w52kYx7if/ZyBzac7x7FF5HhTDaQmzKnWhjiei9T3vGM7
5nKttiuzMxuRcOccPh07qsTxhg3FKj768GpCuGg62ABbgGGHDhjHWURSQ0tKzASv
dhyvuRwkPdwqKzDFJI19B/Vpy9tP57MIV7xVlmTeQyOtYwGbtB/hbaBKEu9V1+Yj
sa//sj/aKOieOzQTzVGZiqJRE28sRvdmyRW7PcxO6eGzLLcJec32hsa991zEcHK0
iOain3H1nA6lJ7jGhmK/
=bb2q
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
