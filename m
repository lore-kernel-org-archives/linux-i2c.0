From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: qup: disable clks and return instead of just
 returning error
Date: Wed, 06 Aug 2014 14:21:01 +0300
Message-ID: <1407324061.2475.79.camel@iivanov-dev>
References: <1407311602-15751-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407311602-15751-1-git-send-email-pramod.gurav-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pramod Gurav <pramod.gurav-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2014-08-06 at 13:23 +0530, Pramod Gurav wrote:
> This fixes a error handling scenario where clocks were not being disabled
> when QUP_OUTPUT_BLOCK_SIZE returns a size greater thanat size of blk_sizes
> array. So this patch adds a statement to jump to err lable to release the
> clocks.
> 
> CC: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> CC: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
> CC: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> CC: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> 
> Signed-off-by: Pramod Gurav <pramod.gurav-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>

Acked-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>

Thanks.
