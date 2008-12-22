From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/4 v2] soc-camera: add support for MT9T031 CMOS camera sensor  from Micron
Date: Mon, 22 Dec 2008 17:37:42 +0100
Message-ID: <200812221737.42194.khali@linux-fr.org>
References: <Pine.LNX.4.64.0812171939420.8733@axis700.grange> <Pine.LNX.4.64.0812180938380.3963@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0812180938380.3963-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guennadi,

Le Jeudi 18 D=E9cembre 2008 09:40, Guennadi Liakhovetski a =E9crit=A0:
> From: Guennadi Liakhovetski <lg-ynQEQJNshbs@public.gmane.org>
>=20
> This camera is rather similar to MT9M001, but also has a couple of
> enhanced features, like pixel binning.

I didn't look at the datasheets, but just to make sure you didn't
overlook this possibility: wouldn't it make sense to have a single
driver for both devices? The i2c subsystem architecture makes this
easy.

>=20
> Signed-off-by: Guennadi Liakhovetski <lg-ynQEQJNshbs@public.gmane.org>
> ---
>=20
> Changes since v1: added
>=20
>  i2c_set_clientdata(client, NULL);
>=20
> in error path and in remove.
>=20
>  drivers/media/video/Kconfig     |    6 +
>  drivers/media/video/Makefile    |    1 +
>  drivers/media/video/mt9t031.c   |  733 +++++++++++++++++++++++++++++=
++++++++++
>  include/media/v4l2-chip-ident.h |    1 +
>  4 files changed, 741 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/mt9t031.c
> (...)

I took a quick look at the code and it looks fine to me, for the
parts I can comment on. So this is:

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

--=20
Jean Delvare
