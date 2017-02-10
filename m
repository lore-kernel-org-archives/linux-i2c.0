From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 0/3] i2c: mux: pca954x: Add interrupt controller
 support
Date: Fri, 10 Feb 2017 13:52:07 +0100
Message-ID: <20170210125205.c2gzgi65x4bi3eys@ninjato>
References: <1485307868-5408-1-git-send-email-preid@electromag.com.au>
 <8a11d374-a9f9-0e58-d01f-1cc72827c5e9@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fbsxif2ils32yryv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47341 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751430AbdBJNqT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Feb 2017 08:46:19 -0500
Content-Disposition: inline
In-Reply-To: <8a11d374-a9f9-0e58-d01f-1cc72827c5e9@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Phil Reid <preid@electromag.com.au>, linux-i2c@vger.kernel.org


--fbsxif2ils32yryv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

> initializer for the 'handled' variable. I amended the previously
> posted fixup and was just about to send you the pull request when
> you started to add patches to i2c/for-next.

Oh, sorry! I wasn't sure if we agreed that you send pull-requests for
v4.11 already or starting with v4.12. And since there seems to be no rc8
for 4.11 I decided to start pulling in.

> probably not happen (anytime soon). I'm going to short out the wait
> and just send a reworked pull request. See below.

Perfect!

> A few thing to take away from this. Phil didn't post the series to
> LKML, and the kbuild bots didn't find the series until I added it to
> my i2c-mux tree. Fengguang indicated that the kbuild bot will now
> (or soon) start to track the i2c list, which might be good to know.

Well, I asked Fengguang to remove the i2c list from that feature a
while ago. People send out RFCs, debug patches, etc... and for all those
build bot reports are just noise IMO.

Build testing plus sparse+smatch testing for the patches when I apply
them to my tree and then having my branches additionally checked by
build bot works well for me. I will happily share my super-simple
'ninja-check' script with you which runs various code checkers when
compiling. It is basically adding "W=3D1 C=3D1 CHECK=3D'ninja-check'" to the
kernel build command-line.

I hope you are open for this workflow. But we can discuss, of course.

> submission. So, from now on I think I'm just going to change my
> acks to some message saying that the patch(es) have been added
> to i2c-mux/for-next (in case the submission is clear-cut i2c-mux
> and not at all about i2c-the-rest). If I just ack a submission I'll
> expect you to pick it up. Ok?

Perfect!

> The question then becomes at approximately which point you'll need
> a pull request? Or should you perhaps be pulling in my tree
> on a more continuous level so that everything i2c-related is
> available in one tree (i.e. your tree)?

I prefer pull requests a little bit. Then, I get a consistent state
approved by you and already checked by build bot. BTW is your tree in
linux-next as well?

> sign-off when you pull? It's not a big thing, but all things being
> equal, I'd prefer the commits to stay as-is...

Sure thing. It might have been done automatically, will check and fix my
scripts...

>=20
> Cheers,
> peda
>=20
> The following changes since commit 7a308bb3016f57e5be11a677d15b821536419d=
36:
>=20
>   Linux 4.10-rc5 (2017-01-22 12:54:15 -0800)
>=20
> are available in the git repository at:
>=20
>   https://github.com/peda-r/i2c-mux.git i2c-mux/for-next
>=20
> for you to fetch changes up to f2114795f721bd5028284ddf84b150798a9b7a73:
>=20
>   i2c: mux: pca954x: Add interrupt controller support (2017-02-10 08:23:5=
1 +0100)

And pulled! Thank you for the work!

   Wolfram


--fbsxif2ils32yryv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlidt2YACgkQFA3kzBSg
KbZH6g/9FKYcxWUOFYiCnUxxGwUVTtLgTt6cLrysQV3qzOByi3uokUhjNosuBpmM
/kwIYNUN05x+DyBl3u2fkGdOlptxbb2QWFoynJJmHdrOhbL/3A9TzcHssPVUQodf
Je9skpiWr6sD8zkCiJ3YxcWwkfqZj39dAuMXIJ0MnrRgqO3g+tvn/C9N9ljf40gm
xCdxZWfO6WQT2SwyNlHVNSHBhGT2zz4CpENRRC8JtGlY3gBKv9kBjRNR8LlZVVet
frrdSkSBbFwfiHljA4rkASx/ONnTlJ76V+IItmOsZiEisNELb5RQHsyFnL3Mgt9C
9+U4vrjICg7Lgn1Z8hZCQ9nblcwWBmk+kFD9KjfCrEKxVO/fjKV1Fh5zEwRv5rCr
S1xutKh3sXBc0klw709MHg1yPBUtITC/TaDowJrfbvE1XC7PXRM2btWeE4BSD3F+
YUVU5508md+iKLjv6W2yF8uOVadZqV1Qxve7vaMWxOTt8EQNkykBbwO/3JJteK/F
xLKy3QUVfo+HNE28HUwTp5kY4e45ovp0Ipgv8O7oAIwV42s+DN2z5+txAYs8alSR
/PYkXLF9Dg+siZZgsBGwaTQ4mSK0g0LFojgACuCAEJlMYD7QeOj3hVaH1Owa7HD5
H/mKsP6b0Xzzyne2RW+VEj1n9DEXFNMRh3SZ6ofugimYwCu6Ke8=
=IxwS
-----END PGP SIGNATURE-----

--fbsxif2ils32yryv--
