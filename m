From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Fri, 4 May 2012 13:58:30 +0100
Message-ID: <20120504125830.GM14230@opensource.wolfsonmicro.com>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com>
 <201205031459.25262.rjw@sisk.pl>
 <20120503133907.GG3955@opensource.wolfsonmicro.com>
 <201205032125.37631.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zROEGoKAXsG5UqGB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205032125.37631.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Rickard ANDERSSON <rickard.andersson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Rabin VINCENT <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--zROEGoKAXsG5UqGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 09:25:37PM +0200, Rafael J. Wysocki wrote:
> On Thursday, May 03, 2012, Mark Brown wrote:

> > This seems like a really useful idiom in general - might it be worth
> > supporting as a standard framework feature?

> The generic PM domains framework does this, it's not platform-specific
> (if I understood your question correctly).

AIUI it only works if the device gets placed into a doman, though?

--zROEGoKAXsG5UqGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPo9JvAAoJEBus8iNuMP3dLZEP/1AH4Pbawgj/cL/V4u/lSXGL
R5Hyxbw3UeXCmrU+pAQeHWsrhCjN0CXicBSzooD74zmlKhR41cYvbPYExKRInUTP
syaCn/x6WqaH25+kMwlb6WQOLeu2RaNoDMtVl7biVz+eg0vPmmtpGxGLNBn7QVNz
+yEqS//kav7S3xpYXKgy/IDMCMwCNWc4Y8ApY1r4rHXHUaOwjRlc+DFBeYiGiMvM
c1sTrCexEUZZlslM1EtksPm3gmkg5O19som3AkIk4PQWRa9xCVu9AQ/kHnzFmKOn
qKeCKa0KAgVzGAOZvMVozS2MpKt+3IRVRHzlR8INJBR+SQNSvZBFOx9//IFV3leR
JsfhFCqRF6hiR4bOFd0s2FcXjrNjwDuAbyDPSAH4eIyDJ8FOdCeVt5FVy8QNYf0z
xmNAE2tg22do6RiOt1hFMBPusxJJkn8TKATSbuyeTC9tWOwEHDtopqKYvOYoJ0ea
8Sptzy24qLtV3fXw9WNrBZgY+wtdyieIT2q1Ehuy+G9zeAHnalJD0sIC5+TAgx60
Cm2fsQh1V2q2f21eaxfFxIuyAK8XDW2DAZU89jMhXFFak6ntlzpFcAKCF/DFkMOh
dLv85e9DYgpa7IZLrMBly2NrAmSvob6tcr0kGkdEkC9YJUNWh6IB8e1FzAEckQsh
7fS0Xiln/fi7yQnOJuTv
=kjaT
-----END PGP SIGNATURE-----

--zROEGoKAXsG5UqGB--
