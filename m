From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Using the gpio i2c multiplexer driver
Date: Wed, 16 Feb 2011 08:07:26 +0100
Message-ID: <4D5B77AE.20307@gmx.de>
References: <1297810054.24938.218.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297810054.24938.218.camel@groeck-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Guenter Roeck said the following:
> Hi all,
> 
> I am trying to use the new GPIO based I2C multiplexer. Unfortunately, I
> have an initialization problem with it.
> 
> Some time after registering the multiplexer as platform driver, its
> probe function is called. Unfortunately, that does not happen in sync
> with I2C adapter initialization. The GPIO mux probe function is called
> before the parent's (ie the multiplexed I2C adapter) probe function is
> called. As a result, the GPIO mux driver does not find its parent i2c
> adapter, and the probe function aborts with an error.
> 
> Any idea how I I can fix the problem, ie how I can ensure that the GPIO
> mux probe function is only called after its parent I2C adapter is
> initialized ?
> 
Well, I assume your GPIO-Mux is registered as an GPIO device? Can't you
add it as an I2C-device? This way the right sequence should be kept.

HTH
-- 
Michael
