From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: axxia: Add bus recovery functionality
Date: Tue, 12 May 2015 21:12:11 +0200
Message-ID: <20150512191211.GC4449@schokonusskuchen.bad>
References: <553F7B11.5000204@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <553F7B11.5000204-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wilshire Jay <jay.wilshire.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Lawnick Michael <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2015 at 02:20:33PM +0200, Alexander Sverdlin wrote:
> Use recovery framework and implement bus recovery using "Bus Monitor"
> register. Tests show that shortening SCL to GND results in "completion"
> timeout with "BUSY" bit still set. So initiate recovery in case of generic
> timeout and "Arbitration Lost" condition.

So, how could you verify in this setup if the recovery actually worked?

> +	switch (idev->msg_err) {
> +	case -ETIMEDOUT:
> +	case -EAGAIN:
> +		i2c_recover_bus(&idev->adapter);
> +	}
> +

Doesn't look right. -EAGAIN means arbitration lost which is not a
condition to reset the bus in a multi-master setup.

Other than that, it looks like a nice example of using this framework.
Just a few little helper functions and the core will do the rest.


--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUlCLAAoJEBQN5MwUoCm2f0IP/337AOt5zT3q+/3wVcqta9Ga
qghw/eDYn0+ys3bcm5YHGR/7bXGS/59YjiXKIN/2zcv6ofasNgVec0RtKx6E1xsU
T8tBscvfh37m+B+qCx62KjawH+o8JTwcmjie/HnwtEkyc1IxLnWpiJGfhzIyaaaX
UyecE1L1iLu53iVs75P3BlgXAIsxIMkyX3QEeu6Cj0K0sbeHPSjARCTlrFwwBb27
9/5G4V5TIzT64DPZOFKmzCUWTCLA1YdHdW1+HDFHN/+GGuFoUSCeRaw6ugkZ9oz/
vsYs3Xwp2Ylmpl9qDhJoUM9u8wUdSibMIcJaty/LBB8V9R2it3id9cIcN/wAehsh
XDcJNYJWIKYXQFBS3r4/9RNWURc7h2Xc8+wlqiAxUejrrqYvRzO+mJqNhduy5mkM
NeRpjJh6fS1lNTnIAgf+VNZZYQgvZb9tNrgAEL+5TVNCgYcUpNODYDraU3cDjfMJ
n6FurnNQMDXpzM3JkiEORax+vPC4UJH+ZUcxR4MXp0bKUyrYHgXkkdsSnpWUBPu2
Q1i3kavK/++7RFYooNulVMjffEE80UjF62T7FTr+SUcXjcA8IaaQbxeKdBYDwqjQ
OGnWueacRuguoRGJgN4MgdFwgHAyENPbaMPHaxOjRgGwhoSGst1icjQ9ow9w9epF
OIIOqnpcJG+QBoO3kTvJ
=Zqnb
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
