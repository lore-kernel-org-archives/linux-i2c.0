From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-tools: fix feature test macros for glibc >= 2.20
Date: Fri, 12 Aug 2016 20:34:57 +0200
Message-ID: <20160812183457.GB2037@katana>
References: <1470213836-2848-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55192 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbcHLSfB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Aug 2016 14:35:01 -0400
Content-Disposition: inline
In-Reply-To: <1470213836-2848-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 10:43:56AM +0200, Wolfram Sang wrote:
> Since glibc 2.20, the usage of _BSD_SOURCE is deprecated. Fix it like
> described here:
>=20
> https://sourceware.org/glibc/wiki/Release/2.20#Deprecation_of__BSD_SOURCE=
_and__SVID_SOURCE_feature_macros
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Pushed to master and 3.1-branch.


--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrhbRAAoJEBQN5MwUoCm29jgP/0BzvaNqWXefzZW1dl2VGkpN
yov9pJlaVrGclbQ7um01+i3p+iAIKCiDkVdLJFVODz2e6AuUkyCcxi7i7oQ2Z1zu
7jVMoEsM0TvZmO8DNCGnQK4IMAVEY5mGtSF2HLZ3n3dHOxD07b3C9Ft3SQlDducL
mgNv4DuA/iuaX215CJ4XY6UA03KipbHOmvhqbFxruYORCk8t0NHHWKGpppPh/ys6
VFuJGjK16wuptEUPBUo1bP2Ppp2tp4n54T26rcDxnrCcY9ip5QLQXi16JGxRqZdQ
RiN45ubD/yTNWBDAjNt+zwDVn/iXiRp4QcYzalQRCo/eGL7SxZ0s6v5/82i1Ms02
GYeqkemn0dPOAbJLlOOx4wwU5CBmFeO0AKiEXVP4m9BD6vtK8PZ+TaOYepPnCOoX
VZsk3wIPkUrPNrarf4YBbF17jBzaSu7ymEl73mXdcApodSZzSJuRSD6VvacL/Kvd
hFzaL6yrsy3dVm4a5FB/Ecq/C5RuPca3pCY2XhOXSHg3+Cpp79mqYDi5uy7jnpnC
FBE642SpWeNomgJZtUBdkApao6Fc5UgGEL9yaNE9MwADXUCCfFN7RZBvKktR1vKk
x6JifSmp2CcwhQ9qJ79K7PEeAMsIFfcshy+XNoOY8YsUlwmv1aJ4nQhU3OjNpQDX
IJVUTh4naaG7KBAi0EpU
=Gqka
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
