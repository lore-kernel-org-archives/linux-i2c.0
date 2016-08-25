From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 0/4] i2c: designware: improve performance for transfers
Date: Thu, 25 Aug 2016 22:07:21 +0200
Message-ID: <20160825200720.GF1614@katana>
References: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47128 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754459AbcHYUcC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 16:32:02 -0400
Content-Disposition: inline
In-Reply-To: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-i2c@vger.kernel.org, Christian Ruppert <christian.ruppert@alitech.com>, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-kernel@vger.kernel.org


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2016 at 07:18:52PM -0300, Lucas De Marchi wrote:
> Diff from v3:
>=20
>     - Fix over 80chars in one place
>=20
>     - Move check for adapter being able to dynamically update TAR to be d=
one
>       on probe time rather than init as requested by Jarkko
>=20
> For the previous version, Christian had added:
>=20
> Tested-by: Christian Ruppert <christian.ruppert@alitech.com>
> on TB101 with Linux-4.7
>=20
> And Jarkko added his Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.c=
om>
> on patches 1 and 3 (now 4).
>=20
> There's a new patch #2 as a preparatory work to move the check
> mentioned above to i2c_dw_probe().
>=20
> v3 of "i2c: designware: do not disable adapter after transfer". Differenc=
es
> are:
>=20
>     - Now there's a first patch that does not depend on IC_TAR being dyna=
mically
>       enabled/disabled: it just doesn't wait for the state change when no=
t needed.
>=20
>     - We added a patch that allows detecting if HW supports the dynamic T=
AR updates
>=20
>     - In the last patch the bits were changed as suggested by Jarkko.
>=20
>     - This is tested on BayTrail and CherryTrail, both of them returning =
true for
>       "dynamically update TAR"
>=20
> Jos=C3=A9 Roberto de Souza (1):
>   i2c: designware: wait for disable/enable only if necessary
>=20
> Lucas De Marchi (3):
>   i2c: designware: add common functions for locking
>   i2c: designware: detect when dynamic tar update is possible
>   i2c: designware: do not disable adapter after transfer

Applied to for-next, thanks! And thanks to all reviewers and testers,
much appreciated!


--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXv0/4AAoJEBQN5MwUoCm2g5QQALJaveIqHFgKMySUNo6AfxHG
HTZUewv685sLvjSECic1fn7uoNeDyx6poqaeStOJAPohCf7HCNd4tCTFPt6OBavP
Or33J3BmbekvvXerStlqEa9Bqfgq36eZilPWT6NTOxf9Cb5HiWjkO7Eu3z30pa9e
TVnBd3rkb2d07dtvPttA9s+/EGrzMSNd/47vcgNvTYnCSra0RaHV2nh0q23NrAm8
vIIz0M01TuJsmCM0jb3MdYRvg/RWCKptG2HJ0WRfh90Wl2YYgJmht3tK+7OfhesF
sgCqJSmuDi8gpEjT55WI6cFPEPozyTkI0PyynMXEJVAnOzE/M8gZwsMdEmsUcV0k
K9o8Wye2bT5rWVoxHKrIrEwv5ZVwbjthCUMGdj1GMqHTNzK6DdIsX8ph0KnVB/2P
dabSn433z73VtMunbrqpRx9yVcUiBBV5bFmZAnycYtwkQ48GuKw4U2CZb5NCvZ1W
Htq+DH3e5ghcsfgC/b30QBpERVhV5/xukF7wErBNcs0IoXxsc2mjK0aIZZwo5A+T
qFEB6P4vsUosHN3gq9coQNUmJwqUEQuXWKgx/NuhSwUvHN+KFRadIxdsXQLfPFeB
ptEBK+E4M+Ph7nQKGCdxgtBAueGjmRRE6iL+kJ9h2kjeZsVQSd9qomuwnniIEDwm
s/FxUEtDSGNzMO9eUc8n
=bT4p
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
