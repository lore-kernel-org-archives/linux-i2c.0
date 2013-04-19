From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH]  I2C: Change the value of octeon i2c adapter timeout
 value
Date: Fri, 19 Apr 2013 09:58:43 +0200
Message-ID: <20130419075843.GA4468@the-dreams.de>
References: <22387590.3491366329664571.JavaMail.weblogic@epv6ml11>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <22387590.3491366329664571.JavaMail.weblogic@epv6ml11>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: EUNBONG SONG <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 19, 2013 at 12:01:04AM +0000, EUNBONG SONG wrote:
> 
> I think HZ/50 is better than 2 for adapter timeout.

Basically OK. But why HZ/50? Most drivers use HZ.
