From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Tue, 26 Jul 2016 08:18:00 -0700
Message-ID: <CAKdAkRQ_XaqBPzvCYKKBsH1Sah01rrk1qaHCvB_D3ObiA7=UJA@mail.gmail.com>
References: <cover.1467772840.git.viresh.kumar@linaro.org> <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
 <20160706065523.GA1439@tetsubishi> <20160706191218.483fd9fd@endymion>
 <20160706205540.GJ4127@ubuntu> <20160711142209.4711f229@endymion>
 <20160711215058.GA7808@kroah.com> <20160725113913.24204d73@endymion>
 <20160725223140.GE25667@ubuntu> <20160726094139.6ad9189b@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34156 "EHLO
	mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953AbcGZPSD (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 26 Jul 2016 11:18:03 -0400
In-Reply-To: <20160726094139.6ad9189b@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

Hi Jean,

On Tue, Jul 26, 2016 at 12:41 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Viresh,
>
> On Mon, 25 Jul 2016 15:31:40 -0700, Viresh Kumar wrote:
>> On 25-07-16, 11:39, Jean Delvare wrote:
>> > The problem is that the patch proposed by Viresh has nothing to do with
>> > this. It's not adding notifications, just changing the time frame during
>> > which user-space holds a reference to the i2c (bus) device. The goal as
>> > I understand it is to allow *prepared* hot-unplug (in the form of
>> > "rmmod i2c-bus-device-driver" or sysfs-based offlining?) while
>>
>> Not really. We are concerned about both prepared and Unprepared cases.
>>
>> This *hacky* patch was useful in case of *unprepared* hot-unplug as well.
>>
>> Here is the sequence of events:
>> - open() i2c device from userspace
>> - do some operations on the device read/write/ioctls() ..
>> - Module hot-unplugged (*unprepared*)
>> - Some of the ongoing i2c transactions may just fail, that is fine ..
>> - Kernel detected the interrupt about module removal and tries to
>>   cleanup the devices..
>> - Now, kernel can not remove the i2c device, unless user application
>>   has closed the file descriptor.
>
> Well, what is the application doing at that point? What error codes is
> it getting? Should it not close the device node and bail out?

It should. Will it? It is up to the application. It may decide to keep
that file descriptor open forever.

>
>> And so kernel is waiting in the driver's ->remove() callback forever.
>>
>> Also, there is no way to co-ordinate (in Android) with the
>> Applications using the device.
>
> Why? Looks like a serious limitation.
>
> At this point I still don't know what application we are talking about,
> why it has to be in user-space when I2C device drivers are supposed to
> be on the kernel side, nor why they have to keep the i2c device node
> opened all the time.
>
> Why do you insist on relying on i2c-dev when it is so clearly no
> compatible with your requirements?

If you provide an interface expect it to be used, maybe even in the
ways you did not anticipated. Kernel's (and out task) is to make the
interface behave properly, not police users.

>
>> They can crash or fail out if they
>> want to, but the kernel shouldn't stop removal of a hardware module in
>> that case.
>
> If they crash or bail out, that would close the device, so no problem.
> The problem would be if they stay alive and misbehave.
>
> If the kernel should be completely independent from what user-space is
> doing, this is simply not compatible with reference counting. The whole
> point of counting references is to know when a device is still in use,
> and prevent it from being removed while this is the case. If you say
> that devices can be removed at any time and this is OK, then you should
> not be counting references at all, this is pointless. But I doubt the
> i2c code is currently ready for this.

There are multitude of reference counts, all counting different
things, not one refcount for the entire thing. You have refcount for
the file object, you have memory refcounts, you have device object
refcounts. And note that device and driver bond is not refcounted at
all. It is supposed to be allowed to be broken at [pretty much] any
moment. You just need to be careful when doing so ;)

>
>> > user-space processes have i2c device nodes open. Unprepared hot-unplug
>> > will still go wrong exactly as it goes now.
>>
>> > My point is that prepared hot-unplug can already be achieved today
>> > without any patch.
>>
>> Yeah, if we have the option of stopping the applications before the
>> device is gone.
>>
>> > Or possibly improved by adding a notification
>> > mechanism. But not by changing the reference holding design.
>> >
>> > Not only the proposed patch does not help and degrades the performance,
>> > but it breaks assumptions. For example, it would allow an application
>> > to open an i2c bus, then you remove its driver and load another i2c bus
>> > driver, which gets the same bus number, and now the application writes
>> > to a completely different I2C bus segment. The current reference model
>> > prevents that, on purpose.
>> >
>> > So, again, nack from me.
>>
>> Yeah, the patch wasn't great and I knew it from the beginning. But we
>> are looking for a solution that can be accepted and so need advice
>> from you guys :)
>
> I have no idea, sorry. Hopefully Greg or Wolfram know more? Check what
> other subsystems are doing?

One option is to, upon device removal, to mark it as "dead" to allow
accesses through i2c-dev to return error, release all hardware
resources, but keep the object in memory in zombie state, waiting for
the last user to drop the reference. Once that happens (maybe years
later) you finally can release last bits of memory. You can check how
we do that for input_dev/evdev pair.

Thanks.

-- 
Dmitry
