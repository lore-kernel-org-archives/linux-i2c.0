From: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Subject: Re: [PATCH] i2c: suppress lockdep warning on delete_device
Date: Fri, 17 May 2013 17:02:13 +0200
Message-ID: <51964675.6030807@nsn.com>
References: <Pine.LNX.4.44L0.1305171040580.1012-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1305171040580.1012-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

On 05/17/2013 04:42 PM, ext Alan Stern wrote:
>> i2c: suppress lockdep warning on delete_device
>>
>> Since commit 846f99749ab68bbc7f75c74fec305de675b1a1bf the following lockdep
>> warning is thrown in case i2c device is removed (via delete_device sysfs
>> attribute) which contains subdevices (e.g. i2c multiplexer):
>
> Can you explain this in a little more detail?  Exactly what does the
> delete_device attribute do, when called for device D?
>
> That is, what does a write to /sys/bus/i2c/devices/D/delete_device do?

Like USB with its hubs, I2C structure could be tree-like, with I2C multiplexers.
delete_device attribute removes I2C device from the subsystem, which is usually not
a problem, except the case when device is a multiplexer and sub-devices should be
removed first. Here we have the problem: holding a "s_active" lock on
"delete_device" attribute of a parent (multiplexer) we need to delete children, but
they were created with the same static attribute "delete_device".

The safety of this operation is exactly the same as in USB case... Any more clever
lockdep annotation is exactly not so easy...

-- 
Best regards,
Alexander Sverdlin.
