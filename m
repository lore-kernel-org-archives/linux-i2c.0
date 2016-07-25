From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Mon, 25 Jul 2016 11:39:13 +0200
Message-ID: <20160725113913.24204d73@endymion>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
	<021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
	<20160706065523.GA1439@tetsubishi>
	<20160706191218.483fd9fd@endymion>
	<20160706205540.GJ4127@ubuntu>
	<20160711142209.4711f229@endymion>
	<20160711215058.GA7808@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34886 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbcGYJjR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Jul 2016 05:39:17 -0400
In-Reply-To: <20160711215058.GA7808@kroah.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

Hi Greg, Viresh,

On Mon, 11 Jul 2016 14:50:58 -0700, Greg KH wrote:
> On Mon, Jul 11, 2016 at 02:22:09PM +0200, Jean Delvare wrote:
> > So you are basically building a test case to cause the problem. It's
> > artificial. The adapter reference being held while the device node is
> > open isn't a bug, it is a design decision. I would consider revisiting
> > that design if there was a real world case where it causes trouble, but
> > not for an artificially created test case.
> > 
> > I don't see anything fundamentally wrong in the design anyway. I do not
> > expect to be allowed to remove a hard disk drive from my system while
> > its partitions are mounted, and I don't expect to be able to unmount
> > partitions while users have files opened on them. You always have to
> > tear things down in the right order. Same here.
> 
> But that's exactly what you do today when your USB disk falls out of
> it's connection.  The kernel recovers and you move on.  Hopefully it
> wasn't your root partition :)
> 
> Same for a serial device that has open userspace descriptors that is
> removed from the system, or almost any other type of device that can be
> physically removed from a system while it is currently running (PCI,
> firewire, thunderbolt, etc.)  What happens if you have an i2c device on
> a PCI card that is removed while userspace has that device descriptor
> open?  You need to "invalidate" it and not oops if userspace keeps
> reading/writing to it.

Honestly I have no idea what would happen in this case. I would expect
the PCI card to be offlined by software first, before it is physically
removed. Hot-unplug doesn't mean hot-tearoff ;-)

In case unprepared hardware tear-off actually happens (more
realistically on USB rather than PCI I suppose) I agree we want to
avoid oopses and other horrible consequences and behave as smoothly as
possible. The code was not written with this scenario in mind, so
additional work is certainly needed.

> > (...)
> > Still no details here. What app, what is it doing, to what device is it
> > talking, why is it not a kernel driver, and why do they keep the device
> > node opened all the time?
> 
> Any random application can write to an i2c device in this system, as
> long as it has "permission" to do so.  But, it's hardware, and on a bus
> that sometimes can be yanked out of the system.  When that happens,
> userspace will be notified of the removal, and "should" be nice and

I don't think there is any such notification on i2c device nodes at the
moment. Unless it's something generic. But I'm certain i2cdump etc.
aren't listening anyway.

> clean up after itself.  But there will always be some lag between the
> actual removal when the kernel figures it out, and when userspace
> finally closes that device node.
> 
> So not crashing the kernel is a nice thing to prevent from happening
> during that window of when the device is removed and userspace hasn't
> quite noticed it yet.

I agree.

> > (...)
> > See my previous questions. We still don't know why they are doing what
> > they are doing in user-space, nor why they think they have to keep the
> > device node opened.
> > 
> > They could always kill the application in question with:
> > # fuser -k /dev/i2c-*
> > before removing the module. Or find a more polite way to tell the
> > application to quit. If they want to do it in user-space, they have to
> > do it right.
> 
> Ideally, yes, userspace will have closed that device node.  But again,
> hardware isn't kind and sometimes decides to be yanked out by users
> before they tell the kernel about it.  We handle this for almost all
> other device subsystems, i2c is one of the last to be fixed up in this
> manner.  Sorry it's taken us well over a decade to get here :)

The problem is that the patch proposed by Viresh has nothing to do with
this. It's not adding notifications, just changing the time frame during
which user-space holds a reference to the i2c (bus) device. The goal as
I understand it is to allow *prepared* hot-unplug (in the form of
"rmmod i2c-bus-device-driver" or sysfs-based offlining?) while
user-space processes have i2c device nodes open. Unprepared hot-unplug
will still go wrong exactly as it goes now.

My point is that prepared hot-unplug can already be achieved today
without any patch. Or possibly improved by adding a notification
mechanism. But not by changing the reference holding design.

Not only the proposed patch does not help and degrades the performance,
but it breaks assumptions. For example, it would allow an application
to open an i2c bus, then you remove its driver and load another i2c bus
driver, which gets the same bus number, and now the application writes
to a completely different I2C bus segment. The current reference model
prevents that, on purpose.

So, again, nack from me.

-- 
Jean Delvare
SUSE L3 Support
