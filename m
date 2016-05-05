From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 2/2] drivers: i2c: qup: Fix error handling
Date: Thu, 5 May 2016 12:22:19 -0500
Message-ID: <20160505172219.GB6533@hector.attlocal.net>
References: <1462166637-16778-1-git-send-email-sricharan@codeaurora.org>
 <1462166637-16778-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36088 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbcEERWV (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2016 13:22:21 -0400
Received: by mail-oi0-f51.google.com with SMTP id x201so110430456oif.3
        for <linux-i2c@vger.kernel.org>; Thu, 05 May 2016 10:22:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462166637-16778-3-git-send-email-sricharan@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, May 02, 2016 at 10:53:57AM +0530, Sricharan R wrote:
> Among the bus errors reported from the QUP_MASTER_STATUS register
> only NACK is considered and transfer gets suspended, while
> other errors are ignored. Correct this and suspend the transfer
> for other errors as well. This avoids unnessecary 'timeouts' which
> happens when waiting for events that would never happen when there
> is already an error condition on the bus.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)

Reviewed-by: Andy Gross <andy.gross@linaro.org>

<snip>

> @@ -1227,6 +1240,9 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>  	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
>  	int ret, len, idx = 0, use_dma = 0;
>  
> +	qup->bus_err = 0;
> +	qup->qup_err = 0;
> +

What about the initial setting of these?  Does this need to be removed from the
main xfer function?

>  	ret = pm_runtime_get_sync(qup->dev);
>  	if (ret < 0)
>  		goto out;
