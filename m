From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 39/86] i2c/i801: use uapi/linux/pci_ids.h directly
Date: Fri, 3 Apr 2015 21:09:58 +0200
Message-ID: <20150403190958.GE1298@katana>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
 <1427635734-24786-40-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427635734-24786-40-git-send-email-mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2015 at 03:40:42PM +0200, Michael S. Tsirkin wrote:
> Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
> use the new header directly so we can drop
> the wrapper in include/linux/pci_ids.h.
>=20
> Signed-off-by: Michael S. Tsirkin <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

I don't know if I should take it. If so, let me know.

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHuWGAAoJEBQN5MwUoCm2j/IP/0ScLpXaQNdK4L7rdxvLq5Zq
ZZfwjjjWzXH6ipUsP7LcjkZU0ypATlZ7dDkNPFtViKOenj7g36WYvClcP2jWqn2w
Bd6jLExf2C3e5CkQhMmc8YCIZHLLiLd50e0Mi2e6nQJh3+0j74kF/+LkF1SWCwez
9bKsEDmejzHYH2dnHuZkk6+kmQmgHGqQNVL/PuR/fzytOCz9/jcJeltj9byqzWUC
YDlm+lkXlcZNTZ83Hg+nI/dWMDCygUUOjScHQPtCpTR8FWrm5ZOX04drCYxz0ynf
cPW99nem5WE2oV0SqB4Y5oD6SA+YyUAVzuOi15bTjgvB3N0JwNT6Xn8b20Mgtn2h
E+zgytkQvEujG32jEfzc43IyDYxN7uQ2FcPQUy1UCaOLKJTxnggj7KGM9hIZMEGB
xkR2831iOBAoSTT5w6NUhf/lC7xBbfQR2zxYpBeQyAITInG6Sg9ClsjlKq1efNHs
PCSiBl51wRZ8co2yfDZF6Z2hJ3BcRKrW7qR4RCOgEh2aGL0pfB5dm9oYVobFqBai
Rln8yupU9reZQVwGrFp3jU+dZ/t9brIGPW0EgBtIL8FYvKTp3ucbR9FEB4d62tWe
eU/nfh9bEYxCEb6n2yI0TYc4wyQMGUk4aYZsja4WoBaZyiF5kUByrrUHvSAuEGIG
AwYeFGgjTeo0xKoq/WnW
=vQgc
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
