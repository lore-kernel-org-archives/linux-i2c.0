From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Using the gpio i2c multiplexer driver
Date: Tue, 15 Feb 2011 14:47:34 -0800
Message-ID: <1297810054.24938.218.camel@groeck-laptop>
Reply-To: guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

I am trying to use the new GPIO based I2C multiplexer. Unfortunately, I
have an initialization problem with it.

Some time after registering the multiplexer as platform driver, its
probe function is called. Unfortunately, that does not happen in sync
with I2C adapter initialization. The GPIO mux probe function is called
before the parent's (ie the multiplexed I2C adapter) probe function is
called. As a result, the GPIO mux driver does not find its parent i2c
adapter, and the probe function aborts with an error.

Any idea how I I can fix the problem, ie how I can ensure that the GPIO
mux probe function is only called after its parent I2C adapter is
initialized ?

Thanks,
Guenter
