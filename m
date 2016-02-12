From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6] i2c: mt8173: add 4GB mode support in i2c driver.
Date: Fri, 12 Feb 2016 20:18:45 +0100
Message-ID: <20160212191845.GN1520@katana>
References: <1454347143-31461-1-git-send-email-liguo.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l3ej7W/Jb2pB3qL2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:59196 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbcBLTSy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 14:18:54 -0500
Content-Disposition: inline
In-Reply-To: <1454347143-31461-1-git-send-email-liguo.zhang@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Liguo Zhang <liguo.zhang@mediatek.com>
Cc: srv_heupstream@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org


--l3ej7W/Jb2pB3qL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2016 at 01:19:03AM +0800, Liguo Zhang wrote:
> If 4GB mode is enable, we should add 4gb mode support in i2c driver.
> Set 4GB mode register to support 4GB mode.
>=20
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>

The subject should have "mt65xx" since this is the driver name. I also
added DMA to the commit message to make clear what this mode is about.

Applied to for-next, thanks!


--l3ej7W/Jb2pB3qL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvjAVAAoJEBQN5MwUoCm2wSEP/3ZLVpccUeBIWAFQs42fI8Jx
c/acHSXHtEreHzNtMr1MAHAOSVt01uSg7VY/sWclYKxV+Bvh8CvghuaLiHTCEVNw
opqzS60ZufBwweO/n/vHMz857ZqCNLXwfI6wW7uuvbmi9ZSrvJQenm2CBjNAw8xv
cCSweez/Kg82ua3TUpI5fuNS+6LYk36WAk1MhtpefS6MgQ515FmSDeQjjNKYBNXW
vuGFQJw1HIWbGmutq6lDbKAj4ENikwZ03Nrsq2xGlHTbUzjUocQuMyg2EYiCJgAt
dO/F4IpaaC7pesBn3wlKx6yAJyCv3Mf0oz8JwPm/9Bcfxeh07Wcdz75isdBGJwJm
UfdTho62Xq54k0tl/tF0t+psKsS604KFVM9gDiOlddOsfj+fqI0QIfbpb9EVNsj4
FJdAV9DA1Ba7OKi2rOQnp2owPvqNO5I3MbgFeVE6DsZHthS8xajj3OL0jCDVCS3x
u/8hX2qkQ/0pq59IP5sHODkyCnmuJCPSqxE1dQXNFPjGjf4ujAAUoMqxW090etso
Z8QbPry5jg/1e2RtHOgbLtERwE/E7Bj/D6DxNXz66zhz0SocxDnWDKT8y5x8AxvJ
IoxA128bEJWkWSskIqaG0l8bRtGN27/0ObV2ZPRSN1Qtf1Jf3blyJPeUzVg7P6MI
UGAkBKvtp8u6kYBi4GxH
=kElB
-----END PGP SIGNATURE-----

--l3ej7W/Jb2pB3qL2--
