From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: i2c: Add MediaTek MT2712 i2c binding
Date: Wed, 20 Dec 2017 12:43:47 -0600
Message-ID: <20171220184347.o2f5ez3n4vmbrq7w@rob-hp-laptop>
References: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
 <1513666263-6443-2-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44223 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755995AbdLTSnu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Dec 2017 13:43:50 -0500
Content-Disposition: inline
In-Reply-To: <1513666263-6443-2-git-send-email-jun.gao@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Matthias Brugger <matthias.bgg@gmail.com>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

On Tue, Dec 19, 2017 at 02:51:01PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
> 
> Add MT2712 i2c binding to binding file. Compare to MT8173 i2c
> controller, MT2712 has timing adjust registers which can adjust
> the internal divider of i2c source clock, SCL duty cycle, SCL
> compare point, start(repeated start) and stop time, SDA change
> time.
> 
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
