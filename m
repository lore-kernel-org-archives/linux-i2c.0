From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: RESEND:i2c-eg20t: fix race between i2c init and interrupt enable
Date: Sun, 18 Sep 2016 09:53:27 +0200
Message-ID: <20160918075326.GA1412@katana>
References: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
 <20160916200456.GA2216@katana>
 <738c387b-2a7e-19fb-d9d9-034426ce3b49@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60107 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752323AbcIRHxh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Sep 2016 03:53:37 -0400
Content-Disposition: inline
In-Reply-To: <738c387b-2a7e-19fb-d9d9-034426ce3b49@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yadi <yadi.hu@windriver.com>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> it seems to me so uncomfortable. how do you like it?
>=20
> for (all_channels)
> 	do_initialization
>=20
> request_irq()
>=20
> for (all_channels) {
> 	 pch_i2c_init  /* Enable interrupts at end of function*/
> 	 register_adapter
> }

Thanks for the correction. This would be still my preferred solution.


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3kf2AAoJEBQN5MwUoCm2g8IQAKw27dY7o1IqYhHyYuyMlEBE
FrP6QSURAdEOpCkbAQov0NlpqgXQEnY8XdJFXpeFzFpuk4arYeq/LmGsP9JpBxTI
EtnkKnTIDGI8OKe//yu87XeZXrQMHBt3ldlLhT1KhCMa1ZZdTySJd2lZNU6Oz41V
UM946rPUmI3jbc5/ALcvWnMU9wWvdn6J277KhUEx+9IRudxvOe41zgY6HwuXVlxy
iaNYPXQ8L5jZ3Yvoow57JG/Kwz19ZskwsmPl/8HpzkwIkc5mSb4PLZ66TShgwpi5
ny8/lH4SyNylllFqzPYpe4qeUsSLzMxQjGdkW7s/Va3sO98bvlDYsKZr10F2mEEo
cNxu/Z82rUNoJd4Qe6/qUtzuqq2J5MXUprfMDUSKFnyOcPbuNJ3UKJ49qaYjgvWX
GQi/xVlLYObxj5Bt6SamuaqOl/Mm756tj1DhMgET6e8lrPHSjm+lSp7Xj1aO6yRf
Aw1XkNib9CRUyoMAQK/VX34O1eoOwkPjoYJCsTZWPH3ox1upeCSHPO9/4BPpwqg8
76bIDK8rfDTbZDwJJ4LeBiqKROtbyEA2QluKvdgBgf92486KUdZAK0hz/4v+d9Z/
3y5Td0kiWedAOic2VpeULeemX+GBs1wb2QfH791pjDRt5unQcl6LZz8ObcnGdYLB
GUJwAbHLindzTRFOJ/CW
=mVR0
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
