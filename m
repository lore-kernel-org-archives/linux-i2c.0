From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Tue, 19 Apr 2016 15:49:57 +0200
Message-ID: <20160419134957.GA3814@katana>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
 <20160415080111.GD1714@lahna.fi.intel.com>
 <1460992811.8946.22.camel@linux.intel.com>
 <5714FCBE.3060009@metafoo.de>
 <20160419124028.GF1725@lahna.fi.intel.com>
 <57162C4E.9090904@metafoo.de>
 <20160419131631.GG1725@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38726 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbcDSNxe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 19 Apr 2016 09:53:34 -0400
Content-Disposition: inline
In-Reply-To: <20160419131631.GG1725@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jean-Michel Hautbois <jhautbois@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, laurent.pinchart@ideasonboard.com, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> It is still not clear to me if this supports more than two addresses and

I stumbled over this as well: "Secondary" doesn't mean "as in second address",
but "as in not primary address". So, more than two are supported.


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXFjeFAAoJEBQN5MwUoCm2zaYP/215BQJPHTcZLiroZKD22Cye
j6w9/4xrlOjHR5YZ2BtxmvGbItHBnYDy2GS/4FMkWR4WkFHf0UpLvCawUCZ9OE8z
fxZonxJfyOcl+SZb0352sk8356nR5g0GjNT77A9ZTWkI9lsyvptQ5kI/B56bPjHl
/DDZs2whHVSMAsOmAdYsIXZkv3l1cPVBrtXkHWz5XjMPSkAzpDvwuZkokI6TUhKo
27ch3+7+2eUvCIRWhj+M2RKbB9PLzNSs4t36/n5L8FuIex356UZVzSExllTyL1Rm
+70o6sLvE+TMGEEO6nGT0l+bglWpoXEfTCSPWsMFT+U+IqGgJarWCKsVZ/wrUNw0
twWOmXGgZSsZUSrEhg93qHKBzxh8mMXlFOO9bMDrrnnZOdIJOLGYypGGTQpbfGm9
oBSkBWBZannyaRIPmduKXv+vWPJdbUqqU4S0DwK2MDsW6qtq6b7zojptTj6mxBvn
MncJMAh2aPc1G3kA1eFPNdn24oAQcQ+zgc3Pd3b+9Hn88RbdF1sowDV8l9k9IbBq
7CNWMkTn6rXzse2teFROTQz05/AG9JnBFn0lJdvBfbHp+9AUMvy2oz4xAwvgaG47
fbfPtExVdzn8cfdJW95Ozba9Tjaze7PA658nVclM3k7CUER2dxMsWFfyNJG6Aok9
R9ut+0My6MdSyfxLDRAA
=9shY
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
