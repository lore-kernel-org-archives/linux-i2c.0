From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c: Add MediaTek MT7622 i2c binding
Date: Tue, 22 Aug 2017 19:36:29 -0500
Message-ID: <20170823003629.pwnuashutcqujdmb@rob-hp-laptop>
References: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
 <1503286614-17670-3-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1503286614-17670-3-git-send-email-jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 21, 2017 at 11:36:53AM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> Add MT7622 i2c binding to binding file. Compare to MT8173 i2c
> controller, MT7622 limits message numbers to 255, and does not
> support 4GB DMA mode.
> 
> Signed-off-by: Jun Gao <jun.gao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
