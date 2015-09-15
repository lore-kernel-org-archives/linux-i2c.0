From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: core: fix a code to suppress a warning
Date: Tue, 15 Sep 2015 16:34:12 +0300
Message-ID: <1442324052.8361.41.camel@linux.intel.com>
References: <1442311867-60185-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <55F80047.4000805@mentor.com> <1442318818.8361.29.camel@linux.intel.com>
	 <55F8134F.5080401@mentor.com> <20150915130049.GB1525@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150915130049.GB1525@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-09-15 at 15:00 +0200, Wolfram Sang wrote:
> > 
> > > > I2C_M_RD is defined as 1, probably (msg->flags & I2C_M_RD) is 
> > > > good
> > > > enough here.
> > > 
> > > Today is 1, tomorrow is 0x80, so, I would stay as I put in the 
> > > initial
> > > fix.
> > 
> > I believe I2C_M_RD will never get any other value than 1, since 
> > this
> > value is deliberately set to 1 and it is in active use by userspace
> > applications for years, nobody intends to break ABI tomorrow.
> 
> I agree. That is one thing that permanently slips through the cracks,
> but I wanted to add a comment saying the I2C_M_RD is guaranteed to be 
> 1
> and then simplify the drivers.

Yes, with comment on I2C_M_RD we may drop wrong assumptions.

> 
> Maybe I should start with the comment right now...

Please, update my patch accordingly, or ping me to update it.
Right now busy with something else.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
