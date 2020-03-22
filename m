From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2] i2c: at91: support atomic write xfer
Date: Sun, 22 Mar 2020 17:35:31 +0100
Message-ID: <20200322163531.GB25488@qmqm.qmqm.pl>
References: <6466e066d7cbad20cb6a334ad8e37cdcf521c492.1584822011.git.mirq-linux@rere.qmqm.pl>
 <c789352c-5517-1fd9-980d-f8f6c2017901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c789352c-5517-1fd9-980d-f8f6c2017901@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Marco Felsch <m.felsch@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Mar 22, 2020 at 04:39:58AM +0300, Dmitry Osipenko wrote:
> 22.03.2020 00:03, Michał Mirosław пишет:
> > Implement basic support for atomic write - enough to get a simple
> > write to PMIC on shutdown. Only for chips having ALT_CMD register,
> > eg. SAMA5D2.
> > 
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > ---
> > v2: remove runtime-PM usage
> >     switch to readl*poll*atomic() for transfer completion wait
> > ---
> >  drivers/i2c/busses/i2c-at91-master.c | 69 +++++++++++++++++++++++++++-
> >  1 file changed, 67 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
> > index ba6fbb9c7390..d9226207157a 100644
> > --- a/drivers/i2c/busses/i2c-at91-master.c
> > +++ b/drivers/i2c/busses/i2c-at91-master.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > @@ -709,6 +710,69 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
> >  	return ret;
> >  }
> >  
> > +static int at91_twi_xfer_atomic(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
> > +{
> > +	struct at91_twi_dev *dev = i2c_get_adapdata(adap);
> > +	unsigned long timeout;
> > +	struct pinctrl *pins;
> > +	__u32 stat;
> > +	int ret;
> > +
> > +	/* FIXME: only single write request supported to 7-bit addr */
> > +	if (num != 1)
> > +		return -EOPNOTSUPP;
> > +	if (msg->flags & I2C_M_RD)
> > +		return -EOPNOTSUPP;
> > +	if (msg->flags & I2C_M_TEN)
> > +		return -EOPNOTSUPP;
> > +	if (msg->len > dev->fifo_size && msg->len > 1)
> > +		return -EOPNOTSUPP;
> > +	if (!dev->pdata->has_alt_cmd)
> > +		return -EOPNOTSUPP;
> > +
> > +	pins = pinctrl_get_select_default(&adap->dev);
> > +
> > +	ret = clk_prepare_enable(twi_dev->clk);
> 
> Hello Michał,
> 
> Please see comments to the clk_prepare_enable() and clk_prepare().
> 
> /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
> static inline int clk_prepare_enable(struct clk *clk)
> ...
>  * clk_prepare may sleep, which differentiates it from clk_enable.
> 

Yes, it may. Though in this case unlikely. Even though clk_prepare()
takes a mutex, this is running only after there are no more processes
in the system, so there are no possible contenders.

Best Regards,
Michał Mirosław
