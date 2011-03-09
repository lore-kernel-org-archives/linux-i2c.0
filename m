From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] misc: adds support the FSA9480 USB Switch
Date: Tue, 8 Mar 2011 16:09:32 -0800
Message-ID: <20110309000932.GA12470@kroah.com>
References: <4D75D338.9070801@samsung.com>
 <20110308135909.GA7519@kroah.com>
 <AANLkTi=cgOJK=xGpbM8zaTVHcF+ZzjTCds+6dw3zAN_P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=cgOJK=xGpbM8zaTVHcF+ZzjTCds+6dw3zAN_P-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <promsoft-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 09, 2011 at 08:59:18AM +0900, Minkyu Kang wrote:
> Dear Greg KH,
> 
> On 8 March 2011 22:59, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> > On Tue, Mar 08, 2011 at 03:56:56PM +0900, Minkyu Kang wrote:
> >> --- /dev/null
> >> +++ b/include/linux/fsa9480.h
> >
> > Why do you need a .h file for this driver?
> >
> > If it's just for platform data, please put it in
> > include/linux/platform_data/ instead.
> 
> Yes, it's for platform data.
> But, sorry I couldn't find such a directory.
> Where?

It's in the linux-next tree, you can create that file in your patch.

thanks,

greg k-h
