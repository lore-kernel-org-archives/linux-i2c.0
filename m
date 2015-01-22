From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Thu, 22 Jan 2015 16:02:43 +0100
Message-ID: <20150122150243.GI3413@katana>
References: <1421346798-17148-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150122144818.GG3413@katana>
 <CAL_JsqKEBYwX=5zgWbdVRxm-H-sFiDa9rAp26BvuKNECoNW=uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKEBYwX=5zgWbdVRxm-H-sFiDa9rAp26BvuKNECoNW=uQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2015 at 08:58:36AM -0600, Rob Herring wrote:
> On Thu, Jan 22, 2015 at 8:48 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > On Thu, Jan 15, 2015 at 08:33:18PM +0200, Pantelis Antoniou wrote:
> >> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> >> This is required to avoid multi probing when using I2C and device
> >> overlays containing a mux.
> >> This patch is also more careful with the release of the adapter device
> >> which caused a deadlock with muxes, and does not break the build
> >> on !OF since the node flag accessors are not defined then.
> >>
> >> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> >
> > Applied to for-current, thanks!
>=20
> Ignoring my comments? It's not a big deal, but Pantelis did send out
> the DT patch necessary for my suggestion[1]. It's needed in another
> place now, too.

Not sure if I saw this patch before...

Is this DT patch targetted to for-next or for-current. Because this
patch is a bugfix and needs to go into this cycle. I'll happily apply a
cleanup patch to for-next then.

>=20
> Rob
>=20
> [1] https://lkml.org/lkml/2015/1/21/602

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwRETAAoJEBQN5MwUoCm2PiMP/jimiJkge0pwpRU0CFMwWTX/
AoNYANxg8L18KSR+yGdeFHr+D/ubzRd4MsgF8XUBM4Ysg7KVApKv+Y3Zp47UkZgH
rpkAFLTXu4870SkmynpGhDF5gGKEpcPCAiqm5w7dUeHhWTLJ8+Y5SjVMSCl4+osx
8VXqhhaL9Em+pprcePKeJwsRp7J9g1K++wijp80O1QvcRpzl+wJCyphCZR8A493+
HTbyQh/YUENlMiTAJhmqqXc1/XDlz5tRLATUcY3a7gFpLj37+bSQXng+AI5OtMDw
OUXLsyulJM01BZRQL/bH4ZEsxF8iAnVZOpSeUz874lufoXB/PIYoFlCOXEnwX9ZV
zBZyzCbqEg7k7oKe9zFOsTUILo+I+o4+Q3hZq2iCkhwh14XU1seH4UWpvxp1YSAM
he3mXN6PlByBqTmFRUN6y5PzzH+xoYlD5f9qoeQjQhRWrk4SKPHULgwJZF2r38yP
tapdk1xDciwoFx66SGusXAxzmfhufD/RH0yzEra70gwV0Um36MPxgTl86qQxNeZA
FFfC/I5hSQdGdmJBvFpQ+LdKIHmzU/3oCXXaJ0gxsWanibzQyVrWH5OMWi5h1k1V
Rz2uW7ab9Sf7YqKtXhFr7o1/hASjd44lrzd6d0iLTy5k/UZm3tL5aOqkbwcaDfuZ
OUHACk0QLV9si78oDpAv
=5rR5
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
