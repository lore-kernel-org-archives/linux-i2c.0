From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 3/3] i2c: mux: pca954x: allow management of device
 idle state via sysfs
Date: Wed, 13 Mar 2019 08:20:44 -0700
Message-ID: <20190313152044.GD10250@kroah.com>
References: <20190228114343.36443-1-robertshearman@gmail.com>
 <20190228114343.36443-4-robertshearman@gmail.com>
 <e07248e6-4987-b7a1-327a-7d30a3e5cdf5@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e07248e6-4987-b7a1-327a-7d30a3e5cdf5@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Robert Shearman <robertshearman@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Robert Shearman <robert.shearman@att.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 13, 2019 at 07:04:06AM +0000, Peter Rosin wrote:
> Hi Greg,
> 
> I was wondering if you think the below ABI addition looks sane to you?

I am not the i2c maintainer :)

> Or, should I ask someone else for a tag?

It's the middle of the merge window.  None of us can do much other than
focus on that until 5.1-rc1 is out.

thanks,

greg k-h
