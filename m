From: Jun Gao <jun.gao@mediatek.com>
Subject: Re: [I2C] About warning 'DMA-API: device driver maps memory from
 stack'
Date: Sat, 16 Sep 2017 17:33:59 +0800
Message-ID: <1505554439.31793.76.camel@mhfsdcap03>
References: <1504354088.31793.48.camel@mhfsdcap03>
         <20170902215829.3jpwmbyy27cpu5rm@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:18218 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750909AbdIPJeG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 16 Sep 2017 05:34:06 -0400
In-Reply-To: <20170902215829.3jpwmbyy27cpu5rm@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: srv_heupstream@mediatek.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com

On Sat, 2017-09-02 at 23:58 +0200, Wolfram Sang wrote:
> Hi,
> 
> nice to see someone else interested in the I2C & DMA topic.
> 
> Please check this series which I sent out recently:
> 
> "[RFC PATCH v4 0/6] i2c: document DMA handling and add helpers for it"
> 
> In that series, I proposed...
> 
> > 3. kmalloc data buffer instead of local variables buf in function
> > i2c_smbus_xfer_emulated(...)
> 
> ... this solution. Although I have to check Mauro's general response to
> the series first. I'd be interested in what you think of the series,
> too.
Sorry for late reply.

As you said in "[RFC,v4,3/6]i2c: add docs to clarify DMA handling". Most
i2c_msgs are register accesses and thus, small messages. And
"[RFC,v4,4/6] i2c: sh_mobile: use helper to decide if DMA is useful".

Maybe the solution as below will be better. Other drivers which will use
i2c would not have to make buffer DMA safe especially register
accesses(they like to use local variables when data_len = 1 or 2).

solution:
2. use FIFO mode when length<=fifo_depth(mtk i2c fifo_depth=8), use
the flag "I2C_M_DMA_SAFE" to check buffer for DMA mode when
length>fifo_depth in i2c-mt65xx.c .

Thanks.
> 
> Kind regards,
> 
>    Wolfram
> 
