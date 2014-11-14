From: xudong chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: Add I2C bindings for mt65xx/mt81xx.
Date: Fri, 14 Nov 2014 11:13:03 +0800
Message-ID: <1415934783.2152.59.camel@mhfsdcap03>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
	 <1415078977-18374-2-git-send-email-xudong.chen@mediatek.com>
	 <20141113181649.GG1275@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141113181649.GG1275@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2014-11-13 at 19:16 +0100, Wolfram Sang wrote:
> On Tue, Nov 04, 2014 at 01:29:35PM +0800, Xudong Chen wrote:
> > Add devicetree bindings for Mediatek Soc I2C driver.
> > 
> > Signed-off-by: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/i2c/i2c-mt6577.txt         | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> > new file mode 100644
> > index 0000000..733e65e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> > @@ -0,0 +1,39 @@
> > +* Mediatek's I2C controller
> > +
> > +The Mediatek's I2C controller is used to interface with I2C devices.
> > +
> > +Required properties:
> > +  - compatible: value should be either of the following.
> > +      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
> > +      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
> > +      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
> > +      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
> > +  - reg: physical base address of the controller and dma base, length of memory mapped
> > +    region.
> > +  - interrupts: interrupt number to the cpu.
> > +  - clock-div: the fixed value for frequency divider of clock source in i2c module.
> > +    Each IC may be different.
> 
> ? Doesn't that platform have CCF and can't we derive an I2C clock there?
> 
This value is fixed and is different from each chip. It cannot be get
from the CCF.

> > +  - clocks: clock name from clock manager
> > +  - clock-names: clock name used in i2c driver probe
> 
> This needs names of the clocks. Check other binding documentation for
> examples.
> 
OK I will add the names.
> > +Optional properties:
> > +  - clock-frequency: Frequency in Hz of the bus when transfer, the default value is 100000.
> > +  - mediatek,have-pmic: platform can control i2c form special pmic side.
> > +    Only mt6589 and mt8135 support this feature.
> > +  - mediatek,have-dcm: platform has DCM(hardware digital clock manager) property.
> > +  - mediatek,use-push-pull: IO use push-pull mode.
> 
> About the last 3 ones: Can't we encode this in the driver? Like, if the
> compatible is "mediatek,mt6589-i2c" we know it has this and that but not
> this?
> 
Yes, the DCM can be moved to the driver, but the pmic and push-pull
cannot encode in the driver.
Because Mediatek i2c IO-config compatible with open-drain and push-pull
mode, some devices use push-pull mode, so need set this in dts.
The PMIC feature can use the pins on PMIC(mt6397) side, if do not set
this the driver will use the I2C pins on the master chip.
I will try to explain more detail for PMIC in the other mail thread.

> > +
> > +Example:
> > +
> > +	i2c0: i2c@1100d000 {
> > +			compatible = "mediatek,mt6577-i2c";
> > +			reg = <0x1100d000 0x70>,
> > +			      <0x11000300 0x80>;
> > +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
> > +			clock-frequency = <100000>;
> > +			mediatek,have-pmic;
> > +			clock-div = <16>;
> > +			clocks = <&i2c0_ck>, <&ap_dma_ck>;
> > +			clock-names = "main", "dma";
> > +	};
> > +
> > -- 
> > 1.8.1.1.dirty
> > 
