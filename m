From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] misc: adds support the FSA9480 USB Switch
Date: Tue, 8 Mar 2011 05:59:09 -0800
Message-ID: <20110308135909.GA7519@kroah.com>
References: <4D75D338.9070801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D75D338.9070801-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 08, 2011 at 03:56:56PM +0900, Minkyu Kang wrote:
> --- /dev/null
> +++ b/include/linux/fsa9480.h

Why do you need a .h file for this driver?

If it's just for platform data, please put it in
include/linux/platform_data/ instead.

If it's not, then please just move it to your driver's .c file.

thanks,

greg k-h
