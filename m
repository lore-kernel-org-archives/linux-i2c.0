From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Mon, 25 Jul 2016 15:31:40 -0700
Message-ID: <20160725223140.GE25667@ubuntu>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
 <20160706065523.GA1439@tetsubishi>
 <20160706191218.483fd9fd@endymion>
 <20160706205540.GJ4127@ubuntu>
 <20160711142209.4711f229@endymion>
 <20160711215058.GA7808@kroah.com>
 <20160725113913.24204d73@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160725113913.24204d73@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On 25-07-16, 11:39, Jean Delvare wrote:
> The problem is that the patch proposed by Viresh has nothing to do with
> this. It's not adding notifications, just changing the time frame during
> which user-space holds a reference to the i2c (bus) device. The goal as
> I understand it is to allow *prepared* hot-unplug (in the form of
> "rmmod i2c-bus-device-driver" or sysfs-based offlining?) while

Not really. We are concerned about both prepared and Unprepared cases.

This *hacky* patch was useful in case of *unprepared* hot-unplug as well.

Here is the sequence of events:
- open() i2c device from userspace
- do some operations on the device read/write/ioctls() ..
- Module hot-unplugged (*unprepared*)
- Some of the ongoing i2c transactions may just fail, that is fine ..
- Kernel detected the interrupt about module removal and tries to
  cleanup the devices..
- Now, kernel can not remove the i2c device, unless user application
  has closed the file descriptor.

And so kernel is waiting in the driver's ->remove() callback forever.

Also, there is no way to co-ordinate (in Android) with the
Applications using the device.  They can crash or fail out if they
want to, but the kernel shouldn't stop removal of a hardware module in
that case.

> user-space processes have i2c device nodes open. Unprepared hot-unplug
> will still go wrong exactly as it goes now.

> My point is that prepared hot-unplug can already be achieved today
> without any patch.

Yeah, if we have the option of stopping the applications before the
device is gone.

> Or possibly improved by adding a notification
> mechanism. But not by changing the reference holding design.
> 
> Not only the proposed patch does not help and degrades the performance,
> but it breaks assumptions. For example, it would allow an application
> to open an i2c bus, then you remove its driver and load another i2c bus
> driver, which gets the same bus number, and now the application writes
> to a completely different I2C bus segment. The current reference model
> prevents that, on purpose.
> 
> So, again, nack from me.

Yeah, the patch wasn't great and I knew it from the beginning. But we
are looking for a solution that can be accepted and so need advice
from you guys :)

-- 
viresh
