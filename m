From: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
Date: Fri, 30 Aug 2013 14:29:35 +0800
Message-ID: <CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
	<20130828095706.GH4086@katana>
	<CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
	<CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
	<20130830054858.GR7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130830054858.GR7656-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 30, 2013 at 1:48 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> * zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [130829 04:03]:
>> On Thu, Aug 29, 2013 at 4:58 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> > On Wed, Aug 28, 2013 at 11:57 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> >> On Tue, Aug 20, 2013 at 04:32:28PM +0800, Zhangfei Gao wrote:
>> >
>> >>> Instead of use platform_driver_probe, use module_platform_driver
>> >>> To support deferred probing
>> >>> Also subsys_initcall may too early to auto set pinctl
>> >>>
>> >>> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> >>> Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
>> >>
>> >> This patch is tougher than it looks. You need it, because
>> >> subsys_initcall may be too early for pinctrl.
>> >
>> > pinctrl is initialized very early, core_initcall().
>> >
>> > This is more a question of individual pin control drivers
>> > and when they probe, and dependencies trying to take
>> > a pinctrl handle before the pin controller is available
>> > will be deferred. Even by those grabbed in the core
>> > by drivers/base/pinctrl.c.
>>
>> Thanks Linus.
>> Your explanation is really make sense.
>>
>> We use drivers/pinctrl/pinctrl-single.c, if subsys_initcall for
>> pinctrl-single, no issue at all.
>
> So far we've seen that if you have issues with this, the real
> problem is that some other driver is trying to initialize way
> too early probably because of legacy reasons that no longer
> apply.
>
> FYI, it's best to have all the drivers initialize with just
> module_init and make them work as loadable modules because of
> the following reasons:
>
> 1. You will get real console error messages when something
>    goes wrong with no need for debug_ll and earlyprintk
>
> 2. By creating loadable driver modules you're already getting
>    some protection from spaghetti code as the interfaces
>    are defined
>
> 3. It will be easier for distros to support various ARM SoCs
>    with loadable driver modules
>
> Regards,
>
> Tony

Thanks Tony,

What about concerns from Wolfram:
" Other people might be
depending on subsys_initcall to get I2C active before they want to
activate, say, PMICs. So, I fear regressions, since deferred probing
might not be available in the needed places to avoid these regressions."

Is it too late using module_init for PMIC?

Besides, the deferred probing still there if depend on late registered
pin control driver.

Thanks
