From: Juergen Fitschen <me@jue.yt>
Subject: Re: [PATCH RFC 3/4] i2c: at91: added slave mode support
Date: Wed, 1 Nov 2017 12:35:05 +0100
Message-ID: <20171101113505.GB17565@jfi-dev>
References: <cover.1509112910.git.me@jue.yt>
 <b81e56548dbe4fa6c37fec4c80b38622f1f1fcdf.1509112910.git.me@jue.yt>
 <20171031155542.rsy7gtpa5notpwcd@rfolt0960.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171031155542.rsy7gtpa5notpwcd@rfolt0960.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello Ludovic,

On Tue, Oct 31, 2017 at 04:55:42PM +0100, Ludovic Desroches wrote:
> On Fri, Oct 27, 2017 at 05:12:00PM +0200, Juergen Fitschen wrote:
> > Slave mode driver is based on the concept of i2c-designware driver.
> > 
> > Signed-off-by: Juergen Fitschen <me@jue.yt>
> > ---
> >  drivers/i2c/busses/Makefile         |   3 +
> >  drivers/i2c/busses/i2c-at91-core.c  |  13 +++-
> >  drivers/i2c/busses/i2c-at91-slave.c | 147 ++++++++++++++++++++++++++++++++++++
> >  drivers/i2c/busses/i2c-at91.h       |  30 +++++++-
> >  4 files changed, 189 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/i2c/busses/i2c-at91-slave.c
> > 
> 
> Adding an example in Documentation/devicetree/bindings/i2c/i2c-at91.txt
> could be useful.

I will add this.

> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> > index 2a79c3d..b38fb8e9 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -34,6 +34,9 @@ obj-$(CONFIG_I2C_ALTERA)	+= i2c-altera.o
> >  obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
> >  obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
> >  i2c-at91-objs			:= i2c-at91-core.o i2c-at91-master.o
> > +ifeq ($(CONFIG_I2C_SLAVE),y)
> > +	i2c-at91-objs		+= i2c-at91-slave.o
> > +endif
> 
> As Designware driver, I would add an entry in 'I2C Hardware Bus
> Support'.
> 
> If a user wants to use the I2C GPIO driver as the I2C slave (once it has
> the slave support), it's not useful to embed i2c-at91-slave code.

Good point.

> > +void at91_init_twi_bus_slave(struct at91_twi_dev *dev)
> > +{
> > +	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_MSDIS);
> > +	if (dev->slave_detected && dev->smr) {
> 
> slave_detected has been checked in the caller. smr has been set just
> before calling at91_init_twi_bus().

Whoops! Better safe than sorry ;) I will remove that check.



Thank you for testing everything! I am curious about how the other MPUs will
perform with the patchset. I have a SAMA5D35 at hand and can test everything on
this MPU in the next days.


Best regards
  Juergen
