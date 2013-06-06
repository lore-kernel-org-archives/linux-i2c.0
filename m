From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c: introduce i2c helper i2c_find_client_by_name()
Date: Thu, 6 Jun 2013 23:32:06 +0300
Message-ID: <CAHp75VcYgpUVpOnKOzkYoZXbEPO_0QG7=WUXza55wpOyRwcKCA@mail.gmail.com>
References: <20130606183346.GA13259@bingao-desk1.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130606183346.GA13259-VlzZ4XCc4GmWDyPblzj0aa2pdiUAq4bhAL8bYrjMMd8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 6, 2013 at 9:33 PM, Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> There is a requirement to get the i2c_client pointer dynamically without
> knowing the bus and slave address. But we do know the client name,
> i.e. the name in the i2c_board_info. This patch is to fit this requirement.
>
> A good example is that an ISP(Imaging Signal Processor) driver needs
> register i2c camera sensor devices via v4l2, so it has to unregister
> all i2c clients that were previously registered by calling
> i2c_register_board_info(), and then re-register. For this case we
> can use this helper to get i2c_client by passing the client name.

Why ISP driver would like to register sensor drivers in the first place?
That seems the task of platform code, or DT, or ACPI5

Why do you need to re-register them at run time?

--
With Best Regards,
Andy Shevchenko
