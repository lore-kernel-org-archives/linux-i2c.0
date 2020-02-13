From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2] i2c: altera: Fix potential integer overflow
Date: Thu, 13 Feb 2020 09:58:15 +0000
Message-ID: <c3f7553c759c46539065a8122538c248@AcuMS.aculab.com>
References: <20200211144704.GA6461@embeddedor> <20200213090959.GA2123@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:27682 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729422AbgBMJ6V (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 13 Feb 2020 04:58:21 -0500
In-Reply-To: <20200213090959.GA2123@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Thor Thayer <thor.thayer@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Wolfram Sang
> Sent: 13 February 2020 09:10
> 
> On Tue, Feb 11, 2020 at 08:47:04AM -0600, Gustavo A. R. Silva wrote:
> > Factor out 100 from the equation and do 32-bit arithmetic (3 * clk_mhz / 10)
> > instead of 64-bit.
> >
> > Notice that clk_mhz is MHz, so the multiplication will never wrap 32 bits
> > and there is no need for div_u64().
> 
> Was there ever? With
> 
> 	u32 clk_mhz = clk_get_rate(idev->i2c_clk) / 1000000;
> 
> a later multiplication with 300 should not wrap u32?
> 
> >  	/* SDA Hold Time, 300ns */
> > -	writel(div_u64(300 * clk_mhz, 1000), idev->base + ALTR_I2C_SDA_HOLD);
> > +	writel(3 * clk_mhz / 10, idev->base + ALTR_I2C_SDA_HOLD);
> 
> The change itself is OK, yet I wonder about the comment above:
> 
> 'clk_mhz * 0.3' will not give a constant 300ns, or?

Depends on the definition of the register.
A count of zero may mean one clock period.
So maybe it could have (3 * clk - 1)/10 instead of (3 * clk + 9)/10.
OTOH nothing probably requires that much hold time.

If that is the 'standard' Altera Avalon slave I2C 'megafunction' I2C
master then it is probably so slow to use it can't matter.
Most of those blocks are crap, they aren't even small.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
