From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Thu, 4 Dec 2008 13:30:00 +0000
Message-ID: <20081204132959.GC8019@sirena.org.uk>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812030917440.4717@axis700.grange> <gh5vf4$e02$1@ger.gmane.org> <Pine.LNX.4.64.0812032158150.7961@axis700.grange> <49378B1A.7030909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49378B1A.7030909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 04, 2008 at 09:47:38AM +0200, Darius wrote:

> This means I should use shifted address in platform data?
> For example: OV7670 image sensor has slave address 0x42 for write, and 
> 0x43 for read operations.
> This is hardware slave address, to which device responds.
> But I should use 0x21 in platform data, because it must be doubled in 
> adapter driver?

Yes, exactly.  Linux does not treat the read/write bit as part of the
address.
