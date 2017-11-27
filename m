From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Fix Failed to allocate irq -2147483648 error
Date: Mon, 27 Nov 2017 19:11:51 +0100
Message-ID: <20171127181151.wltue4ljdditq7hh@ninjato>
References: <20171122112817.9554-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ylriy7oist2gd24w"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47909 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753141AbdK0SLx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 13:11:53 -0500
Content-Disposition: inline
In-Reply-To: <20171122112817.9554-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org


--ylriy7oist2gd24w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 12:28:17PM +0100, Hans de Goede wrote:
> On Apollo Lake devices the BIOS does not set up IRQ routing for the i801
> SMBUS controller IRQ, so we end up with dev->irq set to IRQ_NOTCONNECTED.
>=20
> Detect this and do not try to use the irq in this case silencing:
> i801_smbus 0000:00:1f.1: Failed to allocate irq -2147483648: -107
>=20
> Cc: stable@vger.kernel.org
> BugLink: https://communities.intel.com/thread/114759
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-current, thanks!


--ylriy7oist2gd24w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocVWcACgkQFA3kzBSg
KbYNOw//cCyiPFo3hRYyAy7RIRsOp/8g96yQ6fR6LAMb9yZFAOW/U258647ruIpa
tWn4E+5MWNLxJe20uxHjeOztZx2HTaVK9qAZeuqX3vdRjGbxxp/pe9bUrVIiOgpH
QjmH1PzFF1IbW5HwWh/IfNaxjuKTLQVuP7lX1fbtfTL8yPveqVEaTonXx6cFeotI
x6hCJh4vuA8u+ecRTDe+FfkGVwOrFhzpZD50bT1kFdUNNTjzzqEOKF8gDkPBaqmj
h/Vi7Eihk1x2Y/783zK5+DorPXDA2g66ZQ8E4+wwZ8bw7dXFVbkQ4tzWRNM12JvJ
tFLxMWNN6nLogWiUVLIjgoVZHpWiEEe70JW7FJ4IRK1y700LIqsPjjFeJNtxPp4z
SXMkr3pu+fuEcB5LP6BrqBdDVTbTrV8JASOkb7QP7uOrm9/AORqXxFJb845KmZ02
wxMDqRer5oYjMDZDOAbR4Lt5wZkTrAzQ3Vx4bhCEysNnV19J2KAwFPy2vkZBuxdU
Oqspq0qKHm/8/bD5WJWu2MYf1c0z4cM4pcvMFc9x8tGg0OOr7W1ZPk0qGmS2FuFW
in3mNpZGo/752z1Xr8PS3qQIPkOrtTVn2+biN/LFh8VkKYOIdHG63aJ7dRW6UEm4
gm0LVr/13atRLm1w01ac9C6K57MlrlHvmd4Vto7Qgpq88H9nd3U=
=qSEq
-----END PGP SIGNATURE-----

--ylriy7oist2gd24w--
