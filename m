From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c:imx: use IRQF_SHARED mode to request IRQ
Date: Wed, 11 Oct 2017 10:05:30 +0200
Message-ID: <20171011080530.hz7f5gjbchdgxjcp@pengutronix.de>
References: <1507708640-11622-1-git-send-email-wei.jinhua1@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33259 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757054AbdJKIFf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 11 Oct 2017 04:05:35 -0400
Content-Disposition: inline
In-Reply-To: <1507708640-11622-1-git-send-email-wei.jinhua1@zte.com.cn>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wei Jinhua <wei.jinhua1@zte.com.cn>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, jochen@scram.de, jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn

On Wed, Oct 11, 2017 at 03:57:20PM +0800, Wei Jinhua wrote:
> Some SoC share one irq number between I2C controllers. 
> For example, on the LS2088 board, I2C 1 and I2C 2 share 
> one irq number. In this case, only one I2C controller 
> can register successfully, and others will fail.
> 
> Signed-off-by: Wei Jinhua <wei.jinhua1@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>

The irq handler seems to be prepared for this, too (i.e. it returns
IRQ_NONE if no irq is pending), so:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
