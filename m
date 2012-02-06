From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND] Congatec CGEB base, i2c and watchdog driver support
Date: Mon, 6 Feb 2012 11:58:48 +0100
Message-ID: <CAH9NwWfWVeOaNH6KRXK==sbLb3kR2eJz2+c9+k7zyAFgzwF+Vw@mail.gmail.com>
References: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328102793-4313-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sascha,

2012/2/1 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> This is a resend of the series I posted in january, only difference
> is that this time I have included the i2c and watchdog lists. To
> minimize dependencies I suggest pushing this via the mfd tree, given
> I get acks on the I2C and watchdog part.
>
> The following series adds support for the Congatec CGEB interface
> found on some Congatec x86 boards. The CGEB interface is a BIOS
> interface which provides access to onboard peripherals like I2C
> busses and watchdogs. It works by mapping BIOS code and searching
> for magic values which specify the entry points to the CGEB call.
> The CGEB call is an API provided by the BIOS which provides access
> to the functions in an ioctl like fashion.
>
> For more information about the CGEB API have a look at:
>
> http://www.congatec.com/single_news+M5d58c9cd155.html
>
> This document only describes the C API, unfortunately not the
> underlying BIOS interface.
>
> Comments very appreciated.
>

I am looking forward to see your work in mainline soon. I have here
some boards from
Congatec and I will review and test your patches during this week.


Greets
--
Christian Gmeiner, MSc
