From: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Subject: Re: [linux-pm] [PATCH 2/2] i2c: Factor out runtime suspend checks
 from PM operations
Date: Wed, 22 Dec 2010 20:40:23 +0530
Message-ID: <AANLkTi=KOq65TS299rB=K961=mVXnriyqNxdHzJey5rD@mail.gmail.com>
References: <1292855593-30608-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1292855593-30608-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1292855593-30608-2-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 20, 2010 at 8:03 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> =A0static int i2c_device_pm_restore(struct device *dev)
> @@ -267,7 +248,7 @@ static int i2c_device_pm_restore(struct device *d=
ev)
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0if (pm)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm->restore ? pm->restore(dev) =
: 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_generic_restore(dev);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D i2c_legacy_resume(dev);

The full function is:

static int i2c_device_pm_restore(struct device *dev)
{
	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
	int ret;

	if (pm)
		ret =3D pm->restore ? pm->restore(dev) : 0;
	else
		ret =3D i2c_legacy_resume(dev);

	if (!ret) {
		pm_runtime_disable(dev);
		pm_runtime_set_active(dev);
		pm_runtime_enable(dev);
	}

	return ret;
}

Shouldn't you be deleting the pm_runtime_* stuff from here?  There is
already done in pm_generic_restore() iff the callback exists and return=
s
zero.
