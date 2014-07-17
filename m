From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c-stub: Avoid an array overrun on I2C block transfers
Date: Thu, 17 Jul 2014 20:50:28 +0200
Message-ID: <20140717205028.76c1bc66@endymion.delvare>
References: <20140713171717.25497712@endymion.delvare>
	<20140717172720.GE2901@katana>
	<20140717175749.GA25303@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140717175749.GA25303-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 17 Jul 2014 10:57:49 -0700, Guenter Roeck wrote:
> On Thu, Jul 17, 2014 at 07:27:20PM +0200, Wolfram Sang wrote:
> > On Sun, Jul 13, 2014 at 05:17:17PM +0200, Jean Delvare wrote:
> > > I2C block transfers can have a size up to 32 bytes. If starting close
> > 
> > Shouldn't that be "256 bytes"? 32 is SMBUS transfer size? Otherwise I
> > don't understand the patch.
>
> If I understand correctly, this is still an SMBus command, which is limited
> to 32 bytes. Maybe the description should read "SMBus I2C block transfers ...".

That's correct, "I2C block transfers" despite the name really are
SMBus-style transfers and the SMBus buffer size limit of 32 bytes thus
applies.

With this clarified, Wolfram, what is is that you do not understand?
The start of the block transfer can be anywhere in 0-255, and the size
can be in 1-32, so without a boundary check, one can attempt to read or
write up to offset 255 + 32 - 1 = 286, which is way beyond the
the end of the chip->words array. My patch prevents that from happening.

-- 
Jean Delvare
SUSE L3 Support
