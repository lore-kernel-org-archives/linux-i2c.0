From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Wed, 20 Feb 2019 16:25:48 +0100
Message-ID: <e9d544c8-576d-f52c-d805-90d695b7ed46@gmail.com>
References: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
 <1550666030-30211-3-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550666030-30211-3-git-send-email-qii.wang@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Qii Wang <qii.wang@mediatek.com>, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com, xinping.qian@mediatek.com, linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



On 20/02/2019 13:33, Qii Wang wrote:
> Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
> controller, MT8183 has different registers, offsets, and clock.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> index ee4c324..da2fa60 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> @@ -12,14 +12,15 @@ Required properties:
>        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
>        "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
>        "mediatek,mt8173-i2c": for MediaTek MT8173
> +      "mediatek,mt8183-i2c": for MediaTek MT8183
>    - reg: physical base address of the controller and dma base, length of memory
>      mapped region.
>    - interrupts: interrupt number to the cpu.
>    - clock-div: the fixed value for frequency divider of clock source in i2c
>      module. Each IC may be different.
>    - clocks: clock name from clock manager
> -  - clock-names: Must include "main" and "dma", if enable have-pmic need include
> -    "pmic" extra.
> +  - clock-names: Must include "main" and "dma", "arb" is optional, if enable
> +    have-pmic need include "pmic" extra.

You have to mention that the arb clock is only necessary for mt8183.

>  
>  Optional properties:
>    - clock-frequency: Frequency in Hz of the bus when transfer, the default value
> 
