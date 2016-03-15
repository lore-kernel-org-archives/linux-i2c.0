From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: linux-next: Tree for Mar 14
Date: Tue, 15 Mar 2016 07:43:19 +0100
Message-ID: <20160315064318.GA1385@katana>
References: <20160314174037.0097df55@canb.auug.org.au>
 <20160315003029.GA2126@swordfish>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:41041 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731AbcCOGnb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 15 Mar 2016 02:43:31 -0400
Content-Disposition: inline
In-Reply-To: <20160315003029.GA2126@swordfish>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>, Ben Skeggs <bskeggs@redhat.com>, linux-i2c@vger.kernel.org, dri-devel@lists.freedesktop.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2016 at 09:30:29AM +0900, Sergey Senozhatsky wrote:
> On (03/14/16 17:40), Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20160311:
> >=20
> > The vfs tree gained a conflict against Linus' tree. I also applied a
> > patch for a known runtime bug.
> >=20
> > The tip tree gained a conflict against the mips tree.
> >=20
> > The aio tree still had a build failure so I removed several commits
> > from it.  It also gained a conflict against the vfs tree.
> >=20
> > Non-merge commits (relative to Linus' tree): 11202
> >  8646 files changed, 426680 insertions(+), 211740 deletions(-)
>=20
>=20
> Hello,
>=20
> I'm seeing a bunch of warnings and errors

I pushed the fix to my for-next branch yesterday. Sorry for the fuzz!


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW568GAAoJEBQN5MwUoCm22dUP/jcyNGZA8CakQMIcvdk2wRAh
gVP3Z7NyQZ/sCHp+l4g3q2f330AFsZX2iVX5VjHu40NOOcT9PQwVaRQtXlz8EOHz
bunPppd+qXnnhAP9yQerYnQA/dXRVrjoWeVf5WUfaqWpnutN12IxJm7N9VsM/btu
r4Zw+S5Kc4T1qYNHQFrkfbGQ/BejVtcslRNo7UJHrVPsqeYER72yyrSxhdZ3qJQe
uRsfVE9NYvuqR04lwIPrsgGw/xi2PCAdkjTjsUy2+b8N5KdTTuwbbfaCyM9vPBoE
Ufn0CxEQAe4c0w46R9hDRa2c9z7x0t5cNG12e0RO5LGAOPtmXzb9mCXUrzVfwBND
TqZd6e8iDvJseE3KrCLrK2wNS5rKIDU29vMNcQ+jc0lcJZMlkvY+pEBfxchH5xbS
mlh1dRjSTwgmLYWe+3HGUeKHz0/Q1sQk5++NIkxnwopsvGTDjVE6lZAaKdkHOp+3
s8q7scnIatIguMvXqxjSfMXEiHhI6dZXSd+xz6qKfm276w5hXgGqjy8Eu5/n5Szm
OWlKMVBHDJGgHFJjYnqpJC5Lx9jzThisyPWB8y4EwLYxYu3qjAFcje5zRRKPz/kJ
yMEtj++cdvoRU5rf/PBAOOxXu2ixatj0Dg7C0Lg73tJPfntvVDfLdz2piI6swaBL
AqVnBZ152vR3Z0+LxBoA
=Tp69
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
