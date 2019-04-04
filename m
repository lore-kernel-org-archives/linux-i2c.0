From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 0/9] iProc I2C slave mode and NIC mode
Date: Thu, 4 Apr 2019 08:16:01 +0200
Message-ID: <20190404061601.c7sbti2zyu6tsoyw@katana>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
 <20190403204423.btgtke3tmt7pkr3j@ninjato>
 <06dff712-151b-f188-d154-3130d56d01d8@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nuqsrixpylmauw4w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <06dff712-151b-f188-d154-3130d56d01d8@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <ray.jui@broadcom.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--nuqsrixpylmauw4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 03:20:14PM -0700, Florian Fainelli wrote:
> On 4/3/19 1:44 PM, Wolfram Sang wrote:
> > On Tue, Apr 02, 2019 at 06:18:21PM -0700, Ray Jui wrote:
> >> This patch series adds the following support to the iProc I2C driver:
> >> - Increase maximum read transfer size to 255 bytes
> >> - I2C slave mode
> >> - Polling mode
> >> - NIC I2C mode
> >>
> >> This patch series is based on kernel v5.1-rc3 and available at:
> >> https://github.com/Broadcom/arm64-linux.git
> >> branch: i2c-slave-v6
> >>
> >> Changes from v5:
> >>  - Address various comments from Wolfram
> >=20
> > In the future, please write in detail what you changed. I review so many
> > patches that I can't recall all my comments on every patch.
> >=20
> > That being said, all patches applied to for-next, thanks!
>=20
> OK, I will drop patch #9 from my queue then, thanks.

Sorry, I meant patches 1-8 applied, assuming patch 9 was already taken.
I usually don't pick up DTS patches, so I'd be happy if you could keep
#9 in your tree.


--nuqsrixpylmauw4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyloR0ACgkQFA3kzBSg
KbaJkw//RcBa5KxvEuhAkwsWdS8X9lWErh6M1DVqlE6esIV5BzyjO+AcpQ4gfGTq
aPcO/Im6utF5SWnnHgnYwvCv/CKP9sA1ha5FWMmkd8aIZ5dHcrESvA3kKWKpirsZ
5bkphYdM2llcoxLEKJ361zVRoxIxhJ53HBuRDqv8jI7z8UFwU3CX1Io5a51ZiwcE
T5xJpIkdqq/N2vH24T8PS5nmUYO8ir7mImua/wM374RjqAmP+v/pS+lolBW8E6Dg
t+a6YIZ8pu3x8a3cz6EBZfhcvBiuZx/w0IOBFgSShmozJZUlOBjSrC76B3Puwu0M
Xj8Q7xRLlfXzuqTuCLOzAzGbnQa8uf23WXaAfHgzL1DwKEg6uuPVp594sWqyKRaz
Imps+m1Whii+u74Uvzf8Ig7keC9+5ho8xMlS4GQC5le6ZIrqxmcQUYWFnP4uVYhV
4ymcsTOeoJu7dABW8VTc9VCPYc/2olP8Xi4EXq1CE9k1Mr2sFbbTaq/FwiHFd8Eh
1RIR/D8sEMAVByWc9kjKfA+suCu8+0wzmebUo9NjTKvdfxqkQpc7fY51zqvKepys
9TXPAFFafNnZ/PCoSZXJCex5nauCFJMeKkJZHMDDQPyN2nTDCM+msp1JBVNyzIR9
0tKmVqSUen8WMVWrij6+xfsUIIDBK6h2A2ainrrFv76mfc3zruA=
=yCr3
-----END PGP SIGNATURE-----

--nuqsrixpylmauw4w--
