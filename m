From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: clock driver
Date: Wed, 27 May 2015 10:09:49 -0700
Message-ID: <20150527170949.GA24419@roeck-us.net>
References: <5564C58B.9050400@freescale.com>
 <20150526223829.GA26454@roeck-us.net>
 <55650DBA.5000304@freescale.com>
 <5565108D.2020502@freescale.com>
 <55656D96.9030603@gmail.com>
 <5565DDCA.2000308@freescale.com>
 <5565F40E.70805@gmail.com>
 <5565F4CA.4080105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5565F4CA.4080105-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andrey-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org, rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 27, 2015 at 09:46:02AM -0700, York Sun wrote:
> 
[ ... ]
> 
> Sebastian,
> 
> Thanks for the insight. Looks like I should give up upstreaming this driver. I
> will find other ways to make this driver available if anyone wants to use it.
> 

You might consider putting it on github. That is what I did with my si570
driver. It was then picked up by someone else and ported to the clock framework.
Win-win for everyone.

Thanks,
Guenter
