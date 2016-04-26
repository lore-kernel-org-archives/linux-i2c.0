From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: octeon: Remove zero-length message support
Date: Tue, 26 Apr 2016 23:04:25 +0200
Message-ID: <20160426210425.GB4587@katana>
References: <20160426125342.GB23679@katana>
 <1461680812-10237-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52344 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbcDZVEb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 17:04:31 -0400
Content-Disposition: inline
In-Reply-To: <1461680812-10237-1-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2016 at 04:26:52PM +0200, Jan Glauber wrote:
> Zero-length message support (SMBUS QUICK or i2c) never worked with
> the Octeon hardware. Disable SMBUS QUICK support and bail out in
> case of a zero-length i2c request.
>=20
> After this change 'i2c-detect -q' will return an error on Octeon but
> the previously reported results were wrong anyway.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH9fZAAoJEBQN5MwUoCm2hxcP/j8mHxhM0mNVIPUcf4DBCfFd
NFahStnEQmSPacJSyzKyDG4KWnSDdehGYEfbtGeSxHazoC9LUn/2Y6lOUKEHXQuv
e2sM26CU7Wja5jXLrkbV1v2C6aq9vQBShUFx74Rh3GYOM4FIEU+lV/K1CrOAI6As
IQoCBRsBgq15qA/DLrms42jmgC2IIOa+7JcPsLWJ15+bgZ07ZoF6WNyMPX+U+oUs
8MAjm1BeshhtVMb9JuQWpDYhfRztLAhAKvR4WrrH4hLsADAmCen/PoiZFWeZI4j3
maOWXBaaeEGqiKUttV9Y9FTdJYH7bM4J56w/oso2tiUIaJYtX+Vng4C6RFtpoYoj
0xdNyQeTJZpgDUUqGbK/a/FahXse/ujPDPdFyZ+w0I3Q+HAp3Kidu9wFWsKS+7nq
eK59Ph25vSDrMxvu5S93f/UqakHpAddlpaycPm5RmhocX1xMyFq13VbAJCf4B4xB
9bRJIyDTKF8run4SQu2E87ugmfH/PiPu/UNAtuA/CNusF8AdheUyQ1Oc/VWiBYMJ
1aFTJ6pcygR+0wHy/LlFirUEslQOca1VmPB5ArYitYAcyi8rER+sgpMV/gY40b3R
E/GO3rTpu/7rJIPC9tY/QB/gCN2RTF5JAvP2kTs0DpCyVXXBZCgkVFSmmr+uiawO
QfnXhmF0ymx3Zm1eBBX7
=fIZ9
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
