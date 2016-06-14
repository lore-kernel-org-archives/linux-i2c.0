From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 00/10] i2c: designware-platdrv: Some improvments related
 to PM
Date: Tue, 14 Jun 2016 18:39:09 +0300
Message-ID: <1465918749.30123.70.camel@linux.intel.com>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64484 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbcFNPhv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 14 Jun 2016 11:37:51 -0400
In-Reply-To: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org

On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
> Here's a couple changes for the i2c-designware driver. Most of them a
> related to
> the support for runtime PM and system PM, but there's also a few that
> improves
> some error handling.
>=20
> I have tested these on Hisilicon Linaro 96-board (hi6220). I used a
> couple local
> changes to enable the power-key to act as a wakeup in system PM
> suspend state.
> If anyone are interested about those as well, I am happy to share
> them.

I know Jarkko spent a lot to understand PM flow in this driver.

My overall feelings after brief reading of the series you fixed a
particular problem with your device or flow, which might have broken th=
e
half of current users. So, I wouldn't take this without Tested-by tags
of (almost) all active stakeholders.

>=20
> Ulf Hansson (10):
> =C2=A0 i2c: designware-platdrv: Return error in ->probe() when clk un=
gate
> =C2=A0=C2=A0=C2=A0=C2=A0fails
> =C2=A0 i2c: designware-platdrv: Gate clk in error path in ->probe()
> =C2=A0 i2c: designware-platdrv: Unconditionally enable runtime PM
> =C2=A0 i2c: designware-platdrv: Disable autosuspend in error path in
> =C2=A0=C2=A0=C2=A0=C2=A0->probe()
> =C2=A0 i2c: designware-platdrv: Fix clk gating in ->remove()
> =C2=A0 i2c: designware-platdrv: Update runtime PM last busy mark in
> ->probe()
> =C2=A0 i2c: designware-platdrv: Re-init the HW when resuming
> =C2=A0 i2c: designware-platdrv: Check return value from
> clk_prepare_enable()
> =C2=A0 i2c: designware-platdrv: Simplify code by using dev_get_drvdat=
a()
> =C2=A0 i2c: designware-platdrv: Rework system PM support
>=20
> =C2=A0drivers/i2c/busses/i2c-designware-platdrv.c | 106 +++++++++++++=
----
> -----------
> =C2=A01 file changed, 50 insertions(+), 56 deletions(-)
>=20

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
