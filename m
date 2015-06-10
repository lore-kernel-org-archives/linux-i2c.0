From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Wed, 10 Jun 2015 21:49:49 +0900
Message-ID: <20150610124949.GC1592@katana>
References: <1422083789-18905-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150422074019.GA1511@katana>
 <CAMAWPa-HMhJK9UzwfaMPe-MO=4mzjvC=nRwPX-pbab_fb3YZ9A@mail.gmail.com>
 <20150506183733.GA1513@katana>
 <A4E060DB-2799-4BF5-9CA6-DE53B7DF9A30@konsulko.com>
 <20150610054034.GB1573@katana>
 <CAL_Jsq+xTZy3QsdaXieR8LSVEJfSeehtcytZLOyt7ghTZ=Bcxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+xTZy3QsdaXieR8LSVEJfSeehtcytZLOyt7ghTZ=Bcxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2015 at 07:42:59AM -0500, Rob Herring wrote:
> On Wed, Jun 10, 2015 at 12:40 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >
> >> >>>> Mark (and unmark) device nodes with the POPULATE flag as appropri=
ate.
> >> >>>> This is required to avoid multi probing when using I2C and device
> >> >>>> overlays containing a mux.
> >> >>>> This patch is also more careful with the release of the adapter d=
evice
> >> >>>> which caused a deadlock with muxes, and does not break the build
> >> >>>> on !OF since the node flag accessors are not defined then.
> >> >>>>
> >> >>>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> >> >>>
> >> >>> Now, that the dependency is upstream: applied to for-current, than=
ks!
> >> >>
> >> >> I'm not seeing this in linux-next, or in your for-current branch.
> >> >>
> >> >> Was this dropped or superseded by something else?
> >> >
> >> > I dropped it because it caused a build bug. So, we need another
> >> > dependency in... I am not sure if this is already in.
> >> >
> >>
> >> FWIW, I=E2=80=99ve posted the dependency patch already; it=E2=80=99s t=
rivial as you recall.
> >>
> >> Lets hope it gets picked so that this one can go in.
> >
> > Is that in now?
>=20
> You mean "of: Move OF flags to be visible even when !CONFIG_OF"? If
> so, it is queued up for 4.2 in my tree.

Sorry, I lost track of all the fixes needed for this one. I also can't
recall being CCed to them. Pity.

IIRC it is the one which adds OF_POPULATED. If so, why is this not
scheduled for 4.1 as this bugfix depends on it?

Pantelis, thanks for all the work yet I must say I am seriously confused
with the handling of this patch. I thought you wanted the original I2C
fix applied asap?


--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeDJsAAoJEBQN5MwUoCm2syoQAJByW5edVNkiTLmExWPw74RF
Ifwlmy2wyyNvauPhDDeCnfQelF8kAgUQ0QOi15hiO3f6f4ZUjW2uTusrFHONsG04
XSQCWT2iyk+VyPp8tgaFS1ltb4zD4zU0xun24dqhJ3BPH+GDJ57WnSjndQA3Jlim
qFjNAZcXdMPQORhkF5itlqUwh0LqJn/1VvX+SRSbEnPG5gJDJklikfDDYBXYegA3
mTunKBWKCX7d+BZsSHJdrRy6JPIHseUYmE+8WmFtS6kAEolBIKx3uqKYIo8EBLQK
PoLMtJeQsk9RAdG7/JdAL2qZYc98EhC9hUSyu5R8ZlFJVH87dIQ8snPgmMy/Le8G
rdhvD0pKW+rArmtnCdLKUsV2V7Dvm4FdJEBTXC3pWxlFk22zkn/sdBb7u2sm1LaF
29AHyjOACuXvg6ilCGtz0s+2Ni8snTTSOF4+5fKCcIOYukya3wnkq6Nxfvm+MI4k
TQDTk4Uj7RjFfFxsHtz+PGyABbxnAK/qXwsb6NHs5L37gcYqZgQ3sieb0F9kQhxB
+tB1cILo8vrfhyLTZ0jYGkJoHs3p1d+e5+ss6zRNv6UhFM/xC3vDAF7GzyxOnTlq
O7x3oOhBzn+SzrhmZpqvWuDlcBn8wGyqOTfl/YruNJRb0dlND8kJucfbIiGvw0A8
uyjj60U6C2CRg/MqBrBe
=z8L9
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
