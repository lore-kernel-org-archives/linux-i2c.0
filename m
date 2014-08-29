From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH RESEND 0/8] i2c: Relax mandatory I2C ID table passing
Date: Fri, 29 Aug 2014 10:45:38 +0200
Message-ID: <20140829084538.GC1329@katana>
References: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409236538-21274-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lee,

> Placing this firmly back on your plate.  I truly hope we don't miss
> another merge-window.

Nope, we won't. I'll still need a week or so due to other duties.

> This patch-set has the support of some pretty
> senior kernel maintainers, so I hope acceptance shouldn't be too
> difficult.

Cool, then they could ack it like Grant did? That surely helps.

> As previously discussed I believe it should be okay for an I2C device
> driver _not_ supply an I2C ID table to match to.

I agree...

> The I2C subsystem
> should be able to match via other means, such as via OF tables.  The
> blocking factor during our previous conversation was to keep
> registering via sysfs up and running.  This set does that.

... yet it also should not cause regressions. If you fixed that, sounds
great!

> After thinking more deeply about the problem, it occurred to me that
> any I2C device driver which uses the sysfs method and issues an
> of_match_device() would also fail their probe().  Bolted on to this
> set is a new, more generic way for these devices to match against
> either of the I2C/OF tables.

Even better :) I am generally positive with your patchset, but need to
review the implementation. For core stuff, this simply needs more
attention.

Thanks,

   Wolfram


--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUAD2yAAoJEBQN5MwUoCm2MhoP/jt7l4IDexppgc3psojs47nT
eha2WpOxx5d5rOzGSb+Iy17Wd9Ec83K4et95pDnFPgWi8ewUex3V5D1VYg/wfmdv
n0JCSvUH3yfnDP4Of79knjIt7hQ7mz7AQk78nRSBR7lB4EVRUppm8mcMsLOkA0Mr
50w7UzWkWktmigb40xQqXwfVKAkMqskGAA5t89945++7Ot6y9Z/mzKS0BMxbZJBO
NyuaOkQX9lygRd6i/tsIzopS22kupYHgZxNFHlgQNrKrUedqxNMUk6EBbu7YKHiW
2tI6MNfMr7kdgCp/eJSxwUsCcbIqp/twEM4QTF2tk0m7jhHOtu6V+5I0Ce5NZ7bQ
bnTsehOg/JJesFA1F8VOUSSKIFYI0KaOeyBP5UtqnQueG2vWt0fGgYCOkC8Ox1g2
xqL7/RPzCDhynmGMF8lMJnIX5NxqhLUJ7VuAokVtbMh/iDyLK0tSAGsgDxZjXAIM
tYbfwy16pTw8SEFQC2fLhsAih1VxlM0+qjEENpaiKFwb/brgPQQtQECVtzRRX/W7
j8r6XPoAjZlcCgfHLlozj2V3zUM5RxiAtgESz6Td6SXn0EgkigK3dWOw1imleeTD
tUhW+WiQBv9gYpll+mJVTl/nc/akQY6kAsEuipr5G3cj3S4aWaJrR6v2RUs+ZXtq
tdBcNoGJEGd7sCzgPldN
=9jb2
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
