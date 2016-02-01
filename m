From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: balance clk enable/disable on removal
Date: Mon, 01 Feb 2016 16:44:05 +0200
Message-ID: <1454337845.32507.20.camel@linux.intel.com>
References: <1454106696-5867-1-git-send-email-khoroshilov@ispras.ru>
	 <56AF69D3.4070300@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56AF69D3.4070300@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2016-02-01 at 16:21 +0200, Jarkko Nikula wrote:
> On 01/30/2016 12:31 AM, Alexey Khoroshilov wrote:
> > It seems clk_disable_unprepare() is missed in dw_i2c_plat_remove(),
> > so the patch adds it.
> >=20
> > Found by Linux Driver Verification project (linuxtesting.org).
> >=20
> > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > ---
> > =C2=A0 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
> > =C2=A0 1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > index 438f1b4964c0..8f19b7b81fe0 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -267,6 +267,7 @@ static int dw_i2c_plat_remove(struct
> > platform_device *pdev)
> > =C2=A0=C2=A0	i2c_del_adapter(&dev->adapter);
> >=20
> > =C2=A0=C2=A0	i2c_dw_disable(dev);
> > +	i2c_dw_plat_prepare_clk(dev, false);
> >=20
> I tried this quickly and it appears more work is needed. When=C2=A0
> CONFIG_PM_SLEEP is set then autosuspending will do the unprepare and=C2=
=A0
> this patch causes double unprepare at remove. But when
> CONFIG_PM_SLEEP=C2=A0
> is not set then indeed those clk calls are out of sync.

Besides that I would suggest to check carefully error patch in the
probe(), i.e. handling error from i2c_dw_probe(). There maybe similar
issue is hidden.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
