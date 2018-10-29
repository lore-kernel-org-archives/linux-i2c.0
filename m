From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Date: Mon, 29 Oct 2018 11:15:47 +0100
Message-ID: <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com> <20181028223116.GJ1882@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181028223116.GJ1882@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: ckeepax@opensource.cirrus.com, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 28, 2018 at 11:31 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> > The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> > i2c_device_remove does not clear this. When rebinding an I2C device,
> > whos IRQ provider has also been rebound this means that an IRQ mapping
> > will never be created, causing the I2C device to fail to acquire its
> > IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> > forcing i2c_device_probe to lookup the mapping again.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Adding Benjamin here again. Also, should there be a Fixes: tag?

Not sure if the circumstances are preventing me to think straight, but
how can you reprobe the i2c_device?
And in all cases, for the Host notify part, having the IRQ already set
shouldn't be an issue.

So for the host notify case, this patch is fine, not entirely sure
about the acpi or OF part of it.

Cheers,
Benjamin

>
> > ---
> >  drivers/i2c/i2c-core-base.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 656f0a6fe3adf..28460f6a60cc1 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -430,6 +430,8 @@ static int i2c_device_remove(struct device *dev)
> >       dev_pm_clear_wake_irq(&client->dev);
> >       device_init_wakeup(&client->dev, false);
> >
> > +     client->irq = 0;
> > +
> >       return status;
> >  }
> >
> > --
> > 2.11.0
> >
