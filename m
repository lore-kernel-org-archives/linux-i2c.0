From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: exynos5: Use reinit_completion instead of INIT_COMPLETION
Date: Tue, 5 Nov 2013 16:39:26 +0530
Message-ID: <CAK9yfHyf94oTyJRRYtAiaty=AYiPXf+RQTnqdW4-q=zbvwsdtA@mail.gmail.com>
References: <1383643630-5036-1-git-send-email-sachin.kamat@linaro.org>
	<20131105101055.GA2660@katana>
	<CAK9yfHwv3T6OXO59b+VeFHLU6mxn1Gw+BotOBLUukHuArZ0qig@mail.gmail.com>
	<20131105105606.GB2660@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131105105606.GB2660@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 5 November 2013 16:26, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Tue, Nov 05, 2013 at 03:51:58PM +0530, Sachin Kamat wrote:
>> On 5 November 2013 15:40, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> > On Tue, Nov 05, 2013 at 02:57:10PM +0530, Sachin Kamat wrote:
>> >> INIT_COMPLETION was replaced by reinit_completion vide commit 2c9627cca471
>> >> ("tree-wide: use reinit_completion instead of INIT_COMPLETION"). Use it to
>> >> avoid the following build error:
>> >> drivers/i2c/busses/i2c-exynos5.c:538:9: error:
>> >> undefined identifier 'INIT_COMPLETION'
>> >>
>> >> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> >
>> > You can ignore this topic. akpm (who has the change in his tree) usually
>> > takes care of this.
>> >
>>
>> This option does not show up with allyesconfig. Unless one uses
>> exynos_defconfig and specifically
>> enables this option, this error will not show up.
>
> sed will find them all.

Yes, that would do. However, since I have already found and fixed
this, wouldn't it save
some time and effort for Andrew if he simply applies this?

-- 
With warm regards,
Sachin
