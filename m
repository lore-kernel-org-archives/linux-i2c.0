From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c: introduce i2c helper i2c_find_client_by_name()
Date: Sun, 9 Jun 2013 22:53:35 +0300
Message-ID: <CAHp75VcGUtWyPHrvYDW59-4g8F2m58-Us3CrbJ2bnYJdxnd1Sg@mail.gmail.com>
References: <20130606183346.GA13259@bingao-desk1.fm.intel.com>
	<CAHp75VcYgpUVpOnKOzkYoZXbEPO_0QG7=WUXza55wpOyRwcKCA@mail.gmail.com>
	<20130606212620.GA13620@bingao-desk1.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130606212620.GA13620-VlzZ4XCc4GmWDyPblzj0aa2pdiUAq4bhAL8bYrjMMd8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Please, try to avoid top posting in the future emails.

On Fri, Jun 7, 2013 at 12:26 AM, Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> With v4l2, the camera sensor i2c devices are taken over by v4l2 master
> driver, i.e. ISP driver, and are not expected to be accessed from
> user sapce by ioctl. So ISP driver has to register them by itself to
> get all related information for further communication. Please check
> v4l2_i2c_new_subdev_board() in drivers/media/video/v4l2-common.c for details.

Yes, this is legacy approach for non-DT/non-ACPI5 platforms.

> The platform code can definitely disallow calling i2c_register_board_info()
> to register them but keep the i2c devices list and then let ISP driver register
> them. But, problems come when a single kernel is going to run on two platforms
> - one platform has ACPI5 and the other has SFI.

You have to forget about SFI. Your ISP subdevices use plain platform
data anyway.
In ACPI 5 case v4l2 framework must be extended to cover that case.

> The dynamic unregister and then
> register based on this new helper will not have dependency on firmware interface -
> the same platform code will work for all platforms.

It's not a care of the ISP driver. I think you have to talk to Sakari
about your issues.

> On Thu, Jun 06, 2013 at 11:32:06PM +0300, Andy Shevchenko wrote:
>> On Thu, Jun 6, 2013 at 9:33 PM, Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> > There is a requirement to get the i2c_client pointer dynamically without
>> > knowing the bus and slave address. But we do know the client name,
>> > i.e. the name in the i2c_board_info. This patch is to fit this requirement.
>> >
>> > A good example is that an ISP(Imaging Signal Processor) driver needs
>> > register i2c camera sensor devices via v4l2, so it has to unregister
>> > all i2c clients that were previously registered by calling
>> > i2c_register_board_info(), and then re-register. For this case we
>> > can use this helper to get i2c_client by passing the client name.
>>
>> Why ISP driver would like to register sensor drivers in the first place?
>> That seems the task of platform code, or DT, or ACPI5
>>
>> Why do you need to re-register them at run time?

--
With Best Regards,
Andy Shevchenko
