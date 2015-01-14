From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use {readl|writel}_relaxed instead of
 readl/writel
Date: Wed, 14 Jan 2015 12:05:09 +0800
Message-ID: <20150114120509.0ba8267e@xhacker>
References: <1418279201-3886-1-git-send-email-jszhang@marvell.com>
	<20150113143654.GG7660@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150113143654.GG7660@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram,

On Tue, 13 Jan 2015 06:36:54 -0800
Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:

> 
> On Thu, Dec 11, 2014 at 02:26:41PM +0800, Jisheng Zhang wrote:
> > readl/writel is too expensive especially on Cortex A9 w/ outer L2 cache.
> > This introduces i2c read/write errors on Marvell BG2/BG2Q SoCs when there
> > are heavy L2 cache maintenance operations at the same time.
> 
> Reading this again, I got a question:
> 
> Really read/write errors? I would think that there is a performance
> penalty because of the memory barriers. But errors?

I dunno whether I can call the issue as error. The situation is one i2c client
has a bit strict timing requirement. Without the patch, if there are heavy L2 cache
maintenance operations at the same time, there may be long delay between each
DW_IC_DATA_CMD write opeartions in i2c_dw_xfer_msg() in the DW_IC_INTR_TX_EMPTY isr.

Thus about 1/300 i2c transactions may be ignored by the i2c client per my test.

> 
> > The driver does not perform DMA, so it's safe to use the relaxed version.
> > From another side, the relaxed io accessor macros are available on all
> > architectures now, so we can use the relaxed versions instead.
> 
> Can the designware core make use of DMA in theory?
> 

the IP can do DMA in theory. But currently, there's no DMA support in the driver.

Thanks for your review,
Jisheng
