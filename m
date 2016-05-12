From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: add DMA support
Date: Thu, 12 May 2016 23:35:51 +0200
Message-ID: <20160512213551.GA1641@katana>
References: <1462365503-8451-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160505220625.GA18367@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160505220625.GA18367@rob-hp-laptop>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Is DMA actually faster or less cpu usage? I'm doubtful.

No need to be faster at 100/400kHz :) The key here is way less
interrupts for bigger transfers. The threshold value is hard to measure,
however.


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNPc3AAoJEBQN5MwUoCm2rq8P/3V6/RHRLfC4iSWbFPEfsVYT
CBWgccvl6CjHE6M7tIPpOho+ADh7V/edz9uUv41vbUyxRhafqU0S/HEL5u9+i0ep
ymemGrZFO7CzzX/DYRX0RPBUH5PkMjFvr91EGO5hMZQoXo1D8mq0js7zL+MVwelT
Eu0dtZVco5LIGov540XHJ64HmwtCkXE9HVd5034Ju8kUk+wkWdZZDckCaB+ZbtIq
ownlprn9+Jn75Ng5oLVf0ZR6OIJ4JSHo68UWaikpB+9EhD+KwL07gF8eo2COGGr3
aSXap7GdFYP9A5R+0fPuk/dAgveoGqTYCegkmGp14tcjlX+SgCgLiktVVfDzkfaw
HOcn8o4FPumsKODBXCv3zwhEywTvCfhHr5RdGiCjTo7eiFKz1ThnUVrJcaqS2xZ/
Ch5KnQrtI91DWZxI/bMX4gSBzlxy+OvC6nenjzTerxA24DUXTqYGh3/BIxBuXnCt
zV1Da2yuYMiFgzO8jpUTqQB3pK9PUQPMoQfna5flxFwZjs/7ySKe4INSuObBexC5
gYnGBHPMJzkksKRGjtv0o2ZwEudtxS4SRtao4I3bUR44HEqkr/c5wnKuqIVHkNZN
1jOj/xJ4GoT7bNHm03Do0PXcDkJxLiPk1IhJ7DXytu/PLCLY0pZ59LiU7Rem6lwc
ftt8pq0mFJ/ZjxDozWPO
=xbcF
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
