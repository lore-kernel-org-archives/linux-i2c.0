From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/5] i2c: designware: Enable fast mode plus and high
 speed
Date: Thu, 26 May 2016 13:59:11 +0300
Message-ID: <1464260351.27624.7.camel@linux.intel.com>
References: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Weifeng Voon <weifeng.voon@intel.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jui.nee.tan@intel.com
List-Id: linux-i2c@vger.kernel.org

On Thu, 2016-05-26 at 16:01 +0800, Weifeng Voon wrote:
> Enabled fast mode plus and high speed which supported by APL SoC.
>=20

=46WIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Weifeng Voon (5):
> =C2=A0 i2c: designware: Move clk_freq into struct dw_i2c_dev
> =C2=A0 i2c: designware: get fast plus and high speed *CNT configurati=
on
> =C2=A0 i2c: designware: Enable fast mode plus
> =C2=A0 i2c: designware: set the common config before the if else
> =C2=A0 i2c: designware: Enable high speed mode
>=20
> =C2=A0drivers/i2c/busses/i2c-designware-core.c=C2=A0=C2=A0=C2=A0=C2=A0=
| 33
> +++++++++++++++++++++---
> =C2=A0drivers/i2c/busses/i2c-designware-core.h=C2=A0=C2=A0=C2=A0=C2=A0=
| 12 +++++++++
> =C2=A0drivers/i2c/busses/i2c-designware-platdrv.c | 39 ++++++++++++++=
+++++-
> ---------
> =C2=A03 files changed, 68 insertions(+), 16 deletions(-)
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
