From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA
Date: Mon, 15 Jan 2018 18:59:06 +0100
Message-ID: <20180115175906.4ezync7thrqvqjcu@ninjato>
References: <871skzpbby.fsf@jcompost-mobl.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yipenus77iewbvac"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40842 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbeAOR7I (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 12:59:08 -0500
Content-Disposition: inline
In-Reply-To: <871skzpbby.fsf@jcompost-mobl.amr.corp.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc: linux-i2c@vger.kernel.org


--yipenus77iewbvac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 12:54:09PM -0700, Compostella, Jeremy wrote:
> On a I2C_SMBUS_I2C_BLOCK_DATA read request, if data->block[0] is
> greater than I2C_SMBUS_BLOCK_MAX + 1, the underlying I2C driver writes

greater or equal?

> data out of the msgbuf1 boundary.
>=20
> It is possible from a user application to run into that issue by call
> the I2C_SMBUS ioctl with data.block[0] greater than
> I2C_SMBUS_BLOCK_MAX + 1.

ditto?

>=20
> Call Trace:
>  [<ffffffff8139f695>] dump_stack+0x67/0x92
>  [<ffffffff811802a4>] panic+0xc5/0x1eb
>  [<ffffffff810ecb5f>] ? vprintk_default+0x1f/0x30
>  [<ffffffff817456d3>] ? i2cdev_ioctl_smbus+0x303/0x320
>  [<ffffffff8109a68b>] __stack_chk_fail+0x1b/0x20
>  [<ffffffff817456d3>] i2cdev_ioctl_smbus+0x303/0x320
>  [<ffffffff81745aed>] i2cdev_ioctl+0x4d/0x1e0
>  [<ffffffff811f761a>] do_vfs_ioctl+0x2ba/0x490
>  [<ffffffff81336e43>] ? security_file_ioctl+0x43/0x60
>  [<ffffffff811f7869>] SyS_ioctl+0x79/0x90
>  [<ffffffff81a22e97>] entry_SYSCALL_64_fastpath+0x12/0x6a
>=20
> Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> ---
>  drivers/i2c/i2c-core-smbus.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 10f00a8..f0be621 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -398,6 +398,12 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapte=
r *adapter, u16 addr,
>  	case I2C_SMBUS_I2C_BLOCK_DATA:
>  		if (read_write =3D=3D I2C_SMBUS_READ) {
>  			msg[1].len =3D data->block[0];
> +			if (msg[1].len > I2C_SMBUS_BLOCK_MAX) {
> +				dev_err(&adapter->dev,
> +					"Invalid block read size %d\n",
> +					data->block[0]);
> +				return -EINVAL;
> +			}

Basically good, yet to make the code easier to read I'd suggest
something like this? Untested, wanted to hear your opinion first.

 drivers/i2c/i2c-core-smbus.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 4bb9927afd0106..5fc5ddd965434f 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -397,16 +397,16 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter=
 *adapter, u16 addr,
 				   the underlying bus driver */
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			dev_err(&adapter->dev, "Invalid block size %d\n",
+				data->block[0]);
+			return -EINVAL;
+		}
+
 		if (read_write =3D=3D I2C_SMBUS_READ) {
 			msg[1].len =3D data->block[0];
 		} else {
 			msg[0].len =3D data->block[0] + 1;
-			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 1) {
-				dev_err(&adapter->dev,
-					"Invalid block write size %d\n",
-					data->block[0]);
-				return -EINVAL;
-			}
 			for (i =3D 1; i <=3D data->block[0]; i++)
 				msgbuf0[i] =3D data->block[i];
 		}

--yipenus77iewbvac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc6+YACgkQFA3kzBSg
KbZKkw/+P7hgGP0pQ5QWKUEjGvMMWqj5GXavQaSULs+cuoE2iM8yBQDagm3JCVkz
y964mCbrXC0TjicMihOA2PX/otxM3nyi7/Um5C4WNeq7SpGFBPM/Ung4t4ZFMF7I
kBg6kFzhfu4ED/XzeqLqvodnRyobY1ShkvSDfPKy4ICUL+g0bUpvIqYmGbYS+VCx
mnY8j3xN5mwYZReYAdtmPw9j1JxDODxZSZpnQ4jmXh7fgEDM/Z2OXmAOD4z/KvCX
Kwqcxx/9nkRy6HAzgqp/7Hg1rxO5qTF8CtQn9WYqXwn4fEJ1jR1KgHGx07qwchvQ
gd+jrMV5ywDIWG4SE//MBUJ0uJtET3qNchND3AvIU2Dt7bo1pzgG9g5gp8UtcJEs
QZ5DdC218D9b8lTm0mkhJ5jQWlEboyWAo1VAJctigiBkyllgXmC5oypM7P1N8uuE
AmfNn9fFKNwkZNHssLIlEbXE+XGHD3emgjS0qKBqoTJsvfzGaxx1s12eJCOo6jf/
R1MMplTRujHE6GK7cP5U4nhbfwnqrE/xmxUoCWcmcY1ixTRAz3dTFd+EkkUjs8dq
v5omFEa5fXnC/vtTsuqO6YWa791Emyu25F6z6SXRYPPJnOVz4BNmr9xkk5iDbh1p
xYGWdA9RwrIm1uPnVIkTbm953LQWVj8VxsHmk1qz/5yOpZ6Ozks=
=ynyg
-----END PGP SIGNATURE-----

--yipenus77iewbvac--
