From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/4] i2c: Switch to using gpiod interface for gpio
 bus recovery
Date: Thu, 28 Sep 2017 13:58:24 +0300
Message-ID: <1506596304.16112.155.camel@linux.intel.com>
References: <1504073857-122449-1-git-send-email-preid@electromag.com.au>
         <1504073857-122449-2-git-send-email-preid@electromag.com.au>
         <1506595483.16112.137.camel@linux.intel.com>
         <2ecc500b-42ec-8f30-b8cf-fd646eaaa198@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:20293 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752543AbdI1LEJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 28 Sep 2017 07:04:09 -0400
In-Reply-To: <2ecc500b-42ec-8f30-b8cf-fd646eaaa198@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Phil Reid <preid@electromag.com.au>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org

On Thu, 2017-09-28 at 13:54 +0300, Jarkko Nikula wrote:
> On 09/28/2017 01:44 PM, Andy Shevchenko wrote:
> > > interface. This will allow individual driver to be updated and
> > > tested
> > > individual to switch to using the gpiod interface.
> > >   	int scl_gpio;
> > >   	int sda_gpio;
> > > +	struct gpio_desc *scl_gpiod;
> > > +	struct gpio_desc *sda_gpiod;
> > 
> > I think we even could get rid of plain integers completely.
> > In case some call needs it we can derive it still from the
> > descriptor.
> > 
> 
> I guess it's still worth to split that into multiple patches and
> those 
> driver conversion and integer removal can be follow up patches
> somewhere 
> in the future?

I didn't check and my memory is clean about users.
So, if there are users of those integers outside of I2C core, definitely
we need more patches / iterations.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
