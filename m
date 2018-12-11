From: mtk15107 <qii.wang@mediatek.com>
Subject: Re: [PATCH 1/5] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
Date: Tue, 11 Dec 2018 14:28:28 +0800
Message-ID: <1544509708.14641.6.camel@mhfsdcap03>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
         <1543843974-4054-2-git-send-email-qii.wang@mediatek.com>
         <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Wang <sean.wang@kernel.org>
Cc: wsa@the-dreams.de, devicetree@vger.kernel.org, ryder.lee@mediatek.com, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-12-04 at 12:19 -0800, Sean Wang wrote:
> <qii.wang@mediatek.com> 於 2018年12月3日 週一 上午5:34寫道：
> >
> > From: qii wang <qii.wang@mediatek.com>
> >
> > Add MT7629 i2c binding to i2c-mt2712.txt and there is no need to
> 
> where's i2c-mt2712.txt mentioned here?
> 

Sorry, I will rewrite this commit. Such as:

Add MT7629 i2c binding to binding file. 

> > modify i2c driver.
> 
> suggest not to mention driver in any dt-binding, dt-binding self
> should be os-agnostic
> 

Yes, I will remove it.

> >
> > Signed-off-by: qii wang <qii.wang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > index e199695..7729e57 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > @@ -10,6 +10,7 @@ Required properties:
> >        "mediatek,mt6589-i2c": for MediaTek MT6589
> >        "mediatek,mt7622-i2c": for MediaTek MT7622
> >        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
> > +      "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek mt7629
> 
> change mt7629 to MT7629 to align to the others
> 

OK.

> >        "mediatek,mt8173-i2c": for MediaTek MT8173
> >    - reg: physical base address of the controller and dma base, length of memory
> >      mapped region.
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
