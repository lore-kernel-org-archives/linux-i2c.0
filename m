From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] i2c: Remove unnecessary call to irq_find_mapping
Date: Mon, 29 Oct 2018 11:13:14 +0100
Message-ID: <CAO-hwJLZc1R0LoL1+xAL4-n9Htu_z=pntKU0AsJCKvFZxOauwA@mail.gmail.com>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com> <20181028223041.GI1882@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181028223041.GI1882@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: ckeepax@opensource.cirrus.com, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 28, 2018 at 11:30 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Oct 19, 2018 at 09:59:57AM +0100, Charles Keepax wrote:
> > irq_create_mapping calls irq_find_mapping internally and will use the
> > found mapping if one exists, so there is no need to manually call this
> > from i2c_smbus_host_notify_to_irq.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Adding Benjamin to recipients. He wrote that code.

Yep, definitely looking good. For completeness, I just tested it on
the t450s, and it works fine.

This one is
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> > ---
> >  drivers/i2c/i2c-core-base.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> > index dc78aa7369def..656f0a6fe3adf 100644
> > --- a/drivers/i2c/i2c-core-base.c
> > +++ b/drivers/i2c/i2c-core-base.c
> > @@ -306,10 +306,7 @@ static int i2c_smbus_host_notify_to_irq(const struct i2c_client *client)
> >       if (client->flags & I2C_CLIENT_TEN)
> >               return -EINVAL;
> >
> > -     irq = irq_find_mapping(adap->host_notify_domain, client->addr);
> > -     if (!irq)
> > -             irq = irq_create_mapping(adap->host_notify_domain,
> > -                                      client->addr);
> > +     irq = irq_create_mapping(adap->host_notify_domain, client->addr);
> >
> >       return irq > 0 ? irq : -ENXIO;
> >  }
> > --
> > 2.11.0
> >
