From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Another problem with I2C multiplexer bus naming - solved
Date: Thu, 12 Mar 2015 10:44:23 +0100
Message-ID: <20150312094423.GB4225@katana>
References: <1426133507.16219.YahooMailNeo@web181502.mail.ne1.yahoo.com>
 <1426136151.37151.YahooMailNeo@web181506.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426136151.37151.YahooMailNeo-XYahOdtEMNlRBbKmAC7my5OW+3bF1jUfVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 09:55:51PM -0700, Bob Feretich wrote:

> I tried some random things and setting aliases in the dtsi file solved
> the problem.

Good.

> The use of an alias to set the name of an i2c bus should
> be documented somewhere!

Well, send a patch adding some documentation where you would have liked
to see it.

Thanks,

   Wolfram


--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAV/2AAoJEBQN5MwUoCm2SnMP/17n3EswBBafNqIeBjlSXlMk
vTBuFMm9gtiby4mcwwhjIiFi714RF+PdEKEHW99N8q2Tn0ifG5I9vAkKuzcX8H4A
csYcn7xAOmIZ943O/xQM2yV6RdrmwUtvcl4IfHx+Q2HB82tDz2UGPn+I/rGOFYPm
e3fk42YaItqG9jYgBVcXRVau/qtqQRHuaQOR1LioDqF66RaFll411nwj9ng0geSj
zDxy0cqO566EFw/ihmA8n4/aYrMJckT2b9R5SxVlyO7bAzy5opTPuHSlXk8w3FnU
B0Mhh6fKTlqYgYvYGa/fku5DMvXjgR/YiKXUdCRhH2Xm9V+G3X/fwntD0+1F9Ijk
tZhL6blEXpRLY5tryYWo9fAf47z73xtrsaBrOdywQXaoNTEeKYL+/Gf8Aw9pt9m/
1InutFe2oQGtvuOe/sooDkCFm0eVEn5tiAMePW3JG3rYSaYxWc+zR02aRxX/5cYV
GbngezQvYBzHhlwGTJ8wryO7MtEWpjhjdUz9MUm1yizGtF/9rgN999QGBVD63IfD
dFOTTbUv0jjajVGD+fxBb0VJ6Pc/Z9KJYjpkbN+gA+LH1R9HUhI9wLetj7n1etvo
tdUoHwKT0mULAaPcZ6+MRzyKPhcl2QaE65W4Rf4xXccy1NNmYd0ILqLsUHZMDlCm
9HFXSsE5oIOk+B8xCmNk
=tDno
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
