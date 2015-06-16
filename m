From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-RESEND 0/3] i2c: core/pxa: Add support for hardware lock
Date: Tue, 16 Jun 2015 13:58:59 +0530
Message-ID: <557FDE4B.3060304@linaro.org>
References: <vaibhav.hiremath@linaro.org> <1433270731-23790-1-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433270731-23790-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On Wednesday 03 June 2015 12:15 AM, Vaibhav Hiremath wrote:
> To justify the need for hardware lock, lets take a real usecase scenario -
>
> In case of Marvell SoC, PXA910 silicon, both AP and CP are present and
> these two ARM cores are sharing one pair of I2C pins.
>
> In order to keep I2C transaction operated with atomic, hardware lock
> (RIPC) is required.
>
> This patch extends support for atomic operation by adding hardware lock support
> to the i2c-core.
>
> PATCH[1/3] : Core changes for hardware lock
> PATCH[2/3 & 3/3] : hardware lock support to i2c-pxa bus driver.
>
> Link to previous post:
> http://lkml.iu.edu/hypermail/linux/kernel/1104.3/02352.html
> http://lkml.iu.edu/hypermail/linux/kernel/1104.3/02353.html
> http://lkml.iu.edu/hypermail/linux/kernel/1104.3/02354.html
>
> TODO:
>    - DT node addition
>      I am using PXA1928 based platform which is still not available
>      in Mainline, so it is based on, below patch-series
>      Link to Rob's patches:
>       https://lkml.org/lkml/2015/5/1/14
>       https://lkml.org/lkml/2015/5/19/1206
>      PMIC 88pm860 support
>       http://www.spinics.net/lists/arm-kernel/msg422554.html
>
> Vaibhav Hiremath (3):
>    i2c: core: append hardware lock with bus lock
>    i2c: pxa: Add support for hardware lock
>    i2c: pxa: Add pin ctrl support for CP core access
>

Wolfram,

Any update on this patch-series?

Thanks,
Vaibhav
