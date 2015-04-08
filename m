From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V2 2/6] i2c: qup: Add V2 tags support
Date: Wed, 8 Apr 2015 11:00:49 +0530
Message-ID: <000201d071bd$30b1f130$9215d390$@codeaurora.org>
References: <1428345067-21878-1-git-send-email-sricharan@codeaurora.org> <1428345067-21878-3-git-send-email-sricharan@codeaurora.org> <20150407050640.GB9225@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150407050640.GB9225-zC7DfRvBq/JWk0Htik3J/w@public.gmane.org>
Content-Language: en-us
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Andy Gross' <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Andy Gross
> Sent: Tuesday, April 07, 2015 10:37 AM
> To: Sricharan R
> Cc: srichara-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
> msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org;
> dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH V2 2/6] i2c: qup: Add V2 tags support
> 
> On Tue, Apr 07, 2015 at 12:01:03AM +0530, Sricharan R wrote:
> 
> <snip>
> 
> > +static u32 qup_i2c_send_data(struct qup_i2c_dev *qup, int tlen, u8
*tbuf,
> > +			     int dlen, u8 *dbuf)
> > +{
> > +	u32 val = 0, idx = 0, pos = 0, i = 0, t;
> > +	int  len = tlen + dlen;
> > +	u8 *buf = tbuf;
> > +
> > +	while (len > 0) {
> > +		if (qup_i2c_wait_ready(qup, QUP_OUT_FULL, 0, 4)) {
> 
> Instead of 0 and 4 can we use some #defines?  This applies for all of the
> i2c_wait_ready calls
> 
> <snip>
> 
 Ok, will change this with some macro.

Regards,
 Sricharan

> 
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum, a Linux Foundation Collaborative Project
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
