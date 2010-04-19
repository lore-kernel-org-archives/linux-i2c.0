From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Multiplexed I2C bus core support.
Date: Mon, 19 Apr 2010 14:40:14 +0200
Message-ID: <20100419144014.5123b1b4@hyperion.delvare>
References: <4B5D8AFC.5060209@gmx.de>
	<20100415144906.2a20588d@hyperion.delvare>
	<20100416132144.5ea8b0b1@hyperion.delvare>
	<4BC861B3.3090806@gmx.de>
	<20100416152329.29f3f90d@hyperion.delvare>
	<4BCC2277.3090406@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BCC2277.3090406-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Mon, 19 Apr 2010 11:29:27 +0200, Michael Lawnick wrote:
> Jean Delvare said the following:
> > On Fri, 16 Apr 2010 15:10:11 +0200, Michael Lawnick wrote:
> >> Jean Delvare said the following:
> >> > As discussed some weeks ago, this isn't actually sufficient. You don't
> >> > only need to check the parent segments for address business, you also
> >> > need to check all child segments, recursively. If any child segment has
> >> > a device using the address in question, then you can't use it.
> >> > 
> >> > This may be more difficult to implement. In particular, you'll have to
> >> > pay attention to locking.
> >>
> >> :-) This can't happen if we keep the part you commented on in the other
> >> mail about probing for client one level above. Then this situation can't
> >> arise.
> > 
> > I don't understand. In your code, the probe is done at the parent
> > level, where address business had already been tested. What is needed
> > is child segments checking, so the other side of the tree. I just can't
> > see how your code would help with that.
> > 
> > Can you please explain why the probe is needed, and what it is doing
> > that the standard address business check didn't cover already?
>
> Well, these are my thoughts:
> 
> The generic situation is
> 
> --- MUXn-1 --- MUXn -+- MUXn+1 ---
>                      |
>                 client/device
> 
> A device gets physically visible on all buses beyond the one it is
> connected to.

True.

> Given the bus tree we can decide whether a device is really present on a
> particular bus if we

Please note that we don't have to do this. Other code, in the kernel or
in user-space, is responsible for telling us where the devices are, and
we should trust them. Auto-detected devices is a purely optional
extension, the usage of which is discouraged as much as possible. My
opinion is that I2C device auto-detection should be simply prohibited
on multiplexes I2C buses (that is, such i2c_adapters would have their
class set to 0). I even would like to enforce this, by either
preventing the instantiation of a mux device on an i2c_adapter with a
non-0 class, or by resetting the class to 0, with a big warning in the
kernel logs, as soon as a mux device is instantiated.

As a matter of fact, your own code sets the adapter class to 0 for all
"virtual adapters" (which I call branches.)

> - H/W probe it on selected level. If does not respond, the current bus
> is wrong.

Or the device simply doesn't respond to the message format you used.
There is no universal probe transaction for I2C devices.

> - H/W probe it one level higher. If it responds, the current bus is wrong.

And if it doesn't respond, you can't conclude.

> The first probing is already done in standard initialization sequence. I

I'm not sure I really understand what you mean there, so please let me
repeat here: by default, no probing is done at the hardware level when
an I2C device (i2c_client) is instantiated. i2c_register_board_info()
and i2c_new_device() do not issue any transaction on the bus. Only
i2c_new_probed() device and i2c_driver's .detect() callbacks do, and
using these isn't recommended. The former is fine-grained enough that
it should work in combination with muxes, but the latter isn't.

> added the second probing. By recursively calling __i2c_check_addr() it
> is possible to reduce H/W-probing to ambiguous cases.

We don't want to do hardware probing at all to determine address
business. Look at the i2c-core code as it exists today: address
business is a solely software issue as far as i2c-core is concerned;
I see no good reason to change that just because we add support for
multiplexing.

So, in order to determine whether an address is busy, we have to check
all parent bus segments (which you already do) and all child bus
segments (recursively.) Please change your patch to do this.

> The current implementation implies that mux'es are reset to 'neutral'
> after every bus transaction. If this would not be the case, switching of
> MUXn+1 to neutral needed to be added.

As I said in my review, I don't think we want to switch all muxes back
to neutral after every transaction, because it is very costly for
I2C-based muxes (and your pca954x driver even offers a way to bypass
the reset.) There is also the problem of the initial state of the mux
chip, before we load its driver: we have no reason to believe it is in
neutral state. On top of that, not all muxes _can_ be switched to
neutral. Think of simple muxes controlled by a single GPIO, these have
always exactly one child branch selected. 

Add to this that I don't know of any mux chip which can be
auto-detected. You will always have to explicitly instantiate the mux
device, so you might as well explicitly instantiate all other devices
on that bus. We might extend i2c_new_device() to create multiple
devices at once (like i2c_register_board_info does) for this purpose.

I hope this clarified my point.

-- 
Jean Delvare
