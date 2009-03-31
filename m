From: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Tue, 31 Mar 2009 10:54:35 +0800
Message-ID: <4e090d470903301954h2b3174b5n4b6c41b02cf7b62c@mail.gmail.com>
References: <49C89E13.7040801@gmail.com> <49CA017D.20005@gmail.com>
	 <20090325104357.GB3029@pengutronix.de>
	 <Pine.LNX.4.64.0903282207480.9903@axis700.grange>
	 <d7f267fd0903300048p7caee6e0ne63916b986b132b@mail.gmail.com>
	 <Pine.LNX.4.64.0903301124040.4455@axis700.grange>
	 <20090330095147.GP7861@pengutronix.de>
	 <Pine.LNX.4.64.0903301156060.4455@axis700.grange>
	 <49D08AE4.1090102@gmail.com>
	 <Pine.LNX.4.64.0903301548570.4455@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0903301548570.4455-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 30, 2009 at 9:50 PM, Guennadi Liakhovetski
<g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> Ok, I just was informed, that there is a hardware bug on the board I am
> using. So, please ignore my objections. Sorry for the wasted time.
>
> Thanks
> Guennadi
> ---
It seems Guennadi's patch is based on a newer(not latest) version i2c
driver from freescale.
I suggest we create patch based on the latest freescale kernel source
to avoid fragment.

Thanks
Richard
