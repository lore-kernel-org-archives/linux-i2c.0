From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-core: do not use bus internal data
Date: Sat, 12 Mar 2016 16:14:12 +0100
Message-ID: <20160312151412.GC1661@katana>
References: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50260 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbcCLPOR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 12 Mar 2016 10:14:17 -0500
Content-Disposition: inline
In-Reply-To: <1457351357-13457-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, gregkh@linuxfoundation.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2016 at 05:19:17PM +0530, Sudip Mukherjee wrote:
> The variable p is a data structure which is used by the driver core
> internally and it is not expected that busses will be directly accessing
> these driver core internal only data.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Removed the unlikely() and applied to for-next, thanks!


--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5DJEAAoJEBQN5MwUoCm2GU8QAIYc+nxJaoH698b8cwMP+g0G
IrAp2kyiHrtJJqE6SeGgMIn+FL5Hjob49juQzCO+KB5ts272IP9NbrcvaCvVU7Vt
GWz0fAU9XsV8Lzq/IfcuHoOZ4GBqsgXlCCpduJrlRl30BrOD98IBBIVFnUGuATud
8YUBH2UTy/VViVlt6ff80S1Isk4ngDahiRsuUVlFBnweHmbwB4NY5fOWZ2m3ysN7
tw+gGEUHE/drv5sl2ZplYyNj/j78nq+TP6p7IR0XFRf/DDCcHYbLMkzECxxQL8Ck
w+LUg70riXgQEpoaz28wx2h6F1vuqlhzm4vBSli3otKmdH6ffRJSZwOog5QWCJdu
U5GBbgpeQfzzPAXSb/pTwjfdZIz9mGjhnTYDUP/a4ShCCAhx5Hd0KC8LTbQ0aW6u
oirkWne76bXoC6QInyxbioXKgtBu33moOlI0tIST8k2ZyW8UvysywKysIa+TaIsU
UP9R6eL8bundmOSIDiprE/wwwpRMCjNUNZZ/knlR1ps7yaipuuN5NLMtZx4/Wrmf
8UxELNP7vEzIjUJ19XR155xChMUdJyk7B5th74imCIzuRa4JlnkYUySI+2340kZA
cWkGH/1Bnsdo6t88IFyu+gvkNonQ6e86ysHXMt0x42I+oYzRfj1+DaI60vtOATwp
Imgv6cCxRKz/BmyzHXmR
=6zIA
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
