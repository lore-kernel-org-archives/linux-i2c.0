From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: suppress lockdep warning on delete_device
Date: Fri, 17 May 2013 22:47:51 +0200
Message-ID: <20130517204748.GB2925@katana>
References: <51962903.9050901@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51962903.9050901-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 17, 2013 at 02:56:35PM +0200, Alexander Sverdlin wrote:
> i2c: suppress lockdep warning on delete_device
> 
> Since commit 846f99749ab68bbc7f75c74fec305de675b1a1bf the following lockdep
> warning is thrown in case i2c device is removed (via delete_device sysfs
> attribute) which contains subdevices (e.g. i2c multiplexer):

Applied to for-current with Alan's ack, thanks!

I couldn't apply the patch due to whitespace problems. I fixed them here
because I wanted to have the patch in my very soon pull request. But
please have a look.
