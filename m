From: Bin Gao <bin_gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: i2c: introduce i2c helper i2c_find_client_by_name()
Date: Fri, 21 Jun 2013 17:27:49 -0700
Message-ID: <51C4EF85.7010607@linux.intel.com>
References: <20130606183346.GA13259@bingao-desk1.fm.intel.com> <CAHp75VcYgpUVpOnKOzkYoZXbEPO_0QG7=WUXza55wpOyRwcKCA@mail.gmail.com> <20130606212620.GA13620@bingao-desk1.fm.intel.com> <CAHp75VcGUtWyPHrvYDW59-4g8F2m58-Us3CrbJ2bnYJdxnd1Sg@mail.gmail.com> <20130611171119.GA35135@bingao-desk1.fm.intel.com> <CAHp75VdZA_gouZohD1J+o9ybpXVLLQH=D7QDo9OznW93iBDZpQ@mail.gmail.com> <20130614190003.GA19617@bingao-desk1.fm.intel.com> <20130619101348.GE2950@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130619101348.GE2950@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Bin Gao <bin.gao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 6/19/2013 3:13 AM, Wolfram Sang wrote:
>
>> Even you prefer to extend v4l2, you still need this helper.
>> The idea is just to move the unregister/register from a specific ISP driver
>> to v4l2.
>>
>> I think you misunderstood my pionts somehow. Let me clarfiy a little bit:
>>
>> Current solution:
>> 1. Platform codes(on top of DT/ACPI5/SFI) don't call i2c_register_board_info(),
>> instead, prepare a table(kind of platform data) that has all camera i2c device information.
>> 2. ISP driver registers devices listed in the table to i2c core - this makes sure
>> v4l2 takes over these devices.
>> The problem with this solution is that when a camera device runs on both ACPI5 and
>> SFI, the platform codes will get a bit complicated and it's difficult to ensure one
>> binary kernel runs on both platforms(ACPI5 and SFI).
>> (To extend v4l2 with this solution doen't resolve my problem)
>>
>> Solution I'm suggesting:
>> 1. Let the platform codes call i2c_register_board_info() anyway.
>> 2. Since ISP driver knows which camera devices it supports, so it simply unregisters
>> those devices (get the client by the introduced helper), then register it within v4l2.
>> This solution ensure one binary kernel can run on both platforms.
>> (To extend v4l2 with this solution could not be feasible, the device table is
>> ISP driver specific, not v4l2 specific)
>
> I also wonder about the need to unregister. I have to admit I don't know
> much about I2C handling in v4l2. But if it requires unregistering from
> i2c core and registering to v4l2 core, then it sounds to me like we
> could check if there is a more fundamential cleanup needed? Deferring
> for now, looks like an issue worth looking at, yet there are other
> things in the queue first.
>

Platform codes are supposed to call i2c_register_board_info() or 
i2c_new_device() to register devices, we don't want to change this.
Not sure v4l2 can still take over the devices without 
unregistering/registering. Need look deeply into the v4l2 code...
