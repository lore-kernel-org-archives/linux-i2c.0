From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mxs: change error printing to debug for
 mxs_i2c_pio_wait_xfer_end
Date: Fri, 2 Jun 2017 22:58:18 +0200
Message-ID: <20170602205818.a7c4jf3n267ki35x@ninjato>
References: <20170519124402.4xkaguxjzgyvbwcl@ninjato>
 <20170531094003.21997-1-michael.thalmeier@hale.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bluzjg3bvwww4cq6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43879 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbdFBU6Z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Jun 2017 16:58:25 -0400
Content-Disposition: inline
In-Reply-To: <20170531094003.21997-1-michael.thalmeier@hale.at>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>


--bluzjg3bvwww4cq6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 11:40:03AM +0200, Michael Thalmeier wrote:
> Instead of printing errors after mxs_i2c_pio_wait_xfer_end returns with
> an error code just print a debug message.
>=20
> NAKs and timeouts can occur in this situation normally, so do not treat
> them as errors.
>=20
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>

Applied to for-next, thanks!


--bluzjg3bvwww4cq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkx0WoACgkQFA3kzBSg
KbbbABAAkMDsv0Q3lF7zZOcnCalv/KFc++Q94KIiQoZ98v9tpBY8GtKEOvw63OSG
I0O+jcyKSjvilxTJE3YN4k3y7haX+UQjnwVA+EWIbw7wdZgcfQUZ2ktfEa7L5NJ1
hC3mwre6kk8KrPYxacfi80Q1gDMzmVkOIDeNeeYH+h7L2zs2gKNg01UPXdhZClU1
YdX9XoWOcVCkz9jnxMRKB0JTQOzisjFDQEuEYJr9mTIRTTDFtyZybJpBweg2czYE
FfTctR5+DgoXEj+aVw8Kp576BEKXhybtOKWL5jjw2nlilS/yME9Qit0SOSzURSnO
rEVoFBVBMfJzNHuR5rcB4Sxwe3zmx2wBt6DKVDkRpsIeHYKGtOZV2lwAuNNsKDgr
PXkgp2k+Jx1F4nkZguTjMoZlf5pT2zomdffEiG2r54kdXyEkabGoAfEyg+Z6LtWW
1cpQaAamjhnsANizl41IKf7T2LMlVuabLURu8iZ5UogRW/ykmAEDTJRqaMzwIE7F
DPFYEarXWatq0+g7lmH/7fAJUYNqI5pCAQfnlnLSgvEa0JAW0TJBBSe3kjOND7/K
VswynhaMwWOiSkZYpy8w8PvO+GbxYHeURl/vRLj54b/svezFffzAmCIVLGCyiESV
WB0DM4fIFYnwVieyq7xvv94ikJkI5IB08W48VZJmcJXIb00vfo0=
=zE75
-----END PGP SIGNATURE-----

--bluzjg3bvwww4cq6--
