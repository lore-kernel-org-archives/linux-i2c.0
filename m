From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] i2c: suppress lockdep warning on delete_device
Date: Fri, 17 May 2013 10:42:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305171040580.1012-100000@iolanthe.rowland.org>
References: <51962903.9050901@nsn.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51962903.9050901-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 17 May 2013, Alexander Sverdlin wrote:

> i2c: suppress lockdep warning on delete_device
> 
> Since commit 846f99749ab68bbc7f75c74fec305de675b1a1bf the following lockdep
> warning is thrown in case i2c device is removed (via delete_device sysfs
> attribute) which contains subdevices (e.g. i2c multiplexer):

Can you explain this in a little more detail?  Exactly what does the 
delete_device attribute do, when called for device D?

That is, what does a write to /sys/bus/i2c/devices/D/delete_device do?

Alan Stern
