From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] i2c: attach/detach I2C client device to the ACPI
 power domain
Date: Thu, 10 Oct 2013 11:26:34 +0300
Message-ID: <20131010082634.GF3521@intel.com>
References: <1381327461-10562-1-git-send-email-mika.westerberg@linux.intel.com>
 <1381327461-10562-3-git-send-email-mika.westerberg@linux.intel.com>
 <20131010080919.GC2638@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131010080919.GC2638@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 10, 2013 at 10:09:19AM +0200, Wolfram Sang wrote:
> On Wed, Oct 09, 2013 at 05:04:20PM +0300, Mika Westerberg wrote:
> > From: Lv Zheng <lv.zheng@intel.com>
> > 
> > If the I2C client device is enumerated from ACPI namespace it might have
> > ACPI methods that needs to be called in order to transition the device to
> > different power states (such as _PSx).
> > 
> > Implement this for I2C client devices by checking if the device has an ACPI
> > handle and if that's the case, attach it to the ACPI power domain. In
> > addition we make sure that the device is fully powered when its ->probe()
> > function gets called.
> > 
> > For non-ACPI devices this patch is a no-op.
> > 
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/i2c/i2c-core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 29d3f04..f25dee3 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -254,10 +254,16 @@ static int i2c_device_probe(struct device *dev)
> >  					client->flags & I2C_CLIENT_WAKE);
> >  	dev_dbg(dev, "probe\n");
> >  
> > +	if (ACPI_HANDLE(&client->dev))
> > +		acpi_dev_pm_attach(&client->dev, true);
> 
> I'd prefer to drop the 'if's in case they are checked inside the acpi_*
> calls anyway. Not a show-stopper, though, so:

OK, I'll drop them then from the final version.

> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 

Thanks!
