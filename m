From: Trilok Soni <tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: QUP based bus driver for Qualcomm MSM chipsets
Date: Wed, 08 Sep 2010 18:53:44 +0530
Message-ID: <4C878E60.3060000@codeaurora.org>
References: <1283907557-1874-1-git-send-email-kheitke@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283907557-1874-1-git-send-email-kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org, swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, sdharia-sgV2jX0FEOLY0TyS/+Ba5Q@public.gmane.org, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Walker <dwalker-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 9/8/2010 6:29 AM, Kenneth Heitke wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm
> MSM SOCs.  The Qualcomm Universal Peripheral Engine (QUP) is a general
> purpose data path engine with input/output FIFOs and an embedded i2c
> mini-core. The driver supports FIFO mode (for low bandwidth applications)
> and block mode (interrupt generated for each block-size data transfer).
> The driver currently does not support DMA transfers.
> 
> Signed-off-by: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
> v3: uses DIV_ROUND_UP() as recommended by linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org
> v2: incorporated feedback from the following people:
> 	ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> 	srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org
> 	tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org

Looks good to me.

Acked-by: Trilok Soni <tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
