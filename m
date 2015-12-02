From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 16/16] i2c: designware: Convert to use unified device
 property API
Date: Wed, 2 Dec 2015 10:53:39 +0100
Message-ID: <20151202095339.GC1555@katana>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20151130195858.GB16446@katana>
 <1448966031.15393.131.camel@linux.intel.com>
 <3465575.VLD33ozkzD@vostro.rjw.lan>
 <1449048220.15393.141.camel@linux.intel.com>
 <20151202093341.GM1593@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151202093341.GM1593@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-i2c@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 11:33:41AM +0200, Mika Westerberg wrote:
> On Wed, Dec 02, 2015 at 11:23:40AM +0200, Andy Shevchenko wrote:
> > On Wed, 2015-12-02 at 02:28 +0100, Rafael J. Wysocki wrote:
> > > On Tuesday, December 01, 2015 12:33:51 PM Andy Shevchenko wrote:
> > > > On Mon, 2015-11-30 at 20:58 +0100, Wolfram Sang wrote:
> > > > > On Mon, Nov 30, 2015 at 05:11:44PM +0200, Andy Shevchenko wrote:
> >=20
> >=20
> >=20
> > > > > What is the bug fix here described in the cover letter?
> > > >=20
> > > > The cover letter mentioned 'last part' which I refer to as patches
> > > > 14,
> > > > 15 (though this is for UART), and 16.
> > >=20
> > > Hmm.
> > >=20
> > > So may I assume that patches [1-13/16] are for me and the rest is to
> > > be applied
> > > by the other respective maintainers?
> > >=20
> > > That should be easiest logistically IMHO.
> >=20
> > Have no objections.
>=20
> Unfortunately the patches (except this one) depend on each other so they
> cannot be applied separately.

So, why not let all of them go in in one go?

For this patch:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXr+jAAoJEBQN5MwUoCm2b1AP/1Iyh8gCzMaNeydZHmvUb7rb
2zWS+0M+uGgANpLGoKds2LpkmBlxrXByrSnC+1b+bRd/BsM3G6vCLealzpgBKelL
/DxNHt51e1zgJf7NOm+tSTF0R0+nMyEYTs3MIuDufyGRT9V6SDDXAP2GjaUrScjb
3TwRM5kOWNbscEsA4jzSTsyJwquPoT4dJnStWEvRRZ4jGoU2zB+6y+Zzz+cjmmTe
lizsQUNFD8vwMtk2B4e7TeiqglgipbhpcswYSlQDuLSdYLTPamfvWu+UyvHXG09k
rBjpklgC1evzmN1UsN8FbipPqjyzutkKc+Sp4louEp/N13TxNqq/eysm6//iUmF+
yDexu6H2GFnEJeOMwHy8eXyYGzUgdIFls5UsKy5ZafzHHpwO/fE7J3O1fIUaGOuZ
/PBgcLrJRyJ6d9Y14D8oquK8HgRizcR+0786Q5OW66CMGDF/vpK4WCzM3LfSvuTP
KzIUKpzf8CytfJF26AyDXad1iVYNkTqcmw2LCLzu1w1VmwZNiG1T7K0EyFPKpF7Z
AOb0rI/XUrhxlxelqtpXPQ8L/7FqHj1LmcYteYxdRW6ZoGDCBw4P5lft5lgQmyu7
TSiCGvTV5dwhcBB3FQ6qFYJfnmysIqXGMHw2Tk6QJINUyotpG6oHUj1F5B7+eCB/
8WMgrzvSxFCb08ZZ24k2
=tDse
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
