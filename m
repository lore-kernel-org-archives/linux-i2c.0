From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: imx: silence dma_request_slave_channel errors
 if dma not set up in device tree
Date: Thu, 22 Jan 2015 15:48:31 +0100
Message-ID: <1421938111.3084.29.camel@pengutronix.de>
References: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
	 <20150114141407.GA1598@katana> <20150122143346.GE3413@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150122143346.GE3413@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am Donnerstag, den 22.01.2015, 15:33 +0100 schrieb Wolfram Sang:
> On Wed, Jan 14, 2015 at 03:14:07PM +0100, Wolfram Sang wrote:
> > On Tue, Jan 06, 2015 at 03:48:19PM +0100, Philipp Zabel wrote:
> > > If the i2c device tree nodes don't contain the dmas and dma-names property, an
> > > error is displayed for each i2c device:
> > > 
> > >     of_dma_request_slave_channel: dma-names property of node '/soc/aips-bus@02100000/i2c@021a0000' missing or empty
> > > 
> > > This patch avoids calling dma_request_slave_channel if the dma-names property
> > > does not exist in the device tree in the first place.
> > > 
> > > Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > 
> > Aren't you curing the symptoms instead of the cause? Sending a
> > counterpatch in a second...
> 
> Setting to superseded because of my counterpatch fixing this in the
> dmaengine core. Maybe you want to ack that? :)

Absolutely!
