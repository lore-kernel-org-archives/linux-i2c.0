From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c Questions
Date: Sun, 30 Mar 2008 13:54:09 +0200
Message-ID: <20080330135409.06f8fd09@hyperion.delvare>
References: <BLU106-W751DECBB6A8A8CAAE3C71B0FE0@phx.gbl>
	<20080329230927.3b9b47e5@hyperion.delvare>
	<BLU106-W27A7B34F7BE0CC6E2D9B94B0F80@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <BLU106-W27A7B34F7BE0CC6E2D9B94B0F80-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: badguy development <badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Christian,

On Sat, 29 Mar 2008 22:58:43 +0000, badguy development wrote:
> > On Thu, 27 Mar 2008 21:14:53 +0000, badguy development wrote:
> > > I have to now develop a driver for bus address 0x01
> > >  and in the code I have located that to be an invalid address.
> > > 
> > > the code tests for address < 0x03 && address > 0x77
> > > then promptly fails with invalid address.
> > > 
> > > I am hoping to find an understanding for this.
> > > this is a programmable address, and I will have it changed if I have to..
> > 
> > Please read the I2C specification. Address 0x01 is for CBUS
> > compatibility and cannot be used by I2C devices.
> 
>  Thank you for the CBUS tip, that is what lead me to it in the spec.
>  I guess I will have to continue digging to learn why 0x02 is also disallowed.

0x02 is a bit of mystery to me as well, the specification doesn't
prohibit its use completely, but you can only use it for devices that
are compatible with "other protocols" but they don't say which ones.
0x03 is mysterious as well, it's reserved for "future purposes" since
I2C was defined (two dozen years ago.) 0x04-0x07 is for "HS-mode master
code", whatever it is. 0x08 is used frequently as the SMBus slave
address, 0x09-0x0b for battery stuff, and 0x0c for SMBus alert
response. So my advice would be to stay away of the whole 0x00 row. If
you can program the address, 0x10 would be a sane choice I think, if no
other device on your system needs it.

> > > Also, I have 3 i2c busses on this iMX31 SOM
> > > 
> > > how can I tell my device to only query / operate on a specific bus.
> > > do I need to?
> > 
> > The device can only operate on the one bus to which it is connected, so
> > I can't see any problem here.
> > 
> 
>  I guess I did not use correct terms there.
>   What I meant to ask was: how can I tell my device driver to only query a given bus.
> but I also guess that is not necessary, and the first bus to respond on that address will be carrying my device.

Depends on whether you write a legacy i2c driver (with attach_adapter
and detach_client methods) or a new-style one (with probe and remove
methods.)

If you write a legacy i2c driver (discouraged), you'll call i2c_probe()
in your attach_adapter method, and it will call you back only if a
device is found at the specified address(es). If your device can only
live at one address and only one bus has a device responding at this
address, then the driver will only attach to this device on that bus.
If you are unlucky and you have other devices using the same address on
the other buses, you have to add some detection code in your i2c_probe
callback, otherwise your driver will incorrectly attach to the other
devices. This can be very tricky if the devices don't have
identification registers.

If you write a new-style i2c driver (encouraged), you first number your
i2c buses, then you explicitly instantiate the i2c devices on the bus
you know they are connected to. There is no probing or guessing
involved, you just tell "I have device X on I2C bus N at address A" and
you're done. Much cleaner, and faster too.

> > This is the right list. It would be nice if you could post under your
> > real name.
> 
>   Thanks, I currently do not have an email that uses my name, its top secret.
>   but I can place my name at the end of my messages.
> 
> is this perhaps why I have not recieved confirmation for joining the list?
> am I disallowed without an email revealing a more realistic name?

No, mailman isn't smart enough to check this, and even if it was, there
would be no point in doing this... Everyone can read the list archive,
so putting restrictions on who can subscribe to the list would be silly.

I have no idea why your subscription did not work. Please try again.

> if that is the case I guess I will have to finally create an email account using a name :(

As far as I am concerned, it's just a matter of politeness. When I
spend time helping people, I think it's fair that I know their name.
Not to mention that you won't be able to contribute anything to the
kernel without a real name.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
