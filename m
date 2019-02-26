From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Tue, 26 Feb 2019 10:41:53 -0600
Message-ID: <20190226164153.GA10352@bogus>
References: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
 <1551186660-16902-3-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551186660-16902-3-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qii Wang <qii.wang@mediatek.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 26, 2019 at 09:10:57PM +0800, Qii Wang wrote:
> Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
> controller, MT8183 has different registers, offsets, and clock.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
