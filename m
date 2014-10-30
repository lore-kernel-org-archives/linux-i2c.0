From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: I2C OF IRQ parsing issue due to probe ordering
Date: Thu, 30 Oct 2014 15:22:49 +0200
Message-ID: <2020186.tp9cWKgsNl@avalon>
References: <2287003.09eTeKUr1V@avalon> <1441244.9DO8HMds24@avalon> <20141030132136.GA23852@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20141030132136.GA23852@katana>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thursday 30 October 2014 14:21:36 Wolfram Sang wrote:
> > > See:
> > > 	9ec36cafe43b of/irq: do irq resolution in platform_get_irq
> > > 
> > > I suspect a similar thing could be done for I2C.
> > 
> > That could work. We would need to introduce a new i2c_get_irq() function
> > though. Wolfram, would you be fine with that ?
> 
> I'd think it will look pretty similar to platform_get_irq, no? That is
> fine with me.

It would, but as Thierry pointed out it should be possible to hide the details 
in the I2C core. I'll submit a patch shortly.

-- 
Regards,

Laurent Pinchart

