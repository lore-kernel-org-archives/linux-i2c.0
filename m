From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 7 Jan 2013 16:02:13 +0530
Message-ID: <CAKohpo=1BfLScbqk-Mt_kA62pP1+EKUxCkSRbKvLfiXhGyvz5A@mail.gmail.com>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
	<CAKohpokjxh0DDZVFy1uN7ejdd_=jkbyVvYCy73jJChMy5dKeGA@mail.gmail.com>
	<50C1005B.7@pcserviceselectronics.co.uk>
	<CAKohpo=4xDOQMcbraq9Hj1Gq1xOgSoDj9xoYLHcosTyUJkD6fg@mail.gmail.com>
	<20121219000000.GC19157@pengutronix.de>
	<CAKohponZSSyAGnayRXLOBRZ+AgfB1ut3MLyvHSOTQMPTeU-uxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohponZSSyAGnayRXLOBRZ+AgfB1ut3MLyvHSOTQMPTeU-uxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 20 December 2012 14:47, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 19 December 2012 05:30, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>> Since I missed the things Paul luckily spotted, I think it might make
>> sense to actually use the framework myself to get me a better feeling
>> that I have not missed anything else. So, I am going to add support for
>> another I2C master controller to your framework and see what will happen
>> when I actually use it. It will be probably the mxs controller, I
>> collected the hardware for that already...
>
> Nothing could be better than that :)

Hi Wolfram,

HNY '13.

You got some chance to test this stuff ?
