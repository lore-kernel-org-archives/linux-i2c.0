From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: i2c-mv64xxx: rework offload support to fix
 several problems
Date: Wed, 17 Dec 2014 19:15:49 +0100
Message-ID: <20141217181549.GB3981@katana>
References: <1418315626-9552-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1418315626-9552-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418315626-9552-3-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, linux-arm-kernel@lists.infradead.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 05:33:46PM +0100, Thomas Petazzoni wrote:
> Originally, the I2C controller supported by the i2c-mv64xxx driver
> requires a lot of software support: an interrupt is generated at each
> step of an I2C transaction (after the start bit, after sending the
> address, etc.) and the driver is in charge of re-programming the I2C
> controller to do the next step of the I2C transaction. This explains
> the fairly complex state machine that the driver has.
>=20
> On Marvell Armada XP and later processors (Armada 375, 38x, etc.), the
> I2C controller was extended with a part called the "I2C Bridge", which
> allows to offload the I2C transaction completely to the
> hardware. Initial support for this mechanism was added in commit
> 930ab3d403a ("i2c: mv64xxx: Add I2C Transaction Generator support").
>=20
> However, the implementation done in this commit has two related
> issues, which this commit fixes by completely changing how the offload
> implementation is done:
>=20
>  * SMBus read transfers, where there is one write to select the
>    register immediately followed in the same transaction by one read,
>    were making the processor hang. This was easier visible on the
>    Marvell Armada XP WRT1900AC platform using a driver for an I2C LED
>    controller, or on other Armada XP platforms by using a simple
>    'i2cget' command to read an I2C EEPROM.
>=20
>  * The implementation was based on the fact that the offload engine
>    was re-programmed to transfer each message of an I2C xfer: this
>    meant that each message sent with the offload engine was starting
>    with a normal I2C start sequence. However, the I2C subsystem
>    assumes that all messages belonging to the same xfer will use the
>    so-called "repeated start" so that the entire I2C xfer is seen as
>    one transfer by the I2C devices and cannot be interrupt by other
>    I2C masters on the same bus.
>=20
> In fact, the "I2C Bridge" allows to offload three types of xfer:
>=20
>  - xfer of one write message
>  - xfer of one read message
>  - xfer of one write message followed by one read message
>=20
> For all other situations, we have to fallback to not using the "I2C
> Bridge" in order to get proper I2C semantics.
>=20
> Therefore, this commit reworks the offload implementation to put it
> not at the message level, but at the xfer level: in the
> mv64xxx_i2c_xfer() function, we decide if the transaction can be
> offloaded (in which case it is handled by the
> mv64xxx_i2c_offload_xfer() function), or otherwise it is handled by
> the slow path (implemented in the existing mv64xxx_i2c_execute_msg()).
>=20
> This allows to simplify the state machine, which no longer needs to
> have any state related to the offload implementation: the offload
> implementation is now completely separated from the slow path (with
> the exception of the interrupt handler, of course).
>=20
> In summary:
>=20
>  - mv64xxx_i2c_can_offload() will analyze an I2C xfer and decided of
>    the "I2C Bridge" can be used to offload it or not.
>=20
>  - mv64xxx_i2c_offload_xfer() will actually program the "I2C Bridge"
>    to offload one xfer (of either one or two messages), and block
>    using mv64xxx_i2c_wait_for_completion() until the xfer completes.
>=20
>  - The interrupt handler mv64xxx_i2c_intr() is modified to push the
>    offload related code to a separate function,
>    mv64xxx_i2c_intr_offload(). It will take care of reading the
>    received data if needed.
>=20
> This commit was tested on:
>=20
>  - Armada XP OpenBlocks AX3-4 (EEPROM on I2C and RTC on I2C)
>  - Armada XP WRT1900AC (LED controller on I2C)
>  - Armada XP GP (EEPROM on I2C)
>=20
> Fixes: 930ab3d403ae ("i2c: mv64xxx: Add I2C Transaction Generator support=
")
> Cc: <stable@vger.kernel.org> # v3.12+
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to for-current, thanks. But please fix checkpatch warnings next
time!


--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkchVAAoJEBQN5MwUoCm2PtIP/3ubjNZ2l8aIRIZLuU3t4OuN
aau9JWIyS55hvuTRJFpE3n3IOSbMBHNSvYME3wEHVH7TDscbEgSAez8c4JxDrle5
qzy4OvVQ4a2b+4ryo3qcGxSbh7BIHxwl0/ALk8dr/9GWxlvv9gSKxn3kXrcks/4D
/7dAhsjdCd1G5nXJD84hIHjVEt1TW0fgWxNbku3gc8NkCzlFSnBDtPd65ievfMAB
oxuav4gJXtbWIq8ujpHd04p8v1nm+/bqTUplVywmi4obsypMb5H4zQiDF2FlMgpc
g9mzmH4jEqHyQVL6NJoDrp4KpSAIAUB0UwbCcpUhUSFyN2LAeZ4XFLdQ8Ckhk/QK
jQxeQbnY9pQH3ceBHD01uaUwYJWmumu4zsOIj/QFcvYnzJeBoglrHK1IgJhKzvYT
mkvA3IJ30sib41s06RzZ3Oawp9KdMyI+Qapwfkehl5USDb7p63Z0EZVVJoNWS8R3
v465LD+NS7Fna1fM+klYwmdlZBprojw7QsA5m8kcGQjLIH8am+mkh1GvU8cO+nEQ
fUL11gvVd7SIIh3cnChM0gaEe8hPsxEXtajw0yIwbTlF3d12W8kG82g9hjTzAZOF
NZcUfneMYeUq1wB2dguE2qG0xHICl9b4dTW3DO710kVLzhZhoqr9pvUJeggK+OCB
PUTMzTGS6gfHhHaUpdyL
=yNGB
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
