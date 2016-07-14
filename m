From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/7] i2c: improve error messages when registering an
 adapter
Date: Thu, 14 Jul 2016 21:47:40 +0900
Message-ID: <20160714124739.GD4149@tetsubishi>
References: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60974 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbcGNMrq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 08:47:46 -0400
Received: from p33062-ipbffx02marunouchi.tokyo.ocn.ne.jp ([220.96.46.62]:2941 helo=tetsubishi)
	by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <wsa@the-dreams.de>)
	id 1bNg3M-0006ZV-53
	for linux-i2c@vger.kernel.org; Thu, 14 Jul 2016 14:47:44 +0200
Content-Disposition: inline
In-Reply-To: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 09, 2016 at 01:34:57PM +0900, Wolfram Sang wrote:
> The goal of this series is to have proper error messages whenever somethi=
ng in
> i2c_add_adapter() and friends fail. Then, we can hereafter drop all simil=
ar
> messages in drivers which is largely duplicated code and often not very h=
elpful
> because they are too generic.
>=20
> To achieve this goal, we make sure that dev_* is used whenever a device is
> available. pr_* is used when we have at least an adapter name. If not, we=
 use
> WARN to show the user the code path that failed. Error messages were adde=
d,
> fixed, and made consistent. Also, the first patch fixes a potential leak =
found
> while creating this series. Also, i2c_register_adapter() was a bit refact=
ored
> to be easier to handle. Please look at the patch descriptions for details=
=2E A
> brach is here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git strings/i2c
>=20
> Looking forward to comments.

Applied to for-next, thanks!


--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh4nrAAoJEBQN5MwUoCm23zgP/10L4FNYI0PSZWZXdpZ+TaYV
6H1CCTSWWPpbN/5fvVLa1n5u7SsWN/G5E9XfbUBXo1A74XAjDrBAQpjh7VPnR8Nk
7rtwmpHfkNGzH58s/ih0mjYPge2iZ8vYk/nZ/p2b8/k8yoTyBK8NttYuBJNWkXWN
u4UteddZgM39GEyVgYQoftEki+NeB8QSmhCBFdUfhN3O3XCDR/3/RNLJANdHKME1
o6I/uHI4GhZuyU5B2mwGMU+3sS2thG8aOabRdgfaDuIXZZN2KMJnFqWRoZNfv9AN
/yW/rtevZvfUUfPZdEsVq5x7UpI9yRP7g8Dl6no15nhNFZbiOkWryrR8HYqnLzx9
iuHOv1es+V1Rrool/YsSZqf5NZP3wR8bhI8lZR9L8Qlm8VFXpOIfb/ngaDTJtpuS
6L4O8eKx6zIXbnY6atkR0A5CQOsAC72dQKPELZh12MoRQ5fTJsTZ7TdwbKgOHnBS
Id3NK0teu5xHr8HUNqrJT/QxW05h4YGL/+FzKoEH23hrsAzXYV4IWR6osEfOvTZj
bI5Is+AGmU8HF0kRBMVFAWQvFqopBJ60XiCSuodXIm5RPJLYJFKf+1n6jqRWrbke
xVCvqDkqP+qq9b7hOeJVgCZBZk/SRY8Li4C7j0i+wjpnUBlujAl/VTaD6N5h+0X1
MJK2cl1UTchEXt8i5cRi
=9nAv
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
