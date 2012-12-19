From: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Wed, 19 Dec 2012 01:16:16 +0000
Message-ID: <50D11560.1030302@pcserviceselectronics.co.uk>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org> <CAKohpokjxh0DDZVFy1uN7ejdd_=jkbyVvYCy73jJChMy5dKeGA@mail.gmail.com> <50C1005B.7@pcserviceselectronics.co.uk> <CAKohpo=4xDOQMcbraq9Hj1Gq1xOgSoDj9xoYLHcosTyUJkD6fg@mail.gmail.com> <20121219000000.GC19157@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121219000000.GC19157-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
> On Tue, Dec 11, 2012 at 10:22:37AM +0530, Viresh Kumar wrote:
>> On 7 December 2012 02:00, Paul Carpenter
>> <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org> wrote:
>>> OK by me
>>>
>>> Reviewed-by: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
>> Are you taking it for 3.8 now?
> 
> Since I missed the things Paul luckily spotted, I think it might make
> sense to actually use the framework myself to get me a better feeling
> that I have not missed anything else. So, I am going to add support for
> another I2C master controller to your framework and see what will happen
> when I actually use it. It will be probably the mxs controller, I
> collected the hardware for that already...

Mine was straight code review, not had a spare 5 minutes to do anything
else, time of year and customer panics, let alone having the builders
in. If anyone has had that they will know the nightmare I mean.

-- 
Paul Carpenter          | paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
<http://www.pcserviceselectronics.co.uk/>    PC Services
<http://www.pcserviceselectronics.co.uk/fonts/> Timing Diagram Font
<http://www.gnuh8.org.uk/>  GNU H8 - compiler & Renesas H8/H8S/H8 Tiny
<http://www.badweb.org.uk/> For those web sites you hate
