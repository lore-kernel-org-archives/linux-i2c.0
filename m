From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Finding 'orphaned' i2c drivers
Date: Mon, 23 Feb 2009 12:00:52 +0100
Message-ID: <20090223110052.GE15722@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

what's the suggested way of implementing an i2c drver which does not
have any other interfaces to the outside world than just the i2c device
it is communicating with? More specificly, I implemented a driver for a
Maxim clock generator and would like to use a proprietary interface with
it from a alsa-soc module. I just can't find a sane way to access the
driver's instance from there. It does exist somewhere in the linux
device tree, but is there a simple function that iterates over it and
returns it to me by name? Reading include/linux/device.h didn't point me
to anything that could fit.

Excuse me this is a stupid question, but I can't find any useful
information about that anywhere.

Thanks,
Daniel
