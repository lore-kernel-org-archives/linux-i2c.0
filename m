From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/5] i2c: mux: pca954x: Refactor pca954x_irq_handler()
Date: Fri, 6 Mar 2020 12:02:15 +0200
Message-ID: <20200306100215.GS1224808@smile.fi.intel.com>
References: <20200305155352.39095-1-andriy.shevchenko@linux.intel.com>
 <31d8a07f-a841-d58b-ebc8-3cba39d00a95@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:49522 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgCFKCP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Mar 2020 05:02:15 -0500
Content-Disposition: inline
In-Reply-To: <31d8a07f-a841-d58b-ebc8-3cba39d00a95@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

On Thu, Mar 05, 2020 at 09:34:46PM +0000, Peter Rosin wrote:
> On 2020-03-05 16:53, Andy Shevchenko wrote:
> > Refactor pca954x_irq_handler() to:
> >   - use for_each_set_bit() macro
> >   - use IRQ_RETVAL() macro
> > 
> > Above change makes code easy to read and understand.

> > +	pending = ret >> PCA954X_IRQ_OFFSET;
> > +	for_each_set_bit(i, &pending, data->chip->nchans)
> > +		handle_nested_irq(irq_linear_revmap(data->irq, i));
> > +
> > +	return IRQ_RETVAL(pending);
> 
> What if ret has some bit set above the bit corresponding to the last channel?

We will "handle" spurious interrupt.

> Maybe that's somehow not possible, but if that's the case it's not apparent.

So, does

	pending = (ret >> PCA954X_IRQ_OFFSET) & (BIT(data->chip->nchans) - 1);

satisfy you?

-- 
With Best Regards,
Andy Shevchenko
