From: Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Tue, 4 Dec 2018 12:59:49 -0800
Message-ID: <CAGp9LzpBn=bdRa_jf7+R1hPm7GC+San_63ZOG7U6W3ToaEzjaQ@mail.gmail.com>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com> <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: qii.wang@mediatek.com
Cc: wsa@the-dreams.de, devicetree@vger.kernel.org, ryder.lee@mediatek.com, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 3, 2018 at 5:34 AM <qii.wang@mediatek.com> wrote:
>
> From: qii wang <qii.wang@mediatek.com>
>
> Add MT8183 i2c binding to binding file. Compare to 2712 i2c
> controller, MT8183 has different registers, offsets, clock,
> and multi-user function.
>
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> index 7729e57..dfde624 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> @@ -12,14 +12,15 @@ Required properties:
>        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
>        "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek mt7629
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

if arb is optional, the multi-user function still can work? arb seems
like the clock fed to arbitrating bus when multiple users are
accessing at the same time.

> +    have-pmic need include "pmic" extra.
>
>  Optional properties:
>    - clock-frequency: Frequency in Hz of the bus when transfer, the default value
> @@ -27,6 +28,8 @@ Optional properties:
>    - mediatek,have-pmic: platform can control i2c form special pmic side.
>      Only mt6589 and mt8135 support this feature.
>    - mediatek,use-push-pull: IO config use push-pull mode.
> +  - ch-offset: base reg offset for multi-user.

add a vendor prefix if the property is vendor-specific one.

> +  - mediatek,share-i3c: i3c controller can share i2c function.
>
>  Example:
>
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
