From: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
Date: Fri, 14 Mar 2014 13:00:38 -0500
Message-ID: <20140314180038.GT18529@joshc.qualcomm.com>
References: <1394762863-12154-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394762863-12154-3-git-send-email-bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 13, 2014 at 07:07:43PM -0700, Bjorn Andersson wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> engine with input/output FIFOs and an embedded i2c mini-core. The driver
> supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> generated for each block-size data transfer).
> 
> Cc: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
> +++ b/drivers/i2c/busses/i2c-qup.c
[..]
> +static int qup_i2c_xfer(struct i2c_adapter *adap,
> +			struct i2c_msg msgs[],
> +			int num)
> +{
> +	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
> +	int ret, idx;
> +
> +	ret = pm_runtime_get_sync(qup->dev);
> +	if (IS_ERR_VALUE(ret))
> +		goto out;

General i2c question: is there a reason why the core isn't responsible
for ensuring a device is not suspended before invoking ->master_xfer
(and smbus_xfer)?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
