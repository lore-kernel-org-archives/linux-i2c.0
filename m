From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: davinci: Optimize clock generation on Keystone
 SoC
Date: Tue, 20 Oct 2015 17:05:46 +0200
Message-ID: <20151020150545.GF5379@katana>
References: <55F68D76.1060207@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43276 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796AbbJTPFw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 11:05:52 -0400
Content-Disposition: inline
In-Reply-To: <55F68D76.1060207@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, devicetree@vger.kernel.org, Hemanth Guruva Reddy <hemanth.guruva_reddy@nokia.com>, Lukasz Gemborowski <lukasz.gemborowski@nokia.com>


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2015 at 11:03:50AM +0200, Alexander Sverdlin wrote:
> According to "KeyStone Architecture Inter-IC Control Bus User Guide", fix=
ed
> additive part of frequency divisors (referred as "d" in the code and data=
sheet)
> always equals to 6, independent of module clock prescaler.
>=20
>                          module clock frequency

Applied to for-next, thanks!


--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJlhJAAoJEBQN5MwUoCm2JjkQAIVrT3P+IwbPwNfwJajNISt6
qSa84iX93RT1olkorrebtczK+9rGLYi2PMY1HoA9Ax6YeOkoY89ANnv/kAfYP0Oq
tnCCH1h0F07kDf8PZf7ca4GwR+I924K+Tg0soxlEmnUdEilL2GgqfQxLxVKG0wHh
CJ2M/T+zxCg3zGsDq4VGSGwdnIe+fQf/noje3hcGK546LlGWQRqNxEPD11ThP7U7
0oNDoxB7m96Ufj96ww3EsokfcHiGo5OIE+LONlD47MEfqDfGMvAaq6Jdnozl7TFA
JQgScRDj6vg29lvplzXUNOpewaegZbIDDCth6KkmXIWp8jzDUZE0YS15zjz8zqUe
qUN3i1x7v977KVS0S1sxsm7j6HRjEktjQj39w8+qbjJnMWtQDavT82YTbsGMsPjK
3+ceh2DBzr+GT8IuCByTpPV5UR07xo8Ayx3yR8eFWfJQ3TbuahIrO3DPb8eyTKUq
guo5jbFI+iDcctFOoA6onNit0OF6AWiYskf0tyj6F0kks/jvZsbUN98KabYc+QTf
lyUQryQFYhBnAKIM/l+pey7ZrReJeTmVLHZYouwnJOo89F5BYs4O51Bf4KAZMtyc
ICyioWyfzY4e+omm6yedIF0xYs0rqaoyz8+VOsEMnTKJqji/7cJkipFETfr1Tf6L
pDsf7CQwjmXKigduLE3W
=T6dh
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
