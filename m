From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C Slave monitor mode support
Date: Fri, 18 Jul 2014 14:35:17 +0200
Message-ID: <20140718123517.GB2731@katana>
References: <CAD6G_RRa9C0umBrR6CUF3zb5cSKKfZO7y7UPUKHjJOx41A0aJQ@mail.gmail.com>
 <20140617121912.GA2683@katana>
 <CAOZ77ogXPwXPtUxROJKT2wX=2wkZeHeWPZaBhyCnoP0zMxi8mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOZ77ogXPwXPtUxROJKT2wX=2wkZeHeWPZaBhyCnoP0zMxi8mw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suneel G <suneelgarapati-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jagan Teki <jagannadh.teki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Currently, one would have to put a loop on the address transfer waiting an ack
> is received in user space.

This is what most i2c master drivers would need to do anyhow. I have
never heard of hardware support for that. Do you know an IP core which
does that? And how are timeouts defined/handled?

> This helps the app or the user software to not busy wait considering the slow
> clk of i2c.

Currently, this is not supported in Linux I2C. It probably could be
using another I2C_M_* flag, but a number of details need to be designed
and implemented first. Would you be interested?

Kind regards,

   Wolfram


--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyRSFAAoJEBQN5MwUoCm2B3EP/3xJ/p83LP2eI3dlxXT90ZLf
x96emSpiPMwWSkO6GhTuP96D45lCeam5CIiXSohi49WnJVaAo+LMij5VruN+fMFT
Ky6bZ83+iJIzXg7b/T45hwgqhly3WnN38Ebx1coXINoCuJVzD7kxvcg8eRRJnN/P
U+UZ2vHevsNtYSqvLAHeteLnprVG4U8gCDyZWjThTectDGTdSS1biALOkxDYdWPj
pRGvnI5pzPsja/thFdMP9KfBd62XEennWpa6HimOxdqnq+0IZh/E7T0f1r9llbp6
fGRUoR2LEVfQjoyAcyDvWRdvocP9Y2ANf3aQQQSEZPjXA6e3k1OMSKm9dvzXbcJB
OpIgyn/Kqcp3CuQVJInOAwi5HoVHuo0uUlWyEnRKxUin1giTeFR1mgLTuZD8tGb4
Adf953D22+gMxgDyV9BrGS3FDVBy2ls9Y4UekHtNQw6VfD/r0PRraezlynYH0bks
sdCPT8qvo0gzOBeHRSaukDA3rwpeO5495cSjZqhSp4BOpnFrlC/x4v9b0w2fYjrd
M2UW4W9490M2Fv1EYZ1SjjI5ugxZk9XMGA/wxTVg8nzu06qW2cG403NbQtlRtb+Y
3bg658ZYKuuxMkdPGlCeyh/Ra32WiAUGCcVYMNjeisulsEMJRlHh3bIw/LY0R5xz
KbfW2P29oAR0M/YTVldU
=l9SZ
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
