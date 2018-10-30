From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Date: Tue, 30 Oct 2018 11:51:20 +0000
Message-ID: <20181030115120.GI16508@imbe.wolfsonmicro.main>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
 <20181028223116.GJ1882@kunai>
 <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 29, 2018 at 11:15:47AM +0100, Benjamin Tissoires wrote:
> On Sun, Oct 28, 2018 at 11:31 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> > > The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> > > i2c_device_remove does not clear this. When rebinding an I2C device,
> > > whos IRQ provider has also been rebound this means that an IRQ mapping
> > > will never be created, causing the I2C device to fail to acquire its
> > > IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> > > forcing i2c_device_probe to lookup the mapping again.
> > >
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >
> > Adding Benjamin here again. Also, should there be a Fixes: tag?
> 
> Not sure if the circumstances are preventing me to think straight, but
> how can you reprobe the i2c_device?

You just head into /sys/bus/i2c/drivers/<the_driver> and use the
unbind file to remove the driver. You can then probe the driver
again using the bind file.

> And in all cases, for the Host notify part, having the IRQ already set
> shouldn't be an issue.

To be clear this isn't a theoretical issue this is something I
can replicate very easily. The problem comes in when you unbind
both the I2C device and the device that is providing its IRQ. In
my case the I2C device is a speaker amp and the device providing
IRQs is an audio CODEC.

When the device providing the IRQ is unbound it will delete the
IRQ mapping. For the I2C device to acquire its IRQ something
needs to recreate that mapping, this would normally happen (in a
DT system) as a result of the of_irq_get/_by_name. But as
client->irq is already set this doesn't happen, causing the I2C
device to fail probe because it couldn't locate its IRQ.

I can provide some stack traces or something if that would help
to clarify the issue?

Thanks,
Charles
