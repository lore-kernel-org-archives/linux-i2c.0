From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c/designware: enable i2c controller to suspend/resume
 asynchronously
Date: Tue, 05 Jan 2016 14:14:16 +0200
Message-ID: <1451996056.30729.394.camel@linux.intel.com>
References: <567C0192.2050601@linux.intel.com>
	 <568B848F.1070801@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53884 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbcAEMOG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 5 Jan 2016 07:14:06 -0500
In-Reply-To: <568B848F.1070801@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srinivas.kowtal@intel.com

On Tue, 2016-01-05 at 10:53 +0200, Jarkko Nikula wrote:
> Hi
>=20
> On 12/24/2015 04:30 PM, Fu, Zhonghui wrote:
> > Now, PM core supports asynchronous suspend/resume mode for devices
> > during system suspend/resume, and the power state transition of one
> > device may be completed in separate kernel thread. PM core ensures
> > all power state transition dependency between devices. This patch
> > enables designware i2c controllers to suspend/resume
> > asynchronously.
> > This will take advantage of multicore and improve system
> > suspend/resume
> > speed. After enabling all i2c devices, i2c adapters and i2c
> > controllers
> > on ASUS T100TA tablet, the system suspend-to-idle time is reduced
> > to
> > about 510ms from 750ms, and the system resume time is reduced to
> > about
> > 790ms from 900ms.
> >=20
> Nice reduction :-)
>=20
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > index 6b00061..395130b 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -230,6 +230,7 @@ static int dw_i2c_plat_probe(struct
> > platform_device *pdev)
> > =C2=A0=C2=A0	}
> >=20
> > =C2=A0=C2=A0	adap =3D &dev->adapter;
> > +	device_enable_async_suspend(&pdev->dev);
> > =C2=A0=C2=A0	adap->owner =3D THIS_MODULE;
> > =C2=A0=C2=A0	adap->class =3D I2C_CLASS_DEPRECATED;
> > =C2=A0=C2=A0	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev-
> > >dev));
>=20
> Does device_enable_async_suspend() need to be called before enabling=20
> runtime PM? I suppose not since there appears to have also related
> sysfs=20
> node for toggling it runtime.
>=20
> I'm thinking if you could move the device_enable_async_suspend() call
> into drivers/i2c/busses/i2c-designware-core.c: i2c_dw_probe() and
> then=20
> also PCI enumerated adapter could take advantage of it.

I concern about Intel BayTrail-T / Braswell / CherryTrail cases, since
we have non-trivial PM for LPSS there.=C2=A0Zhonghui, have you a chance=
 to
stress test this on platforms based on mentioned SoCs?


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
