From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware-pci: Fix BUG_ON during device removal
Date: Thu, 13 Feb 2020 19:11:02 +0200
Message-ID: <20200213171102.GC10400@smile.fi.intel.com>
References: <20200213151503.545269-1-jarkko.nikula@linux.intel.com>
 <20200213161854.GA5929@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200213161854.GA5929@ninjato>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 13, 2020 at 05:18:54PM +0100, Wolfram Sang wrote:
> On Thu, Feb 13, 2020 at 05:15:03PM +0200, Jarkko Nikula wrote:
> > Function i2c_dw_pci_remove() -> pci_free_irq_vectors() ->
> > pci_disable_msi() -> free_msi_irqs() will throw a BUG_ON() for MSI
> > enabled device since the driver has not released the requested IRQ before
> > calling the pci_free_irq_vectors().
> > 
> > Here driver requests an IRQ using devm_request_irq() but automatic
> > release happens only after remove callback. Fix this by explicitly
> > freeing the IRQ before calling pci_free_irq_vectors().
> 
> Does it make sense to keep devm for irq handling, then?

Only for sake of better error handling in error path in the ->probe().

-- 
With Best Regards,
Andy Shevchenko
