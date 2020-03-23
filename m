From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] i2c: nvidia-gpu: Handle timeout correctly in
 gpu_i2c_check_status()
Date: Mon, 23 Mar 2020 13:38:09 +0800
Message-ID: <DA56E103-CAA7-4C28-9528-9EAFF2C717CD@canonical.com>
References: <20200311165806.12365-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43635 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgCWFiP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 23 Mar 2020 01:38:15 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jGFmw-0006F1-2P
        for linux-i2c@vger.kernel.org; Mon, 23 Mar 2020 05:38:14 +0000
Received: by mail-pj1-f71.google.com with SMTP id np18so9336295pjb.1
        for <linux-i2c@vger.kernel.org>; Sun, 22 Mar 2020 22:38:14 -0700 (PDT)
In-Reply-To: <20200311165806.12365-1-kai.heng.feng@canonical.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ajayg@nvidia.com
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:I2C CONTROLLER DRIVER FOR NVIDIA GPU" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>


> On Mar 12, 2020, at 00:58, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Nvidia card may come with a "phantom" UCSI device, and its driver gets
> stuck in probe routine, prevents any system PM operations like suspend.
> 
> Let's handle the unaccounted case that the target time equals to jiffies
> in gpu_i2c_check_status(), so the UCSI driver can let the probe fail as
> it should.
> 
> Fixes: c71bcdcb42a7 ("i2c: add i2c bus driver for NVIDIA GPU")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> drivers/i2c/busses/i2c-nvidia-gpu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
> index 62e18b4db0ed..1988e93c7925 100644
> --- a/drivers/i2c/busses/i2c-nvidia-gpu.c
> +++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
> @@ -88,7 +88,7 @@ static int gpu_i2c_check_status(struct gpu_i2c_dev *i2cd)
> 		usleep_range(500, 600);
> 	} while (time_is_after_jiffies(target));
> 
> -	if (time_is_before_jiffies(target)) {
> +	if (time_is_before_eq_jiffies(target)) {
> 		dev_err(i2cd->dev, "i2c timeout error %x\n", val);
> 		return -ETIMEDOUT;
> 	}
> -- 
> 2.17.1
> 
