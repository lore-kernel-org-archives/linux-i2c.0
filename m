From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: do not show SDA hold time warning when
 not needed
Date: Fri, 2 Jun 2017 22:15:02 +0200
Message-ID: <20170602201502.yobk7f7sdp34ez3d@ninjato>
References: <1492203192-28025-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1492502087.24567.47.camel@linux.intel.com>
 <20170418095939.68788787@free-electrons.com>
 <7b011e1e-8fa3-07c4-6688-5e258fd64dbd@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="md663zgur6szjajk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43686 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbdFBUPF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Jun 2017 16:15:05 -0400
Content-Disposition: inline
In-Reply-To: <7b011e1e-8fa3-07c4-6688-5e258fd64dbd@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--md663zgur6szjajk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> hardware that doesn't support SDA hold time. But needless spamming have
> negative value so this is worth to fix. (I would do this as a single liner
> by else if ()).
>=20
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

I agree with Jarkko on everything, including the 'else if' fix.


--md663zgur6szjajk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkxx0IACgkQFA3kzBSg
KbZ91g//Ra9RHkECnk8uMIDlwQQZpQAIbXv2Vt0KlSmdMihDBIrj3FgPiF503Yo/
7RG+8rqfO4yORU5EkJMaeHfkj2KSeNZGMqg0BoZfuGQ7uf4e5WSmb8i2NjGsBDb9
zc1bPnLLjv3gf1UR6wYEGME94r60u0Wqwfnq2dJZ9aoDpXVBIPE/MzwoRlSteU1F
0gcQTtrL15JJx23Znw9T2Hn/Tr0NIZLVL47cKEy7QcxeEzvZi7MBzanqEQXdroTV
WY3gWoGmqch+e5qjUKP+8PiEjTmHD/K016LKTvgLXxNFnVsPtRH2QRp866C86lmM
ADzTrYrsdsh+TRjcw/H1bGupnFQ4dKeNaq/wgEUwos7JrbVyPagFlejdXLOI84OK
dbJvS1Z/qoz9UchEpnx+L561DmZujgDfssfZjNEwHOpY677Hi04cF/cYexarpGBT
kLzHT71jIiJU+rqYQuW1lVXfSpPhtmQic6Xrmt3GxEtd6ZJob+6S3k/gWeI0gKOX
I6BjjDVHJreNcuGd1jIGtonJ0LXUCPYz50hHEPO0NOm6sH1E0Y1xCcW1+iVFTqv4
201wpSHIWSIJOPDZx7H1+8AF6PbSlWKYFHkFVPENmvIBIoQkeCA86gAUA0BVhhkq
yHE+i6v51BJYA6SxgMbkb4mXht5AF9hEyTh1NE6psvVfyBzazy0=
=ABdc
-----END PGP SIGNATURE-----

--md663zgur6szjajk--
