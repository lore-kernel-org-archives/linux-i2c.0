From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: use release_mem_region instead of release_resource
Date: Mon, 14 Aug 2017 21:37:57 +0200
Message-ID: <20170814193756.pux5c7l23izojwus@ninjato>
References: <1502378145-12869-1-git-send-email-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m7k4ahtkl4ao5q3t"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50555 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdHNTh6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 15:37:58 -0400
Content-Disposition: inline
In-Reply-To: <1502378145-12869-1-git-send-email-vasilyev@ispras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org


--m7k4ahtkl4ao5q3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 06:15:45PM +0300, Anton Vasilyev wrote:
> Use api pair of request_mem_region and release_mem_region
> instead of release_resource.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Applied to for-current, thanks!


--m7k4ahtkl4ao5q3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR/BEACgkQFA3kzBSg
KbZp5g//X/5Nrv4LIjEPboKXJSyLkPeqYKr8cVa++0bu9zNToQZEB+yzHfrl2wYE
4tHGlMG6oW4pseExBfAfhplba+PpZWY9xEQHjgu97isGrvjSdYQzvJ0Oba+HqPZe
QY3kyyXZRJUqV+03GVEQnoFUVhapzFP0eAjGgI0ht8WqI4haLGCvAncjqqzoOZCg
XuOCZ+WHGFFM26z/zTaZatHgVE2iOeJjBs0M1BIZf+OdWtJpcog0/kTPA1A/pDf8
QeuRtuN0YEOeGC/cpmGmsRy00RKqNexlnRnwzvFWXjBfqO6LDHPB27eh4wMoxEPU
OjZ8UKTN2JfmAIxO5IuAYEbm4guGo5FsVUG8DMW/Yg7/igvAtK6C1r7mzWLrzNop
nBkeJ14UTzqjiSjjMvcNZR7IzliaoHcfWZm/n/7DifBAgm/hioAigB6xkRLbzbNF
WKo6BCOwgsElRg5wV/U81g63roh/dRW9tP5KwZl28nesFqPLtK4vtkkhAFCEd6e3
vB1rV8zOfAgaRF/mURKdVT4X81OO+i8CEMNxAu1ggMu6vZ78ZjbMIQecGyLk4lPr
cwc+tgoK7HiPcF4nNEQxBgTGzedS4kR4X6fFbyxIZE+/JbKIZKmaaEZ88Z+eBdnQ
CRQrF7q19OvsHBjHDKT4mmkPp/kGVFgyRejPMR4aEex2QEv1a08=
=l7sO
-----END PGP SIGNATURE-----

--m7k4ahtkl4ao5q3t--
