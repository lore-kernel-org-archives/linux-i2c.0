From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 09/11] i2c: rcar: revoke START request early
Date: Fri, 1 Apr 2016 22:14:15 +0200
Message-ID: <20160401201415.GA25936@katana>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
 <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
 <56FD9080.4090203@cogentembedded.com>
 <20160331224838.GA7381@katana>
 <56FED245.4010503@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34015 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbcDAUOX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 1 Apr 2016 16:14:23 -0400
Content-Disposition: inline
In-Reply-To: <56FED245.4010503@cogentembedded.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >IIRC my tests showed that if you don't remove
> >the spinlocks (patch 4), the interrupt latency will already be too high
> >again.
>=20
>    Thank you for the valuable info!

Oh, and add patch 6 to it. The context switches are a major problem in
this.


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/taWAAoJEBQN5MwUoCm2q1wP/iUG2w7u5JoczlOCVZaWEKUB
DiP7idAaMGMcT5ZVAXkoCz4JyP6Bt7F8XvnQcpNbFHx2teNbpDv8sMK5HJgi5xCP
qbYIVzFP51d+mNSyzFjb+yY4GZmgZd1ZUyiikC2J6HwgVqv9xoVe/b423v39evSx
DGXo9YTeJGAzEAPe6oGsVnzdKIln8WhAuxft3mpUqois4Io1GMz4N2BMkM7bt9Yj
kEqqRFr+QWkh5gtuU/8RXTREHQJpPujZm//7wRPuTrYH6GQ/1/QOVWLZW3PQvDJj
72njbqtEpl8P9u7IuZu5CwU1+OfD7ArX1dusdCwsdgsqdftHJpknau2ljy8oCIMw
Ue41Yuvsmi0UyBuPVSGtMJdNzFldHqAyYPJrGxDk91HmTcjGGj7Lz3VhxtA+ooXl
VpQwQ9UweodO2i0pmiWzqgRDd2bs9ZUA125wtRWBk6shHhVK2Fv+sKbBVrcAL1G/
FDZEzYQtoR+AbnA17183+Dwj03Cxgkvtvn9PP6gUS7WMOpvS2k7QINDMjntH8WR4
0CCuR2bDECjwK3nb0uE90Z7Zt29R1eB9Ci55XT93g81fDh0cSTV8vLprGc5AkZHX
hnNssDx9GLEaL6bZXVBEqwuiEjL7jVd6pTjfnDNE5dmqJT4m1Zj+6mAdkXvn/7lh
9FOaPnarJmWKV8LR4/kE
=gSlR
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
