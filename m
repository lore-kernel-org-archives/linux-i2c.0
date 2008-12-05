From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Fri, 5 Dec 2008 16:17:49 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812051612500.5840@axis700.grange>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812030917440.4717@axis700.grange>
 <20081203234317.GA4256@fluff.org.uk> <4937AA1C.8050004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4937AA1C.8050004-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 4 Dec 2008, Darius wrote:

> I tested on MX1. There delay is not needed at all.

Darius, how exactly you tested on MX1? I just found out, that also 
i2c_smbus_{read,write}_word_data() doesn't work with imx driver on i.MX31, 
whereas the mxc driver does.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
