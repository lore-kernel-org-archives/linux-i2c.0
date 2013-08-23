From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] misc: (at24) move header to linux/platform_data/
Date: Fri, 23 Aug 2013 21:02:47 +0200
Message-ID: <20130823190247.GA3821@katana>
References: <1377283100-10390-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1377283100-10390-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
List-Id: linux-i2c@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2013 at 02:38:20PM -0400, Vivien Didelot wrote:
> This patch moves the at24.h header from include/linux/i2c to
> include/linux/platform_data and updates existing support accordingly.

This message explains what the patch does but not why the change is
wanted. I'd be surprised if we really want *all* platform_data in one
single directory? Is this patch part of a bigger series? That being said
i2c is not the best place for this include, in deed...


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSF7HWAAoJEBQN5MwUoCm2zWwP/0HCmL8utiAoXSaSITUtnxAP
HADAzHe7f2/hkJJjJFVKj3BP5qlD/qLboSh/MwEXnpqIHQ6kZxGO2Ohfydy1JRJ5
x+k5JEITIeB7zJeOyQM6ZpBZwOHMkB2yoa+5kDpqmETVBehBUoGBc59z9b7resHY
yW5lgzbKHDlzaeHhzrQ/0/8SDHqz2Dr0eGIuCOE0a8I8350Jp9NuaKyRTJ9H7Si8
ctfTGYbBEYwYsRyTsqZmN6gx0fzn6auwF4KjoO4Ijj/6B46NBeOosZyrDugZ4iIW
Asx47LjuoRzfFkQnGh0X9g66Gq3y7LXg+9P97vu+4j9tJZaDD+lbNn11POsluSbK
nPfF/fxGCUMFQtmtwD8esArTmG5P7Fbcd50m4evnpuZRhEBURIDmxV62Cb/B91TU
QytdPLBJBE4pdqjKxiOr8Zbz2YuxXjlK/8BVO51YVXqyYheTyHBJGw1se2FehqMB
l6UtNoWiygMx6PaIbZlYWJ6gByrerV4528peQ0ELWVtH6asBLn9foAj77gRdVlGg
uZVvhU6Uh2G5+uFjePbhwS8MjNsv/GpR424zm//yKwINNgdQZRZryJWWsu+wbbkD
QHpVw6N8tg6268KJWTjkeWiA8NkT7Jtm+BNgq8IXfP0MLMUz9A5EamL6dpI9+boT
3sYS1NImLj4GyXp6VC21
=bytS
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
