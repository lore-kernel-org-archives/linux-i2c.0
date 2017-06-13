From: Jun Gao <jun.gao@mediatek.com>
Subject: Re: [PATCH v4 2/2] arm: dts: Add Mediatek MT2701 i2c device node
Date: Tue, 13 Jun 2017 18:24:12 +0800
Message-ID: <1497349452.930.36.camel@mhfsdcap03>
References: <1495784107-6711-1-git-send-email-jun.gao@mediatek.com>
         <1495784107-6711-3-git-send-email-jun.gao@mediatek.com>
         <1497268468.930.26.camel@mhfsdcap03>
         <dbfcfd5b-8812-8df2-40dc-42e889577c9a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dbfcfd5b-8812-8df2-40dc-42e889577c9a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2017-06-13 at 11:36 +0200, Matthias Brugger wrote:
> 
> On 12/06/17 13:54, Jun Gao wrote:
> > On Fri, 2017-05-26 at 15:35 +0800, Jun Gao wrote:
> >> From: Jun Gao <jun.gao@mediatek.com>
> >>
> >> Add MT2701 i2c device node.
> >>
> >> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> >> ---
> >>   arch/arm/boot/dts/mt2701-evb.dts | 42 ++++++++++++++++++++++++++++++++++++++++
> >>   arch/arm/boot/dts/mt2701.dtsi    | 42 ++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 84 insertions(+)
> [...]
> > 
> > Dear Matthias,
> > 
> > Could you take this patch together with
> > [PATCH v4 1/2]dt-bindings: i2c: Add Mediatek MT2701 i2c binding ?
> > 
> > Thanks!
> > 
> 
> They are both included in the pull request I send [1] [2], or do I miss 
> something?
> 
> Regards,
> Matthias
> 
> [1] 
> https://github.com/mbgg/linux-mediatek/commit/729b7f8dbdaff270c53052897ea06486221a49a2
> [2] 
> https://github.com/mbgg/linux-mediatek/commit/c6c301d3ff7531894257acc4f4a73928a109bda1

Dear Matthias,

Would you mind to use the same style as follows in i2c-mtk.txt of [2]?

"mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek MT2701
"mediatek,mt6577-i2c": for Mediatek MT6577
"mediatek,mt6589-i2c": for Mediatek MT6589
"mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for Mediatek MT7623
"mediatek,mt8173-i2c": for Mediatek MT8173


Thanks!
