From: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C controller
Date: Fri, 21 Feb 2014 09:35:57 -0600
Message-ID: <92B0AE30-5CDF-43FC-8588-EEF0C5F86266@codeaurora.org>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com> <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392943090-30556-3-git-send-email-bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On Feb 20, 2014, at 6:38 PM, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org> wrote:

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
> ---
> drivers/i2c/busses/Kconfig   |   10 +
> drivers/i2c/busses/Makefile  |    1 +
> drivers/i2c/busses/i2c-qup.c |  772 ++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 783 insertions(+)
> create mode 100644 drivers/i2c/busses/i2c-qup.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f5ed031..403e196 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -648,6 +648,16 @@ config I2C_PXA_SLAVE
> 	  is necessary for systems where the PXA may be a target on the
> 	  I2C bus.
> 
> +config I2C_QUP
> +	tristate "Qualcomm QUP based I2C controller"
> +	depends on ARCH_MSM

ARCH_QCOM

> +	help
> +	  If you say yes to this option, support will be included for the
> +	  built-in I2C interface on the Qualcomm SoCs.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-qup.
> +
> config I2C_RIIC
> 	tristate "Renesas RIIC adapter"
> 	depends on ARCH_SHMOBILE || COMPILE_TEST

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
