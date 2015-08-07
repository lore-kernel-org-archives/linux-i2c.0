From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: designware: Remove space between variable and
 its value in debug print
Date: Fri, 7 Aug 2015 13:08:43 +0200
Message-ID: <20150807110843.GA12206@katana>
References: <1438944208-16276-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438944208-16276-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +	dev_dbg(dev->dev, "%s:  %s enabled=%#x stat=%#x\n", __func__,

What about the double space between the %s?


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxJG7AAoJEBQN5MwUoCm2L5wQAJZQt/QnJRPgKvgQdvreuCF9
SKkNE5I4KupqNXLuxZjJ4Zb/geZKzUHiWzp0gu6H2rGj3ujePkbiMlmFw070PuOJ
T66xmXhnFcsAISBRXzrNOdYtlrcdcblw6qazqdbRy9xiyTgvoylJIAL2rqI1mmPc
yLJRwP+kAjgCb+TDQyg2wAJjXBFPek+wpXuI4JbD3iiAIb7KV80n0/i/t5GkGkjl
aV5Ma4bREBbQvsweH4IqvGXfr+ui0QYCvF7qmgKyU0l5W0EXU9+Hcn8e+demO/Xp
iukNoa0ZoJCFsE4EufLf5+6iu/kP8AwM0HiibId00R1s++CqEe3Qf7opS3IC1/7x
YjDEIs+a6THGsKS4A07z2SCXjdgCM9V7F+aDVvRhbyZ4fsrE1jBTkY6rZzGn4+HS
wj457Wnfe8H2FgSWf+iKvXCUhIEfgSSTR+sppMH++p8timtP7oDD29QibIVao0CH
X00czUwTqtVdNW9/GDvq+uPmY7Wjrdhuo8JB84EzsRgHsrTULL86SZradpPG41Qw
+B3Kzv9sKnSGJJukzsxejqop55mi/s4pws/0taKsiRQxseHlOUnMccTdSX9hygAG
8HhPLSaiMNR3Hz6UVdbEH+HthnVvjHa7JBt7GU6tB4XOVsU7n5BmT6ODD7YxoUGJ
aOeyu3SLJmGM4OtL5lva
=L/aI
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
