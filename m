From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 2/2] eeprom: at24: Add support for address-width
 property
Date: Tue, 26 Jun 2018 10:26:25 +0300
Message-ID: <20180626072625.jspoadjqf37pet34@kekkonen.localdomain>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
 <1529994128-26770-3-git-send-email-alanx.chiang@intel.com>
 <20180626064736.msxcnsi5rsnxp62k@kekkonen.localdomain>
 <0772C36F3434E145A062D024A4869A09010AA12F@PGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0772C36F3434E145A062D024A4869A09010AA12F@PGSMSX101.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chiang, AlanX" <alanx.chiang@intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Yeh, Andy" <andy.yeh@intel.com>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "Mani, Rajmohan" <rajmohan.mani@intel.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "brgl@bgdev.pl" <brgl@bgdev.pl>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 26, 2018 at 07:11:54AM +0000, Chiang, AlanX wrote:
> Hi Sakari,
> 
> > -----Original Message-----
> > From: Sakari Ailus [mailto:sakari.ailus@linux.intel.com]
> > Sent: Tuesday, June 26, 2018 2:48 PM
> > To: Chiang, AlanX <alanx.chiang@intel.com>
> > Cc: linux-i2c@vger.kernel.org; Yeh, Andy <andy.yeh@intel.com>;
> > Shevchenko, Andriy <andriy.shevchenko@intel.com>; Mani, Rajmohan
> > <rajmohan.mani@intel.com>; andy.shevchenko@gmail.com; brgl@bgdev.pl;
> > robh+dt@kernel.org; mark.rutland@arm.com; arnd@arndb.de;
> > gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 2/2] eeprom: at24: Add support for address-width
> > property
> > 
> > Hi Alan,
> > 
> > On Tue, Jun 26, 2018 at 02:22:08PM +0800, alanx.chiang@intel.com wrote:
> > > From: "alanx.chiang" <alanx.chiang@intel.com>
> > >
> > > Provide a flexible way to determine the addressing bits of eeprom.
> > > Pass the addressing bits to driver through address-width property.
> > >
> > > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> > > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> > >
> > > ---
> > > since v1
> > > -- Add a warn message for 8-bit addressing.
> > >
> > > ---
> > >  drivers/misc/eeprom/at24.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > > index 0c125f2..231afcd 100644
> > > --- a/drivers/misc/eeprom/at24.c
> > > +++ b/drivers/misc/eeprom/at24.c
> > > @@ -478,6 +478,22 @@ static void at24_properties_to_pdata(struct device
> > *dev,
> > >  	if (device_property_present(dev, "no-read-rollover"))
> > >  		chip->flags |= AT24_FLAG_NO_RDROL;
> > >
> > > +	err = device_property_read_u32(dev, "address-width", &val);
> > > +	if (!err) {
> > > +		switch (val) {
> > > +		case 8:
> > > +			chip->flags &= ~AT24_FLAG_ADDR16;
> > > +			dev_warn(dev, "address-width is 8, clear the ADD16
> > bit\n");
> > 
> > Even though the default is 8 address bits, I don't see a need to issue a
> > warning if the address-width property sets that to 8 explicitly. I.e. only warn
> > if the flag was set.
> > 
> 
> Do you mean I have to add a statement for checking if the bit has been set before?
> For example:
> 
> If (chip->flags & AT24_FLAG_ADDR16)
> 	dev_warn(dev, "address-width is 8, clear the ADD16 bit\n");
> 
> If it is, I would like to modify it as below:
> 
> case 8:
> 	If (chip->flags & AT24_FLAG_ADDR16) {
> 		chip->flags &= ~AT24_FLAG_ADDR16;
> 		dev_warn(dev, "address-width is 8, clear the ADDR16 bit\n");
> 	}
> 	break;

Seems good to me.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
