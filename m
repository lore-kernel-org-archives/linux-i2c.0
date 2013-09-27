From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-dev: Create 'name' attribute automatically
Date: Fri, 27 Sep 2013 18:22:12 +0200
Message-ID: <20130927162212.GA3094@katana>
References: <1380249371-32430-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380249371-32430-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2013 at 07:36:11PM -0700, Guenter Roeck wrote:
> The 'name' attribute is needed for all i2c-dev class devices, meaning
> it can be created automatically by pointing to it in the class data
> structure. This simplifies the code and reduces the probability for race
> conditions (the name attribute should exist by the time the device is
> announced to user space).
>=20
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Applied to for-next, thanks!


--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSRbC0AAoJEBQN5MwUoCm2vy4QAJx7ILRZ8udDN7DE3IzilGTJ
4PdDFojjBYh+2uwv2Eih3YKQZ+x5zQ8OrP3y8PznAmdOR5TABI5lubOk3e1QAATB
6hMXLryYe27q4WPRjiCw1PWHbxx0cD29XOfVEQu6q3Lz92QKiiKUXdikpii6+eXs
fC5ThyXxdUdwmjm4CNWGu5usDGRrYi0eO4jklM1O1jkKHJAnkXxDfRSBt+ZHMAnL
CBTPsRgcA9WBKllGRYLoVNejzp00vE0Nt+LpkTXTe0oBujiBxf0ElKRYJi3pdrbe
SoupflZcmv2//E5FTyPNWygyNTTD95W8e9Q44oVt6NA1djehp9r+FMYmL5CzCNnP
8gaQWcUby0LaY+Wj+GnwU75hUbazrBUBAn8+u6x+JCHGWeUXFHs3ioZBigsI/iCO
N6OQic8+RP+P1wm6MKsS+gaswgg1dNKQtS3ou3HJXcWXsaTZwYap/CxyXdp63138
8J/w4+dezRmUjl39GVl+3V1aEgMqd+IraOr1Vn3YBup1l9vP4N8/qNWELebktyp5
nIHqxM+6l80Qb0CCwORO71mn6Lv8+UHMbZfNhMmoEcla76UvxeIYkO9QHA35i2Fb
bQm0GvaHD9SGCAo+T8yxUz2n5TBdobzcfB01itzoZCNkzhsbJd95pykZpO+W1wTl
Pn2rndRX+XQxOfgDctsK
=EEFQ
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
