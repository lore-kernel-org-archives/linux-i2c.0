From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [patch v8 1/1] i2c: add master driver for mellanox systems
Date: Sun, 20 Nov 2016 10:02:12 +0100
Message-ID: <20161120090212.GA1554@katana>
References: <1479455458-157627-1-git-send-email-vadimp@mellanox.com>
 <20161119210444.GB2856@katana>
 <AM5PR0501MB2097315FB75BFEF681512187A2B20@AM5PR0501MB2097.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:52218 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753118AbcKTJCQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 20 Nov 2016 04:02:16 -0500
Content-Disposition: inline
In-Reply-To: <AM5PR0501MB2097315FB75BFEF681512187A2B20@AM5PR0501MB2097.eurprd05.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Possibly I should add validation for "num" parameter at the beginning of mlxcpld_i2c_xfer?

There is 'max_num_msgs' in the quirk structure.

Thanks,

   Wolfram


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYMWaUAAoJEBQN5MwUoCm2Y5QQAIEtXxexi78GOu4fw0hnTk0y
z8+w48MXz67stknQw+bBFN3/0+GoeGzKJbJn8E4xHg4CsBGK6xaAfqa8QogKDhmB
DoWe7fSf7LJjCuXBqwPlYUz7arha6IdPw86WUvB9M27UM6BZp6y/hPczLZH5CoMv
FaHBiTrQ8TcZyNvQbRVIZjry1PZlRW33f0PmL0PBl4vyFhU1OCx6buEwal09KgYI
9TNWGdGPlVNAgTXAIyB2fQikUmgAp5/OqnT2ZM4rkPYWKbUwuOBtbfD1BuTYH5yy
jPBBigkUbZsSqprOc57ysEzkkQW/mdSzf5555lhJyU2iqIIU+ugH5MaGqf2Lu2vq
47RKKN7GQC78Higa5R5j32AEmTYFfFLLmXBwEE+0PWRXMkzSZHiSJKqsQDZ9pZ0c
zAp6d9vJ5eycScZDr+EQgH8dyzA6LtQZJP+DwCa/MECBDG+rQfA6rgGRAJJz+XNO
WuRFufg0bC1BA/xwtxAvT5xij+4Eq2F++jfykkEw/jV4FHi+HOBgFLuFLAMtzgMm
hFX1swG3Aj2bNBoo/U+wkLeIr1wo/X2jqLOykfMUlWk9Ovq87R9Vg8B26E9kM+/l
dzQ/Dm4i3YZEu4fXhMDwNxZTtjDxzR8PEd1hO3gMQYfP8s6/d3LfA3U8cXnci/4n
+j2rMH+XHEXSuW+YXlre
=wj4c
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
