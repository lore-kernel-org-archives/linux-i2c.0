From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 7/7] i2c-designware: switch to use runtime PM
 autosuspend
Date: Wed, 10 Apr 2013 14:56:20 +0300
Message-ID: <20130410115620.GC1283@intel.com>
References: <1365590202-1623-1-git-send-email-mika.westerberg@linux.intel.com>
 <1365590202-1623-7-git-send-email-mika.westerberg@linux.intel.com>
 <CAM=Q2cvp3U=-SDdWwjZQScSgesUD4Oq4_Om=sE7JNPko-HtVoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2cvp3U=-SDdWwjZQScSgesUD4Oq4_Om=sE7JNPko-HtVoQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Ruppert <christian.ruppert@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 10, 2013 at 05:13:57PM +0530, Shubhrajyoti Datta wrote:
> Hi Mika,
> 
> 
> 
> On Wed, Apr 10, 2013 at 4:06 PM, Mika Westerberg <
> mika.westerberg@linux.intel.com> wrote:
> 
> > Using autosuspend helps to reduce the resume latency in situations where
> > another I2C message is going to be started soon. For example with HID over
> > I2C touch panels we get several messages in a short period of time while
> > the touch panel is in use.
> >
> Also the time to autosuspend could  be a macro just in case someone wants
> to tweak it.
> 
> Just a suggestion.

Well, you can always do that via sysfs /sys/.../power/autosuspend_delay_ms
(or whatever the name of the file is).

> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/i2c/busses/i2c-designware-core.c    |    3 ++-
> >  drivers/i2c/busses/i2c-designware-pcidrv.c  |    3 ++-
> >  drivers/i2c/busses/i2c-designware-platdrv.c |    3 ++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c
> > b/drivers/i2c/busses/i2c-designware-core.c
> > index 7c10c5b..21fbb34 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -600,7 +600,8 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg
> > msgs[], int num)
> >         ret = -EIO;
> >
> >  done:
> > -       pm_runtime_put(dev->dev);
> > +       pm_runtime_mark_last_busy(dev->dev);
> > +       pm_runtime_put_autosuspend(dev->dev);
> >         mutex_unlock(&dev->lock);
> >
> >         return ret;
> > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > index aacb64e..c8797e2 100644
> > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > @@ -291,7 +291,8 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
> >         /* Increase reference counter */
> >         get_device(&pdev->dev);
> >
> > -       pm_runtime_put_noidle(&pdev->dev);
> > +       pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> > +       pm_runtime_use_autosuspend(&pdev->dev);
> >         pm_runtime_allow(&pdev->dev);
> >
> 
> Could you explain this?

Hmm, I'm not sure what you mean. In the above we enable autosuspend and set
the delay. Am I missing something?
