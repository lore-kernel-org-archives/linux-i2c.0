From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: I2C adapters protocol deviation
Date: Thu, 03 Apr 2014 17:30:09 +0200
Message-ID: <533D7E81.4050900@redhat.com>
References: <20140403145528.GA6199@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140403145528.GA6199@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 04/03/2014 04:55 PM, Maxime Ripard wrote:
> Hi Wolfram,
> 
> On the Allwinner A31, the PMIC communicates with the SoC through a bus
> looking quite similar to I2C, while being pretty different.
> 
> The communication starts with the PMIC through the regular I2C
> protocol, but it's only used to initialize the PMIC, and switch to a
> mode called "Push/Pull 2 Wire Interface".
> 
> That bus is using SDA and SCL, with the start and stop conditions
> exactly like I2C does, but:
>   - Once the start condition has been issued, the address isn't sent,
>     only a direction bit. Hence, it does not support multiple devices
>     anymore.
>   - Once that direction bit has been sent, the master sends the
>     register it wants to read from/write to, over 8 bits, followed by
>     one parity bit.
>   - Whenever you're writing, the master then sends the data over 8
>     bits, followed once again by a parity bit. Then, and only then, an
>     ACK is issued by the slave.
>   - Whenever you're reading, the master then clocks SDL and the slave
>     drives SDA for 8 bits plus 1 parity bit. If there was some kind of
>     error, the slave will pull SDA up for 9 cycles, resulting in a
>     parity error. Like with I2C though, since it is the only and last
>     byte it's receiving, the master won't issue an ACK.
> 
> Obviously, to go ahead with the PMIC support, we need to support this
> controller and bus first. I can't really decide whether it's within
> the scope of the allowed protocol deviations of I2C or if we should
> create a whole new bus for it.

I've been thinking about this too. In the mean time I have slept quite a
few nights on this now and swung my opinion from use i2c subsys to do our
own bus and back again. But since I've actually added support for this
to u-boot and I now know the device better I believe using the i2c
subsys is the best solution for this.

The PMIC does seem to start in i2c, and then gets switched to this new
push-pull 2 wire i2c-ish protocol on init. So it does have a slave address,
but that is used only once, and then the bus is for a single device only.

Note there seems to be no way to use the host in a regular i2c mode. It has
a setup mode where it does a single regular i2c write (or so I believe) and
then it is in its own custom mode from there on.

So what we really have is a single slave i2c host sort of. At least
we could model it like that. The host could be told which address to
listen to (and which single i2c write to do to init the pmic) through
devicetree and then all the differences would be hidden in the host
driver, ie we would check the slave-address and if it is not the single
one we support, we just return the appropriate error for a device not
acking, and everything should work as a regular i2c host which
only supports i2c_smbus_read_byte and i2c_smbus_write_byte.

IOW the i2c_algorithm struct for the host would not set master_xfer,
only smbus_xfer and its functionality function would return
I2C_FUNC_SMBUS_BYTE

Regards,

Hans
