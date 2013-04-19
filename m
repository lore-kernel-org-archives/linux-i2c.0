From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Re: [PATCH]  I2C: Change the value of octeon i2c adapter timeout
 value
Date: Fri, 19 Apr 2013 20:32:58 +0200
Message-ID: <20130419183258.GB3702@the-dreams.de>
References: <33288064.110491366362833968.JavaMail.weblogic@epv6ml06>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <33288064.110491366362833968.JavaMail.weblogic@epv6ml06>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: EUNBONG SONG <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 19, 2013 at 09:13:54AM +0000, EUNBONG SONG wrote:
> 
> 
> On Fri, Apr 19, 2013 at 12:01:04AM +0000, EUNBONG SONG wrote:
> >> 
> >>  I think HZ/50 is better than 2 for adapter timeout.
> 
> > Basically OK. But why HZ/50? Most drivers use HZ.
> 
> Actually, I just translated 2 jiffies because HZ is 100 in default cavium config. 
> You can find that in "arch/mips/configs/cavium_octeon_defconfig". 
> And i have been using this value over 1 year in octeon board without problem.

Have you been writing to EEPROMS? Their erase/write cycle might be
longer. But I am not forcing you to change the value, just giving some
suggestions.
