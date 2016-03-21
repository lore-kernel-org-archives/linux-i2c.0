From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [RESEND PATCH V7 4/6] i2c: qup: Add bam dma capabilities
Date: Mon, 21 Mar 2016 19:31:27 +0530
Message-ID: <004901d1837a$2df9f620$89ede260$@codeaurora.org>
References: <1456142895-32646-1-git-send-email-sricharan@codeaurora.org> <20160224101949.GB1391@katana>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56151 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861AbcCUOBh (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Mar 2016 10:01:37 -0400
In-Reply-To: <20160224101949.GB1391@katana>
Content-Language: en-us
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi wolfram,

> On Mon, Feb 22, 2016 at 05:38:15PM +0530, Sricharan R wrote:
> > QUP cores can be attached to a BAM module, which acts as a dma engine
> > for the QUP core. When DMA with BAM is enabled, the BAM consumer
> pipe
> > transmitted data is written to the output FIFO and the BAM producer
> > pipe received data is read from the input FIFO.
> >
> > With BAM capabilities, qup-i2c core can transfer more than
> > 256 bytes, without a 'stop' which is not possible otherwise.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > Reviewed-by: Andy Gross <andy.gross@linaro.org>
> > Tested-by: Archit Taneja <architt@codeaurora.org>
> > Tested-by: Telkar Nagender <ntelkar@codeaurora.org>
> 
> Applied to for-next, thanks!

There is a bug with only this patch which comes out when CONFIG_DEBUG_SG
option gets
enabled.  I have patch like below to fix it, but wanted to ask you if it
would correct to have this in the
original patch or should I sent a separate fix ? Sorry for the mess on this.
Not sure if the pull request is sent
already.

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 23eaabb..a1fae0c 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -595,9 +595,6 @@ static int qup_sg_set_buf(struct scatterlist *sg, void
*buf,
 	if (!ret)
 		return -EINVAL;
 
-	if (!map)
-		sg_dma_address(sg) = tg->addr + ((u8 *)buf - tg->start);
-
 	return 0;
 }
 
@@ -1268,6 +1265,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 		}
 	}
 
+	idx = 0;
+
 	do {
 		if (msgs[idx].len == 0) {
 			ret = -EINVAL;
@@ -1407,27 +1406,21 @@ static int qup_i2c_probe(struct platform_device
*pdev)
 
 		/* 2 tag bytes for each block + 5 for start, stop tags */
 		size = blocks * 2 + 5;
-		qup->dpool = dma_pool_create("qup_i2c-dma-pool", &pdev->dev,
-					     size, 4, 0);
 
-		qup->start_tag.start = dma_pool_alloc(qup->dpool,
GFP_KERNEL,
-						      &qup->start_tag.addr);
+		qup->start_tag.start = devm_kzalloc(&pdev->dev,
+						    size, GFP_KERNEL);
 		if (!qup->start_tag.start) {
 			ret = -ENOMEM;
 			goto fail_dma;
 		}
 
-		qup->brx.tag.start = dma_pool_alloc(qup->dpool,
-						    GFP_KERNEL,
-						    &qup->brx.tag.addr);
+		qup->brx.tag.start = devm_kzalloc(&pdev->dev, size,
GFP_KERNEL);
 		if (!qup->brx.tag.start) {
 			ret = -ENOMEM;
 			goto fail_dma;
 		}
 
-		qup->btx.tag.start = dma_pool_alloc(qup->dpool,
-						    GFP_KERNEL,
-						    &qup->btx.tag.addr);
+		qup->btx.tag.start = devm_kzalloc(&pdev->dev, size,
GFP_KERNEL);
 		if (!qup->btx.tag.start) {
 			ret = -ENOMEM;
 			goto fail_dma;
@@ -1566,13 +1559,6 @@ static int qup_i2c_remove(struct platform_device
*pdev)
 	struct qup_i2c_dev *qup = platform_get_drvdata(pdev);
 
 	if (qup->is_dma) {
-		dma_pool_free(qup->dpool, qup->start_tag.start,
-			      qup->start_tag.addr);
-		dma_pool_free(qup->dpool, qup->brx.tag.start,
-			      qup->brx.tag.addr);
-		dma_pool_free(qup->dpool, qup->btx.tag.start,
-			      qup->btx.tag.addr);
-		dma_pool_destroy(qup->dpool);
 		dma_release_channel(qup->btx.dma);
 		dma_release_channel(qup->brx.dma);
 	}
--

Regards,
 Sricharan
