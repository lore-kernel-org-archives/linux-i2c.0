From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/5] i2c:ocores: add polling interface
Date: Mon, 11 Feb 2019 11:25:26 +0100
Message-ID: <20190211102526.3y46r43usznu4jgp@ninjato>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-4-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xzumx76qidkqnvai"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190211083122.32485-4-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xzumx76qidkqnvai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 09:31:20AM +0100, Federico Vaga wrote:
> This driver assumes that an interrupt line is always available for
> the I2C master. This is not always the case and this patch adds support
> for a polling version.
>=20
> Report from Andrew Lunn:
>=20
>   I did some timing tests for this. On my box, we request a udelay of
>   80uS. The kernel actually delays for about 79uS. We then spin in
>   ocores_wait() for an additional 10-11uS, which is 3 to 4 iterations.
>=20
>   There are actually 9 bits on the wire, not 8, since there is an
>   ACK/NACK bit after the actual data transfer. So i changed the delay to
>   (9 * 1000) / i2c->bus_clock_khz. That resulted in ocores_wait() mostly
>   not looping at all. But for reading an 4K AT24 EEPROM, it increased
>   the read time by 10ms, from 424ms to 434ms. So we should probably keep
>   with 8.
>=20
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
>=20

Fixed these checkpatch warnings:

WARNING: 'transfered' may be misspelled - perhaps 'transferred'?
#111: FILE: drivers/i2c/busses/i2c-ocores.c:306:
+		 * We wait for the data to be transfered (8bit),

CHECK: Please don't use multiple blank lines
#129: FILE: drivers/i2c/busses/i2c-ocores.c:324:
+
+

WARNING: 'transfered' may be misspelled - perhaps 'transferred'?
#154: FILE: drivers/i2c/busses/i2c-ocores.c:349:
+			break; /* all messages have been transfered */

and applied to for-next, thanks!


--xzumx76qidkqnvai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhTZYACgkQFA3kzBSg
KbaeVRAAqZ4SeQ2Nh40ZbPVb5JQ3jPP5Oif5G2yTY/ivF//ajMSFBUlN7K/fLsAv
9W/u7mZKIeukpQgoJ7iAWxfY3Cs6FC0hXAEwicYGAyiZW+rUYgvRREpNg5r0hmdz
NfqIQ18H0qIX1Z7AuHAU38LrZMNSTfnUv3HjfYiN4ydvHcrY/U/BycwuO2RdH1mx
3GQ+rmtCi/f5jdxWX2M9V79iKb1H01jhVRr7xepnkg8omydSuyCkeeBgLtYEVc92
qLN3G0YLArZws1rcbmMJL2axUsjaItPtov4xh/+US4CGTGru5hE8P15YzT5vAnMS
FWBrcKcI5EpZ4Zm9zKlGLKG8C2vuK3PCRcA8u0xXB9ym4lAsqPxWYZPLUPIP6MM6
ZKPQYE0EJMCBM6wWM3pNkUUXinjmn/n9xVuFnpEDwWUPpced20JjZRpTPxTYoz63
NK2lkODo02ZnUcjqNAR+9jhBinyNnGqEE0GZo0DpgBOw2Opu85PDf9LfT8gyV8iF
sX6YiMjbJ07A54EFCHJpkpVj47Qg8cfDJfQANcn+xKiyV6WlBIdzQx2MPqi1B/vl
da0edU33kvYVf16bmlppDN6TTy30cRcjsktnVz3ZvQwPR5dZbqMhbCmx74NNb2Kb
bBBZYjEuYHIfdeOqnuhxj8k+k5iug9Rqh6mUkhE1UIGZ7OlQJNU=
=E7yU
-----END PGP SIGNATURE-----

--xzumx76qidkqnvai--
