From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: v4l2-subdev Re: [PATCH 0/5] soc-camera: convert to platform
 device
Date: Mon, 20 Apr 2009 16:18:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0904201617130.4403@axis700.grange>
References: <aec7e5c30904170040p6ec1721aj6885ef16573cd484@mail.gmail.com>
 <Pine.LNX.4.64.0904170950320.5119@axis700.grange>
 <aec7e5c30904170331n6da85695gdd6da8d6a42eacf1@mail.gmail.com>
 <Pine.LNX.4.64.0904171235010.5119@axis700.grange>
 <aec7e5c30904200014n2d8cdcfeud23f2b6b221f9fad@mail.gmail.com>
 <Pine.LNX.4.64.0904200921090.4403@axis700.grange>
 <aec7e5c30904200100wb117328sb97ea0262d163547@mail.gmail.com>
 <Pine.LNX.4.64.0904201010130.4403@axis700.grange>
 <aec7e5c30904200154w758e4ecl8174a4cb0bce11f9@mail.gmail.com>
 <Pine.LNX.4.64.0904201525320.4403@axis700.grange> <20090420140411.GE8776@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090420140411.GE8776-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Kuninori Morimoto <morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 20 Apr 2009, Mark Brown wrote:

> On Mon, Apr 20, 2009 at 03:50:44PM +0200, Guennadi Liakhovetski wrote:
> 
> > break if we move it down right after i2c? Another hackish interim solution 
> > would be to replace module_init with subsys_init in i2c-sh_mobile.c like 
> > some other i2c adapters do (including MXC, PXA). That's certainly easier, 
> > but then we'd also have to modify i2c-imx, later maybe i2c-at91.c...
> 
> That'd be sensible long term anyway - voltage and current regulators are
> often I2C devices and they need to be initialised very early in order to
> be available for general use.

If there are other requirements to have i2c initialise early we can well 
move it up the chain. I think it would be preferable to modifying each i2c 
host adapter driver to use subsys_init().

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
