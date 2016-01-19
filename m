From: ntelkar@codeaurora.org
Subject: Re: [PATCH V6 0/6] i2c: qup: Add support for v2 tags and bam dma
Date: Tue, 19 Jan 2016 07:48:49 -0000
Message-ID: <e45ba8b5efc13a4eda4b5c1b2282facc.squirrel@www.codeaurora.org>
References: <1452588233-1803-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54470 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259AbcASHsv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 02:48:51 -0500
In-Reply-To: <1452588233-1803-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, wsa@the-dreams.de, srichara@codeaurora.org

Added SMB support on top of these patches and tested  i2c with ipmitool.
It works as expected.
Tested-by: ntelkar@codeaurora.org

> i2c: qup: Add support for v2 tags and bam dma
>
> QUP from version 2.1.1 onwards, supports a new format of i2c command tags.
> Tag codes instructs the controller to perform a operation like read/write.
> This new tagging version supports and is required for adding bam dma
> capabilities. V2 tags supports transfer of more than 256 bytes in a single
> i2c
> transaction. Also adding bam dma support facilitates transferring each
> i2c_msg
> in i2c_msgs without a 'stop' bit in between which is required for some of
> the clients.
>
> Tested this series on apq8074 dragon board eeprom client on i2c bus1
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
>  arch/arm/boot/dts/qcom-msm8974.dtsi |  14 +-
>  drivers/i2c/busses/i2c-qup.c        | 922
> ++++++++++++++++++++++++++++++++++--
>  2 files changed, 887 insertions(+), 49 deletions(-)
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
>
