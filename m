From: Trilok Soni <tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2] gpio: sx150x: Add Semtech I2C sx150x gpio expander
 driver.
Date: Mon, 12 Jul 2010 14:25:24 +0530
Message-ID: <4C3AD87C.1010407@codeaurora.org>
References: <1278617834-14970-1-git-send-email-gbean@codeaurora.org> <4C370EB4.4040906@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C370EB4.4040906-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory Bean <gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean, Andrew,

On 7/9/2010 5:27 PM, Trilok Soni wrote:
> On 7/9/2010 1:07 AM, Gregory Bean wrote:
>> Add support for Semtech SX150-series I2C GPIO expanders.
>> Compatible models include:
>>
>> 8 bits:  sx1508q
>> 16 bits: sx1509q
>>
>> Signed-off-by: Gregory Bean <gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/gpio/Kconfig       |   11 +
>>  drivers/gpio/Makefile      |    1 +
>>  drivers/gpio/sx150x.c      |  646 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/i2c/sx150x.h |   78 ++++++
>>  4 files changed, 736 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/gpio/sx150x.c
>>  create mode 100644 include/linux/i2c/sx150x.h
>>
> 
> Looks good to me. 
> 
> Reviewed-by: Trilok Soni <tsoni-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 

Any review comments on this new version of the driver?

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
