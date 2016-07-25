From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: slave support framework improvements
Date: Mon, 25 Jul 2016 09:21:51 +0200
Message-ID: <20160725072151.GA1599@katana>
References: <137031469256709@web4j.yandex.ru>
 <20160723195114.GA2104@katana>
 <27421469430128@web19h.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50395 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbcGYHV7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Jul 2016 03:21:59 -0400
Content-Disposition: inline
In-Reply-To: <27421469430128@web19h.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kachalov Anton <mouse@mayc.ru>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > How do the other masters know that their channel is currently muxed
> > then? And what if two of them want to access two of your slaves at
> > the same time?
>=20
> In current implementation this I2C switch might be only switched from
> one side (via i2c command). From the MUX point of view, there is only
> one master (which may mux) and a number of slaves behind each channel.
> But on proto level IPMB requires to act as multi-master to receive
> answers from other intelligent nodes. To receive answer requesting
> node have to switch to slave mode after master write request.

And how is guaranteed that one of the intelligent nodes behind the MUX
do no send requests on their own while their channel is not muxed?


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXlb4PAAoJEBQN5MwUoCm20V8QAK1pbq/+Svt0d3bGP99iBKS/
RwXiSF+6oDU6fT75WT+ebtCcgFqAJmOP0f+NqKPXIPUhzlLWtSzLCgAp8r5CTmvN
HSj7VtHpJnHNdm4+HKYXzK7hHP+8tb3W2unrXs8fPCgBNSyY13ZAzPUGGS07hs4u
k6L/bC6anhnkqxppsjmWxalF95LiWa7+r0ipfgwsotf/95HjOrHvsNVHLk+8cFOg
rEfqwJjmu+uvY4epnTCNDl7BhZlTMQHGnZ7Y3kg6LQBWpvIaIXQyf1vBzuY5uTwr
B7YWeExjLygNderBLrFCD9xrXrBb0sjmQ7q+OdheP50sMSb0sjXA2Rjc1f8wh4/z
6LcOd9UFbeDlWr85ncPrJOFUJ+9yzobjvl+3b7KU4Q6071sx97R14rmwhyEAJ07k
SLz0XcBD6vLPC1aBB95mHeb3JTgieCC/pzOt/WtY1uzrDNGKjt8XbMazh/f/wFfe
DThNM2qBdzjJ4Yf1of1WJ7ND/VL+DCXY9pmrrzNknCV/6UCD+vFQyazEOZii+Qrg
/ESjC/YO//QUyuR3895BS6KtnszEQ9ACxl3YjillE5j4X4ZnziR9JKEJTpolIDEf
+sCn42Ae+MQpoXxF21ruY8Mu2UgUjgZ/pyQ1Selmz8JzA56sUOVu6M06G1J7glpZ
x5Vp0n7QwFCm+gh9qhzo
=0ZGH
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
