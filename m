Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0AD3E559F
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180148; cv=none; b=WvuzvXL+KhBVesxBhiJEIeIoOF34ax7zUDnpiOmUnxkQ4WVYA7xYJnecw7ZrH+M/JjPk8zgtB/fkPt7ZsAEdwmXYXguuNEiqKLOPp0p3dq7tDUGhKfFRw/ZljotC+H5yi6YQpWGn6CPAP12HyQPRQyENPQkZy6ZK41MPTwrGlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180148; c=relaxed/simple;
	bh=uAg7yvTbG/5q1gosYB1549ltiBRHNpEsmfMFqy3jHOg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FEt0GXtmE44D/Iv7+buv2RsDM1DcT8P2QCH+WUVaCZtlFQdtHIP8NrQ5usuA/fIgJiOZC4smdMApHp5b3wyxrxTv9ZZqmWRO1yGkvon3czJmFv/dzsryj3N+h5AnpRdZvQU6smbvJwSGX//+eK6fSBg/NSSkNuwT0RGmNLP/A+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qSRHcn+l; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qSRHcn+l"
Received: from [IPV6:2a01:cb1d:8f2:800:77df:2bd9:9512:fa38] (unknown [IPv6:2a01:cb1d:8f2:800:77df:2bd9:9512:fa38])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DAEA37CA;
	Tue, 19 May 2026 10:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1779180132;
	bh=uAg7yvTbG/5q1gosYB1549ltiBRHNpEsmfMFqy3jHOg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=qSRHcn+lzeu6fDeaUcxPlTE3lkBrWPG/abpXHks6LmGtSBYVq6A6ioTC24EZ8hlYT
	 DUro/YUHjsAAGZdWm2/44hI/tbarw4K7F2eb2oeZ09i78pk9i1P0U4VIZZ5GqHs/fV
	 nvSVgujyz7x03K+oG+L/y2nYX5sVY6mJK5f8pcYo=
Message-ID: <aa1a6931-1a98-4f72-b8fc-ae05df28f931@ideasonboard.com>
Date: Tue, 19 May 2026 10:42:21 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dan Scally <dan.scally@ideasonboard.com>
Subject: Re: [PATCH v2 1/2] i2c: imx: Don't recover bus when arbitration lost
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Andi Shyti <andi.shyti@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Gao Pan <b54642@freescale.com>,
 Fugang Duan <B38611@freescale.com>, Wolfram Sang <wsa@kernel.org>
References: <20260424-i2c-imx-fixes-v2-0-34fb9504aaeb@ideasonboard.com>
 <20260424-i2c-imx-fixes-v2-1-34fb9504aaeb@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260424-i2c-imx-fixes-v2-1-34fb9504aaeb@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Oleksij / all

On 24/04/2026 13:36, Daniel Scally wrote:
> In i2c_imx_xfer_common(), the driver attempts bus recovery whenever
> i2c_imx_start() fails. One of the failure modes for i2c_imx_start()
> is an arbitration-lost signal which results when a second I2C master
> on the bus tries to control the bus simultaneously, which is a normal
> and expected behaviour.
> 
> Bus recovery is not the right response for this case. Add a check for
> the -EAGAIN return code to avoid running the bus recovery.
> 
> Fixes: 1c4b6c3bcf30d ("i2c: imx: implement bus recovery")
> Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
> ---

I raised this patch after we had issues with one of the i2c controllers on imx8mp. In that case, the 
bus had multiple masters that were causing the SoC's i2c controller to lose arbitration. The result 
was that the framework attempted to run i2c_generic_scl_recovery() and regularly hit the "SCL is 
stuck low, exit recovery" message [1] because the bus was busy rather than stuck.

I'm now experiencing a different issue with the imx8mp in which a different controller - which isn't 
on a multiple-masters bus - starts transacting fine early in boot, but then seems to get stuck - any 
attempt to start a transaction by either a driver or i2ctransfer results in the IAL bit in I2C_I2SR 
being set and so the driver reports that it's lost arbitration [2]. In this case, the bus recovery 
is needed to fix the problem, and so this commit hurts things rather than helps them. This problem 
isn't consistent - I get it on maybe 10% of boots.

I'm trying to find a way to handle the two problems together. I can move the retries into the 
i2x-imx driver like below, and that works so far:

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a208fefd3c3b3..cee333236646a 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1551,7 +1551,20 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
         int use_dma = 0;

         /* Start I2C transfer */
-       result = i2c_imx_start(i2c_imx, atomic);
+       for (unsigned int try = 0; try <= 3; try++) {
+               result = i2c_imx_start(i2c_imx, atomic);
+               if (result == -EAGAIN) {
+                       i2c_imx_stop(i2c_imx, atomic);
+
+                       if (i2c_imx->slave)
+                               i2c_imx_slave_init(i2c_imx);
+
+                       continue;
+               }
+
+               break;
+       }
+
         if (result) {
                 /*
                  * Bus recovery uses gpiod_get_value_cansleep() which is not

That way it retries 3 times if i2c_bus_busy() reports -EAGAIN from lost arbitration, but then gives 
up and runs the bus recovery if none of the retries works. I do wonder why the i2c controller is 
setting the IAL bit though given there's no other master on the bus. If I use a logic analyser to 
track traffic on the bus I can't see anything anomalous, so I thought I'd check whether anyone has 
experienced something similar before.


[1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/i2c/i2c-core-base.c#L254
[2] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/i2c/busses/i2c-imx.c#L548

>   drivers/i2c/busses/i2c-imx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index a208fefd3c3b35672a00eda8448f24859aaa793a..b68a0f7105682006bbcfee52891c9a9c2d8c009e 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1552,7 +1552,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>   
>   	/* Start I2C transfer */
>   	result = i2c_imx_start(i2c_imx, atomic);
> -	if (result) {
> +	if (result && result != -EAGAIN) {
>   		/*
>   		 * Bus recovery uses gpiod_get_value_cansleep() which is not
>   		 * allowed within atomic context.
> 

