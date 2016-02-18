From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V4] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Thu, 18 Feb 2016 13:19:40 +0100
Message-ID: <20160218121940.GB1438@katana>
References: <1455762081-11947-1-git-send-email-alexandra.yates@linux.intel.com>
 <1455762081-11947-2-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455762081-11947-2-git-send-email-alexandra.yates@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2016 at 06:21:21PM -0800, Alexandra Yates wrote:
> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
> resources have been moved to reside under the i801 SMBus host
> controller whereas previously they were under the LPC device.
>=20
> This patch adds Intel lewisburg SMBus support for iTCO device.
> It allows to load watchdog dynamically when the hardware is
> present.
>=20
> Fixes: cdc5a3110e7c ("i2c: i801: add Intel Lewisburg device IDs")
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
>=20
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>

Perfect. Applied to for-current and added stable, thanks!


--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWxbbcAAoJEBQN5MwUoCm2SXkP/RTA0QvmDbN0HvTdNvdCRKV5
2euIiPoNcplcF7UhlwdC+/WKQN+QwsHUBZFocH6fmHtbYx6pSHM0MP52J29hCZHI
IukX63sQG15h6Z15XXYdNtlYF81fQPwWrErFyH8nw34qe/mqoBl1G4lhmtDXNTAj
mzBY4ApTDhO5iCEpbxWGIkurZt5LAQsHbQzw8nUXCQjoT/xk7I0v+MUdT9QMhV8N
jz53M7UzZHILKGf0GPpWfEA/hBu9HrhIWQQZI6XPFMzpOBx1r5qz99IYZSCtNIXW
GeNOb/rI5X66b1u51ur5iAW4jtxghHmXHQrq316/9jdheaAJTTI41jbFYggZy9F9
1zR+uaKZpw7FB5WcY5WJM31w4YA/TYupHIFytXvUp/qA0WJ4aO4CmK/GMqE7FfG5
3zpq1U8nWpXpN68F1NRS3Wo2So8xveFfDbQxDlBT6yO5sD/vFkqOQkMcjc8jeaR9
DWsv7x8pw3VJYl976iGfSBiHjIb4Az3YcnteMmIq8hC0nNPz6c1ShOrwNpYxFlFT
zRRJxr1+Sd5rzpvyO6+Mqry9sQqR2lc1HJUUYZXtI/sUFuiDeCAhudU8tLN0McXb
SEM9ykvf0+6qRlMo+rIBMnk88c0I/iWoTKGCEa/3QIjlnUsPRhqOj8omGgd6gzhC
OOPo+RAG9TTSZqn7L5uG
=9ZTl
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
