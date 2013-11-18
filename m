From: Peter =?iso-8859-15?q?H=FCwe?= <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: I2C Master with limited transmission sizes
Date: Tue, 19 Nov 2013 00:03:03 +0100
Message-ID: <201311190003.03429.PeterHuewe@gmx.de>
References: <201311160438.36636.PeterHuewe@gmx.de> <20131117111524.GB3093@katana>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131117111524.GB3093@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

thanks for your answer.
> > I'm currently writing a driver for a cheap usb-to-i2c master device,
> > which unfortunately can only write 31 bytes (+slave addr) and read 32
> > bytes.
> 
> Which one?

CH341 based ones like this one http://wch-ic.com/download/down.asp?id=114
They go for about ~12 USD on ebay so quite affordable.

lsusb shows it as 
ID 1a86:5512 QinHeng Electronics CH341 in EPP/MEM/I2C mode, EPP/I2C adapter


> If you have control over sending start/stop bits, you could omit the
> stop condition unless you transfered all of the 32 byte chunks and issue
> the stop at the end.

This should be possible - I'll give it a try.

Once I've finished my testing I'll post it here for review.


Thanks,
Peter
