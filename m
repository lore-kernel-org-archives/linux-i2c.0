From: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: getting rid of subsys_initcall usage?
Date: Fri, 30 Aug 2013 09:51:47 +0800
Message-ID: <521FFAB3.2080405@linaro.org>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org> <20130828095706.GH4086@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130828095706.GH4086@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 13-08-28 05:57 PM, Wolfram Sang wrote:
> On Tue, Aug 20, 2013 at 04:32:28PM +0800, Zhangfei Gao wrote:
>> Instead of use platform_driver_probe, use module_platform_driver
>> To support deferred probing
>> Also subsys_initcall may too early to auto set pinctl
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
>
> This patch is tougher than it looks. You need it, because
> subsys_initcall may be too early for pinctrl. Other people might be
> depending on subsys_initcall to get I2C active before they want to
> activate, say, PMICs. So, I fear regressions, since deferred probing
> might not be available in the needed places to avoid these regressions.
> I am all ears for a nice transition away from subsys_initcall, anyone?

Dear Wolfram,

The deferred probe will be successful if change platform_driver_probe to 
platform_driver_register, to register itself to drv name list.

However, the effect is subsys_initcall is postponed, until pin control 
driver is probed successfully.
If the pin is specific and does not need configure, there is no issue.
There may still have issue if the mulit-function pin need be configured 
via pinctrl, except put pin control driver earlier too.

Thanks
