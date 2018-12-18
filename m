From: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Tue, 18 Dec 2018 10:35:25 +0800
Message-ID: <1545100525.11699.47.camel@mhfsdcap03>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
         <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
         <20181211202931.xav4gzi7rzh2scgx@ninjato>
         <1544693547.11699.40.camel@mhfsdcap03>
         <20181217230629.i7i3kbreurgt7u73@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181217230629.i7i3kbreurgt7u73@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, ryder.lee@mediatek.com
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-12-18 at 00:06 +0100, Wolfram Sang wrote:
> > > What is "multi-user"? Why can't you add this offset to the reg-property
> > > directly?
> 
> ...
> 
> > MT8183 doesn't need to support muti-user according to the latest project
> > information, and I'll remove this feature from patches.
> 
> Okay. It will be dropped then, thanks for the heads up!
> 
> > > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> > > 
> > > Please explain in more detail? Is this an I3C controller?
> > 
> > Yes, it is a i3c controller, and it is compatible with i2c. I only use
> > the feature of i2c, so I need a flag to do some extra settings.
> 
> Can't you derive this from the compatible? If it is
> "mediatek,mt8183-i2c", then you know you need these extra settings?
> 

Not all channels are i3c controllers in MT8183. only i3c controller need
some extra settings.
