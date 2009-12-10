From: "Chaithrika U S" <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 2/4] i2c: davinci: Add helper functions
Date: Thu, 10 Dec 2009 16:45:48 +0530
Message-ID: <005b01ca798a$20572430$61056c90$@com>
References: <1260267218-19406-1-git-send-email-chaithrika@ti.com>	<1260267218-19406-2-git-send-email-chaithrika@ti.com> <1260267218-19406-3-git-send-email-chaithrika@ti.com> <4B1E376F.1030808@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B1E376F.1030808-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-us
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Sergei Shtylyov' <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 08, 2009 at 16:54:31, Sergei Shtylyov wrote:
> Hello.
> 
> Chaithrika U S wrote:
> 
> > Add i2c reset control and clock divider calculation functions
> > which will be useful for power management features.
> >
> > Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
> >   
> 
> [...]
> 
> > @@ -138,15 +147,6 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
> >  	u32 clkh;
> >  	u32 clkl;
> >  	u32 input_clock = clk_get_rate(dev->clk);
> > -	u16 w;
> > -
> > -	if (!pdata)
> > -		pdata = &davinci_i2c_platform_data_default;
> > -
> > -	/* put I2C into reset */
> > -	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> > -	w &= ~DAVINCI_I2C_MDR_IRS;
> > -	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> >  
> >  	/* NOTE: I2C Clock divider programming info
> >  	 * As per I2C specs the following formulas provide prescaler
> > @@ -178,12 +178,32 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
> >  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
> >  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
> >  
> > +	dev_dbg(dev->dev, "input_clock = %d, CLK = %d\n", input_clock, clk);
> > +}
> > +
> > +/*
> > + * This function configures I2C and brings I2C out of reset.
> > + * This function is called during I2C init function. This function
> > + * also gets called if I2C encounters any errors.
> > + */
> > +static int i2c_davinci_init(struct davinci_i2c_dev *dev)
> > +{
> > +	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
> > +
> > +	if (!pdata)
> > +		pdata = &davinci_i2c_platform_data_default;
> >   
> 
>    The very idea of "default" platform data seems doubtful. Could we 
> remove it?
> 

This platform data is used to set the default parameters in case the 
platform is not specifying it. I am not too sure of why it is different
from other drivers where an error is raised if the platform data is missing.
May be this update can be made as a separate patch out of this series.

Regards, 
Chaithrika
