From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: mux: create "channel-n" symlinks for child
 segments in the mux device
Date: Mon, 1 Dec 2014 18:26:05 +0100
Message-ID: <20141201172605.GD3212@katana>
References: <1415885996-14770-1-git-send-email-wsa@the-dreams.de>
 <1415885996-14770-2-git-send-email-wsa@the-dreams.de>
 <20141118151204.GD30004@katana>
 <CAAVjN7etzqy7tum5yboVErhWZ=VhKy9c6UG5xMMTihgjG9ZDqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAVjN7etzqy7tum5yboVErhWZ=VhKy9c6UG5xMMTihgjG9ZDqg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 29, 2014 at 03:29:46PM -0800, Danielle Costantino wrote:

> I know this has already been applied but I wanted to comment that on
> embedded systems this patch increases the probe time of mux devices.

In what magnitude is the delay? And in what setup? How did you measure?

I have doubts. This patch just adds a symlink to the sysfs filesystem.
sysfs is not needed for probing.

> Otherwise the patch works and provides much needed parent device
> information without breaking the api.

Any news on lsi2c, by the way?


--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfKStAAoJEBQN5MwUoCm2BccP/24b6h1CG2richcYFYY5bi2L
7Dl7E72S9X9p/ZIq0mbgUQwsWaKLvEFOyFbtKmQi2k+6V2bD2ySsCXIyUoFhxRsu
Bnff5U9nWV0+u0nyfeEK07oNF2x4icaNU3fg04+Fcp5StYevIJ90aBJZB4HR3TEe
cEnM4QUm/F6nx1D8DaLkC7ocMtfEueMEtIFQB8f9FvbLUFCwZUzSdCaWMEoO4X4Z
BkwPQzfiamsJobIAQQFhkTBGfRtpRZ9qUoBoK9fEMuSJsTmm7X1Nd7dTEKuPAB8p
6tKr29hOEVtwVJFrcBe/tCJtP5xxKwk2yYJH3KD1XIYCSVZGvUBYMWu803ZN/EkM
XGwsCHU8BxSQ5xKn4MGZ6DzWszm+HKgCH+Pmc5e3rTm3sObBUMVD2LrHtdsIrMQe
Kg4uxrrTj3p40dvD2z1YC+fttSOZN8dgKP25NYyAZXGqq1k4TouBua1yfl3XAWni
2WHHo4bX1abTcpf6FlfVgfdcB+uAoZdqoiayNMek49A3jrdgY9gLmAAVdqfwNMzb
migwlxV8kMG8M2ha0o5a9Wt0ZPsLFFkZz+FA9eZOiW3CP1FVwVADvb+wLGPzpKxA
ZO02og+FCaa5zRxXgjJZbLrlK5V9rQ4zvkxWbFDFoQYCJ/inQBZswJ5jqRlAYEaw
VbaMfc5ikivFglkCQz09
=QZL8
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
