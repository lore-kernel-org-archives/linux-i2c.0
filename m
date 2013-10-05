From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] i2c: enable runtime PM for I2C adapter devices
 enumerated from ACPI
Date: Sat, 5 Oct 2013 11:31:06 +0100
Message-ID: <20131005103106.GX27287@sirena.org.uk>
References: <1380552228-23329-2-git-send-email-mika.westerberg@linux.intel.com>
 <1380632982-10709-1-git-send-email-mika.westerberg@linux.intel.com>
 <20131005080901.GQ28875@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TbvQLmyOl28t66Jz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131005080901.GQ28875-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TbvQLmyOl28t66Jz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 05, 2013 at 11:09:01AM +0300, Mika Westerberg wrote:

> It looks like Windows actually powers the I2C controller off independently
> of the I2C client power state. We should probably do the same in Linux even
> though it is not following what the ACPI spec says (but makes sense with
> serial buses like I2C and SPI).

Sounds like it's probably worth going to the effort of getting the spec
amended...

--TbvQLmyOl28t66Jz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJST+pnAAoJELSic+t+oim9w9UP/RVUc3CNBP4r86nPFZL1CuW0
PQQp7vxoQM6jJJvaNRMiMMhgI43FKj2XdhwuLiQpDuIAy0kU2j8LorgYi3/JgWgy
Zr7uzbQY2s/3KolUd1TySw2Gxe3CNdDuN8fytTYBKW+U6l6vcAjw5s+xUSyXveXB
SY2diiAtXpbXFADR+JhjvIHviDGSsQ0NyFYDismzWTiwLA5oRaT81/hVvkNnrxxD
/glj2ZYzrVxL6cASA94b8JlZfOCl8WSAIvX42V3VbATc62lMUqTQosfSXj0wGBDF
9KbbvRNfQr9ilKCoBhxX0hPXH6mmqvbX2yDkVxEKc9DitAhBtZ8Ba6zgBc2A7iWO
v7i98Dxny8t/VWF18q5rjs/CZG52JC7zmxpwJ9r1YNSTHVRkllfHx4GZMT6JQNao
HjdCg79PgUPTS7EdaOb+i6ircogOSjOxEBnMpmorvRlvKpOzp3AMe/cicWPc9Viz
oJV9eN0sLrLony07/7v/3cOqNGrSiGxPVdnima1Yeghql4l8GjsFe3UFHZk1IUSi
6vhLsSofftqFeKLOmY32ADhj1CjzhS8xy2mr0NPI+L5D6JmLeIuBsIdlt5YhKdbm
6HCq+/zTW10fWkaUpFoPD87Ss4qRPXLea0ujBZsXytEmnNsRT5JI9uJgJZQa7nXt
ZYKoX/zcDbJmNwEAj5dv
=EfJ0
-----END PGP SIGNATURE-----

--TbvQLmyOl28t66Jz--
