From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Mon, 14 May 2012 19:06:20 +0100
Message-ID: <20120514180619.GH25668@opensource.wolfsonmicro.com>
References: <CAF2Aj3gHaha9mO4gKf0ReQc-wR7wpomf_9m59AfAUNBr2fLyCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF2Aj3gHaha9mO4gKf0ReQc-wR7wpomf_9m59AfAUNBr2fLyCQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 14, 2012 at 06:39:00PM +0100, Lee Jones wrote:

> Okay, so can you suggest a way to marry up the constraints found in DT to
> the remainder of the settings found in the driver without pointlessly
> applying it all to the DT itself (which is was some of the other drives
> have done)?

That's what people are using regulator_of_match() for - it's for mapping
the init data in DT array to a handle the driver can use for its
internal data (and vice versa).  See how tps65910 is using it for an
example.

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsUlvAAoJEBus8iNuMP3djKQQAIj51LKoVQhWo7Dl/l9BlGXt
vI61NVlZ9aOE6CBM6O0oyx+y1HG85HLHBcAZ7X9zCyhEf2TuuRwkmIXErC99ykjC
D3TBP8cdZHNV74R05lAE1dZK1+AmGCexYqcUijI7qq719DPxmUksYG4u7G3uPqaO
QNYweu4FI8dd4sqYe8y4jqamMpo+KuPYW3muglq3iD9XU84N5R7t2dI+IrebOsqq
uvfCSFc53pexBB0wuKgZSscHigwbKD20lRB4JqqjqVabeLkatZJQsg6crh1338x/
TGvUbZI1zNub/yFzhBOXtJ4fYgIlkHTs472RcPgcqoZMNjE/W03DvCQQ5eEEeGVN
al8bwopAa6WTwzWYi030A92DZUqiXy5QcEftwjL9P0tMLP7rfLs6QLsF0edrbuk9
t4XWNOWUuQPx4pI+XEJOQms8g1abJzx0tCSeWmdqLWPkFnhrCvy2j2zP913/EJ9s
QA7mcwq7ffCYRvr1sc5bQtW//uEiQkGpTOMrem7xIXIOklk8RAW4vyrYt92p+Lws
jRbWbu8v5zwFnEkZq3pwdgRFSBkz1ObxvgnYS0AURnZ/TJO6iZcFqpIJ6Y4FXJZX
wdbjVBfLKh67UvnWH0VIn71jiE53ww1gEd75EtkirF7TGvf5HwqKMY4yqUeDP3Nj
IMnm9t4pRsAY3uRDd19c
=yB4e
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--
