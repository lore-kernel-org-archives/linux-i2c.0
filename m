From: "Chuck Kamas" <ckamas-mizZ2TCXIxVBDgjK7y7TUQ@public.gmane.org>
Subject: RE: How to manually call i2c_client's probe from i2c-dev.c ioctl
Date: Thu, 17 Sep 2009 08:45:57 -0700
Message-ID: <C62896630644CE43BF64B0FF0AC27F0E1815EC@mail.ad.skymv.com>
References: <C62896630644CE43BF64B0FF0AC27F0E18153F@mail.ad.skymv.com><20090916225247.2094619b@hyperion.delvare><C62896630644CE43BF64B0FF0AC27F0E1815B9@mail.ad.skymv.com> <20090917092612.53327f80@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20090917092612.53327f80-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean,

Thanks for the reply.  I see now that I was not clear.  In the patch
that I mentioned, Michael used a call i2c_new_device(client->adapter,
&bInfo).  This is from the new model.  What would be the equivalent call
from the old model?  I.e. what function do I call so that a chip driver
will issue a probe and if a chip is found it will be properly
registered?

Thanks for looking at my issue.

Chuck


> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] 
> Sent: Thursday, September 17, 2009 12:26 AM
> To: Chuck Kamas
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: How to manually call i2c_client's probe from 
> i2c-dev.c ioctl
> 
> On Wed, 16 Sep 2009 16:25:59 -0700, Chuck Kamas wrote:
> > All of this I am very aware of.  However, I still need to 
> solve this 
> > problem. Can you please suggest a solution?
> 
> You did not tell us what your problem was!
> 
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
> 
