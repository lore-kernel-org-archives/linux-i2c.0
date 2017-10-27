From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH resend v5 3/3] platform/x86: intel_cht_int33fe: Update
 fusb302 type string, add properties
Date: Fri, 27 Oct 2017 12:41:27 +0200
Message-ID: <20171027104126.iaoandrsng7hxehq@ninjato>
References: <20171011094121.6108-1-hdegoede@redhat.com>
 <20171011094121.6108-4-hdegoede@redhat.com>
 <20171026203323.w5xj2mms5epda6pt@ninjato>
 <5f747f91-0eb8-5566-5de3-b5dfd1f134ce@redhat.com>
 <011c294b-20c3-9c37-3606-626b2201fde9@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l6ju7eeiii4fb25d"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <011c294b-20c3-9c37-3606-626b2201fde9@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--l6ju7eeiii4fb25d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2017 at 12:31:01PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 27-10-17 12:13, Hans de Goede wrote:
> > Hi,
> >=20
> > On 26-10-17 22:33, Wolfram Sang wrote:
> > > On Wed, Oct 11, 2017 at 11:41:21AM +0200, Hans de Goede wrote:
> > > > The fusb302 driver as merged in staging uses "typec_fusb302" as i2c=
-id
> > > > rather then just "fusb302" and needs us to set a number of device-
> > > > properties, adjust the intel_cht_int33fe driver accordingly.
> > > >=20
> > > > One of the properties set is max-snk-mv which makes the fusb302 dri=
ver
> > > > negotiate up to 12V charging voltage, which is a bad idea on boards
> > > > which are not setup to handle this, so this commit also adds 2 extra
> > > > sanity checks to make sure that the expected Whiskey Cove PMIC +
> > > > TI bq24292i charger combo, which can handle 12V, is present.
> > > >=20
> > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >=20
> > > I can't apply this one. Is there an immutable branch I need to pick u=
p?
> > > Or shall this go via another tree? My base is v4.14-rc5.
> >=20
> > It should be applied on top of this patch:
> >=20
> > http://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git/co=
mmitdiff/5c003458db40cf3c89aeddd22c6e934c28b5a565
> >=20
> >  From linux-platform-drivers-x86.git/for-next.
> >=20
> > So either we are going to need an immutable branch from you
> > with the first patch of this series so that the platform/x86
> > maintainers can merge this, or the other way around :|
>=20
> Alternatively we could push this patch as a post rc1 fix I guess.

I intentionally did not push out yet until this was cleared. So, I think
the most simple option is that I create an immutable branch with only
the i2c patches from you. Then linux-platform maintainers can pull in
my branch and your patch here on top of that. Would be my favourite.

D'accord everyone?


--l6ju7eeiii4fb25d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnzDVYACgkQFA3kzBSg
Kbb5GA//dv4SsVO8pj9840PXF9ol44QYp/DXivqg6xImioduKap9TKSys8kPsSki
si5TCcJ6xOAsi22aEYSEn71oOFHq3hiQ7jJ1Grhrytd5pnJoc1jvNW63bmkvevc7
Qv2NkKHJbPy84mfqqyN4/3uA/aFjG54RA0JbAQJ7X//8qLMeD/x2/GxFiE/lZAVo
NeeLN6mNk08Zld6X31Da3aWOPEe+BMEW7bypvAUYatcCl0M/+Hr/n6nUVlT7s36D
oVcHodyNqVFi0C8UTS1PzMO3cvkjtv3UBcuzPDeRhRwiPtOVSEQzTxUarU9SmoDh
R66MUF2qVJRs314ywGdTqOktA7CqSPRiYsxarUg+jmtHSDgApo9xH3PNPb3fn6EK
1stCrjcf2djcqUIu+Z2M49q3Rk0aFZWp4/RAbnMzthtA6v0aKeKpAaSH9pT5lHsW
0lC6QCkJtUsoWQYCiD0Pwpm4YYzj+vGVSnHa8LqYQdiOka8wLkk0LeSUoBJ2HPk6
uWHwXplPdb1/glkFarZ1Ws8NJJyDyokvSwWWgeepZIGzKDYUsaPotoiJSHiB5nTU
0lwg2zE9PZkfSButxkpSDmIWs4aD3Oia0stVNqMIbXzr3qghSYk0NCni2wMBUkHx
dSpAIInBa29F4A37v85E1eK9OndoAigb4g1NTfqTC41KmA6c7dM=
=5c+j
-----END PGP SIGNATURE-----

--l6ju7eeiii4fb25d--
