From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Mon, 11 Jul 2016 14:50:58 -0700
Message-ID: <20160711215058.GA7808@kroah.com>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
 <20160706065523.GA1439@tetsubishi>
 <20160706191218.483fd9fd@endymion>
 <20160706205540.GJ4127@ubuntu>
 <20160711142209.4711f229@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44548 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbcGKXGI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Jul 2016 19:06:08 -0400
Content-Disposition: inline
In-Reply-To: <20160711142209.4711f229@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

On Mon, Jul 11, 2016 at 02:22:09PM +0200, Jean Delvare wrote:
> Hi Viresh,
> 
> On Wed, 6 Jul 2016 13:55:40 -0700, Viresh Kumar wrote:
> > On 06-07-16, 19:12, Jean Delvare wrote:
> > > Well well... I don't like this patch at all to be honest.
> > 
> > Sure, I didn't like it much as well. I just wanted people to comment on what
> > else we can do here. We don't really want to add out-of-mainline stuff here.
> > 
> > > My first question would be: what is keeping /dev/i2c-* open all the
> > > time? Originally i2c-dev was developed with development and debugging
> > > tools in mind (the i2c-tools suite.) The device nodes were never meant
> > > to be kept open for more than a few seconds.
> > 
> > We thought that buggy userspace shouldn't be allowed to get kernel into trouble.
> > Isn't that the case ?
> 
> Buggy user-space run by root can cause any kind of trouble. And the
> point being discussed here is amongst the most minor of these. But I
> even disagree with calling it buggy.
> 
> > In our case this is what happens:
> > - userspace opens the file descriptor
> > - we try to forcefully remove the module from phone (that doesn't talk to
> >   userspace to stop using the device).
> > - The module doesn't get ejected unless the app closes the fd.
> 
> So you are basically building a test case to cause the problem. It's
> artificial. The adapter reference being held while the device node is
> open isn't a bug, it is a design decision. I would consider revisiting
> that design if there was a real world case where it causes trouble, but
> not for an artificially created test case.
> 
> I don't see anything fundamentally wrong in the design anyway. I do not
> expect to be allowed to remove a hard disk drive from my system while
> its partitions are mounted, and I don't expect to be able to unmount
> partitions while users have files opened on them. You always have to
> tear things down in the right order. Same here.

But that's exactly what you do today when your USB disk falls out of
it's connection.  The kernel recovers and you move on.  Hopefully it
wasn't your root partition :)

Same for a serial device that has open userspace descriptors that is
removed from the system, or almost any other type of device that can be
physically removed from a system while it is currently running (PCI,
firewire, thunderbolt, etc.)  What happens if you have an i2c device on
a PCI card that is removed while userspace has that device descriptor
open?  You need to "invalidate" it and not oops if userspace keeps
reading/writing to it.


> > > Do you have user-space i2c device drivers on your system? Which ones,
> > 
> > No. Its probably an app written by some of our module app developers.
> > 
> > > and why (I would expect all useful i2c devices to have a kernel
> > > driver.)
> > 
> > That's what we have.
> 
> Still no details here. What app, what is it doing, to what device is it
> talking, why is it not a kernel driver, and why do they keep the device
> node opened all the time?

Any random application can write to an i2c device in this system, as
long as it has "permission" to do so.  But, it's hardware, and on a bus
that sometimes can be yanked out of the system.  When that happens,
userspace will be notified of the removal, and "should" be nice and
clean up after itself.  But there will always be some lag between the
actual removal when the kernel figures it out, and when userspace
finally closes that device node.

So not crashing the kernel is a nice thing to prevent from happening
during that window of when the device is removed and userspace hasn't
quite noticed it yet.

> > > Requesting and freeing the i2c adapter for every transaction is going
> > 
> > Well, we are just finding it (taking a reference of it) and the dropping its
> > reference.
> 
> Yes, that's what I meant, sorry for using the wrong terms.
> 
> > > to add a lot of overhead to all existing tools :-(
> > 
> > :(
> 
> i2cdump typically runs 258 ioctls on the device node, i2cdetect 235.
> i2c_get_adapter isn't cheap. Multiple function calls, mutex
> locking/unlocking, preemption disabling/enabling... You don't want do
> to that repeatedly if it can be avoided. So, nack from me.
> 
> > > It's not like every user can open i2c device nodes and block the
> > > system. Only selected users should be able to open i2c device nodes
> > > (only root by default) so they should be responsible for not
> > > misbehaving.
> > 
> > Hmmm. The problem is that they weren't told when the module tries to go away and
> > so they don't know that they need to close the fd.
> 
> See my previous questions. We still don't know why they are doing what
> they are doing in user-space, nor why they think they have to keep the
> device node opened.
> 
> They could always kill the application in question with:
> # fuser -k /dev/i2c-*
> before removing the module. Or find a more polite way to tell the
> application to quit. If they want to do it in user-space, they have to
> do it right.

Ideally, yes, userspace will have closed that device node.  But again,
hardware isn't kind and sometimes decides to be yanked out by users
before they tell the kernel about it.  We handle this for almost all
other device subsystems, i2c is one of the last to be fixed up in this
manner.  Sorry it's taken us well over a decade to get here :)

hope that explains things better,

greg k-h
