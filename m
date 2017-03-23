From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 02/14] i2c: mv64xxx: simplify optional reset handling
Date: Thu, 23 Mar 2017 21:41:17 +0100
Message-ID: <20170323204116.doujbvi7t3n2j4ak@ninjato>
References: <20170315113134.13655-1-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ccduzyt36lw7dsmw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41004 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752128AbdCWUlZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:41:25 -0400
Content-Disposition: inline
In-Reply-To: <20170315113134.13655-1-p.zabel@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--ccduzyt36lw7dsmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 12:31:34PM +0100, Philipp Zabel wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
>=20
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_(de)assert unconditionally.
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied to for-next, thanks!


--ccduzyt36lw7dsmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUMugACgkQFA3kzBSg
KbbUEQ/+NCvmhy4CRDxRFG0/IALn25SNa72iqfjOP7uBIWc31tQ1VXEdKNTAXdu/
33E5+vrbTzuP42loib0n5xTDeud4CUcNdmGW0offF5azNrwqn4OVMbqtvdsMV8g1
t9GrfnGvUL94R0RjB2SlRTmxNbWO+Xdr6mfI65sUSzBP+OaD56FhdjMG01LTLmvu
+DRke1A4JdXFXsqw99UNRbONVc1QszqGo2vsyx52QvzKN7+pbFQzkmWu3OCQUSVh
62kN+ZWICaSBLNrkvHCB+qpmUHCPp9OO+MWhPh/ThpzD7eMZbFcRe0uHcF0+9U/y
A6uLaTknivMEq/DJMIXn7BESvSHEPIrjtTN6P0eqiB2sjDq33EN8cNZx6noc6C4F
91+7iAjwQqXA8WRRmT1PK3wRK1YHheB2Foq24fnLXVmE3hrnY9K8cj/B9k3UfuJ8
2w0YZ2l54W30Q54F37tpCY9aeMzvIkksYHaBqs6XZCRqh0FM6K+Xw9YOXdJfeMvn
DNDqZQsnTk7CGpvR8vOPgwk95C1DrwQybNO6Xd2m7lSTjEKPLS6TmtZn5epzsZ4I
OgRdB2pTAycde4Korw8jFD4dYM7g3fRTeNBBn67hC5kxaXtCrapA3mDjeWpKr/XW
m8ttEMNa48OB+jc/8XmJHqU1HmT1dP54LjCkGeyYAcwBBgpL6cE=
=lvNa
-----END PGP SIGNATURE-----

--ccduzyt36lw7dsmw--
