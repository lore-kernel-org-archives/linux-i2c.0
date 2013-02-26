From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: I2C: Fix i2c fail problem when a process is terminated by a
 signal on octeon  in 3.8
Date: Tue, 26 Feb 2013 11:02:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302261101250.2128@pobox.suse.cz>
References: <88.A5.02716.F6CB6215@epcpsbge3.samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <88.A5.02716.F6CB6215-aQUAdjPflGw0W0ZDtsw9yvpXobYPEAuW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?EUC-KR?B?vNvAurrA?= <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 22 Feb 2013, =EC=86=A1=EC=9D=80=EB=B4=89 wrote:

>=20
> =C2=A0
>=20
> I've been debugging the abnormal operation of i2c on octeon.
> If a process is terminated by signal in the middle of i2c operation,
> next i2c read operation which is done by another process was failed.
> So i changed to ignore signal in the middle of i2c operation.
> After that the problem was not reproduced.

This is not really material directly for trivial.git. Adding maintainer=
s=20
to CC.

>=20
> =C2=A0
>=20
> Signed-off-by: EunBong Song <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>=20
> diff -up drivers/i2c/busses/i2c-octeon.c{.orig,}
> --- drivers/i2c/busses/i2c-octeon.c.orig=C2=A02013-02-21 08:09:03.168=
018843 -0800
> +++ drivers/i2c/busses/i2c-octeon.c=C2=A02013-02-21 08:09:38.34401889=
8 -0800
> @@ -183,7 +183,7 @@ static irqreturn_t octeon_i2c_isr(int ir
> =C2=A0=C2=A0struct octeon_i2c *i2c =3D dev_id;
> =C2=A0
> =C2=A0=C2=A0octeon_i2c_int_disable(i2c);
> -=C2=A0wake_up_interruptible(&i2c->queue);
> +=C2=A0wake_up(&i2c->queue);
> =C2=A0
> =C2=A0=C2=A0return IRQ_HANDLED;
> =C2=A0}
> @@ -206,7 +206,7 @@ static int octeon_i2c_wait(struct octeon
> =C2=A0
> =C2=A0=C2=A0octeon_i2c_int_enable(i2c);
> =C2=A0
> -=C2=A0result =3D wait_event_interruptible_timeout(i2c->queue,
> +=C2=A0result =3D wait_event_timeout(i2c->queue,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 octeon_i2c_test_iflg=
(i2c),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c->adap.timeout);
>=20
> =C2=A0
>=20
> =C2=A0
>=20
> [IMAGE]
>=20
> [SeenTimeChecker?do=3D5c4ee24ec3c4b5ef0b1e1d188d51662fbee53716e9d11aa=
47790d17410439b26f5961395f090d04f94a68828d2d0a033db9fdddda33
> e82cbe4a391424e62fcf6cf878f9a26ce15a0]
>=20

--=20
Jiri Kosina
SUSE Labs
