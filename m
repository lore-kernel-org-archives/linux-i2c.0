From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: stub: Add support for SMBus block commands
Date: Thu, 17 Jul 2014 19:12:49 +0200
Message-ID: <20140717171249.GB2901@katana>
References: <1404742983-27303-1-git-send-email-linux@roeck-us.net>
 <20140717132135.GI2740@katana>
 <20140717154020.650ad59c@endymion.delvare>
 <20140717165603.GA16408@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140717165603.GA16408@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, Randy Dunlap <rdunlap@infradead.org>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 09:56:03AM -0700, Guenter Roeck wrote:
> SMBus block commands are different to I2C block commands since
> the returned data is not normally accessible with byte or word
> commands on other command offsets. Add linked list of 'block'
> commands to support those commands.
>=20
> Access mechanism is quite simple: Block commands must be written
> before they can be read. Subsequent writes can be partial. Block
> read commands always return the number of bytes associated with
> the longest previous write.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to for-next, thanks! I took the liberty to add Jean's Rev-by tag
=66rom V2.


--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyAQRAAoJEBQN5MwUoCm2If4P/R4MuLx1IgodRlrIQBiPrLQ+
8HK0OjuJUYTOIEYB1PqvKIxpnbyVr+/A2fwphhutgKE4GZwPqyAsS5QO8c2FI+q3
zJTooXnW76OMscrRtf30KLY4W50hhcWYtuOjgX0FK/AMpU1rVU/YRzXWrxDzjLTk
fmmK81RKim0IgJnrx+cXryMnefmmGvb/elqdP+1Py0dLTKHIuVoIQhInSr7pcmSp
Z/wGywUd12zyqHiq0kpYcpyteffv/Zq0pWPyb3XOETQKNSUYVR14eKgvNtJfm1dQ
qVYcneRauRq9C+TfF9abxrbNvdZS9i6pFgEe6Z8eJLgIJKukV/1GylA0ioERyQ8t
RgVlGHNWRNpehiLq4WnaF2/F51we/yBnZif8mHU4hbTjfLBIvM9FUrk16w4w4mmh
XzMHzLzUDxn7q3YJbsxu9dddLCVv02yeci3wK1DUUIw2e1A4PrcwGUTfIjW52qjX
9r4O97b0wrzpl/iwZnU68wEzZSLLw8r+rneLcbqYZ1WpS0Dbq17o58mg4vFlsBEo
Ze8GUXiwtjp8gT5dwLiXeD3/U4q88h2zMw7C/sQVvldoSgQoP2Rtb9a75ywAiOQn
DtfagQoqPrYQpkQ19afDealZDNKAFnRZgvXXg6cOhpx5CCdv4N6jC6YK2fk2VUKT
6X4KjeGSNZ0dPxOVwsP5
=Q+5b
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
