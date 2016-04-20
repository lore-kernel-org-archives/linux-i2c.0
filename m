From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/4] i2c: designware-platdrv: fix unbalanced clk enable
 and prepare
Date: Wed, 20 Apr 2016 17:16:00 +0300
Message-ID: <1461161760.6620.306.camel@linux.intel.com>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
	 <1460638414-5987-3-git-send-email-jszhang@marvell.com>
	 <57177C32.4090000@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30997 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbcDTOPB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 20 Apr 2016 10:15:01 -0400
In-Reply-To: <57177C32.4090000@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2016-04-20 at 15:55 +0300, Jarkko Nikula wrote:
> On 04/14/2016 03:53 PM, Jisheng Zhang wrote:
> >=20
> > If i2c_dw_probe() fail, we should call i2c_dw_plat_prepare_clk() to
> > disable and unprepare the clk, otherwise the clk enable and prepare
> > is left unbalanced.
> >=20
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> > =C2=A0 drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
> > =C2=A0 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > index 00f9e99..1488cea 100644
> > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > @@ -268,6 +268,8 @@ rpm_disable:
> > =C2=A0=C2=A0		pm_runtime_put_noidle(&pdev->dev);
> > =C2=A0=C2=A0	}
> >=20
> > +	i2c_dw_plat_prepare_clk(dev, false);
> > +
> > =C2=A0=C2=A0	return r;
> > =C2=A0 }
> >=20
> This is a bit unclear to me does devm_clk_get take care of clk
> disabling=C2=A0
> in case of probe error or driver removal?
>=20
> I see Andy's 1cb715ca4694 ("i2c-designware: move to managed functions=
=C2=A0
> (devm_*)") removed it but at quick look drivers/clk/clk-devres.c:=C2=A0
> devm_clk_release() calls only clk_put and I don't see disable is done=
=C2=A0
> down the path.

The following is a mistake of the mentioned patch.
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clk_disable_unprepare(dev->c=
lk);

I did at the same mistake in dw_dmac driver which had been fixed later
in the commit 8be4f523b480 ("dmaengine: dw: fix regression in dw_probe(=
)
function").

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
