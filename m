From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/1] drivers/misc/akm8975: Add compass sensor driver
Date: Fri, 27 Aug 2010 11:03:06 +0100
Message-ID: <20100827110306.6dfd27c3@linux.intel.com>
References: <1282872717-12228-1-git-send-email-achew@nvidia.com>
	<20100826191037.abdf65e5.akpm@linux-foundation.org>
	<643E69AA4436674C8F39DCC2C05F763816B7C05787@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <643E69AA4436674C8F39DCC2C05F763816B7C05787-lR+7xdUAJVNDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Chew <AChew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: 'Andrew Morton' <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > +       If you say yes here you get support for Asahi Kasei's
> > +       orientation sensor AK8975.
> 
> Should it be in drivers/hwmon?

Who knows - Linus needs to settle that mess at KS for all these
sensors. It's not hwmon however. Some acceleromters are in hwmon for
historical reasons. Input makes some sense to me but...


> > +#define AK8975DRV_CALL_DBG 0
> > +#if AK8975DRV_CALL_DBG
> > +#define FUNCDBG(msg) pr_err("%s:%s\n", __func__, msg);
> > +#else
> > +#define FUNCDBG(msg)
> > +#endif

Can we stop having DIY macros for debug

> The driver assumes that I will only ever have one device in the
> machine.  That's surely a reasonable assumption, unless I'm making a
> compass-testing workstation.  But it's a bit sad from a general driver
> design point of view.

I'm not so sure - its a generic component. There are lots of similar
devices and robots and the like often have multiple sensors as does
anything fault-tolerant.

> > +static int akm_aot_open(struct inode *inode, struct file *file)
> > +{
> > +     int ret = -1;
> > +
> > +     FUNCDBG("called");
> > +     if (atomic_cmpxchg(&open_flag, 0, 1) == 0) {
> > +             wake_up(&open_wq);
> > +             ret = 0;
> > +     }
> 
> What's all this doing?

It's from some kind of template various people keep using for these
drivers, unfortunately the template is a bit weird and uses
atomic_cmpxchg not test_and_set as it should. The template also uses
ioctls on a random misc device not sysfs files on the input device, and
has locking errors on the ioctl

All faithfully copied in this one...

> I'm suspecting that we're not getting ourselves a standardised Linux
> compass driver API :( I think this is a significant problem!

It needs sorting. This driver should go to the linux-input list so
Dmitry can veto it using the input layer, or accept it in which case we
can all copy the interface.

(With Intel hat on we have an akm8974 device with driver internally
that is also waiting someone to work out wtf the kernel API should be
so we can submit it). I will have to see if we can merge 8974/5 into
one driver sanely.

> Can ->power_off and ->power_on ever be NULL?

In the template it is copied from yes - because it assumes the platform
layer may want to fill stuff in. Of course it *should* be using runtime
pm

> No suspend/resume handling?

Seems odd as it has power functions yes.

The misc interface really ought to go away, its for random ioctls and
once you've got an input device and multi-device support you cannot
associate the two sanely. sysfs on the input device is surely the way
to go - or the lot on the misc device depending what Dmitry thinks.

Alan
