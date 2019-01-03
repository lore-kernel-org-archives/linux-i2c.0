From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Thu, 3 Jan 2019 13:23:09 -0600
Message-ID: <20190103192309.GA18564@bogus>
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
 <1545397111-24183-6-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545397111-24183-6-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, qii.wang@mediatek.com, ryder.lee@mediatek.com
List-Id: linux-i2c@vger.kernel.org

On Fri, 21 Dec 2018 20:58:30 +0800, qii wang wrote:
> Add MT8183 i2c binding to binding file. Compare to 2712 i2c
> controller, MT8183 has different registers, offsets, clock,
> and multi-user function.
> 
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
