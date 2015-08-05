From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v5 5/5] i2c: pxa: Add ILCR (tLow & tHigh) configuration
 support
Date: Wed, 05 Aug 2015 14:21:26 +0530
Message-ID: <55C1CE8E.9000601@linaro.org>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org> <1437482466-16126-6-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437482466-16126-6-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: robert.jarzmik-GANU6spQydw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Tuesday 21 July 2015 06:11 PM, Vaibhav Hiremath wrote:
> With addition of PXA910 family of devices, the TWSI module supports
> SCL clock adjustment using ILCR register.
>
> This patch enables the control and configuration of ICLR through DT
> properties,
>
> i2c-sclk-high-time-ns:
>    SCLK high time (tHigh), for standard/fast/high speed mode
> i2c-sclk-low-time-ns:
>    SCLK low time (tLow), for standard/fast/high speed mode
>
> Note that in case of standard and fast mod, the tLow and tHigh counters
> are same, and software will use tLow value.
>
> Also, brought up devm_clk_get() fn above i2c_pxa_probe_dt(), as it
> uses clk rate for timing calculations.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-pxa.c | 69 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 63 insertions(+), 6 deletions(-)
>

Robert,

It would be helpful if you can test this patch-series and confirm that
it now fixes the NULL pointer deference issue.

Thanks,
Vaibhav
