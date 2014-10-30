From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: I2C OF IRQ parsing issue due to probe ordering
Date: Thu, 30 Oct 2014 14:53:42 +0200
Message-ID: <1718941.Qj8UzhsRTh@avalon>
References: <2287003.09eTeKUr1V@avalon> <20141027125819.GA12641@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20141027125819.GA12641@katana>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram and Thierry,

On Monday 27 October 2014 13:58:19 Wolfram Sang wrote:
> > The i2c@e6520000 node is probed before the gpio@e6051000 node. The
> > of_i2c_register_devices() function tries to register all children,
> > including hdmi@39. It tries to parse and map the I2C client IRQ by
> > calling irq_of_parse_and_map(), which returns 0 as the interrupt
> > controller isn't probed yet. The adv7511 driver later probes the hdmi@39
> > device and gets client->irq set to 0.
> 
> I've got this strange feeling of deja vu... Ah, here: Thierry Reding
> tackled this problem a year ago. His series:

Thanks for the pointer.

> https://lkml.org/lkml/2013/9/16/111 (of/irq: Defer interrupt reference
> resolution)
> 
> He did a V2 (which never made it to the i2c list). Seems like the first
> two patches made it and the rest got stalled without discussion?
> 
> https://lkml.org/lkml/2013/9/18/216
> 
> Adding Thierry to the queue. Maybe he can bring some light to what
> happened to his series.

That's exactly what I need :-) Thierry, do you plan to respin the series ?

-- 
Regards,

Laurent Pinchart

