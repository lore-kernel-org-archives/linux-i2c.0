From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Mon, 27 Mar 2017 12:07:28 +0200
Message-ID: <20170327100728.GB2150@katana>
References: <1487051641-31927-1-git-send-email-chin.yew.tan@intel.com>
 <1487051641-31927-2-git-send-email-chin.yew.tan@intel.com>
 <20170323205825.w26jcbv6gz7wu6zg@ninjato>
 <20170323210048.c45uiolhdpgqfk5o@ninjato>
 <1E48613D81AD0745B344B23C7C5E26B00100E44A@PGSMSX103.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:56700 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbdC0KHv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Mar 2017 06:07:51 -0400
Content-Disposition: inline
In-Reply-To: <1E48613D81AD0745B344B23C7C5E26B00100E44A@PGSMSX103.gar.corp.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Tan, Chin Yew" <chin.yew.tan@intel.com>
Cc: "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > This describes why you change NULL to dev->sda_hold_time. But it
> > > doesn't say why you introduce the switch-block instead of populating
> > > all fields like it was done before.
> Instead of loading all speed mode settings, switch block is used to load =
the=20
> required settings for selected speed mode.=20

Thanks. Please add this sentence to the commit message.


--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY2ORgAAoJEBQN5MwUoCm2Z+QQAKtN3viKQCJeyx4DRdk3aqJb
9TsO39ZASnALyYLQRSSiVPXM0Onk3O8ZcXDtqxaKYzrVVDslrYqcEtp3QkI4q3Od
FMPHN2r1mtwCB1aHMf5EECgOXqlfAEB61TwlqGbp736ellmZsNkFs0yVpQ7L8QXu
WKi6A6UgRMnQ78vbUbyqpLIocT4u1GYGq/+TiGFnMklTkiDkOqAjXL9ynRW6/Sro
2MnIl480FjcLnyJbS1OZPuyupvvk0ztFoEXtktxZAV2xBHt6/e5fWgmTly6W+BpM
Lazd+QBPS9ZZN+RdkVIBEo7t069YLcnno6PfWrLcRvmlOEQr3t4zOlvdMF/thT8M
/o8YbpzlUrFOw8fXDizyRzQOqTsI/sR6ink7iW2j4LgFfbppXGzG5f1+kgsgF1nD
kR95FUFwIgMab0Pw65xW2oMB5IdshGZU8wACUVmdBS8/XtA10P4TW6ulbueNdl3A
xNGye2Cvrz6ScXp9LTMKsYuKtLs6gqVDD8Kd+vmynvsXcEIz+D2qTVbZd02+7MJz
CmfyBgoqmGnIHDPiu7JsjbkVhs1JZwu+NaVftqGW7DaKZIa7+IUX03uhwj3u+Ul9
+DS6YMbqRaCuh1raWpOrP8ZeyN9CbtNHXnvhL7AQnW+/wEqRBDJ+74IYb83b6Ikx
ofTmxwkk4hnJRNFvtDzI
=um/6
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
