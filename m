From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: MCP4728 address change
Date: Tue, 8 Nov 2011 08:45:45 +0100
Message-ID: <20111108084545.7ed3db9d@endymion.delvare>
References: <CAN=k24=x1MQaSu2b-tz6-8BvwW4WfY5e47z21Vdf+B6D93xQtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN=k24=x1MQaSu2b-tz6-8BvwW4WfY5e47z21Vdf+B6D93xQtQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wayne,

On Mon, 7 Nov 2011 11:25:42 +0000, Wayne Tams wrote:
> I have been tasked with writing a driver for a Microchip Quad DAC with
> EEPROM memory, MCP4728 if you would like to look it up. This device
> has a feature that I have not come across before, the device's I2C
> address is set in software and stored in the EEPROM as opposed to
> using hardware. The factory default address for the MCP4728 is 0x60
> and to avoid conflict it needs to be changed. The datasheet tells me I
> must switch the LDAC pin from high to low at the last bit of the
> second byte in the I2C message and it must stay low until the end of
> the third byte.
> 
> I am wondering if there are any other devices within the kernel source
> that support this type of address setup? I am assuming that the normal
> set of I2C/SMBUS functions will not be enough to program a new address
> since I will need some sort of mechanism to switchthe LDAC pin?

I have never heard of anything like this before, and I confirm that you
won't be able to achieve this with the standard function set. If you
need to synchronize another action with the I2C transfer at bit level,
this pretty much implies that you need to do software bit-banging
(using the i2c-algo-bit driver.) Obviously this requires that you have
full control over the I2C bus pins.

One way to do it would be to write custom callback functions for
i2c-algo-bit. Usually getsda and getscl simply set a GPIO direction
and/or value, but in your case you would need to additionally keep
track of how many times you are called, so that you know when you have
to trigger the other actions. This won't be pretty, but with proper
locking in place, this should work.

Address selection through pin wiring is a lot saner than this IMHO.

-- 
Jean Delvare
