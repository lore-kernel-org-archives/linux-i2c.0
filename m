From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-ali1563: remove sparse warnings
Date: Sun, 10 Jan 2010 16:45:08 +0100
Message-ID: <20100110164508.51fc29a7@hyperion.delvare>
References: <4B49E533.8050808@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B49E533.8050808-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>, cocci-dAYI7NvHqcQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 10 Jan 2010 15:33:23 +0100, N=C3=A9meth M=C3=A1rton wrote:
> From: M=C3=A1rton N=C3=A9meth <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
>=20
> Remove the following sparse warnings (see "make C=3D1"):
>  * drivers/i2c/busses/i2c-ali1563.c:91:3: warning: do-while statement=
 is not a compound statement
>  * drivers/i2c/busses/i2c-ali1563.c:161:3: warning: do-while statemen=
t is not a compound statement
>=20
> Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>
> ---
> --- linux/drivers/i2c/busses/i2c-ali1563.c.orig	2010-01-10 13:40:31.0=
00000000 +0100
> +++ linux/drivers/i2c/busses/i2c-ali1563.c	2010-01-10 13:54:16.000000=
000 +0100
> @@ -87,9 +87,9 @@
>  	outb_p(inb_p(SMB_HST_CNTL2) | HST_CNTL2_START, SMB_HST_CNTL2);
>=20
>  	timeout =3D ALI1563_MAX_TIMEOUT;
> -	do
> +	do {
>  		msleep(1);
> -	while (((data =3D inb_p(SMB_HST_STS)) & HST_STS_BUSY) && --timeout)=
;
> +	} while (((data =3D inb_p(SMB_HST_STS)) & HST_STS_BUSY) && --timeou=
t);
>=20
>  	dev_dbg(&a->dev, "Transaction (post): STS=3D%02x, CNTL1=3D%02x, "
>  		"CNTL2=3D%02x, CMD=3D%02x, ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n"=
,
> @@ -157,9 +157,9 @@
>  	outb_p(inb_p(SMB_HST_CNTL2) | HST_CNTL2_START, SMB_HST_CNTL2);
>=20
>  	timeout =3D ALI1563_MAX_TIMEOUT;
> -	do
> +	do {
>  		msleep(1);
> -	while (!((data =3D inb_p(SMB_HST_STS)) & HST_STS_DONE) && --timeout=
);
> +	} while (!((data =3D inb_p(SMB_HST_STS)) & HST_STS_DONE) && --timeo=
ut);
>=20
>  	dev_dbg(&a->dev, "Block (post): STS=3D%02x, CNTL1=3D%02x, "
>  		"CNTL2=3D%02x, CMD=3D%02x, ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n"=
,

Applied, thanks.

--=20
Jean Delvare
