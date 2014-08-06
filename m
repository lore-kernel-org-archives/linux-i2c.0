From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH] i2c: qup: disable clks and return instead of just returning
 error
Date: Wed, 06 Aug 2014 08:19:31 -0400
Message-ID: <53E21D53.30606@codeaurora.org>
References: <1407311602-15751-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1407311602-15751-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Andy Gross <agross@codeaurora.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>
List-Id: linux-i2c@vger.kernel.org

Hi Pramod,

Not a big deal, but some typos caught my eye.

On 08/06/2014 03:53 AM, Pramod Gurav wrote:
> This fixes a error handling scenario where clocks were not being disabled
> when QUP_OUTPUT_BLOCK_SIZE returns a size greater thanat size of blk_sizes

s/thanat/than the/

> array. So this patch adds a statement to jump to err lable to release the

s/err lable/the error label/ or s/err lable/the fail label/

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
