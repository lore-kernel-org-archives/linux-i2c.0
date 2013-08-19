From: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c-designware: make HCNT/LCNT values configurable
Date: Mon, 19 Aug 2013 21:40:40 +0900
Message-ID: <52121248.2090000@pobox.com>
References: <1376914074-31103-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376914074-31103-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 8/19/13 9:07 PM, Mika Westerberg wrote:
> The DesignWare I2C controller has high count (HCNT) and low count (LCNT)
> registers for each of the I2C speed modes (standard and fast). These
> registers are programmed based on the input clock speed in the driver.
>
> The current code calculates these values based on the input clock speed and
> tries hard to meet the I2C bus timing requirements. This could result
> non-optimal values with regarding to the bus speed. For example on Intel
> BayTrail we get bus speed of 315.41kHz which is ~20% slower than we would
> expect (400kHz) in fast mode (even though the timing requirements are met).
>
> This patch makes it possible for the platform code to pass more optimal
> HCNT/LCNT values to the core driver if they are known beforehand. If these
> are not set we use the calculated and more conservative values.
>
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Looks good, thanks.

Acked-by: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
