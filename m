From: Jan Kandziora <jjj@gmx.de>
Subject: Re: Introducing a kernel driver for the DS28E17 Onewire to I2C master
 bridge; Feature request: introduce I2C_FUNC_STOP
Date: Thu, 14 Jul 2016 14:53:41 +0200
Message-ID: <57878B55.1030200@gmx.de>
References: <578612EB.1060709@gmx.de> <20160714095812.GA1563@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:60492 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbcGNMxp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 08:53:45 -0400
In-Reply-To: <20160714095812.GA1563@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 14.07.2016 um 11:58 schrieb Wolfram Sang:
>=20
>> It's available here:
>>=20
>> https://github.com/ianka/w1_ds28e17
>=20
> You need to send patches to get anything reviewed.
>=20
Is there a special procedure to follow to have those three diffs queued=
?
Because Kconfig.diff, Makefile.diff and w1.diff are in that archive
and the other diff can be easily obtained:

$ diff -u /dev/null w1_ds28e17.c >w1_ds28e17.diff


>> I've already sent a mail to Evgeniy Polyakov, maintainer of the
>> W1 subsystem and Wolfram Sang, maintainer of the I2C subsystem
>> but got no reply. Maybe due to holiday season.
>=20
> For my case, I am just extremly busy. Have a look for the pending=20
> patches for I2C here:
>=20
> http://patchwork.ozlabs.org/project/linux-i2c/list/
>=20
Uh! Understood.


> Please also note, that a maintainer is not the only reviewer for a=20
> subsystem, the whole list is. You can try there to get people
> attracted to your patch. If you count on me, expect a delay of
> weeks.
>=20
Oh, I haven't expected a review, just a ping "have noticed, please
follow the procedure as follows."

As I'm not familiar with the procedures.

As for sending the information to you instead of the list, the
MAINTAINERS file wasn't clear to me about this. And for the w1
subsystem, where this driver is also relevant to, there isn't a list
at all.

It's not clear to me who's in charge of a driver which touches both
subsystems.


>> I also have a question/feature request for the i2c subsystem.
>> The DS28E17 can support I2C_M_STOP, which allows to combine
>> write/read into a single transaction for slaves which need the
>> intermediate stop condition =E2=80=93 as the DS7505 from the evaluat=
ion
>> board. Using I2C_M_STOP
>=20
> It cannot do repeated start?
>=20
The datasheet says it can at least for a write to the pointer byte
followed by a read but it doesn't seem to work.

- From my tests, it doesn't work, or it least it doesn't work the way
the ds28e17 bus master does the repeated start.


>> instead of splitting the transaction into two would save some
>> overhead on the Onewire bus (8 bytes at 15kBaud =3D=3D 4ms, of
>> busy-looping when Onewire is bitbanged.)
>=20
>> What's the right way to handle this on the I2C driver side? Could
>> we have a I2C_FUNC_STOP as we have a I2C_FUNC_NOSTART?
>=20
> We can factor it out like I2C_FUNC_NOSTART when it is proven that
> it really is needed.
>=20
I will check it again.


Kind regards

	Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAleHi1IACgkQzGZqmZvWQdm4oACfYOySD0I7LYljZxD/UYfNHjCy
0S4Amwdj0ctB3wi6qJFoHuz0JweYV1eW
=3DifHt
-----END PGP SIGNATURE-----
