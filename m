From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 6 May 2015 20:37:33 +0200
Message-ID: <20150506183733.GA1513@katana>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150422074019.GA1511@katana>
 <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2015 at 10:51:07AM -0700, Kevin Hilman wrote:
> On Wed, Apr 22, 2015 at 12:40 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > On Sat, Jan 24, 2015 at 09:16:29AM +0200, Pantelis Antoniou wrote:
> >> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> >> This is required to avoid multi probing when using I2C and device
> >> overlays containing a mux.
> >> This patch is also more careful with the release of the adapter device
> >> which caused a deadlock with muxes, and does not break the build
> >> on !OF since the node flag accessors are not defined then.
> >>
> >> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> >
> > Now, that the dependency is upstream: applied to for-current, thanks!
>=20
> I'm not seeing this in linux-next, or in your for-current branch.
>=20
> Was this dropped or superseded by something else?

I dropped it because it caused a build bug. So, we need another
dependency in... I am not sure if this is already in.


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVSl9tAAoJEBQN5MwUoCm2MUgP/RoDDlLfJxk4Ky9KNMse+bbo
j+jZ1uoOkSR7k40DA67Usk2NCK8Fn/DH8hp8qsv20IfzDZTUhO2xs8pI8VrGfvSa
pAfin1ExblMSgjxzErq5bNF74d6ZB4iuURkCtPDV+eFcuZuzhWHaoH6+VuJrZDtM
CnZiVJClG/newnX5d9Qbfj11cWznx02j1Y8durMuZS/zOnyGXEvutKwDMGnzl6Dt
lY3KFXrS7KVLm0vP2d5SHINpVEY6Xmvn206biZP9Nn8WtexiIwsG9CR0WPPkfWNF
3M2NrOdbJKCYJ22vWLaDmVA3BaIwwLSBanjTa2/fhIGVpqWMfZa2UyUWu74GcQHI
1Syu552ZcYdOa8gvlXzlGWVd01IKz7adwApDnmqUkAViJrSbLdNypIlfifq1BNEZ
D4S0WYzJ9PL6UAn54C2ThgZtoXiay0OgiH49PUkeNLkIYFJo4XylnlzdRW9vBiPl
3jUsRgWKrKeX/bjz8m/WnCI+OVOfcFjGaeQv5WWg+9JIr7Ice3UJLL9EMi79WvMy
2l+3aPkKXHXrzt5EcqhWaYcqt79hyYBi7bubr/RH32yTrN70jcfCMjNHKjfJOyd6
CSwmXLEFOhh1QH6oCHREPEKPLXHYqb34KL+/FBVIIt37cjZGh3Hs5kh+x4wKfW7e
eHNHLMab6xWCtJ1ZquME
=M2BR
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
