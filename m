From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: mediatek: Fixup i2c ack error interrupt
 handling
Date: Tue, 11 Aug 2015 16:55:21 +0200
Message-ID: <20150811145521.GB1525@katana>
References: <1438845731-17805-1-git-send-email-eddie.huang@mediatek.com>
 <1438845731-17805-3-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438845731-17805-3-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 03:22:11PM +0800, Eddie Huang wrote:
> When occur i2c ack error, i2c controller generate two interrupts,
> first is the ack error interrupt, then the complete interrupt.
> i2c interrupt handler should keep the two interrupt value, and only
> call complete() for the complete interrupt.
>=20
> Signed-off-by: Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Applied to for-next, thanks!


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVygzZAAoJEBQN5MwUoCm2PLUQAIGePqS8CPsPurg00pgUGkOF
Os8CMsA6hdFJf6WbVJdkE3qTGfmwnSdxe+4hIC8Il3IhO6meknFSfM/Y4r/fVz4v
5+hCeBMAdQKmWF4XPCz103btnnU793Hup41zSd1X4ccnW/jAUNvczposPa8GYk3u
44/itgC4PvlamAzlVsNQsmZ3zLl2pgSodX75fR+2A6Z2c9QIsIDuqCoDbUTVhhtD
MP/r94iWgUPvwEYlRTb4JIt26f/3xg8TnyPQFCJiEnGSv6hc62TQZL3CLUCa3l+J
mLMz85IKX1QrCvdxl+1wNG1zxa6ryYqIY1LsyZkgjqA3gVS9qM756sOa94LjA1dl
8N4c008QQjpK7rDmLmeQwS7A8Y74GqFmLjtInKroFwCr7JhpUzsr7JGmlbg1QfE0
qw90Df6rHENRWhFcjqy1cMjk835OC+fcYGwfAgbz9iqym42VFcHi/jXunbOzQUj2
RKqoukgaIo49fMVm1voYkz2WomKJrLZGiDspJqPSv/ry0sdiRjmzASAqWupYaF8g
FpQjoM+c2aXHC4a2z/BXJKaZeK03HP5CJMlMOcXkwldvoEgp+NrUTOCviE+Hp3FR
IGzRx/J+6kJGB5+VAQmdOHOJDawmV6ZqzGnA9eRhp3zqfL3fR62J8/dfgCJRsv1d
CJOs5wMdilIamU49bvor
=PVj7
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
