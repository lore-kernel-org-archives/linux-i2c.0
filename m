From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 1/3] i2c: added FUNC flag for unsupported clock
 stretching
Date: Tue, 20 Oct 2015 17:35:11 +0200
Message-ID: <20151020153511.GI5379@katana>
References: <1442410323-9833-1-git-send-email-nicola@corna.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43496 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbbJTPfV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 11:35:21 -0400
Content-Disposition: inline
In-Reply-To: <1442410323-9833-1-git-send-email-nicola@corna.info>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Nicola Corna <nicola@corna.info>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-i2c@vger.kernel.org


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2015 at 03:32:01PM +0200, Nicola Corna wrote:
> Added I2C_FUNC_NO_CLK_STRETCH, to be used when clock stretching is not
> supported.
>=20
> Signed-off-by: Nicola Corna <nicola@corna.info>

I think this should be rather a quirk than a functionality, i.e.
I2C_AQ_NO_CLK_STRETCH. Agree?

> ---
>  Documentation/i2c/functionality | 1 +
>  include/uapi/linux/i2c.h        | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/Documentation/i2c/functionality b/Documentation/i2c/function=
ality
> index 4aae8ed..f53807e 100644
> --- a/Documentation/i2c/functionality
> +++ b/Documentation/i2c/functionality
> @@ -21,6 +21,7 @@ For the most up-to-date list of functionality constants=
, please check
>                                    I2C_M_REV_DIR_ADDR and I2C_M_NO_RD_ACK
>                                    flags (which modify the I2C protocol!)
>    I2C_FUNC_NOSTART                Can skip repeated start sequence
> +  I2C_FUNC_NO_CLK_STRETCH         Does NOT support clock stretching
>    I2C_FUNC_SMBUS_QUICK            Handles the SMBus write_quick command
>    I2C_FUNC_SMBUS_READ_BYTE        Handles the SMBus read_byte command
>    I2C_FUNC_SMBUS_WRITE_BYTE       Handles the SMBus write_byte command
> diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
> index b0a7dd6..59e4b43 100644
> --- a/include/uapi/linux/i2c.h
> +++ b/include/uapi/linux/i2c.h
> @@ -88,6 +88,7 @@ struct i2c_msg {
>  #define I2C_FUNC_SMBUS_PEC		0x00000008
>  #define I2C_FUNC_NOSTART		0x00000010 /* I2C_M_NOSTART */
>  #define I2C_FUNC_SLAVE			0x00000020
> +#define I2C_FUNC_NO_CLK_STRETCH		0x00000040 /* No check for SCL low */
>  #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
>  #define I2C_FUNC_SMBUS_QUICK		0x00010000
>  #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000
> --=20
> 2.5.1
>=20

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJl8vAAoJEBQN5MwUoCm2twkP/iOiPdKI1MJAZeFnV3PSacI8
sMrvv4NfWf44AGTVhnDdKAZZ1BlwUqmmBqU5X5tz5C+d3llTNKlO1m1Nv5XPzWRR
GV/4++yuOv6OVm3bg70qKYvdBDoEU8fGZjOjrXqBZ7iAoAQWuVVu98NT8pDfilMh
j+u7BRqdoB9kMWjkduFuDKcL9epVFh4s19YwmS239S7mwKIphdw82rwf3F2j+nJz
5+o4PxsCuXMi+CCqFZi3LLzGFQyzq1sCQ+K92dj3ZBLcljkt/8W4kCVKyr/e0jp4
JfNL4dpwXjxK1Fll/rRvjWPaEVB6Uin7MnLyxIyvy63Vg/exd0wyd62mnyA0bxwF
Xv0/rXfyr40lxflI1WZ9B3adNr/mzxNlDuT9rWgUebUBJ0dSKmJkLDr/rkh1P4mr
z6EpyySgzA/dvejPvBNFL7lIA1ZvkZ9CFzRYdEXxpBey7ZTXFy2Jg6s7z775cmV8
J8XCVrKDTczfx7ZFErBoqT+vYo4hXEq8qrVRNxqDP3hoRV9fPkxI760RzfT94duc
z3ImQPO5XqFEoPCoWaEmIZAkr6G0wCPPxJSwDKaIeTWUuZLfs9w8T9XcZmpWS3xb
MifjMWj1H0XCmzjPfPGhgSLosAR/UQT01/fv+Utorp00YSR9+QD2xQW5Dl3c9LMX
dxPf0jRZwKtACE1e6hzK
=aBbH
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--
