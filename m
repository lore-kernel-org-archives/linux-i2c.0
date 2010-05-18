From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-xii.c: Use OF instead of platform bus
Date: Tue, 18 May 2010 11:24:07 +0200
Message-ID: <AANLkTinZrIhPMJ8En09PUXc5tbFzls3nYLXZPlfemY0c@mail.gmail.com>
References: <1274117574-1485-1-git-send-email-ricardo.ribalda@gmail.com>
	<4BF18D47.2030809@pelagicore.com> <AANLkTik9hCEhCFd9ku6m1SkTz45q6JwxxLUgBjLMOV-0@mail.gmail.com>
	<4BF252F1.3090301@pelagicore.com> <20100518084548.GB4572@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100518084548.GB4572-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram:

  First news about it.... Then lets wait to see how this goes, there
are not so many people using this hw.... IMHO If finaly we move from
of_platform to platform we would be doing a bad mistake, of_platform
is much more clean and useful


     Best regards

On Tue, May 18, 2010 at 10:45, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wro=
te:
>>> Of course we can have a more flexible patch, let me think about the
>>> best (clean) way to implement it.
>>
>> I did something similar to the xilinx_spi driver. It was OF only, I
>> splitted it into a generic part, and OF part, and write a platform d=
river
>> part.
>
> Wasn't Grant Likely about to post a patch-series getting rid of the o=
f_platform
> bus for this merge window?
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
> iEYEARECAAYFAkvyU7wACgkQD27XaX1/VRswLACghJXHJmP8t93q6euaj4TH4mIl
> 7cUAnRcQIb1lqMyt5X8dalaD5mS787U0
> =3Dc0Tj
> -----END PGP SIGNATURE-----
>
>



--=20
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
