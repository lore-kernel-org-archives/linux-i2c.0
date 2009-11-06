From: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: at24 driver - a possible problem
Date: Fri, 6 Nov 2009 14:57:59 +0200
Message-ID: <533f29860911060457m70a1adfcr2dd11f0785748014@mail.gmail.com>
References: <533f29860911050810w4d939b39x2ad11c189f13c977@mail.gmail.com>
	 <20091105172537.GA3332@pengutronix.de>
	 <20091106131524.76ae52b9@hyperion.delvare>
	 <20091106124905.GA3980@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091106124905.GA3980-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Here is what system-call behaviour I was expecting from the position
of a user space developer.
You can then say whether it is impossible, incorrect or inefficient.

When I found that the read() was failing I at once suspected that a
write() was not finished at the time of the call.
So I added the O_SYNC flag to the open() call. (The man says: O_SYNC
- The file is opened for synchronous I/O. Any write()s on the
resulting file descriptor will block the calling process until the
data has been physically written to the underlying hardware.)
But obviously this didn't fix the issue.

Correct me if I'm wrong but I would expect from a synchronous write()
call to NOT finish before the data has been "phisically written".
And in this case of course the read operation wouldn't need a waiting l=
oop.
What do you think?

Regards,
Aleks

2009/11/6 Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
>
>> This makes a lot of sense. When a write operation is in progress, th=
e
>> EEPROM is busy and may not ack its address. Whether the request is
>> another write or a read probably doesn't make a difference, a nack i=
s a
>> nack. So the same waiting loop that we have for writes, is certainly
>> needed for reads as well. Shouldn't be too difficult. Any volunteer?=
 I
>> can review the patch when it's done.
>
> If nobody is faster ;), I will do it this weekend.
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkr0G0EACgkQD27XaX1/VRsWPgCgr43owCqfBvtuQHtCz5bY9nZg
> rT0An26MIi9s6NobqIAeKgDKWvky9/pp
> =3D0Jrc
> -----END PGP SIGNATURE-----
>
>
