From: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
Date: Thu, 12 Sep 2013 09:12:39 +0800
Message-ID: <CAMj5BkgqBCh0316NmoP_XMXvJTVQxxvUvs63wZfS_TvNLdqAfg@mail.gmail.com>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
	<20130828095706.GH4086@katana>
	<CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
	<CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
	<20130830054858.GR7656@atomide.com>
	<CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
	<20130830082712.GT7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130830082712.GT7656-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 30, 2013 at 4:27 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> * zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [130829 23:36]:
>> What about concerns from Wolfram:
>> " Other people might be
>> depending on subsys_initcall to get I2C active before they want to
>> activate, say, PMICs. So, I fear regressions, since deferred probing
>> might not be available in the needed places to avoid these regressions."
>
> There should not be any reason to get a PMIC activated
> early on. The system should be booting already at that point,
> and the PMIC related init can be done later on.
>
>> Is it too late using module_init for PMIC?
>
> You can probably do it as a fix early on during the -rc
> cycle too. Of course it needs to be verified to work first :)
>

Dear Wolfram

What's your suggestion about this issue.
Use subsys_initcall, deferred probing still exist if base on pin control driver.

Thanks
