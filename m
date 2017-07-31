From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/2] i2c: designware: Print clock freq on invalid
 clock freq error
Date: Mon, 31 Jul 2017 15:56:26 +0200
Message-ID: <20170731135626.mvyooopfburencwq@ninjato>
References: <20170713134502.10816-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cnvwmi5jwbpwwbil"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49364 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752156AbdGaN42 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Jul 2017 09:56:28 -0400
Content-Disposition: inline
In-Reply-To: <20170713134502.10816-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org


--cnvwmi5jwbpwwbil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 03:45:01PM +0200, Hans de Goede wrote:
> When we refuse to probe due to an invalid clock frequency, log
> the frequency which is causing this error.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-current, thanks!


--cnvwmi5jwbpwwbil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/NwoACgkQFA3kzBSg
KbZv1w//S4OYZSv42RKrEhElM0lZ4nQBBS1fXkFteF1IENjeeKIUSSckb+stXKfT
nG07Qipfc9UwWdReP70w+zJsfShHsLuHjJayHpEkUZ/cWCkZnChqf/GWEoh6j0M7
DGW8fk7vznBlDkjCgWb8SxT7Gvehu5TltRqEHDOTtWWxDulKaKimUXvcKji7fe2G
wYkR1oNvRtYBMWtEK7t7RNu4+led+Ewv7RicbEhHTh0bRLG34swu1aljCW+rifxC
7+kjnW6awqQqPqL4ALMNEORgLvSLO6uJAM6UArgbFE3YbL8v3nmUnHrm1zVCu4Mm
z/pORYGHo67ybnwTIVuu85kjiKYlb1r4K4Wa/CN+pykXFM89jMF+665Rv/+1fyJE
ga5qb5qFNoUqjh2iWJfCp7dmCmde29Rt0vvx/l5opp89Zt8zo5NOn7aCBz0A+Uec
BbL1QA8kI2y0m6OVj47X48iXiEw+gwaFIQPhCK8af75/OEJ4E+j9XESHCL+MiuN0
TIdhBPR6nJvK7mGHUkImBa/52ERhpz6VrNTkudkIi3G0ngWLkBi0y+11YUXm32jz
dS0/SyxEY+5Dw4XSxvS6u/G3k1cDpqVCuzDsfoSTHAu9lht0+bMDt1Mc1k+eg8Lw
3J+JwTnzLXbQaZj34+ax1865ap1cfsDVpVKzkMTLJBeVWTPKaF8=
=plbE
-----END PGP SIGNATURE-----

--cnvwmi5jwbpwwbil--
