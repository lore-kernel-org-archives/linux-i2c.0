From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: at24 driver - a possible problem
Date: Sun, 8 Nov 2009 14:30:01 -0700
Message-ID: <200911081330.01280.david-b@pacbell.net>
References: <533f29860911050810w4d939b39x2ad11c189f13c977@mail.gmail.com> <200911061258.52179.david-b@pacbell.net> <20091108202331.GA6374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091108202331.GA6374-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 08 November 2009, Wolfram Sang wrote:
> Still, the latter one beats me right now. The sysfs-bin-write gets a kobject
> and the O_SYNC is placed in the flags of a filp during open. Is there a some
> connection between those?

I'd have to look carefully, but ISTR there isn't.


> I'm not even sure if O_SYNC should be handled at the 
> sysfs-layer instead of inside the driver?
> 
