From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Wed, 6 Jul 2016 13:55:40 -0700
Message-ID: <20160706205540.GJ4127@ubuntu>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
 <20160706065523.GA1439@tetsubishi>
 <20160706191218.483fd9fd@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35804 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbcGFUzm (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Jul 2016 16:55:42 -0400
Received: by mail-pa0-f50.google.com with SMTP id dx3so14826690pab.2
        for <linux-i2c@vger.kernel.org>; Wed, 06 Jul 2016 13:55:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160706191218.483fd9fd@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

On 06-07-16, 19:12, Jean Delvare wrote:
> Well well... I don't like this patch at all to be honest.

Sure, I didn't like it much as well. I just wanted people to comment on what
else we can do here. We don't really want to add out-of-mainline stuff here.

> My first question would be: what is keeping /dev/i2c-* open all the
> time? Originally i2c-dev was developed with development and debugging
> tools in mind (the i2c-tools suite.) The device nodes were never meant
> to be kept open for more than a few seconds.

We thought that buggy userspace shouldn't be allowed to get kernel into trouble.
Isn't that the case ?

In our case this is what happens:
- userspace opens the file descriptor
- we try to forcefully remove the module from phone (that doesn't talk to
  userspace to stop using the device).
- The module doesn't get ejected unless the app closes the fd.

> Do you have user-space i2c device drivers on your system? Which ones,

No. Its probably an app written by some of our module app developers.

> and why (I would expect all useful i2c devices to have a kernel
> driver.)

That's what we have.

> Requesting and freeing the i2c adapter for every transaction is going

Well, we are just finding it (taking a reference of it) and the dropping its
reference.

> to add a lot of overhead to all existing tools :-(

:(

> It's not like every user can open i2c device nodes and block the
> system. Only selected users should be able to open i2c device nodes
> (only root by default) so they should be responsible for not
> misbehaving.

Hmmm. The problem is that they weren't told when the module tries to go away and
so they don't know that they need to close the fd.

Also coming to the earlier thing, I though even the buggy userspace thing
shouldn't be allowed to block kernel device unregisteration.

-- 
viresh
