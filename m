From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-gpio performance issue w/MPC8xx @ 50 MHz
Date: Sun, 1 May 2011 10:26:03 +0200
Message-ID: <20110501102603.7993da58@endymion.delvare>
References: <BANLkTikaS8yOTcO+OChvutB0syWdVBsh8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTikaS8yOTcO+OChvutB0syWdVBsh8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Eran,

On Tue, 19 Apr 2011 23:53:11 +0300, Eran Duchan wrote:
> Hey list
> 
> I needed to bit bang I2C on an ancient MPC875 running at a blazing 50
> MHz. I started by initializing the generic i2c-gpio bus but quickly
> found it could not bit bang @ 100 kHz. The most I was able to get it
> was ~50 kHz by setting udelay to 0 and patching around i2c-gpio.c to
> make sure it doesn't modify this value.
> 
> I then implemented a bus driver of my own, based on i2c-gpio. The only
> difference was that it simply implemented set/get sda/scl by directly
> writing to hardware. Using this I was able to reach around 150 kHz.
> 
> 1) Any comments on the above? Could I have done something differently?

Apparently the gpio layer is adding a delay somehow. You should ask
Grant Likely (gpio subsystem maintainer) and Haavard Skinnemoen (author
and maintainer of the i2c-gpio driver) about it. I Cc'd both. They
should know where in i2c-gpio or the gpio layer an extra delay may be
introduced.

> 2) I thought perhaps a thin adapter could be implemented that exported
> a platform data structure holding callbacks: set sda/scl dir/val, get
> sda/scl. By registering such a bus driver and supplying these
> callbacks in the platform module, one could avoid having to
> re-implement a bus driver like I did. Comments?

What you are proposing is turning i2c-algo-bit into a platform driver
instead of the basic library it is at the moment. When the code was
written, the platform "bus" didn't even exist so it wasn't an option.
While I don't expect all users of i2c-algo-bit to be converted to such
a platform driver, it may indeed be useful in some cases, so I have no
objection.

That being said, if you use GPIOs, it would certainly be better to find
out whether the extra delay you've been observing could be removed.
Properly requesting the GPIOs you need is definitely cleaner than
accessing the I/O port (or whatever) directly. Direct access can be
unreliable if other code is using GPIOs nearby.

-- 
Jean Delvare
