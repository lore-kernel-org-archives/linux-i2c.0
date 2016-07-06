From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Wed, 6 Jul 2016 19:12:18 +0200
Message-ID: <20160706191218.483fd9fd@endymion>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
	<021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
	<20160706065523.GA1439@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42189 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294AbcGFRMV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 6 Jul 2016 13:12:21 -0400
In-Reply-To: <20160706065523.GA1439@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

On Wed, 6 Jul 2016 15:55:24 +0900, Wolfram Sang wrote:
> On Tue, Jul 05, 2016 at 07:57:07PM -0700, Viresh Kumar wrote:
> > The i2c-dev calls i2c_get_adapter() from the .open() callback, which
> > doesn't let the adapter device unregister unless the .close() callback
> > is called.
> > 
> > On some platforms (like Google ARA), this doesn't let the modules
> > (hardware attached to the phone) eject from the phone as the cleanup
> > path for the module hasn't finished yet (i2c adapter not removed).
> > 
> > We can't let the userspace block the kernel forever in such cases.
> > 
> > Fix this by calling i2c_get_adapter() from all other file operations,
> > i.e.  read/write/ioctl, to make sure the adapter doesn't get away while
> > we are in the middle of a operation, but not otherwise. In .open() we
> > will release the adapter device before returning and so if there is no
> > data transfer in progress, then the i2c-dev doesn't block the adapter
> > from unregistering.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I'd think Jean has more experience with I2C hotplugging approaches and
> difficulties, so I'd be interested in his high level review.

Well well... I don't like this patch at all to be honest.

My first question would be: what is keeping /dev/i2c-* open all the
time? Originally i2c-dev was developed with development and debugging
tools in mind (the i2c-tools suite.) The device nodes were never meant
to be kept open for more than a few seconds.

Do you have user-space i2c device drivers on your system? Which ones,
and why (I would expect all useful i2c devices to have a kernel
driver.) And why do they keep their i2c device node opened all the time?

Requesting and freeing the i2c adapter for every transaction is going
to add a lot of overhead to all existing tools :-(

It's not like every user can open i2c device nodes and block the
system. Only selected users should be able to open i2c device nodes
(only root by default) so they should be responsible for not
misbehaving.

-- 
Jean Delvare
SUSE L3 Support
