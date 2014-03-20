From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: platform_data in i2c device drivers
Date: Thu, 20 Mar 2014 17:25:45 +0100
Message-ID: <532B1689.3080202@codethink.co.uk>
References: <532A1B12.8080400@yahoo.com> <1511928.3cA2QKoAZt@avalon> <532B1367.8050906@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <532B1367.8050906-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Bormann <fbormann-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 20/03/14 17:12, Frank Bormann wrote:
> Hi Laurent,
>
> First of all, thank you so much for your detailed explanation. This
> really helps out a lot.
>
> Your assumptions are correct, I am needed working on an ARM device and
> it uses device tree for driver configuration.
>
> Just to confirm that I understand you correctly, what you're saying is
> that the platform_data and the device tree configuration mechanisms have
> an exclusive-or relationship, at least when it comes down to an
> individual driver, is that correct? And, if there is no platform_data
> provided, it is perfectly permissible for the probe function of the
> driver to make call to of_* functions to read its configuration?
> Provided that the kernel has Open Firmware and Device Tree support
> enabled of course.

Yes, dev->of_node should be set appropriately for devices enumerated
from the OF. This can then be used to read anything that the driver
core has not already found.

>
> Would it also acceptable for a driver's probe function to allocate
> memory for a platform_data instance and use the platform_data member in
> client->dev to store a pointer to it if no previous platform_data is
> available from the i2c_board_info configuration mechanism? Again
> provided of course that the memory is freed and the platform_data member
> in client->dev set back to null in the remove function of the driver.

I think client->dev should be avoided if at-all possible. Many
drivers keep their own local copy of platform data or the pointer
to it in their driver private information.

I tend to prefer not to alloc platform_data for OF if possible
as it avoids fragmenting the memory. devm_kzalloc() can also
be used to avoid having to remember to free the memory again.




-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
