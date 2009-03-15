From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Let checkpatch shout on users of the legacy model
Date: Sun, 15 Mar 2009 09:25:29 +0100
Message-ID: <20090315092529.6f3a6c9f@hyperion.delvare>
References: <20090312161551.51ee067f@hyperion.delvare>
	<20090312123204.7d093fca@pedra.chehab.org>
	<20090312185110.41e25953@hyperion.delvare>
	<20090312234133.2c84c56a@pedra.chehab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090312234133.2c84c56a-tFzVqosiKpjELl06WqLlIA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mauro,

On Thu, 12 Mar 2009 23:41:33 -0300, Mauro Carvalho Chehab wrote:
> On Thu, 12 Mar 2009 18:51:10 +0100
> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > There's no point in rescheduling. If we patiently wait for an API to
> > become unused before we remove it, there's no point to announce a
> > version when the API will be removed in the first palce, and there's a
> > risk that the removal will never happen. The whole point of announcing
> > a version is that developers can prepare for it and we stick to what we
> > announced (as much as possible).
> > 
> > Really, I don't think 2.6.30 is unrealistic. Hans has done a huge work
> > already for the v4l side.
> 
> True. Thanks to Hans, most of drivers were converted.
> 
> > I have done my part on hwmon, and Alessandro
> > Zummo on rtc. Getting the remainder done within a few weeks sounds
> > totally possible _if_ we can drop support kernels < 2.6.22 from the
> > v4l-dvb repository. This has already been discussed... There are i2c
> > subsystem fixes and improvements which many people have asked for which
> > depend on this.
> 
> The issue is not related to drop support for < 2.6.22, but to finish porting
> the I2C adapters that use those I2C drivers, and test they with the several
> different supported i2c combinations.

It is related, indirectly, because it is the same developers who can
work on finishing driver conversions and who take care of the v4l-dvb
repository. The time spent on compatibility issues (which happen to be
difficult to deal with for kernels < 2.6.22) is not spent on fixing and
testing upstream drivers. Not to mention that the code for pre-2.6.22
kernels would be so different that it would need to be tested
separately, in effect doubling the amount of testing required.

Hans made a poll some weeks ago with regards to the interest developers
and users have in supporting pre-2.6.22 kernels and the results were
pretty clear: this is something almost nobody is interested in. So I am
curious, what are we waiting for before we drop support these old
kernels?

> On a first glance, it seems that we still need to port bttv, cafe-ccic, cx23885,
> em28xx, cx88 and pvrusb2.
> 
> Those drivers responds for the majority number of different TV capture boards
> in the market.
> 
> I know that Hans is working with bttv driver, and asked other developers to
> help on this task.
> 
> It is still a huge job, due to the number of different I2C variants that each
> card have, the need for tests with several different I2C configurations and the
> lack of information we have about a large number of the supported cards.
> 
> Doing this conversion without care and enough testing will for sure generate
> regressions.

Yes, I agree. I can help test bttv (2 adapters) and cx88 (one adapter).

-- 
Jean Delvare
