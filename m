From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Tue, 8 May 2012 13:19:41 +0100
Message-ID: <20120508121940.GL15893@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FA90BE1.3050304@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FA90BE1.3050304-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 01:04:49PM +0100, Lee Jones wrote:
> On 07/05/12 18:08, Mark Brown wrote:

> >You should be using of_regulator_match() for this (I think it's supposed
> >to do an equivalent job...) rather than open coding.

> of_regulator_match() didn't exist when I wrote this. In fact, it
> only made it into -next a couple of days ago. Besides, it doesn't

It's been kicking around for review for a little while longer than that
(it was waiting for review while Rhyland was on holiday), and in any
case half the reason for adding infrastructure is to avoid adding
repeated code.

> satisfy the needs of this code segment. of_regulator_match() is
> a(nother) wrapper around of_get_regulation_constraints(), which is
> only used to populate 'struct regulation_constraints constraints'
> after being provided with a selection of .compatible strings.

I suspect that what you're trying to achieve isn't a good regulator
binding but I'm not entirely sure what you're trying to do so perhaps
not.  You haven't documented the binding at all which might make things
clearer...

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqQ83AAoJEBus8iNuMP3deq8P/2m3DooUlm0x1B96oxyX92fE
QZn+ys1LnPkDMap7m6zIIEQJuOL2NWQ3bTJJOrZ7WZM7N6CwiKN0iQHqqvR6k4lr
m67PRn23Tg/UObrVkRah9tDM+NFkzTNEv3ssbEOz27Ew32+n7w6uwSG+A74/rUgR
WcrC58zpLkADGg/9gWCNuJYaqhgrEoCp6a1O7yDo/3FNc2Z/UTzucsz+16wTieR+
Ilo7gxLO3u+7g62QCLVluSwql35SlmF8LpsSJcmpMsN8fJtl2PgwsdQ0u82voglg
GonB+T5Eed53P1vk42Ro4u4A54O5pmDbosb7mNarW/iHKTPS1h82+Yr6LcT5Mans
x+DrQUlsC0t1qT2o16vwUhfRmcJsjucCQNTUsEkJw6mEHtLMmEcvqcnvgnnu1sZw
0az2ub+NETs3ErntpnXyFcHYvzRNfVRoeYl2Que2nU/rdwbegtKlDkb+8uij17nc
fwN8RLjcGE+VhUd9nAR4/V6HTb6cL+OLNc4Pqv/K6RDz39d4rVhtdWHBydjJ3Hps
eVOTKZl47dFEeQAiDFYIbVoRfj+LejU33LpXHQXMGQL8zZ/6/L/0YrWrdm/e0GhB
dgROe21SRjoAk0uWMQiu6xY0TChIpIWdI9mg1ooqgcx6bERCC7vdCE96qZIQrFcV
9/UREYkF4nZP4yx4tHB5
=uQHW
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
