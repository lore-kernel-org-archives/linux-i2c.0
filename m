From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Thu, 9 Jul 2015 22:29:52 +0200
Message-ID: <20150709202952.GQ4744@katana>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150422074019.GA1511@katana>
 <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com>
 <20150506183733.GA1513@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SvyA5ywaG/v2A5dH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150506183733.GA1513@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--SvyA5ywaG/v2A5dH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2015 at 08:37:33PM +0200, Wolfram Sang wrote:
> On Wed, May 06, 2015 at 10:51:07AM -0700, Kevin Hilman wrote:
> > On Wed, Apr 22, 2015 at 12:40 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrot=
e:
> > > On Sat, Jan 24, 2015 at 09:16:29AM +0200, Pantelis Antoniou wrote:
> > >> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> > >> This is required to avoid multi probing when using I2C and device
> > >> overlays containing a mux.
> > >> This patch is also more careful with the release of the adapter devi=
ce
> > >> which caused a deadlock with muxes, and does not break the build
> > >> on !OF since the node flag accessors are not defined then.
> > >>
> > >> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> > >
> > > Now, that the dependency is upstream: applied to for-current, thanks!
> >=20
> > I'm not seeing this in linux-next, or in your for-current branch.
> >=20
> > Was this dropped or superseded by something else?
>=20
> I dropped it because it caused a build bug. So, we need another
> dependency in... I am not sure if this is already in.

Applied to for-current AGAIN, let's hope it will work this time...


--SvyA5ywaG/v2A5dH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntnAAAoJEBQN5MwUoCm2m/UQAIfTPxmbFXNN93x5sV0MU3I3
fZZrl9h4/FpGcAB7MljSxJ1NdqVwp/CRJ+dAo8tm6EXpn26G3GHeUVs9oXMLqko8
V3PRLcaJ5Es4NR893B73GWWryloYz0tabDZeTYFQ6q0/oap11DPArWAFW0LE2W/1
rq2tHFP76TUDyHCJ/Kiy73V2SebeYYBLENkn5SsNEAU+BUtwOo6iv8bkKrjSlsqM
iB0zZtQNfQNr0DL2XSP7JyES/mi061FujKCtZ3YWodFUDbtjDrynJfeFAIPkJ83u
+GhtydFy9uslIK163D7ZZ4a126mB1dm+aD527gmsKTrRkAnRLeH1ZQe41wCGwTu2
JfzSriW7LuXIBOmDS6mS3g1z2na29tzrnK1xuRICZ2JX68x9eZ+fdPKFdR+DZzhS
rIkb1z+Z7VYjiMl+18W26tH6CGD6UyOgewlLtgW7Vh4/Hd9iJXrzjWXCHGjlhOiD
H0v5Q2SNLk+XzdZRzeAbHD9/7/o++XsFuQiQ8CUuEGM8LMO1VOP1RhDZXEjKehmp
em5Lf16ixSmZ2DSBuWvkqrK5kmM6ABwikzd+BJRcV53ZjmW2W8fi/HJMm7M5CIj8
eA/aFIdfS/JO/bpaZVvOAsBxOL1qf7arMoQS8HWhWlbew1TNnGru4AL5UMVEa5MT
NwqnsG6MOPHUnTDv6txD
=4G+W
-----END PGP SIGNATURE-----

--SvyA5ywaG/v2A5dH--
