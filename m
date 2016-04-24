From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Sun, 24 Apr 2016 22:14:37 +0200
Message-ID: <20160424201437.GA2123@katana>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
 <20160415080111.GD1714@lahna.fi.intel.com>
 <1460992811.8946.22.camel@linux.intel.com>
 <5714FCBE.3060009@metafoo.de>
 <20160419124028.GF1725@lahna.fi.intel.com>
 <57162C4E.9090904@metafoo.de>
 <20160419131631.GG1725@lahna.fi.intel.com>
 <5716333D.1040106@metafoo.de>
 <20160419144027.GH1725@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160419144027.GH1725-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean-Michel Hautbois <jhautbois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Jean-Michel Hautbois <jean-michel.hautbois-JiVWUdsMzBtWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The above should work with both DT and ACPI so I'm OK with the current
> patch. We can add ACPI parts later when needed.

Just to make sure, I read this as an ack for the original patch?


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHSktAAoJEBQN5MwUoCm2A6YP/jv9Z6pHjkrxQTlgrMGqq+DQ
shbwlymDIo9zHPpZ+qclW2284O6Z4fA40smaDDS4MvEzKNaGX+Gkg16kL9QyhgkS
fV2kEnNZSol//UpyE7F84tPz6PYlySubkV3xBakjuj2YTN21xXedF1AldTxlO1vd
Xe3CLBvd+dMPVbqNvgvQ0ntueG4rDcDXM5RM0Rp7M8v5ss8YOU2HORICP1VrEK6h
0ngK3SN2FOMAg6Nxzlb/t0W5QSLed2GEWB45HSJSudeM8bkuPDpvtbrajZRS48e+
T6ic4a//7uNV/36KTp1WzadKpUW8S1GwzK+5onLChd29PN3hW0nRKIS0M1IBO8c9
EZlZWShrzhw/LfroybD/Xn5Xu+POimov2cCKQI2UPk87Pdo53QfFCbetA++obMk4
MBoOE3yQERiuzESPANpc2NkFg5+vw5F6p7ZZ0z3Cz/Y3lmZX8YrxXgybLPv5gtL/
DzBCJwZ+XqHsHRV5/dLxNGO4RLI+UoAlzACfi099bL17ogTYcPQ7hDzWA1A/P9+F
1ZyX93empAkelZR7x2dxQXxG1OjEvRPPRPFwqWx3V7KhXXgJolr+yEYYKE1XWLzi
wBv2KPe2zZ8c4ZR9+2amdlLCKMaure38KOxA6mMYAgDOlfzAU9T/gyFZe9CJ1kFP
AGC0uD1uxoJWUXqjstyp
=ZNi4
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
