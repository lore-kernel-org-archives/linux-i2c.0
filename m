From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
Date: Thu, 9 Aug 2018 17:13:20 +0800
Message-ID: <1533806000.3347.6.camel@mtksdaap41>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
         <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
         <20180808205752.llowh4bvu2wkuhga@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808205752.llowh4bvu2wkuhga@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jun Gao <jun.gao@mediatek.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2018-08-08 at 22:57 +0200, Wolfram Sang wrote:
> On Sat, Jul 07, 2018 at 05:29:54PM +0800, Jun Gao wrote:
> > From: Jun Gao <jun.gao@mediatek.com>
> > 
> > This function is needed by i2c_get_dma_safe_msg_buf() potentially.
> > It is used to free DMA safe buffer when DMA operation fails.
> > 
> > Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> 
> Right, we need something like this. This leaks in the sh_mobile driver,
> too :(
> 
> I am still thinking if there is a nice way to put this functionality
> into i2c_release_dma_safe_msg_buf() itself somehow...

Wolfram,

I have second thought on these API now. Recently, we have saw similar
issue for spi device driver.

I believe the reason for these api is because some arch changed to can
not do DMA on stack recently. Maybe we should have dma_mapping to bounce
buffer like it bounce un-dma-able address for those arch? or we should
have a common driver API for this, not just for i2c?

Joe.C
