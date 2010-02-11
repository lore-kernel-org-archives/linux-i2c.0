From: "H Hartley Sweeten" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: RE: [Q] i2c-taos-evm bus driver
Date: Thu, 11 Feb 2010 12:12:51 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902153420@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190902152F0E@mi8nycmail19.Mi8.com><20100209091639.5b6e39a5@hyperion.delvare><BD79186B4FD85F4B8E60E381CAEE190902152FBE@mi8nycmail19.Mi8.com> <20100209214252.2a01f010@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20100209214252.2a01f010-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, February 09, 2010 1:43 PM, Jean Delvare wrote:
> Hi Hartley,

Hello.

> On Tue, 9 Feb 2010 11:38:37 -0500, H Hartley Sweeten wrote:
>> On Tuesday, February 09, 2010 1:17 AM, Jean Delvare wrote:
>>> No, it works reasonably fine. I was using it myself no later than one
>>> month ago. Out of curiosity, with which exact evaluation module do you
>>> plan to use it?
>> 
>> I'm not actually...
>> 
>> I am trying to figure out how a serio driver actually gets "hooked" to a
>> serial port.  The i2c-taos-evm driver looked simple enough to play with
>> in order to figure it out.  I was trying to follow the Documentation in
>> order to use it and ran into the issue below.
>
> OK... but please keep in mind that you won't be able to use this driver
> without supported hardware. The driver will not bind to the serial port
> if it doesn't detect a supported device.

That's what I am trying to figure out.

Now that I know the baud rate and port setting from your patch to inputattach.c
I was just going to dummy something up to one of my serial ports.  I really
don't need the i2c-taos-evm driver to "work" I just want to figure out how
the serio connection is made.

It still seems strange to me that a user space application is needed to connect
two kernel drivers together.  Actually three if you include the serio "bridge".
I assume the actual connection between the drivers is something like this:

	some_tty_driver <--> serio <--> i2c-taos-evm

>> (...)
>> Do you know if there is a way to make the connection in kernel?

> I suppose this is possible from a pure code perspective, but I can't
> see why one would want to do that. The kernel has no idea what is
> connected to the serial ports: devices on the serial port can't be
> reliably nor safely probed. This is why we rely on user-space to
> declare which device is connected to which port, based on the
> assumption that the user knows what he or she is doing.

My intention is to do this in an embedded system.  The serial port
I am using will always be connected to the target device.  I am just
Trying to figure out a way to make the kernel driver connection.

>> Also, do you know if there is any information on the serio stuff
>> available anywhere?  Other than just reading the kernel source I
>> have not been able to locate anything.
>
> I seem to remember I hit the exact same problem back when I wrote the
> i2c-taos-evm driver. I ended up reading the source code of other serial
> device drivers and used them as an example. It was enough to get things
> to work, but I won't claim I understood all of serio... just enough to
> do what I needed back then.
>
> Maybe Dmitry Torokhov (Cc'd) will be more helpful than me.

Hopefully... There seems to be a real lack of information available.

Thanks for the reply,
Hartley
