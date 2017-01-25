From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V3] i2c: imx-lpi2c: add VLLS mode support
Date: Wed, 25 Jan 2017 22:10:02 +0100
Message-ID: <20170125211002.r6p3dmgtbydhjpne@ninjato>
References: <1484648455-5454-1-git-send-email-pandy.gao@nxp.com>
 <20170125205305.w2ohn46ouzrxutkm@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i5aj3rixt4pdwbcx"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:39120 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751242AbdAYVKP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 25 Jan 2017 16:10:15 -0500
Content-Disposition: inline
In-Reply-To: <20170125205305.w2ohn46ouzrxutkm@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>
Cc: wsa-dev@sang-engineering.com, vz@mleia.com, linux-i2c@vger.kernel.org, frank.li@nxp.com


--i5aj3rixt4pdwbcx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2017 at 09:53:06PM +0100, Wolfram Sang wrote:
> On Tue, Jan 17, 2017 at 06:20:55PM +0800, Gao Pan wrote:
> > When system enters VLLS mode, module power is turned off. As a result,
> > all registers are reset to HW default value. After exiting VLLS mode,
> > registers are still in default mode. As a result, the pinctrl settings
> > are incorrect, which will affect the module function.
> >=20
> > The patch recovers the pinctrl setting when exit VLLS mode.
> >=20
> > Signed-off-by: Gao Pan <pandy.gao@nxp.com>
>=20
> Applied to for-next, thanks!

Reconsidered and applied to for-current instead.


--i5aj3rixt4pdwbcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliJFCoACgkQFA3kzBSg
KbY2GBAAnRPlztxjbkXG+WlrJRbOtc7FtHJwv4QfGANMDZHCaji+GekrSlBaeKuS
DxNFP7UEtaOrhejBMLLKByBjXN3oF/3uMxIFmywit/O3+StgpyR3+azzxCUtO4ex
SWnWWUT0dvDBr+lHsto9PsqaPBcQw+jZw79GoDPiRoM6iKiDxdnWIwKanBMk87RX
Ukk31cq7VJ0Q3Ibhkh5zDb2wiLhd/mGLXHTd1RrLiMRVcAU5K8kxUCNi15LiAI8h
WuVr5DoVMuOLrj02Sr2gRbvRO4JN+kbiGr90awfoNhwIVTIRIfAd5FbWk3LJJzOC
tT97REMJgSuHjv2wWOA/Eup3bfdG1GCPrlq8iWmTccTwlSfuJGD3EkuzeQPR0eHz
unuOR9Hf97Lxr7z8O1jr866sK/ne4Zew7cfjNp7r++KIdNeejcQWUMmOmYOjC0U5
DRtFvp20yNqBjXvDOZIKg9rlAbu+JFu6F0NyYVTbRow+zFiWH6uvBx3FSHNTl2Io
13TIx1qMfIlv34JfiBBwWHMw9zuSw8sh2pqpft7jz90mB1mOYnIHXamacXMJDaeb
zk3sVBXJkk73Qkx1ePqGFkiSBGYywXrO0k8MD3lnER9cynVsKIzwuBiPJ6jK/FG/
dGRxtifvga7LktON3l9TReZk1FJ6K6Ql8WX+G33eLouPEZw0NMo=
=oQX9
-----END PGP SIGNATURE-----

--i5aj3rixt4pdwbcx--
