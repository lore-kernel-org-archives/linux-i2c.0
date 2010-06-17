From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] hmc6352: Add driver for the HMC6352 compass
Date: Thu, 17 Jun 2010 13:46:50 +0100
Message-ID: <20100617134650.501b14bb@linux.intel.com>
References: <20100616121534.26294.12540.stgit@localhost.localdomain>
	<201006161443.45375.oneukum@suse.de>
	<20100617122048.142def43@lxorguk.ukuu.org.uk>
	<201006171426.08442.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201006171426.08442.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> > Its an array anyway - there isn't as such a 'correct macro' nor
> > does it need to be using one.
> 
> So why does he use this unstructured data? Do we just hope the
> compiler is good enough on big endian architectures?

Its an array because it comes from an i2c bus which is a bytestream.
There is no structure on the i2c bus and the device is defined to
return a pair of bytes in this manner.

Alan
