From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c_intel_mid: Fix slash in sysfs name
Date: Tue, 4 Jan 2011 10:32:35 +0000
Message-ID: <20110104103235.1954dc23@lxorguk.ukuu.org.uk>
References: <20101214152849.7265.93628.stgit@bob.linux.org.uk>
	<20101215100815.44fb8b83@endymion.delvare>
	<4D227005.3010000@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D227005.3010000-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> > New sanity check of what? Where's the code?

Slashes in path names - it was added to the sysfs code

> > Using the adapter name to request the IRQ is silly. The very same issue
> > was fixed in i2c-pca-platform recently:
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=323584436db0cb05286425d4dfd9516fce88487f
> 
> I agree, something like dev_name(dev) is much better for readability
> of /proc/interruopts

I'll take a look at this now I am back from Christmas break.

Alan
