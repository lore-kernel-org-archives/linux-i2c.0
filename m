From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] i2c/designware: enable i2c controller to
 suspend/resume asynchronously
Date: Mon, 01 Feb 2016 17:16:03 +0200
Message-ID: <1454339763.32507.26.camel@linux.intel.com>
References: <569893D1.5050403@linux.intel.com>
	 <56AF73E1.7080501@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5058 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932750AbcBAPP3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 1 Feb 2016 10:15:29 -0500
In-Reply-To: <56AF73E1.7080501@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2016-02-01 at 17:04 +0200, Jarkko Nikula wrote:
> On 01/15/2016 08:38 AM, Fu, Zhonghui wrote:
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
> > Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> > ---
> > Changes in v2:
> > - Move the device_enable_async_suspend() call into i2c_dw_proble()
> >=20
> > =C2=A0 drivers/i2c/busses/i2c-designware-core.c |=C2=A0=C2=A0=C2=A0=
=C2=A01 +
> > =C2=A0 1 files changed, 1 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c
> > b/drivers/i2c/busses/i2c-designware-core.c
> > index ba9732c..5d6ad27 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -861,6 +861,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
> >=20
> > =C2=A0=C2=A0	init_completion(&dev->cmd_complete);
> > =C2=A0=C2=A0	mutex_init(&dev->lock);
> > +	device_enable_async_suspend(dev->dev);
> >=20
> I'm aware Andy had concerns about about stability and you also
> mention=C2=A0
> in another thread:
>=20
> "if enable all LPSS devices suspend/resume asynchronously, the
> system=C2=A0
> can't resume sometimes on ASUS T100TA(BayTrail-T SoC). But, I have=C2=
=A0
> verified that the system can resume normally every time if enable
> only=C2=A0
> i2c controller async mode and let other LPSS devices in sync mode on=C2=
=A0
> ASUS T100TA.".
>=20
> What I'm thinking would this change move things forward and help to
> find=C2=A0
> out what potential underlying issues there are in LPSS code.
>=20
> I'm fine with this I2C side change but can we assure we don't=C2=A0
> accidentally enable the same on other LPSS devices before finding
> the=C2=A0
> root cause for the crash?

Besides that we have to be really aware about DMA power related fix
introduced in v4.5-rc1 in acpi_lpss.c [1]. So, I would like to see a
wide testing especially on Intel Baytrail / Braswell platforms before
enabling it.

[1]=C2=A0http://comments.gmane.org/gmane.linux.acpi.devel/80263

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
