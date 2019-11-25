From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] docs: i2c: Fix return value of i2c_smbus_xxx functions
Date: Mon, 25 Nov 2019 15:48:57 +0100
Message-ID: <20191125144857.GA2412@kunai>
References: <1574162632-65848-1-git-send-email-mine260309@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1574162632-65848-1-git-send-email-mine260309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lei YU <mine260309@gmail.com>, Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 07:23:52PM +0800, Lei YU wrote:
> In i2c/dev-interface.rst it said
>=20
> > All these transactions return -1 on failure
>=20
> But actually the i2c_smbus_xxx functions return negative error numbers
> on failure, instead of -1.
>=20
> Fix the document and remove the following sentence.
>=20
> Signed-off-by: Lei YU <mine260309@gmail.com>
> ---
>  Documentation/i2c/dev-interface.rst | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-=
interface.rst
> index 69c23a3..f2f2b28 100644
> --- a/Documentation/i2c/dev-interface.rst
> +++ b/Documentation/i2c/dev-interface.rst
> @@ -163,11 +163,10 @@ for details) through the following functions::
>    __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
>                                     __u8 *values);
> =20
> -All these transactions return -1 on failure; you can read errno to see
> -what happened. The 'write' transactions return 0 on success; the
> -'read' transactions return the read value, except for read_block, which
> -returns the number of values read. The block buffers need not be longer
> -than 32 bytes.
> +All these transactions return a negative error number on failure.
> +The 'write' transactions return 0 on success; the 'read' transactions
> +return the read value, except for read_block, which returns the number
> +of values read. The block buffers need not be longer than 32 bytes.

I think the correct solution is to remove this paragraph entirely.
Because the returned value does not depend on the kernel but on the
libi2c version. Check this commit from 2012 in the i2c-tools repo:

330bba2 ("libi2c: Properly propagate real error codes on read errors")

So, I think we should document it there. Jean, what do you think?


>  The above functions are made available by linking against the libi2c lib=
rary,
>  which is provided by the i2c-tools project.  See:
> --=20
> 2.7.4
>=20

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3b6dUACgkQFA3kzBSg
KbaPQg/+MmrOr+FUSQ7FXtf8yk4h1WIUeMafkVFytIXVI/oAwIba9jTOK796qwem
wgpThFpOjIVw2IxKC/bx2FEYys39aOJBU+1X+qyvhlqvxI96a36seSXLArzoAQBO
xvn2v1xCB8TqlQAqMr80vnp5lz30kLVcW0KIiJuF9ayHsn/wqdGEBy2yz93hf8n9
wk+SSj5lR5aF71lcgSyypq8y79NbKjJhLfx2lU48sgw6VIn5PR7XjL0A/XEw29uk
lcJOI9VTaaWhSR+X553GSewJ4f5xmLWn7aMf5fLa8eilBkf/JAp2yM+Hxzu9E5uj
fNhWBDkjVCNsYZdfdEhy+QWkVH5Jxe2dpjOf3sUic5TCC9cxqDgl9OAZRnnEethH
f2MorU7coV7RyqLIrS89xUew0dkEKZAAln3n8uAKPOLLsS5LJXRYgxe1X+d1sqGW
9OkGxzbzpPgZ/TjvAC9KbRzHkBRLoqejPUBvXIFSC7PFqwz93chObKmdMZnK0x4I
gEZe86wt2k9p4I/7J+zEKXcDe45jMAmo6MBsO9Dq9vayo8GwAk5bQW/6Sf6cf6IG
80iZA1dFFSAALauR1vmRx6itOSR1IAIJXfQHiKSOfUhBh2+7iJbXBKpbCv7BWoql
ETGd6JizdPYFzZjy5Q0cCRJd0Seh58uQMfAc7KgOJWLDDXdeF/0=
=cVqu
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
