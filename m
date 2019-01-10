From: Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Date: Thu, 10 Jan 2019 23:35:34 +0300
Message-ID: <20190110203534.GA25269@jeknote.loshitsa1.net>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
 <20190109214756.GA18115@jeknote.loshitsa1.net>
 <20190110133236.GC3837@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110133236.GC3837@imbe.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 10, 2019 at 01:32:36PM +0000, Charles Keepax wrote:
> On Thu, Jan 10, 2019 at 12:47:56AM +0300, Yauhen Kharuzhy wrote:
> > On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> > > The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> > > i2c_device_remove does not clear this. When rebinding an I2C device,
> > > whos IRQ provider has also been rebound this means that an IRQ mapping
> > > will never be created, causing the I2C device to fail to acquire its
> > > IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> > > forcing i2c_device_probe to lookup the mapping again.
> > 
> > Hi.
> > 
> > I found  driver i2c/busses/i2c-cht-wc.c which instantiates I2C device
> > (battery charger) and passes IRQ to driver not using standard I2C IRQ mapping code.
> > So if we reprobe I2C device (by reloading I2C device driver module or by
> > manipulations with sysfs), we get invalid IRQ number for client:
> > 
> >  adap->client_irq = irq_create_mapping(adap->irq_domain, 0);
> >  ...
> >  irq_set_chip_data(adap->client_irq, adap);
> >  irq_set_chip_and_handler(adap->client_irq, &adap->irqchip, handle_simple_irq);
> >  ...
> >  board_info.irq = adap->client_irq;
> >  adap->client = i2c_new_device(&adap->adapter, &board_info);
> > 
> > 
> > adap->client->irq will be reset after device removing here.
> > 
> > 
> > Any advice to fix this? Maybe move initial i2c_client->irq value to new field
> > like client->init_irq and copy it to client->irq at probing, for example?
> > 
> 
> Could you be a little more specific here, are you saying if you
> reprobe the battery charger device or if you reprobe the I2C
> controller itself?

If I reprobe the battery charger.

> 
> Apologies but I am having a little difficulty working out the
> path through which the IRQ is not reinitialised. As I would have
> through the battery chargers probe would have reset up the IRQ
> then the core would pick it up again from there.

No, this I2C bus driver(i2c-cht-wc) pass the IRQ to charger not throuth
ACPI of OF but by initializing of board_info.irq field, so I2C subsystem
cannot reinitialize irq automatically.

I am not sure if this is right path for IRQ initialization and maybe
should be changed for this driver.

> 
> Thanks,
> Charles

-- 
Yauhen Kharuzhy
