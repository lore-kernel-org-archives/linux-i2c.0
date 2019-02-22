From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client device.
Date: Fri, 22 Feb 2019 11:15:59 +0100
Message-ID: <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com> <20190221232609.d4vxl3osj6mwooey@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221232609.d4vxl3osj6mwooey@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jim Broadus <jbroadus@gmail.com>, ckeepax@opensource.cirrus.com, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 22, 2019 at 12:26 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Tue, Feb 19, 2019 at 11:30:27AM -0800, Jim Broadus wrote:
> > A previous change allowed I2C client devices to discover new IRQs upon
> > reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ was
> > assigned in i2c_new_device, that information is lost.
> >
> > For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
> > are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> > client device structures are initialized during an ACPI walk. After
> > removing the i2c_hid device, modprobe fails.
> >
> > This change caches the initial IRQ value in i2c_new_device and then resets
> > the client device IRQ to the initial value in i2c_device_remove.
> >
> > Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> > Signed-off-by: Jim Broadus <jbroadus@gmail.com>
>
> Adding Benjamin to CC

Sorry, I should have answered earlier.

I am a little bit hesitant regarding this patch. The effect is
correct, and I indeed realized a few weeks ago that something were
wrong as we couldn't rmmod/modprobe i2c-hid.

But I still have the feeling that the problem is not solved at the
right place. In i2c_new_device() we are storing parts of the fields of
struct i2c_board_info, and when resetting the irq we are losing
information. This patch solves that, but I wonder if the IRQ should
not be 'simply' set in i2c_device_probe(). This means we also need to
store the .resources of info, but I have a feeling this will be less
error prone in the future.

But this is just my guts telling me something is not right. I would
perfectly understand if we want to get this merged ASAP.

So given that the code is correct, this is my:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

But at least I have expressed my feelings :)

Cheers,
Benjamin



>
> > ---
> >  drivers/i2c/i2c-core-base.c | 9 +++++----
> >  include/linux/i2c.h         | 1 +
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index 28460f6a60cc..af87a16ac3a5 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -430,7 +430,7 @@ static int i2c_device_remove(struct device *dev)
> >       dev_pm_clear_wake_irq(&client->dev);
> >       device_init_wakeup(&client->dev, false);
> >
> > -     client->irq = 0;
> > +     client->irq = client->init_irq;
> >
> >       return status;
> >  }
> > @@ -741,10 +741,11 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
> >       client->flags = info->flags;
> >       client->addr = info->addr;
> >
> > -     client->irq = info->irq;
> > -     if (!client->irq)
> > -             client->irq = i2c_dev_irq_from_resources(info->resources,
> > +     client->init_irq = info->irq;
> > +     if (!client->init_irq)
> > +             client->init_irq = i2c_dev_irq_from_resources(info->resources,
> >                                                        info->num_resources);
> > +     client->irq = client->init_irq;
> >
> >       strlcpy(client->name, info->type, sizeof(client->name));
> >
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index 65b4eaed1d96..7e748648c7d3 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -333,6 +333,7 @@ struct i2c_client {
> >       char name[I2C_NAME_SIZE];
> >       struct i2c_adapter *adapter;    /* the adapter we sit on        */
> >       struct device dev;              /* the device structure         */
> > +     int init_irq;                   /* irq set at initialization    */
> >       int irq;                        /* irq issued by device         */
> >       struct list_head detected;
> >  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> > --
> > 2.20.1
> >
