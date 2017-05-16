From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V1] i2c: xgene: Add support for I2C_FUNC_I2C functionality
Date: Tue, 16 May 2017 23:40:21 +0200
Message-ID: <20170516214021.ydrdksvosghyxbvr@ninjato>
References: <1493181705-18531-1-git-send-email-tnhuynh@apm.com>
 <20170516213908.losif4flmht44rur@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qhz266pkapq4z2qb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:36020 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbdEPVkX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 16 May 2017 17:40:23 -0400
Content-Disposition: inline
In-Reply-To: <20170516213908.losif4flmht44rur@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: tnhuynh@apm.com
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com


--qhz266pkapq4z2qb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2017 at 11:39:08PM +0200, Wolfram Sang wrote:
> On Wed, Apr 26, 2017 at 11:41:45AM +0700, tnhuynh@apm.com wrote:
> > From: Tin Huynh <tnhuynh@apm.com>
> >=20
> > Certain I2C slave drivers, such as the pca95xx, require
> > only I2C operations instead of SMBus extensions.
> > This patch adds I2C_FUNC_I2C functionally to support those drivers.
>=20
> Again, no Signed-off. I can't apply it without one. lso, please add your
> full name to the mail header.

Wrong mail, should have been replied to the other patch, sorry!



--qhz266pkapq4z2qb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkbccUACgkQFA3kzBSg
KbbMMA/6A6DoWaC7cgAH0+Nu6Gf/oXqv39ngXgIIq3ig1ytcue4Iysb8S8LtiAnr
BQAw4pQhPDvqpA9tdDvEFr0kyy3KGHsgOorOaKF14wrZjVfjjBqUKO45RLGX+Ci6
k3Nmh98mbbpkDuQmLLwFJAbwYPZyFY26Bmd5WfBB9woaE1S2XpP4FO7RocccliLN
thtMKxFbnr/uSDWidxPo2XJiiPNvsSu+a9YFi5AvOho1hAryjNf91OgvkPbUpZ1f
uu1Uz+aInDfYggUeyqjR8216zwOT/3Lh1uT2/2i5SSl90CqyNCo7UeTGk60oBf2o
z4e2HDeuijumlfWZV92LJVdWs1XeUrD0ULxPKhxkl/wrkQg5iFMDQrA8Ws6x11CN
UkC4uasvyiIf9GQK8y5whRV3+zNbQTnXtlmprBF6PWFOQWUnos1sNbsxc9p/8DNS
MY4lZyofKw/RIP/uWf3lhhgnzQOlOk+5o3DkbJBRZ72hhH17lv7hnn59BA7sORdI
0HDdgvittlwWgf3kCq0QVYV3Lwa02XRtgyihl2mSK+2u2qWynP8qgViFP4/5mRXr
k354kV3NZcf96J+ZdrboL0mDgv2nKFKtUiiyyTt+ShCEY5Br4VSQrKvbCpdpcuW1
x/wBk78cRGvcsPZktGZIGkSESTe5DziIir7T8Sqjv/mn4L2VD1o=
=+mKM
-----END PGP SIGNATURE-----

--qhz266pkapq4z2qb--
