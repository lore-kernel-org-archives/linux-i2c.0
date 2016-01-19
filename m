From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V7 0/6] i2c: qup: Add support for v2 tags and bam dma
Date: Tue, 19 Jan 2016 15:44:03 +0530
Message-ID: <000101d152a2$23bb1da0$6b3158e0$@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32904 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbcASKOP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 05:14:15 -0500
In-Reply-To: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
Content-Language: en-us
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi wolfram,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Sricharan R
> Sent: Tuesday, January 19, 2016 3:33 PM
> To: wsa@the-dreams.de
> Cc: devicetree@vger.kernel.org; architt@codeaurora.org; linux-arm-
> msm@vger.kernel.org; ntelkar@codeaurora.org; galak@codeaurora.org;
> linux-kernel@vger.kernel.org; andy.gross@linaro.org; linux-
> i2c@vger.kernel.org; iivanov@mm-sol.com; agross@codeaurora.org;
> dmaengine@vger.kernel.org; sricharan@codeaurora.org; linux-arm-
> kernel@lists.infradead.org
> Subject: [PATCH V7 0/6] i2c: qup: Add support for v2 tags and bam dma
> 
> i2c: qup: Add support for v2 tags and bam dma
> 
> QUP from version 2.1.1 onwards, supports a new format of i2c command
> tags.
> Tag codes instructs the controller to perform a operation like read/write.
> This new tagging version is required for adding bam dma capabilities.
> V2 tags supports transfer of more than 256 bytes in a single i2c
transaction.
> Also adding bam dma support facilitates transferring each i2c_msg in
> i2c_msgs without a 'stop' bit in between which is required for some of the
> clients.
> 
> Tested this series on apq8074 dragon board eeprom client on i2c bus1
> 
> [V7] Added tested-by tags and fixed a small comment
> 
> [V6] Added review tags and fixed a checkpatch warning in patch 4/6.
> 
> [V5] Addressed few more comments from Ivan T. Ivanov.
>      Squashed patch 2 and 3 as no point in having only few lines of
>      common code between v1 and v2 tags for increased complexity.
>      Couple of non functional review comments fixes in patch 3, 4.
>      Added a change in patch 4 to have proper transfer completion in
>      a corner case. patch 5, 6 unchanged.
> 
> [V4] Added a patch to factor out some common code.
>      Removed support for freq > 400KHZ as per comments.
>      Addressed comments from Ivan T. Ivanov to keep the code for
>      V2 support in a separate path.
>      Changed the authorship of V2 tags support patch.
> 
> [V3] Added support to coalesce each i2c_msg in i2c_msgs for fifo and
>      block mode in Patch 2. Also addressed further code comments.
> 
>      http://comments.gmane.org/gmane.linux.drivers.i2c/22497
> 
> [V2] Addressed comments from Ivan T. Ivanov, Andy Gross [v1] Initial
> Version
> 
> Sricharan R (6):
>   i2c: qup: Change qup_wait_writeready function to use for all timeouts
>   i2c: qup: Add V2 tags support
>   i2c: qup: Transfer each i2c_msg in i2c_msgs without a stop bit
>   i2c: qup: Add bam dma capabilities
>   dts: msm8974: Add blsp2_bam dma node
>   dts: msm8974: Add dma channels for blsp2_i2c1 node
> 
 Wolfram,  Does the first 4 patches looks good to be picked up  ?

Regards,
 Sricharan
