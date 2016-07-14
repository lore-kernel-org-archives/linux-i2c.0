From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Introducing a kernel driver for the DS28E17 Onewire to I2C
 master bridge; Feature request: introduce I2C_FUNC_STOP
Date: Thu, 14 Jul 2016 22:19:22 +0900
Message-ID: <20160714131921.GE4149@tetsubishi>
References: <578612EB.1060709@gmx.de>
 <20160714095812.GA1563@tetsubishi>
 <57878B55.1030200@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:32845 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbcGNNTa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 09:19:30 -0400
Content-Disposition: inline
In-Reply-To: <57878B55.1030200@gmx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>
Cc: linux-i2c@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Is there a special procedure to follow to have those three diffs queued?

Try https://kernelnewbies.org/ or Documentation/SubmittingPatches for
Kernel submission procedures.

> As for sending the information to you instead of the list, the
> MAINTAINERS file wasn't clear to me about this. And for the w1
> subsystem, where this driver is also relevant to, there isn't a list
> at all.
>=20
> It's not clear to me who's in charge of a driver which touches both
> subsystems.

Yes, this can be tricky at times. One tool to assist is
scripts/get_maintainer.pl. Other than that, simply use all addresses
mentioned in a MAINTAINERS entry for a subsystem. And if you touch
multiple subsystems, just CC them all.

> The datasheet says it can at least for a write to the pointer byte
> followed by a read but it doesn't seem to work.
>=20
> - From my tests, it doesn't work, or it least it doesn't work the way
> the ds28e17 bus master does the repeated start.

It would be really good if that would work. Having a STOP betwen those
messages is unsafe. It won't probably matter for your setup, but
still...

> I will check it again.

Thanks!


--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh5FZAAoJEBQN5MwUoCm20iYP/R1V6ZLiJf+E7AhaH1wGseuQ
dqkxqh0TZvgS7p8xjVVfOJhR26H4juWljAsoQaoj93nCUp4KjBMHOPn86rQnX1VI
wuQwjXcRfZr9DtnivPJy/ogazSrpof80Ae7k3j9aj0kgtf6xjZqWXb92pX2Crzqn
dIDGHnpUYdLkG2irqP+7nODamRXNwQXwqp200P9k3rUHOmqV2QT2ptN7OrYtPoVE
lSieO+XfJxBIQunsOF8gwj9SIAmjhrTmY4wRhUkNTKDUmuP2gEf/pESgNsIrXbCB
ZBmy029a4AdFGQXITgUU+EmYUiUM68Tw23le305xrhD8ycn2YNkdobD9LZSLNfcg
EPOFNILVAeWVJsD4qbYvgAl9+g5co3Iv+iX2vZyiD535KukmQMuygabuhwpGQr0p
tR6RxdQdDWG28DtiEp1ZkCd8saOD9qbmhnqlQkMsLlsBu/iYu0ftqp+HnWCcPUio
0Nqk/hfgt1FjDShF0ZiA5fwzI2xhCBx/s74YXVCvJExoEkL6sarpZDwHcMRxzw3n
/aog42sOoSR9OlLWQWj8tg/uwwmXrK1wQ80HPop/8OtZzMNA1WXGFxuFRUkn1zee
d4uvMX2/ghluogioX4iclCoiU2LIMD9rsBzugkaUucJ/5fEgAt4e+HMPmVKfoYKR
LmFNwJHpohMHTE/sHTWi
=hgFc
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
