From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/2] i2c: qup: support SMBus block read
Date: Sat, 18 Jun 2016 16:13:28 +0200
Message-ID: <20160618141328.GC1430@tetsubishi>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
 <1465409985-17113-2-git-send-email-austinwc@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465409985-17113-2-git-send-email-austinwc@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Austin Christ <austinwc@codeaurora.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, rruigrok@codeaurora.org, timur@codeaurora.org, cov@codeaurora.org, nkaje@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 12:19:45PM -0600, Austin Christ wrote:
> From: Naveen Kaje <nkaje@codeaurora.org>
>=20
> I2C QUP driver relies on SMBus emulation support from the framework.
> To handle SMBus block reads, the driver should check I2C_M_RECV_LEN
> flag and should read the first byte received as the message length.
>=20
> The driver configures the QUP hardware to read one byte. Once the
> message length is known from this byte, the QUP hardware is configured
> to read the rest.
>=20
> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
> Signed-off-by: Austin Christ <austinwc@codeaurora.org>
> Reviewed-by: sricharan@codeaurora.org

Missing name here, too. Looks good otherwise.


--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZVcHAAoJEBQN5MwUoCm2BogQALTxnNWZHV88YMvLFeSna0E2
Aq2Hu3Y5zBNZKBzch3zBE6LTFC7IykkNohPQaMcCjMeUJNQtrAxGBUYwwlishuEp
bmRCVRDg4w37Mcjh7fh0bg4Y7WLpSZzUlS+VkaJxYGU8FO5mi9QPB/6soopp9Vyk
FHc6H+ThR3WcWf7cDBNjeDejThFNB2l3LVfrfLDkiWp3doAFlZejA3ApwNW+/2KX
duSTL0e0F+5chEVBkpwgJaayBovoOjk0u2DRlf67UM7nlElCtl0STPTUolI0MmX9
11pH7yQhap49qqhJ7asK85bp3TCgHokn5LUTZX2u0VBlmndfaSKUHjDeBj2QGTUA
hRx0PA21gfuAzjjn5tU2W7Mv5Oyp6y2DT1tKAk7N0SgWvMgspWqhF9085J6Ow0P9
LS9trIDpcygR9mKUqNr/z7qRn0ekXwdW+pLVtfWeUh83aEdlWqPKKGFE0hB+Ldqc
1Wh9llShJMlJrsEcc7l10VQg7mVSv4MImM1W3zpIpgcmCw/ALQd0YIglbeYaAUd9
rsGeQ6YZacGNNM32uH2TTOzWzJxT6Xn55IcPgUxY58C7sfwk1+zPdoiB3fpcxJTu
6NdsiZa89c428cJ9lBrw6t1KhQ69ZvQurDF4dlca2nkqZ4nleIzV6z7LPLsa8Dmp
P/PyFewo7Cm0+zMAzU1x
=3BSk
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
