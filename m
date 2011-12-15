From: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>
Subject: Re: Cleanly intercepting suspend/resume of specific i2c clients?
Date: Thu, 15 Dec 2011 11:23:48 -0600
Message-ID: <CADkCAuvwmmtc3tvBPw3XwUgnAJ5jg_qkLAK9twUNogNP-Ligpg@mail.gmail.com>
References: <CADkCAuteSObrXMnmN--8AG84-V_aWWudt_EXwBNPZfG6GHG2hA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF176BE922AB@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF176BE922AB-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Linus Walleij (linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org)" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Stephen:

On Thu, Dec 15, 2011 at 10:30 AM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>
> This sounds like something the new pinctrl subsystem will eventually grow
> to address.

It might, but I'm not sure it is exactly what I want.  In particular,
in what I gather from reading about pinctrl it seems to presume that
only events on the device in question will invoke pin control events.

I'm trying to do things at a higher level, by using the Device Model
to express relationships between devices beyond simple electrical and
data connections.  The vreg APIs are a good example, since they allow
me to name regulators on a per-device basis but still associate those
names with a physical regulator at some point.  This additional layer
of indirection lets me refer to device-specific pin names like "VIN"
in my probe() methods, and have something behind the scenes do the
"Device X's VIN is actually regulator LDO23 on this platform"
translation.

I can get similar behaviors when I create a "virtual" platform device
as a parent of one or more platform devices representing actual
hardware.  That allows me to tell the kernel, "After you suspend
devices X and Y, I need to know about it".  The only thing that gets
clumsy here is the additional code to deal with the split
device/driver implementation, which facilitates managing N devices
just fine but in my case I know there will only be one of the virtual
devices.

In a way, I'm trying to implement a generic "device event notification
shim" that can wedge in between a parent and child device of any type,
and intercept events passing between them.  I think I can get this
done with ordinary struct device and struct driver implementations,
plus judicious use of device_move().  I just wanted to be sure I
wasn't reinventing anything before going down this path.

Assuming I survive the trip, I'll report back with what I find. :)

b.g.
-- 
Bill Gatliff
bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org
