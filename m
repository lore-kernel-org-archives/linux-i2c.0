From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v5 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
Date: Wed, 30 Nov 2016 17:18:50 +0100
Message-ID: <20161130161850.GA1441@katana>
References: <20161121133247.29889-1-romain.perier@free-electrons.com>
 <20161121133247.29889-2-romain.perier@free-electrons.com>
 <20161129211716.GA15594@katana>
 <e5c36597-d917-0555-89cd-35f68087c1c5@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:34636 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754171AbcK3QSz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 30 Nov 2016 11:18:55 -0500
Content-Disposition: inline
In-Reply-To: <e5c36597-d917-0555-89cd-35f68087c1c5@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Perier <romain.perier@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> What do you prefer everything in one commit or two seperated commit ? (one
> including the new fields for fm_mask and another one to add support for
> a3700-i2c).

One commit is fine!


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPvvqAAoJEBQN5MwUoCm2vdYP/0eRXEyYy2YjgdZIAWFIXk6y
U1utO+BbdsAfkzwEXFONdIufhSxc65eJJbr6m1/2ifY52NzcIfZ1E5heD4GH+/RF
+UZbbdpBuEZPY5QOyJ2paVD64RppzvUeAUkz43onN1z3HfAMShEXdflcusA1h3V5
86cdMtXJgkViKmUA9IVrXG3r3s3EIw+qXdTI3v3taci/PztqzA4FfRlJrugvLBYP
cDCv/yJqL90exkj2YI3opsh2HtlMQeCVpi3GtKxlruj8pbSZu6lAJOm32lRroK0d
KKH1XmqyD7jnlULGc5WfBltrHH2jmYjVCwI1KXnkjHpzg+zO8N3rrS2Q6nCPIkf6
SUajC4Ut/OhFhbe3w17Eq64stBstPI0U4kIn38vfqlh15HlxtG7BFjGLMhM4Xs4O
PKmACxGGjwhQ95phpG3g+LRAXcnfmsmGGQE00+Ipl1yUBbG+AYXCi5yCIkyQEKtc
n0eRHQuVbSAFTX2Qz7mO9HS/dz9XXeYOoK6uspPSlIxanvrH6XbgwnkpbIXmeIdc
iFcVmr6GtEsS0dyq3eAenedQonGWMVpJ3gRG5gA7kXc/DQmTIYpYLXfurG5EfWPR
Lyd2PcalAfaWgUSS3DNUTX7/nia5ZozTQZvsYICDSPgHnSH4Q2qHaLn0ny//hWQ/
cgkcA7qPIYQ1CjFwj08J
=/5MQ
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
