From: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Tue, 19 Feb 2019 21:13:43 +0800
Message-ID: <1550582023.30065.52.camel@mhfsdcap03>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
         <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
         <20190205131641.GF12401@kunai> <1550109268.30065.13.camel@mhfsdcap03>
         <20190215090257.geumssb2cucs7rzt@ninjato>
         <1550316723.30065.44.camel@mhfsdcap03>
         <20190216122915.hchghozcn7ntdkbm@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190216122915.hchghozcn7ntdkbm@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, ryder.lee@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com, Rob Herring <robh@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 2019-02-16 at 13:29 +0100, Wolfram Sang wrote:
> > Maybe you think that MT8183 SoC only has the I3C controllers. Actually,
> > there are I2C and I3C controllers on MT8183 SoC. We will remove
> > "mediatek,share-i3c" for I2C controller driver, so these patches are
> > just to support the I2C controllers on MT8183 SoC. For the I3C
> > controller we will send some new patches which are based on i3c
> > framework directories(kernel/drivers/i3c), not based on
> > i2c-mt65xx.c.
> 
> Sounds perfect to me. If it turns out that the I3C driver can share
> things with the I2C driver, we can discuss it then. But unless we have
> an I3C driver and know for sure, the above strategy seems good to me.
> 

Can I push the V4 patches of I2C controller driver now? or you just want
an I3C driver that is compatible with the I2C controller?

According to our plan, I2C controller will use
i2c-mt65xx.c(kernel/drivers/i2c/busses/)and I3C controller will use
i3c-xxx.c(kernel/drivers/i3c/master/)
