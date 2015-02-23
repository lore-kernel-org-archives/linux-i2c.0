From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 2/5] i2c-designware-baytrail: fix typo in error path
Date: Mon, 23 Feb 2015 14:54:11 +0200
Message-ID: <1424696051.14897.13.camel@linux.intel.com>
References: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1423587970-19136-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150211164611.GA2712@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150211164611.GA2712@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-02-11 at 17:46 +0100, Wolfram Sang wrote:
> > +				PUNIT_SEMAPHORE, &sem);
> > +	if (ret)
> >  		dev_err(dev->dev, "iosf failed to read punit semaphore\n");
> >  	else
> >  		dev_err(dev->dev, "PUNIT SEM: %d\n", sem);
> 
> Shouldn't the latter be a dev_dbg?

Wolfram, do we agree on this as states in the patch? Maybe you have more
comments, questions?

Otherwise, should I rebase this on top of 4.0-rc1 or you will be okay
with current version?

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy
