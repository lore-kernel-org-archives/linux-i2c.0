From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] Documentation: i2c: slave-interface: add note for driver
 development
Date: Thu, 8 Sep 2016 16:57:24 +0200
Message-ID: <20160908145724.GD1485@katana>
References: <20160825172740.25390-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49246 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966432AbcIHO53 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 8 Sep 2016 10:57:29 -0400
Received: from dslb-094-223-189-209.094.223.pools.vodafone-ip.de ([94.223.189.209]:56560 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1bi0la-0005Sv-8g
        for linux-i2c@vger.kernel.org; Thu, 08 Sep 2016 16:57:26 +0200
Content-Disposition: inline
In-Reply-To: <20160825172740.25390-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 07:27:40PM +0200, Wolfram Sang wrote:
> Make it clear that adding slave support shall not disable master
> functionality. We can have both, so we should.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-current, thanks!


--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0XxUAAoJEBQN5MwUoCm2A94QAKr3VnT2t79/HRF26U5UN4AY
dSjQFaaQ/1D+nDVslNuBPbTKBT2Z1P9Ge4Latbo8hoViFEl3qHWgBkGjb4lxnuzf
/OxNjf+RQ8SeEOwUsfk7hb1An2xaA3aqeA/miW0isGqddCdjLy4flOUgBHElJBM0
NfAAd3n2kPYLYZabVzlfqVyd2I20FMZExYQ1xsq4x58B5yl0VKRHeN31AQiEt/ma
x28wG6eXRvT/kwJN/T3C+YQMAtPKqxGcwgVJSW4FAaPc+EQThorZaefbUqoVJlZ3
8VBlj5i0ixmw09K/7NCIDr8D4SNeeFx4hTsvOuLqhiHod7g0h7PBos63/cJseoHq
IIGAgDBywYbopEUqfKihCfxU9F3+uUDXSIh/00nnpiD4QV3fioVeDx6qyHQLMuMu
kt5xbzGW16IwKNBBo8aZUEYkFP2zfLoS4E1fijCsPfvnatmUGIyLtIMrOt2d9QXG
1enupCkqGSpiWi7dPTbNmWNqurdvWgceKGWLQ7SQMFlE5QL5OQKZn9j5ME+aHAZ2
euB6CghLqn8QA+75mw9PZj7vziJMCzBJplf/QJiJnSDmzjYqbJKAYsm81uxs5eBm
HvATy9jbmwkkLaNHg6fJGwrJSoVvE+gEfnQA4qgwsSQbDK95ivVHJZpJH4A8zRyo
s7UZAkce/b12ditp9yLA
=CuyJ
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
