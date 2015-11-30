From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: davinci: Increase module clock frequency
Date: Mon, 30 Nov 2015 15:10:54 +0100
Message-ID: <20151130141054.GG1513@katana>
References: <564DBEE3.4030508@nokia.com>
 <20151130135504.GE1513@katana>
 <565C566C.7000809@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:32870 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbbK3OK7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 09:10:59 -0500
Content-Disposition: inline
In-Reply-To: <565C566C.7000809@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The comment refers to datasheet, not really to the code. And eventual cha=
nges to the datasheet
> that's what can make it invalid (though I don't know TI's plans on it). N=
evertheless, yes, I
> think, it's better to drop the comment. Should I re-spin the patch with c=
omment removal in it?=20

Thanks. Even better would be replacing the comment: can you give a short
explanation why there is now 12MHz and what needs to be considered if
the value is to be changed again?


--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXFjuAAoJEBQN5MwUoCm2gM8P+weXeDGzyrkaj6cT8Ty2PRkp
ahd/ZQ13EXqYCmFNYbYv9F4o5H9bvu6Jcmp8T+nrc/pezSe+EF0/d/w5P70PQl3k
zjwpLO8q58D4NygY8nzVQTsbnD8S8gCxqd37Gr1fuB399Ldr02Y2AM5S7FjFS215
vfOIH/WpE5K4alnA6H0bcHcJz6tOPiQ3J3dPw5B1sY+efut8qiRuF0gfr/HX+Xzx
7eEXa4JeFGZpUXPt2QGBHroVg542CAQ99pJ5D3s06mSMIoQgizk77CDGqLIukvfc
ccKc0T4IYdpkAsG33wTluYMwcKnYHxpiArsODN5ezdJgotNC7Vlj7wzkYQeMpHbk
1MecfDKCEHxFWwKkVJx9g0J97eOJNV/MkqW7HdA1VA7VE8WVQIHkfgvaImQr+t5B
ehjsfPUg1LSUv8E3QTOiJu9La8BD58TvD1va3Y8it763moa9uTl4eTARbVGzlwMz
mVaoIZzCgjsc1TuyEY9ASTsTuZHgHpbtqBmhQHPBFQEqrIlgsgQBklIqtv90Byo+
jA2xnyUFYTtXSPdVOL8NzF5wCOxscVk40+HG7wtcKsnLaWfSB7fjd181ssN3O/He
FeqTdg8Bw1JnQTMFo2CMXiJj97UmZ4fM+SzFACldK9RbqyLDXqpfOD/SmUbFY+8t
hlfgQQ642Y1zAmvvoQvi
=GkF2
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
