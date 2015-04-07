From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V2 2/6] i2c: qup: Add V2 tags support
Date: Tue, 7 Apr 2015 00:06:40 -0500
Message-ID: <20150407050640.GB9225@qualcomm.com>
References: <1428345067-21878-1-git-send-email-sricharan@codeaurora.org>
 <1428345067-21878-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428345067-21878-3-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, srichara-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 07, 2015 at 12:01:03AM +0530, Sricharan R wrote:

<snip>

> +static u32 qup_i2c_send_data(struct qup_i2c_dev *qup, int tlen, u8 *tbuf,
> +			     int dlen, u8 *dbuf)
> +{
> +	u32 val = 0, idx = 0, pos = 0, i = 0, t;
> +	int  len = tlen + dlen;
> +	u8 *buf = tbuf;
> +
> +	while (len > 0) {
> +		if (qup_i2c_wait_ready(qup, QUP_OUT_FULL, 0, 4)) {

Instead of 0 and 4 can we use some #defines?  This applies for all of the
i2c_wait_ready calls

<snip>


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
