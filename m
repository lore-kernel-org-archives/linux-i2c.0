From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-mxs: fixed error message in pio transfer
Date: Tue, 9 Sep 2014 14:36:07 +0200
Message-ID: <201409091436.08028.marex@denx.de>
References: <540DEFA6.9030600@elproma.com.pl> <201409082014.07749.marex@denx.de> <540EB762.8090509@elproma.com.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <540EB762.8090509-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz =?utf-8?q?U=C5=BCycki?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, September 09, 2014 at 10:16:34 AM, Janusz U=C5=BCycki wrote=
:
> W dniu 2014-09-08 20:14, Marek Vasut pisze:
> > On Monday, September 08, 2014 at 08:04:22 PM, Janusz U=C5=BCycki wr=
ote:
> >=20
> > Thanks, but the Subject of the email doesn't make much sense. Also,=
 a
> > short commit message exlaining what you did and why you did it woul=
d be
> > nice.
> >=20
> > While the patch is obvious and obviously correct, can you please fi=
x
> > those two minor things ?
>=20
> i2c-mxs: fixed error message in pio transfer
>=20
> If I2C_M_RD flag is set SELECT command is sent
> and afterward READ command.
> The patch fixes READ command to return READ failure error message
> instead of SELECT failure error message.
>=20
> >> Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
> >> ---
> >>=20
> >>    linux-3.14.17/drivers/i2c/busses/i2c-mxs.c | 2 +-
> >=20
> > btw. how did this 'linux-3.14.17' get in the path ?
>=20
> I have some scripts in my repo and I forgot about longer patch.

Can you please repost the patches using git send-email ?

Thanks!

Best regards,
Marek Vasut
