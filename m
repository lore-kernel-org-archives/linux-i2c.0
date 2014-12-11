From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Date: Thu, 11 Dec 2014 09:47:29 +0200
Message-ID: <8247960.gkSH1BQ5uX@avalon>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de> <20141211050226.GJ16827@intel.com> <20141211073727.GA1252@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141211073727.GA1252@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 11 December 2014 08:37:27 Wolfram Sang wrote:
> > I think this is a limitation of driver may not be for HW. The right model
> > for dma_chan is to be viewed as SW channels and not the ones of HW (yes
> > that is how most of the drivers use that, but we can improve upon)
> > 
> > If we rework the driver to view dma_chan as SW channels, then you can
> > accept multiple channel requests and accept based on if we are able link
> > the channel to that peripheral or not.
> 
> In my understanding, the DMA driver does exactly that.

Actually it doesn't at the moment, I should implement that.

> However, it is not even loaded at the time the I2C driver wants a channel,
> so the dmaengine core defers the probe. That is the problem for optional DMA
> channels: we can't know when deferring probe won't help anymore and don't
> know when it is time to fall back to PIO.

This is true regardless of the whether the driver exposes HW or SW channels.

-- 
Regards,

Laurent Pinchart

