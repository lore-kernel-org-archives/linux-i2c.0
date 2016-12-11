From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/4] i2c: octeon: thunderx: Limit register access retries
Date: Sun, 11 Dec 2016 23:01:48 +0100
Message-ID: <20161211220148.GG2552@katana>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-4-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:54972 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753870AbcLKWBu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 11 Dec 2016 17:01:50 -0500
Content-Disposition: inline
In-Reply-To: <20161209093158.3161-4-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 10:31:57AM +0100, Jan Glauber wrote:
> Do not infinitely retry register readq and writeq operations
> in order to not lock up the CPU in case the TWSI gets stuck.
>=20
> Return -EIO in case of a failed data read. For all other
> cases just return so subsequent operations will fail
> and trigger the recovery.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

I can't apply this one?


--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTczMAAoJEBQN5MwUoCm2wkgQAKYVDugoFQ+ZMHXlqxvIhEOW
9T2IhiEawt4cSnj5JhDngnkNeCbnQpj1nX73L5w5Dk6ZYWa9SwmQHaBY5I/R2bWO
JCGa+ZNTt5toB9Mby+rhNJZMztuzopYl8ylGMSEcc8IfTiKEgx3tMn1yiMipmCUk
z92wUR3Fw2Mbi9H9DhbkhYZZrq4wuQHxENhxUEJVxZgMdKBo4oUMfXC1rF2Sxjz2
hncyBm0LlWrDMNlklUQjtcdTRPb3sNA3vvkAfGf3vSg/XZDYN/mfuwqYGwq6cpwA
w3kFM8lAm8erxZVojmvnFlgbzBmvf1obIL5Xi7aoZS1+Yu7trAhp7qQAgdOyDeME
8lpBM+jrd/wcD4doquSApa5Aqn7zgLf09HnS+Ut6NGr3D2zfmcUQeA9yYejiGgb0
4yI+Y07d1Vd3OqUfDcTOJN2+kdngkdxdhaDOeFgfcFtz5eJvqnXWhRv17E1oHBv2
wiZFIfTUlLtqFmr773zAfaAGmF6g6Imi5FvkGVOt++geZTrgUaIhEq2Hzhk2vP6F
czaMqUB6R8NcaHf9Qe+4Cn2Olhrs46GHnPibE4MebR1IDJMNpyXtKnXQYuU/HXN9
yD60i8BDQevIo9dqeMnMDyFui/KSRi5axK6iJawNV6s1bnbibo3XWwNk0c/XlHYD
Sw8SKaEr/hxuQK1ju2ry
=3S4s
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--
