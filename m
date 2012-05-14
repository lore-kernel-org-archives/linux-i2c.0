From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Mon, 14 May 2012 17:39:15 +0100
Message-ID: <20120514163914.GB25668@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FB12B73.50302@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FB12B73.50302-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 14, 2012 at 04:57:39PM +0100, Lee Jones wrote:
> >>  	pdata = dev_get_platdata(ab8500->dev);
> >>-	if (!pdata) {
> >>-		dev_err(&pdev->dev, "null pdata\n");
> >>+	if (!pdata&&  !np) {
> >>+		dev_err(&pdev->dev, "null pdata and no device tree found\n");
> >>  		return -EINVAL;
> >>  	}

> >Neither should be mandatory.

> Unfortunately, this has to reside, as without it I'd have to
> re-write the driver. Something with is completely out of scope of
> what I'm trying to achieve right now. It's something I'd be happy to
> do in the future, but not in this patch-set.

Why do you need to rewrite the driver?  That doesn't sound terribly
plausible...   The normal approach to this stuff is to allocate a
platform data struct unconditionally, why is this impossible in your
case?

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsTUqAAoJEBus8iNuMP3d7EoP/22b8XAlcdETBPsi//YPkRzC
O1y7++zunvr/JUckzKiBu8kzauV0vcIkI1JP5+DkHn0cjmWJlf8MNpbLpn02+PaF
mj9kMOtg+msqYaypQtJ8EdDRkErI+XII54/Um8e2WoWibssGfrpN4vsQliU0e9zq
ZdY6IIdD+pV6amJMyUk7KFoj2KKLMWbbXATGQ30t9sd3yFer/wFaC1vwBNXRbBFB
6DhKk4I3HTvoxHeRS8y9nEvaFwY/Pa7ya66JFrE/XT4RGiUp0JvpuRljQ3C/YgO7
2bQQGE8Tw8OJ5HfI0SASlW9t58X4qBDKW+awxSHt0UTo8a5zU6Ah8mc2CSfvlepS
YTzrZWeBQ1WeE1jXIfGb8Sn3xzlxAsW+bJiO4yQjfLlJr5kALvu54+3Dt2SO9JcX
sbIXGaqS5cS4IZocSoX+LbdBpAbBHxgwJQS14zUhujdeJivT3KktKv4r5xB6pYXS
8gqD+Shn6huTX7Yk4GGhadWoFxwKelWmYKlNG9XPyBBFf4iRUxD+yD6ATT4N3mC3
aq07jYugg9+rb3LGFjuhSfSM4A/2Y4vCVUFAP9CeyDoHCyZk1JFMjduQ4tbem9xa
qHEY9Q0YxsQ90OLiaMoWKSlMDDbamFzsZhI2/r45jE3WGyHVPfK0C+7U5IqfUHli
QVp2LViKd2vCpG6Vo7kS
=mA9R
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
