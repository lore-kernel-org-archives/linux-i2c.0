From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Revert "i2c: designware: detect when dynamic tar update
 is possible"
Date: Tue, 14 Feb 2017 22:10:13 +0100
Message-ID: <20170214211013.cl3hmsmqieemzxyn@ninjato>
References: <20170213091819.4370-1-jarkko.nikula@linux.intel.com>
 <1487006561.2767.6.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6rxo6de3etswn23l"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55977 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752985AbdBNVKS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 14 Feb 2017 16:10:18 -0500
Content-Disposition: inline
In-Reply-To: <1487006561.2767.6.camel@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>
Cc: "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "Nehal-bakulchandra.Shah@amd.com" <Nehal-bakulchandra.Shah@amd.com>


--6rxo6de3etswn23l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 05:22:42PM +0000, De Marchi, Lucas wrote:
> On Mon, 2017-02-13 at 11:18 +0200, Jarkko Nikula wrote:
> > This reverts commit 63d0f0a6952a1a02bc4f116b7da7c7887e46efa3.
> >=20
> > It caused a regression on platforms where I2C controller is synthesized
> > with dynamic TAR update disabled. Detection code is testing is bit
> > DW_IC_CON_10BITADDR_MASTER in register DW_IC_CON read-only but fails to
> > restore original value in case bit is read-write.
> >=20
> > Instead of fixing this we revert the commit since it was preparation for
> > the commit 0317e6c0f1dc ("i2c: designware: do not disable adapter after
> > transfer") which was also reverted.
> >=20
> > Reported-by: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> > Reported-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > Cc: <stable@vger.kernel.org> # v4.9+
> > Fixes: 63d0f0a6952a ("i2c: designware: detect when dynamic tar update i=
s possible")
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>=20
> Acked-By: Lucas De Marchi <lucas.demarchi@intel.com>

Why do you base64 encode your mails? E.g. Patchwork can't collect your
tags this way. Yes, it could be fixed maybe, but still?


--6rxo6de3etswn23l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlijciYACgkQFA3kzBSg
KbY8vA//T/6H0Qh/3y2yMaLnCzREoS+lEGrJJL/65X3XXdQdSzxqQ511AuprqgwS
vd2f5i82Nn2d2hquZLOxADMdqL7FoKlftHtTuhoOnixfHP4Y7sOPRdU1+8qVvkcF
OyXBW133DyEfNV/w47+SUF4DEKfI7mABTZMQDVioVXgQz7RmklPejO5cqAq0RtVD
vIkfEpz/zQFfrYp41ac3P1nQ2K3hx1c+BXWXlBYG5gEqQqmmIG9nLRK99DEPxONx
hrkyrRlkGHrMH6gkfa5dCXswFOEdRNh7wnX8s9q1zWzHcJvg6h/0Euz97Tc/+/VG
P8j4RZFUFdvAdjSm3GB/X3bfo60JC6j947zt71Uay0ByxUlaHsBpaiEazgFnfRJc
xAHagaG7/bRyA25EfQN0HcQ+XWrOEarQC3LqIMWb3VFV52FXg98gAvDNpsfo9AIr
VT7Y+HhYy1kKCV6xOaSchzdcwq5BpJd0DeBdf/gYC1vpA1aKEhrYl2xbYatA54MP
EoCefBUkFzyOSo9Pw+ApGU/q7fxKZFRb7jC5nM3Lk4O/O/MCv//GWNDxuOf2iV4Z
rCQY6hGitSv46qFKFlLB9Fa2lRmBTEF6DnFlMqVBMRHKHpr+iiiPuF2a5Gd/xX76
iglIuDOu6ykGGDk1C029W9H6vPaa2uMZ1YzAWfRy02bnzm+ryV4=
=eRI6
-----END PGP SIGNATURE-----

--6rxo6de3etswn23l--
