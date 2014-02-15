From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/5] i2c: mv64xxx: refactor message start to ensure
 proper initialization
Date: Sat, 15 Feb 2014 15:44:53 +0100
Message-ID: <20140215144453.GB2579@katana>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
 <1392323793-4125-3-git-send-email-wsa@the-dreams.de>
 <52FE0056.2030706@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52FE0056.2030706-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2014 at 12:39:02PM +0100, Gregory CLEMENT wrote:
> On 13/02/2014 21:36, Wolfram Sang wrote:
> > Because the offload mechanism can fall back to a standard transfer,
> > having two seperate initialization states is unfortunate. Let's just
> > have one state which does things consistently. This fixes a bug where
> > some preparation was missing when the fallback happened. And it makes
> > the code much easier to follow.
> >=20
> > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>=20
>=20
> Tested-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>=20
> With this one the bug we observed was fixed.

I squashed patches 1+2 (easier handling for stable) and applied to
for-current, thanks!


--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS/31lAAoJEBQN5MwUoCm2KPQP/jCGIcbY5iaPvThIg9Oz2Bwg
3TVvfIeC5NiVx7Oa5vgOfogGq2eArLyda2AIpwo4YdagAJw8l8YZuPCAsKS+BXbY
mQC+27rqB7r4EE565lVie/ZmbmDQHTsDhGxJiwOthTw7jL2ej2Sh9X3r2ATsd9jg
vHvoXlTkM4ZgeoMdrtXaFOhJWPido8Q62CKre15CnQV4niKECBtqasNFfYqp2c9q
4nInx8GNyYaU4lJzTK5B6nWHjTc1RsA5V8fkq5CbZ/uE4+ZBlq+yz9h21rcdHtxl
4GmT6STAIX7DeQGSGgS/6iFs5Hk77mehgslSmpDyHpwyGKD7x47mwpbtqrHNWF6l
A0NTG1Y3vaKkh4ihqFohjnjgvnd6F3/xtWcrEj/7aqCAEnX2+qBi12t/EcbEJUeP
jt3npg4c0rHf9361QZNIvbw5jzU9PFlWlrX0/JrEVMxMwV3rV/AEAh/1GHdAhhD5
Qm/NTxaQpa1EZrCcdTcVcD7vpm5QsHvEygRjj8pc+Ienl9Wmdq9qZTzR2JxYBp6w
nMGNKs2cNZxvQ0uLdURpizldP1AZ0jfZWguFse4GBu9vcVO0JX7M8PmmZV+7eQl8
7rLyuVrZhxxJCTasEBdlV4I+HOVXnE/+avGWrrOw5MSLRC4yTlUNLLBsn068LE3E
4uvTWivcmcOauiR1ckSS
=9JkQ
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
