From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: make const array supported_speeds
 static to shink object code size
Date: Tue, 17 Oct 2017 23:50:19 +0200
Message-ID: <20171017215019.2xvl3btrxx57ckxd@ninjato>
References: <20170921223007.21081-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rtznlqrhghmoj6nw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170921223007.21081-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--rtznlqrhghmoj6nw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 11:30:07PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Don't populate const array supported_speeds on the stack, instead
> make it static.  Makes the object code smaller by 150 bytes:
>=20
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    8474	   1440	      0	   9914	   26ba	i2c-designware-platdrv.o
>=20
> After:
>    text	   data	    bss	    dec	    hex	filename
>    8324	   1440	      0	   9764	   2624	i2c-designware-platdrv.o
>=20
> (gcc version 7.2.0 x86_64)
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-next, thanks!


--rtznlqrhghmoj6nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmexoACgkQFA3kzBSg
KbZz9w/9GIw0JJv/S3R+mnvHjC4bEa3HdmgW6gjtXikM8nIOzE4qYRz4ru9sFZeg
G9pqzJxmvi/m/m3yz2RINp6L3BrMeWSLg9pz+HQdXJbBRetShZHcfxrrS21kjEmW
OGjUI0CfunYR5V+DA4Ucrm0kAXUPi8IfFIwsuFK3MLZJq/Bt4PKwcvs8gKek7so0
dDLgFCi85uN8daLMdU8Ed9LqhoJBkElNulkY7Hqlk3Cy5Vh1OKDeqBmOqW0a51Dl
Hb6X/K6UhY7IWyVxA+BCG2wTSeMnMt7wVlfpz+utQzKiavD1Yi3LOlBbNmQQHcrZ
p1yHccaPAF1DUoxHcTcxKMn7Zg7azjCUyMI453wJA+Mz+4o+j01p30u0CfTBuDy/
FrWv6H9V7riJK0gBkbDipPQo0YxieL67stEE/617qsPW50QfDtHfQDuHQeWa/S5J
wzVm5WfQ+XUiqwQOh3WIe3QwVP4zHGwDRROk7vye4TIp00zqvZ9s+3g6xrjZ/ogl
fHYcnZmoi1xPp4inkx2WXiXuryzeyMMSbJV2YAaMqGMnVSOZwgNm6J2zjiFt5Biv
t3Ye7KFvt/CTR2kCewWJWuXjp/OWv0na16R5AlQ5Vys11abhp9aQd7Vn9KOv+xeZ
94uTu25xz5UFG1VB7Qi0joEErwYMLN92m+/Nay7AeZ5mSLsSz6U=
=HL32
-----END PGP SIGNATURE-----

--rtznlqrhghmoj6nw--
