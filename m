From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Date: Mon, 29 Jun 2009 18:46:51 +0200
Message-ID: <20090629184651.6fc3dca5@hyperion.delvare>
References: <4A448926.1030701@samsung.com>
	<20090626113059.4c0c2fb3@hyperion.delvare>
	<1f3430fb0906290347r92201acpb35087c55049d8c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1f3430fb0906290347r92201acpb35087c55049d8c5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <promsoft-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, suchang.woo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 29 Jun 2009 19:47:26 +0900, Minkyu Kang wrote:
> Hi Jean,
>=20
> 2009/6/26 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>:
> > On Fri, 26 Jun 2009 17:39:02 +0900, Minkyu Kang wrote:
> >> The GP2A002 is a I2C interfaced Sensor for Proximity/Ambient
> >> This patch adds support the GP2A002 sensor
> >>
> >> Signed-off-by: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> Signed-off-by: Suchang Woo <suchang.woo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> ---
> >> =A0drivers/hwmon/Kconfig =A0 =A0| =A0 =A07 +
> >> =A0drivers/hwmon/Makefile =A0 | =A0 =A01 +
> >> =A0drivers/hwmon/gp2ap002.c | =A0471 +++++++++++++++++++++++++++++=
+++++++++++++++++
> >> =A0include/linux/gp2ap002.h | =A0 21 ++
> >> =A04 files changed, 500 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 drivers/hwmon/gp2ap002.c
> >> =A0create mode 100644 include/linux/gp2ap002.h
> >>
> >> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> >> index 2d50166..cc4e200 100644
> >> --- a/drivers/hwmon/Kconfig
> >> +++ b/drivers/hwmon/Kconfig
> >> @@ -1017,6 +1017,13 @@ config SENSORS_APPLESMC
> >> =A0 =A0 =A0 =A0 Say Y here if you have an applicable laptop and wa=
nt to experience
> >> =A0 =A0 =A0 =A0 the awesome power of applesmc.
> >>
> >> +config SENSORS_GP2AP002
> >> + =A0 =A0 tristate "GP2AP002 series Proximity/Ambient Sensor"
> >> + =A0 =A0 depends on HWMON && I2C
> >> + =A0 =A0 help
> >> + =A0 =A0 =A0 This driver provides support for Proximity/Ambient S=
ensor.
> >> +
> >
> > This doesn't have anything to do with hardware monitoring, so this
> > doesn't belong to drivers/hwmon.
> >
>=20
> Can you please explain about belong to hardware monitoring?
> did i missing something?

I'm not sure how I can explain it better. Your driver is for a device
which is no a hardware monitoring chip, so this driver should not be
located in the drivers/hwmon directory.

--=20
Jean Delvare
