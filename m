From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Thu, 17 Sep 2015 17:46:32 +0200
Message-ID: <55FAE058.7080504@osg.samsung.com>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441972564-9621-1-git-send-email-kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On 09/11/2015 01:55 PM, Kieran Bingham wrote:
> Hi Wolfram,
> 
> I have picked this patchset [0] up from Lee to rebase it, with an aim to
> get this series moving again.
> 
> This resend fixes up my SoB's as highlighted by Lee
> 
> A couple of minor issues were resolved in the rebase. As it stood, Javier
> proposed [1] to merge this series, and use a follow up series to make sure
> that all I2C drivers are using a MODLE_DEVICE_TABLE(of,...)
> 
> I have prepared a Coccinelle patch to work through the bulk of the changes
> required for the conversion, which will assist the transition process.
> 
> Once this patch set is accepted, I will commence converting the other
> drivers, and submitting with a per subsystem breakdown or simliar to
> reduce traffic.
> 
> [0] https://lkml.org/lkml/2014/8/28/283
> [1] https://lkml.org/lkml/2014/9/12/496
> 
> Lee's most recent cover-letter (from 12 months ago) follows:
> 
> Hi Wolfram,
> 
> Placing this firmly back on your plate.  I truly hope we don't miss
> another merge-window.  This patch-set has the support of some pretty
> senior kernel maintainers, so I hope acceptance shouldn't be too
> difficult.
> 
> As previously discussed I believe it should be okay for an I2C device
> driver _not_ supply an I2C ID table to match to.  The I2C subsystem
> should be able to match via other means, such as via OF tables.  The
> blocking factor during our previous conversation was to keep
> registering via sysfs up and running.  This set does that.
> 
> After thinking more deeply about the problem, it occurred to me that
> any I2C device driver which uses the sysfs method and issues an
> of_match_device() would also fail their probe().  Bolted on to this
> set is a new, more generic way for these devices to match against
> either of the I2C/OF tables.
> 

I reviewed this series but wonder if we shouldn't take another approach.

There are two reasons why a I2C device ID table is needed even when devices
are registered via OF:

1) Export the module aliases from the I2C device ID table so userspace
   can auto-load the correct module. This is because i2c_device_uevent
   always reports a MODALIAS of the form i2c:<client->name>.

2) Match the I2C client with a I2C device ID so a struct i2c_device_id
   is passed to the I2C driver probe() function.

As Kieran mentioned I proposed a transition path to fix 1) and posted
these patches: https://lkml.org/lkml/2015/7/30/519

While this series are fixing 2) by changing the matching logic and adding
a second probe callback for drivers that don't need to get a i2c_device_id.

Now, the problem I see with this approach is that drivers will likely want
to get the struct of_device_id .data field since that is the reason why
the I2C core pass a pointer to the struct i2c_device_id in the first place.
So drivers could get the .driver_data field and take decisions depending on
which device was registered / matched.

If the parameter is removed from probe, it means that drivers will have to
to open code to get it. This is the same issue that exist with OF today, if
a driver needs the .data field from the of_device_id table, is has to do:

struct of_device_id *match of_match_node(of_match_table, i2c->dev.of_node);

to get the match->data. And a similar helper will be needed to get the
struct i2c_device_id since the core won't do it anymore.

So what I propose is to change the probe callback signature instead to have
a const void *data as the second parameter and the core can either lookup
from the I2C device ID table or the OF device ID table depending on which
mechanism was used to register the I2C device.

That way legacy drivers will only need a I2C device ID table and DT drivers
will only need a OF device ID table and drivers won't need to open code the
matching logic to get the data stored in the tables.

Drivers that support both legacy platform and OF based registration, will
have both tables and the I2C core will lookup the data from the right table.

An alternative is to keep this series but have a generic function that gets
a pointer to a struct i2c_client as parameter and returns the data from the
correct table so drivers that don't need that information won't get it at
probe time but drivers that need it, can get it easily assisted by the core.

Both options are similar, the question is if the I2C core should match and
lookup the entry from the correct table on probe or let drivers do it later.

Any thoughts?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
