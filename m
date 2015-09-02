From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v5 RESEND 0/5] i2c: pxa: Add support for PXA910 family of
 device
Date: Wed, 2 Sep 2015 12:17:42 +0530
Message-ID: <55E69B8E.8040704@linaro.org>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440395978-9065-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Monday 24 August 2015 11:29 AM, Vaibhav Hiremath wrote:
> Sorry for not following up on this aggressively, was quit busy with some
> other stuff. Resending this patch with Robert's Tested-By.
>
>
> This patch-series is subset of the original patch-series, submitted
> on 14 Jul 2015.
> Link to Original Patch-series - https://lkml.org/lkml/2015/7/14/80
>
> The first six patches have been already queued up for upstream. So this
> patch-series is respin of remaining 5 patches.
>
> Testing:
>    - Basic testing on PMIC device on I2C-0 interface
>    - Boot tested on platform based on PXA1928
>    - Read few registers of PMIC (RTC, ID, etc...) during boot
>
> V4 => V5
> =======
> Link to V3: https://lkml.org/lkml/2015/7/14/80
>    - Dropped First 6 patches as they are already accepted, queued for upstream
>    - Fixed a bug in PATCH [5/5], where for non PXA910 devices it as resulting into
>      NULL pointer dereference.
>
>


Any update on this? This series is waiting since long time now.

Wolfram,
I know you wanted to have more discussion on DT properties & changes.
And I would be more happy to discuss.

Thanks,
Vaibhav
