From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [1/7] i2c-designware: move to managed functions (devm_*)
Date: Tue, 9 Apr 2013 11:20:55 +0200
Message-ID: <20130409092055.GC3624@the-dreams.de>
References: <1363867800-23861-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130409090032.GA28509@the-dreams.de>
 <20130409092212.GE21818@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130409092212.GE21818@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Jean Delvare <khali@linux-fr.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Ruppert <christian.ruppert@abilis.com>
List-Id: linux-i2c@vger.kernel.org


> > >  	i2c_dw_disable_int(dev);
> > > -	r = request_irq(dev->irq, i2c_dw_isr, IRQF_SHARED, pdev->name, dev);
> > > +	r = devm_request_irq(&pdev->dev, dev->irq, i2c_dw_isr, IRQF_SHARED,
> > > +			pdev->name, dev);
> > 
> > Is it ensured that no interrupts will happen during remove? Because the
> > adapter will be deleted before devm will free the interrupt.
> 
> Both platform and PCI driver disable the controller in their remove
> function, and interrupts will be disabled as well. Is this enough or should
> we handle this differently?

That's fine. Thanks!
