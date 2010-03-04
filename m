From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Do you always need a client driver to access a I2C device?
Date: Thu, 4 Mar 2010 16:06:39 +0100
Message-ID: <20100304160639.3ce6c273@hyperion.delvare>
References: <4B8579C4.7080502@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B8579C4.7080502-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve <steve.explores-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Steve,

On Wed, 24 Feb 2010 19:11:00 +0000, Steve wrote:
> I am modifying an embedded kernel driver to use the Linux I2C sub-system 
> rather than the RTOS I2C calls it previously used. The driver just needs 
> to make a very small number of I2C read/writes to a device on the I2C 
> bus at a fixed address and does not need to expose any methods to 
> user-space via /dev or sysfs. An algorithm and adapter driver are 
> provided for the SoC that controls the board, but there are no client 
> drivers.
> 
> I have been reading the Documentation/i2d doc and looking at some of the 
> existing drivers. I only need to read/write a few bytes to the device 
> but from the doc, examples and i2c api it appeared I would need to write 
> a client driver for the device to obtain the i2c_client ptr I needed to 
> do that. Along with the appropriate board_info for the devices on the board.

This is the most popular way, and in most cases the most practical too,
but is not mandatory.

> However I noticed that the DTV demodulator drivers, e.g. 
> drivers/media/dvb/frontends/au8522.c, appear to be doing it simply using 
> a i2c_adapter ptr and i2c_transfer().

Correct. This approach in DVB predates the relatively recent rework of
the i2c device binding model. If it had to be designed from scratch
today, I suspect they would use i2c clients, but back then, the i2c
binding model was too unappealing to them.

> For my simple needs, access fixed embedded device, no need for user 
> space access, is the i2c_adapter ptr a simple and "appropriate" way to 
> go or am I missing something that makes it more complex than it seems?

This is appropriate, if you keep in mind the associated limitations
(see below.)

> This assumes its straight forward to get the adapter ptr from the SoC 
> adapter driver of course. Perhaps I should be doing a client driver 
> instead after all?

In general, SoC adapters have a fixed number (they are registered using
i2c_add_numbered_adapter()), so you can easily get a handle using
i2c_get_adapter(n). Don't forget to call i2c_put_adapter(adapter) when
you're done.

> I think I have spent too long looking through the sub-system 
> infrastructure source and have ended up confusing myself somewhat. I 
> just want to make sure I am on the correct path before continuing with 
> my reading and investigating. The kernel version is 2.6.27.39.

Accessing the device without a client is definitely an option. You only
have to consider the following two issues which are inherent to this
approach:
* There is no exclusive access guaranteed if you do not instantiate and
  use an i2c client for a specific device address. Other parts of the
  kernel. Other parts of the kernel, as well as user-space, will be able
  to access your device too, and you'll never know.
* The access API without a client is fairly limited, basically you have
  to rely on i2c_transfer() for raw I2C access or the heavy-weight
  i2c_smbus_xfer() for SMBus access (required if the underlying
  controller can't do raw I2C.) These functions are less convenient
  that the i2c_master_*() and i2c_smbus_*() functions which operate on
  i2c clients for simple transactions.

Still, it can be done if such is your desire.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
