From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [v4, 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
Date: Thu, 17 Nov 2016 22:54:40 +0100
Message-ID: <20161117215440.GA10851@katana>
References: <20161109115715.2557-2-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:36214 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbcKQVyo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Nov 2016 16:54:44 -0500
Content-Disposition: inline
In-Reply-To: <20161109115715.2557-2-romain.perier@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Perier <romain.perier@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Igal Liberman <igall@marv>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	[REGS_A3700] = {
> +		.ibmr = 0x00,
> +		.idbr = 0x04,
> +		.icr =	0x08,
> +		.isr =	0x0c,
> +		.isar = 0x10,
> +	},

Can't you reuse REGS_PXA3XX?

>  static const struct platform_device_id i2c_pxa_id_table[] = {
> @@ -98,6 +106,7 @@ static const struct platform_device_id i2c_pxa_id_table[] = {
>  	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
>  	{ "ce4100-i2c",		REGS_CE4100 },
>  	{ "pxa910-i2c",		REGS_PXA910 },
> +	{ "armada-3700-i2c",	REGS_A3700  },

So, you declare a platform_device_id here...

> +	if (of_device_is_compatible(np, "marvell,armada-3700-i2c")) {
> +		i2c->fm_mask = ICR_BUSMODE_FM;
> +		i2c->hs_mask = ICR_BUSMODE_HS;
> +	} else {
> +		i2c->fm_mask = ICR_FM;
> +		i2c->hs_mask = ICR_HS;
> +	}

... but don't consider this case here?


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLicgAAoJEBQN5MwUoCm2itQP/2D78mzxQjZmSYiLtTdAX9/8
iy42TibAfL4u86k3dUsOF6yWL8y2ydiLzU2nX88BQNiQUu2o5b/J5pKhJ+GLgX85
eWPiEy2NEFts+gBbhSYAxEkbbY5V7g9TuY6qssw0wVOhD1Db77GJu9IBmsPFvIZf
wg9+L+feFelcmPk/DlNQcM8dc8fVrIiHiCBFXVTAfYfdNpVBK8qNFvhAIeIO4Mom
1iYBZ6OCjzzzHnduyHTEJy1D65AEet9cDfENxAGkRnrXFVpA73EuMX6erXcaJVM8
NOg1sAa1SpwxcIAPyFLOlsqhzQg7oKIgZAJvu042aRKlQCilaxg0au90okk3inm2
IPX6HRYJO4/smCQRbIi+d4xcFfUXx46lxrp74KfGXE6tcuqyY8yoJsa0M1l/ZKo7
tVFoOWFtP5ZQuifq0Yloj6lcjJQ1Uz9JG7y1cXhNujZHHU+lt0jmgNeCpIEV4icw
sf60DWGrQHeJwvpZaL8ij8oH7ZhWtSMMTbNgmFfMq0a4xLHyAkRvcKmV4rXBV+wh
dNDGKG2sIQilwrzvibTLaEgkSktyXIq8GKZEco332TZLcqXhAh9KUXm92/bNk5tS
sr4nshppGcfk4nJLC2yaHJ57Sr/5SiCUYyk0iLtvUhyV3M1+z1U9CqIuOpCj01NN
9c6mZZb0MoMD6vXYEJFi
=rN3o
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
