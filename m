From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 25 Jan 2013 14:24:14 +0530
Message-ID: <CAKohpokBLyJ8PEO6vP-LPt4rj4CkmyBWJ0s9TKiGhKOTEcfywA@mail.gmail.com>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
	<20130124072445.GA8364@nekote.pengutronix.de>
	<CAKohpo=HhdsVRqzGN87yUSz3rEn-3MHEh3rM0-XJJgcX19kXUg@mail.gmail.com>
	<20130125085012.GB5684@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130125085012.GB5684-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 25 January 2013 14:20, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>> I kept it to make sure we don't do this calculation every time... I would like
>> to keep it for better performance..
>
> Please move it. It is a constant anyhow, and globals are best avoided.

I will move it. But i couldn't understand what you mean by "it is a constant
anyhow", because that was one of the reason for keeping it global.

> Now onto V9...

You will find the same there too :)

Anyway i need to do some minor cleanups requested by uwe, so v10 is
required.
