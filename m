From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] of: base: add function to get highest id of an alias
 stem
Date: Wed, 18 Mar 2015 13:46:31 +0100
Message-ID: <20150318124631.GB3580@katana>
References: <1426177093-26820-1-git-send-email-wsa@the-dreams.de>
 <1426177093-26820-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426177093-26820-2-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 05:17:58PM +0100, Wolfram Sang wrote:
> I2C supports adding adapters using either a dynamic or fixed id. The
> latter is provided by aliases in the DT case. To prevent id collisions
> of those two types, install this function which gives us the highest
> fixed id, so we can then let the dynamically created ones come after
> this highest number.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCXOnAAoJEBQN5MwUoCm2oegP/0XwIzZWTdiQJRkOZnRPWR9s
2RsaQ3qLeQhuPveezpztlTLELunG2Gd/tzr6Jg6wY45OxC4VJEbrAsh+3r226Iac
WmSGnxWiGyu+zXMg6HGGhglSd75Q0Z/h8qIHtb77phw4c+q83XHeGdN6bjIZv3ED
q0AtTYN+r8Yikd29xqCyEZXoyghqSacjyjkIN/s0R8Eka9QBVRDUKMKcJQt+IoCZ
FII2SD/X7ODKdR6SJZSIR89B7jFhIPFuBeHLFmhaKD4YRa5LOSkJjl8XxdlmLiNn
aX2US/jbKpCaqG8jwegOjV/BJHRzPB7hQDd6xbL7rm/3H2IhJCbKFAswRDGag3DM
NG/FnDK8bHXtatbemfXW1oOpa3rLbtroXTwtlI2nz/1xCA6RJTL0Z+4w7m/tmgP2
Op8Ngi//dfk0HLIUTvUyY09vQyP3DRDVwWl6cdjcebTAHrMzGYeCv+1R8n1lb/qt
7XkBbmyI6meWprfd2OVKgAFw9Y3mhI9B9h2cG9CysTQLfZblGmTHSKKtUN/7txLg
JQcOimi6jzhHjAyKH5DHMr6UcyJE+RxLDvM4KWF/1OYfRqIxZt+s8HM7uIxAhdV+
tz/h7HV/XSna23yG6wLp75mKqiJur/uxHv60xjll2Q9sDRbm+z5CpiAkjdLR6+6O
p2nPBmSkeTXh2T7sVM7T
=ZQN+
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
