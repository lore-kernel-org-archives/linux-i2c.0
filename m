From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [2.6.37 -> 2.6.38 regression] "mv64xxx: I2C bus locked, block:
 1, time_left: 0" every few seconds
Date: Sat, 7 Jan 2012 16:45:02 -0800
Message-ID: <20120108004502.GA20549@ericsson.com>
References: <20120101042401.4bef017e@natsu>
 <20120101073255.GA2402@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120101073255.GA2402-E4JsH6yu/ca99If2fRKg35Ea+QML8DWm@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arnaud Patard <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Roman Mamedov <rm-pzoh41kZ4TQvJsYlp49lxw@public.gmane.org>, Manuel Roeder <manuel_roeder-Mmb7MZpHnFY@public.gmane.org>, Michael Ott <michael-rB2af1Vdh+fddJNmlsFzeA@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Mauro Barella <mbarella-RSoB1PSltFvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jan 01, 2012 at 01:32:55AM -0600, Jonathan Nieder wrote:
> Hi,
> 
> Roman Mamedov wrote[1]:
> 
> > This bug is still present for me in the latest kernel version in
> > Debian testing (3.1.6).
> >
> > The last properly working kernel version seems to be:
> [...]
> > And the problem occurs since:
> [...]
> 
> Thanks.  Arnaud, any hints?  To summarize:
> 
>  - Michael Ott reported with Debian kernel 2.6.38-3 (which is closely
>    based on stable v2.6.38.2):
> 
> 	syslog tell me every few seconds:
> 	i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> 
>  - Manuel Roeder reported the same and found that upstream v2.6.38
>    triggers the problem and v2.6.37.6 does not.
> 
>  - Roman Mamedov finds the bug present in Debian 3.1.6-1 (which
>    is closely based on stable v3.1.6) and Debian 2.6.37-2 (based on
>    stable v2.6.37.2) but not Debian 2.6.37-1 (based on mainline
>    v2.6.37).
> 
> The regression range described above seems a little inconsistent to
> me, so maybe there's something more going on.
> 
Points to commit eda6bee6c7e67b5bd17bdbced0926f5687f686d5 (i2c-mv64xxx: send repeated START
between messages in xfer). Maybe you can back it out and see if it makes a difference.

Guenter
