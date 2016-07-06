From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] i2c-dev: Don't let userspace block adapter
Date: Wed, 6 Jul 2016 08:34:49 -0700
Message-ID: <20160706153449.GL2671@ubuntu>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <577D1895.3060202@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <577D1895.3060202@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>
List-Id: linux-i2c@vger.kernel.org

On 06-07-16, 16:41, Lars-Peter Clausen wrote:
> On 07/06/2016 04:57 AM, Viresh Kumar wrote:
> > Hi Wolfram/Jean,
> > 
> > I am part of the kernel team for Google's projectara [1], where we are
> > building a module smart phone.
> > 
> > This series tries to fix one of the problems we hit on our system as we
> > are required to hotplug pretty much every thing on the phone and so this
> > fixes hotplug issues with i2c-dev.
> > 
> > As described in the second patch, the current implementation of i2c-dev
> > file operations doesn't let the modules (hardware attached to the phone)
> > eject from the phone as the cleanup path for the module hasn't finished
> > yet (i2c adapter not removed).
> > 
> > We can't let the userspace block the kernel devices forever in such
> > cases.
> > 
> > I was able to test them on the ARA phone with kernel 3.10 only and not
> > mainline.
> 
> This sounds like you want hot-unplug. This is currently not support by the
> I2C framework for adapters. A better approach compared to this series might
> be to implement full hot-unplug support for I2C adapters. This will probably
> also be useful for additional usecases.

Yeah, we need hot-unplug.

Hmm, doing that would require more knowledge of the framework and I am
afraid I don't have it right now, not that it can't be done :)

-- 
viresh
