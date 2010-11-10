From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v2] misc: adds support the FSA9480 USB Switch
Date: Wed, 10 Nov 2010 14:31:10 +0000
Message-ID: <20101110143110.GA5043@sirena.org.uk>
References: <4C7CD95A.5040309@samsung.com> <20100917150731.f1f44f3c.akpm@linux-foundation.org> <AANLkTim2UhJAhOw1qHvZ9bbctR0tNSMvE61T=sxffHxO@mail.gmail.com> <4CB26931.5040105@samsung.com> <20101011173649.GC7116@kroah.com> <AANLkTi=vTkHJJ2dq5RZHHCwWYEBtY=Y7dPPh=Wzzx95f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=vTkHJJ2dq5RZHHCwWYEBtY=Y7dPPh=Wzzx95f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <promsoft-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 10, 2010 at 09:55:34AM +0900, Minkyu Kang wrote:
> Dear Greg KH,

> > And why are you exporting symbols from this driver, that should not be
> > needed at all.

> It's for other drivers.
> For example.. When USB cable is connected, PMIC driver enable the
> power for each device. (USB, uart, audio and so on..)
> But if use the manual switch, PMIC driver can't know what device is enabled.
> So, this function was exported.

This seems like it would require the PMIC driver to have knowledge of
the USB switch driver which would be likely to give a system which is
rather board specific.  For PMIC supply management integration the
regulator API would be more normal.
