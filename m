From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] i2c: mediatek: add i2c first write then read
 optimization
Date: Tue, 1 Dec 2015 01:56:55 +0100
Message-ID: <20151201005655.GC2064@katana>
References: <1447047839-5223-1-git-send-email-liguo.zhang@mediatek.com>
 <1447047839-5223-2-git-send-email-liguo.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46572 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998AbbLAA5A (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 19:57:00 -0500
Content-Disposition: inline
In-Reply-To: <1447047839-5223-2-git-send-email-liguo.zhang@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Liguo Zhang <liguo.zhang@mediatek.com>
Cc: srv_heupstream@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2015 at 01:43:58PM +0800, Liguo Zhang wrote:
> For platform with auto restart support, between every transfer,
> i2c controller will trigger an interrupt and SW need to handle
> it to start new transfer. When doing write-then-read transfer,
> instead of restart mechanism, using WRRD mode to have controller
> send both transfer in one request to reduce latency.
>=20
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Reviewed-by: Eddie Huang <eddie.huang@mediatek.com>

Applied to for-next, thanks!


--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXPBXAAoJEBQN5MwUoCm25a8QALZk1BwzERtedyftupkAV0/M
FD0KO86KL40cVjwPsht2Oi5B0wlKIHlEPidGeQaG1vnA+NHbsWQirWUeQxBiVR/T
4DqU3LnC3DhWiBgsNNAjhhr00GME1btUV7XaPwROSLv4VdXmzxnbZ5/U5dQiKkBr
d6SOXDQfNeYvXExaA/iviupwGHOHJC4gmMWdBn/i196yw11VgXAFTAXGsMNtXQmI
SxmeO4bZQoReEBetYQUfKyWBLxBVUn5+HNnQZUa0zjH+g0C9czwJMBidRBS+Eviy
xeDWC7gV3cA7Hqyhb2MtyRjlYaGO7eDp/ijRKRtG3c/hwNyoPAn1VDL0zeywpoF6
ph+GNSMYp2v1tYPK9RjylQn1GDDjV5gjT5fmsgnXAosCjEFAPOriU1PlJr3nJkBR
G32G2VOgZlcOJLo/KAjHB0/c9TMgXD0Io5vFHFIM+/uq7L9hmUuOopGtSk8pjWwh
uDVbXXAXCjaowWHVmkXR2eBNdJ4UYqfOcTz5Z5+aonjqIbebzTLKSN8Yj4wRvxxG
llJUjAgykP2/dR0qEKTYQMFSuf3Jjib7c3bi6GZBVq+vZWqXtGMPJvnv/NXxpRnT
S6+0QqZM7yL8Ntfsqd4bERnkY2vr87nX5yQ872HRHRqcKcDToU82HKPM7BXRiwN0
b/34pjNtLhvSnG/on5ea
=8q+r
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
