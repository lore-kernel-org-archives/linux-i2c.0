From: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [RESEND PATCH 1/2] dt-bindings: i2c: Add MediaTek MT7622 i2c
 binding
Date: Thu, 10 Aug 2017 16:19:00 +0800
Message-ID: <1502353140.17420.7.camel@mtksdaap41>
References: <1502332061-25085-1-git-send-email-jun.gao@mediatek.com>
         <1502332061-25085-2-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:47450 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750735AbdHJITG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 10 Aug 2017 04:19:06 -0400
In-Reply-To: <1502332061-25085-2-git-send-email-jun.gao@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2017-08-10 at 10:27 +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT7622 i2c binding to binding file. Compare to MT8173 i2c
> controller, MT7622 limits message numbers to 255, and does not
> support 4GB DMA mode.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> index bd5a7be..ff9ac61 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> @@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
>  
>  Required properties:
>    - compatible: value should be either of the following.
> -      "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek mt2701
> -      "mediatek,mt6577-i2c": for i2c compatible with mt6577.
> -      "mediatek,mt6589-i2c": for i2c compatible with mt6589.
> -      "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for i2c compatible with mt7623.
> -      "mediatek,mt8173-i2c": for i2c compatible with mt8173.
> +	"mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek MT2701
> +	"mediatek,mt6577-i2c": for Mediatek MT6577
> +	"mediatek,mt6589-i2c": for Mediatek MT6589

Better not change those and just add compatible strings for mt7622.

> +	"mediatek,mt7622-i2c": for Mediatek MT7622
> +	"mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for Mediatek MT7623
> +	"mediatek,mt8173-i2c": for Mediatek MT8173
>    - reg: physical base address of the controller and dma base, length of memory
>      mapped region.
>    - interrupts: interrupt number to the cpu.
