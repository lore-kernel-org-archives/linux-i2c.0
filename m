From: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Thu, 21 Feb 2019 21:32:09 +0800
Message-ID: <1550755929.30363.26.camel@mhfsdcap03>
References: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
         <1550666030-30211-3-git-send-email-qii.wang@mediatek.com>
         <e9d544c8-576d-f52c-d805-90d695b7ed46@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e9d544c8-576d-f52c-d805-90d695b7ed46@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: wsa@the-dreams.de, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com, xinping.qian@mediatek.com, linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2019-02-20 at 16:25 +0100, Matthias Brugger wrote:
> 
> On 20/02/2019 13:33, Qii Wang wrote:
> > Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
> > controller, MT8183 has different registers, offsets, and clock.
> > 
> > Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > index ee4c324..da2fa60 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > @@ -12,14 +12,15 @@ Required properties:
> >        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
> >        "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
> >        "mediatek,mt8173-i2c": for MediaTek MT8173
> > +      "mediatek,mt8183-i2c": for MediaTek MT8183
> >    - reg: physical base address of the controller and dma base, length of memory
> >      mapped region.
> >    - interrupts: interrupt number to the cpu.
> >    - clock-div: the fixed value for frequency divider of clock source in i2c
> >      module. Each IC may be different.
> >    - clocks: clock name from clock manager
> > -  - clock-names: Must include "main" and "dma", if enable have-pmic need include
> > -    "pmic" extra.
> > +  - clock-names: Must include "main" and "dma", "arb" is optional, if enable
> > +    have-pmic need include "pmic" extra.
> 
> You have to mention that the arb clock is only necessary for mt8183.
> 

Arb clock is not only necessary for mt8183. When two i2c controllers are
internally connected to the same GPIO pins, the arb clock is needed to
ensure that the waveforms do not interfere with each other.
Maybe ""arb" is for multi-master" is better. Not all i2c controller have
multi-master.

> >  
> >  Optional properties:
> >    - clock-frequency: Frequency in Hz of the bus when transfer, the default value
> > 
