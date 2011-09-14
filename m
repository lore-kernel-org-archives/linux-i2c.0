From: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: QUP based bus driver for Qualcomm MSM chipsets
Date: Wed, 14 Sep 2011 12:39:53 -0600
Message-ID: <4E70F4F9.2000707@codeaurora.org>
References: <1308018114-19709-1-git-send-email-kheitke@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1308018114-19709-1-git-send-email-kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org, tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org, bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/13/2011 08:21 PM, Kenneth Heitke wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm
> MSM SOCs.  The Qualcomm Universal Peripheral Engine (QUP) is a general
> purpose data path engine with input/output FIFOs and an embedded i2c
> mini-core. The driver supports FIFO mode (for low bandwidth applications)
> and block mode (interrupt generated for each block-size data transfer).
> The driver currently does not support DMA transfers.
>
> Signed-off-by: Kenneth Heitke<kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> v2: updates to runtime PM calls (addresses comments from Mark Brown).
>      Disable interrupts before setting completion object to NULL (bug fix).
> ---
>   drivers/i2c/busses/Kconfig                |   11 +
>   drivers/i2c/busses/Makefile               |    1 +
>   drivers/i2c/busses/i2c-qup.c              | 1175 +++++++++++++++++++++++++++++
>   include/linux/platform_data/msm_qup_i2c.h |   24 +
>   4 files changed, 1211 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/i2c/busses/i2c-qup.c
>   create mode 100644 include/linux/platform_data/msm_qup_i2c.h
>

Hi Ben,

Would it be possible to pull this driver into your tree?  If not, please 
let me know of any concerns that need to be addresses.

thanks,
Ken


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
