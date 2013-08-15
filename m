From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 05/35] i2c: use dev_get_platdata()
Date: Thu, 15 Aug 2013 20:03:21 +0200
Message-ID: <20130815180321.GB5934@katana>
References: <003701ce8cfa$ba3fd060$2ebf7120$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <003701ce8cfa$ba3fd060$2ebf7120$@samsung.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2013 at 04:59:33PM +0900, Jingoo Han wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Not convincing. I couldn't find a cover letter explaining the motivation
and if this should go via the seperate trees or via one cleanup pull
request. (and if there is one, the i2c list should be on cc) Also, all
35 patches seem to be seperate mails and not threaded, so I can't easily
check other opinions. Will skip for now unless somebody points out a
strong reason.


--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDRfpAAoJEBQN5MwUoCm2GusQAItEve0EGDQN9T2lUe3PntZq
DTeMDNnU1OoyG/grKhw2xovqyq0My0HAdjyzGj5g3wXRGaDwC0SRiNHrvOwmq7l/
AkbQc1sNNj3Pqz7F//embkQitIB16aRTNxtgzdvHT/3jKLd1X9GcGZ02eEvlbIme
cxJiE1NMnJWLAw3hYdehI+o74siAgH1yb268tGxj9dcDoUVpJPO6r77dlYf78b6p
FbADvAvgRK70CnRej7oYun4Q9gDkLb8dKmqSRZHsq4KlPaB04Pti9fKlqnMjq803
DC90Uo4pQbWszEgmydFld0T3ZmKqZGQoUSOgyrosD9bfNQFH6uDL00E8xo6jpmyv
TGDNATShsDGbvgqlASjXaXKdSXME8ihNiImgHrEkNugLZiZBoROv7OKFKYxOP/Fe
vni+uJWv7n/skrrO9ZOKuER8kbd/oKCpxzOZeKVCDErRqXxQ88JBjVxCq1zzEosn
Yk764J0WvnB8r/eflVfyF93tM1vzpR2Oqg8XCUr+6PeUZhqiiKUOEz3Jj3WJE1IV
+9qyu6oDh9rfE/x2okFfNpYiYHrdTathAcBjAaDOG1s0ZjORIa5mc1NFd4Vn9FkP
E57vGDxWVEK7OoWiVh71Yfvho320EXAVy9ZrU75JElhEgG241zViFMK9LhWQZHs+
8jmsOOyL2bZuxHbSD9hL
=zZil
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
