From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 3/3] i2c: mux: pca954x: allow management of device
 idle state via sysfs
Date: Wed, 13 Mar 2019 14:14:10 -0700
Message-ID: <20190313211410.GB32331@kroah.com>
References: <20190228114343.36443-1-robertshearman@gmail.com>
 <20190228114343.36443-4-robertshearman@gmail.com>
 <e07248e6-4987-b7a1-327a-7d30a3e5cdf5@axentia.se>
 <20190313152044.GD10250@kroah.com>
 <20190313163610.qbuexiowfcqgqndu@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190313163610.qbuexiowfcqgqndu@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Robert Shearman <robertshearman@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Robert Shearman <robert.shearman@att.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 13, 2019 at 05:36:10PM +0100, Wolfram Sang wrote:
> Hi Greg,
> 
> > > I was wondering if you think the below ABI addition looks sane to you?
> > I am not the i2c maintainer :)
> 
> Peter is the i2c-mux maintainer, so I trust him very much on the I2C
> side of things. We just wondered if you'd notice a general flaw when
> exposing such an interface to userspace.

Ah, I see.  No, looks fine to me, it's a single value, well documented,
should be just fine.

thanks,

greg k-h
