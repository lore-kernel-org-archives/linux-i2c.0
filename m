From: "Chuck Kamas" <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Subject: RE: How to manually call i2c_client's probe from i2c-dev.c ioctl
Date: Wed, 16 Sep 2009 16:25:59 -0700
Message-ID: <C62896630644CE43BF64B0FF0AC27F0E1815B9@mail.ad.skymv.com>
References: <C62896630644CE43BF64B0FF0AC27F0E18153F@mail.ad.skymv.com> <20090916225247.2094619b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20090916225247.2094619b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean,

All of this I am very aware of.  However, I still need to solve this
problem. Can you please suggest a solution?

Chuck


> -----Original Message-----
> From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Jean Delvare
> Sent: Wednesday, September 16, 2009 1:53 PM
> To: Chuck Kamas
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: How to manually call i2c_client's probe from 
> i2c-dev.c ioctl
> 
> On Wed, 16 Sep 2009 09:56:37 -0700, Chuck Kamas wrote:
> > I am trying to backport Michael's patch to add PROBE and 
> REMOVE ioctls 
> > to 2.6.21 
> > 
> http://article.gmane.org/gmane.linux.drivers.i2c/3339/match=ioctls+pro
> > be
> > 
> > I have been able to add the IOCTLS and re-compile the 
> kernel module, 
> > but am confused as to what function to call in the old 
> device model.  
> > I believe that I should use i2c_attach_client() from 
> i2c-core.c.  Is 
> > this correct?
> 
> You are backporting a patch which was rejected upstream, to a 
> model which is deprecated. It's probably time to reconsider 
> your technical choices.
> 
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-i2c" in the body of a message to 
> majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
