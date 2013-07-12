From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: i2c: introduce i2c helper i2c_find_client_by_name()
Date: Fri, 12 Jul 2013 13:02:56 +0200
Message-ID: <1899733.ozqpzoazFs@avalon>
References: <20130606183346.GA13259@bingao-desk1.fm.intel.com> <CAHp75VeasHGariq=v005NSUTe_+e471NYbEoSzPJXcFNgsfKNQ@mail.gmail.com> <20130712110047.GA3135@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7896866.9i7YIXmRqC"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130712110047.GA3135@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--nextPart7896866.9i7YIXmRqC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 12 July 2013 12:00:47 Wolfram Sang wrote:
> > Briefly looking into ACPI tables we have and mechanisms that we can
> > use in ACPI case, I doubt we may apply all the ideas, probably some of
> > them, though I didn't get yet where to read about in details. What I
> > could say now is that the patch provided by Bin Gao is definitely no
> > go.
> 
> Laurent explained to me what V4L did and now does. It used to be the way
> tha V4L drivers did register I2C slaves according to platform_data. Now,
> with DT the slaves get instanciated earlier, so they now use notifiers
> to know when the slaves are in place. Something like this should
> probably be done here, too, instead of unregistering and re-registering.

This will be available in v3.11 in drivers/media/v4l2-core/v4l2-async.c.

-- 
Regards,

Laurent Pinchart

--nextPart7896866.9i7YIXmRqC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABAgAGBQJR3+JgAAoJEIkPb2GL7hl14ugH/j+Mw8QncwOfqDwa+NpqzX/H
16fmoTPCi2EufBs2zREShHY/20/r6fflXM6r3zapKwSTF4HLWRCjEc6MR5JInMMk
cOnG9MN7e1PJRql5G13oflXdobTCHJ/ioPL57uZ+Ub5WjLWceNW4UtSPyfPpDnkN
f8LsR/5HgAah1/dsgYOQN+ziGsiQCbkfreEoqsWze81aK3vi/Esz7Gb9Kn3wHDkZ
tA5iQ7G1GmmxiYyrz5Wij1uBvncBbLViGdPPsIP/B8Zmrgr/u2JjzBWkDzcw07jX
MH84fWqYNa+ueSbdPu6KFhJVfx+fH4X4hxX+d3Sc2m29oPzHPtA3+yiFqY8nxmw=
=ZKyh
-----END PGP SIGNATURE-----

--nextPart7896866.9i7YIXmRqC--
