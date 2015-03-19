From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: driver for the Conexant Digicolor I2C controller
Date: Thu, 19 Mar 2015 11:30:43 +0200
Message-ID: <20150319093042.GB2415@tarshish>
References: <7da767503ac6085c10fbd1953ffd36621b8bf0c5.1424092804.git.baruch@tkos.co.il>
 <a106023efa9fd648f46021cd063437df798528de.1424092804.git.baruch@tkos.co.il>
 <20150318210730.GA12960@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150318210730.GA12960@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, Mar 18, 2015 at 10:07:30PM +0100, Wolfram Sang wrote:
> On Mon, Feb 16, 2015 at 03:20:04PM +0200, Baruch Siach wrote:
> > This commit adds a driver for the I2C master controller on the CX92755 SoC. The
> > CX92755 is one SoC in the Conexant Digicolor series. This driver should support
> > other SoCs from that series.
> > 
> > Only 7bit slave addresses are currently supported.
> > 
> > Tested on the Equinox CX92755 EVK, using i2c-tools utilities to read and write
> > the on-chip (sic) audio codec.
> > 
> > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> 
> Looks mostly good.
> 
> > +static u32 dc_i2c_func(struct i2c_adapter *adap)
> > +{
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> > +}
> 
> You probably want to advertise I2C_FUNC_NOSTART here, too?

OK.

> And if you could rebase to something after 4.0-rc1, that would be much
> appreciated.

Did that some time ago along with the rest of my queue for that platform. Just 
waited for some review before reposting.

Thanks for reviewing,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
