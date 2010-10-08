From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Newbie Question About Dev-Interface Method
Date: Fri, 8 Oct 2010 08:57:58 +0200
Message-ID: <20101008085758.2f06dbad@endymion.delvare>
References: <1286480883-25589-1-git-send-email-rklein@nvidia.com>
	<8F90F944E50427428C60E12A34A309D2308DA559B4@carmd-exchmb01.sierrawireless.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8F90F944E50427428C60E12A34A309D2308DA559B4-3qf8vkpM5jTbmvMHnzRVpW3Pdy6AhKVLXbPIYa3/oNjDOqzlkpFKJg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rory Filer <rfiler-usJ8hg9QsBLWpu6QEFMNjNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rory,

On Thu, 7 Oct 2010 14:37:57 -0700, Rory Filer wrote:
> I'm working on a proof-of-concept device which contains several chips connected to the same adapter (/dev/ic2-0) on the I2C bus. Some of these have kernel-space drivers (e.g. GPIO Expander) and some don't. For the ones that don't I've opted to use the method described in the kernel Documentation/i2c/dev-interface document. This works great and does all I need for now. This is the general procedure I'm following as outlined in kernel - Documentation/i2c/dev-interface. 
> 
> - open /dev/i2c-N
> - Set the chip's address by calling ioctl(file, I2C_SLAVE, address)
> - interact with the chip using read/write or smb calls, etc.
> - close the file when done
> 
> I'm assuming that a kernel space chip driver like our gpio expander (pca953x.c) also uses the same adapter driver as my user-space application since that expander chip is on the same bus.

Let's clarify right away: i2c-dev (which handles /dev/i2c-* nodes) is
NOT an adapter driver. It is a bridge driver between user-space and
your adapter driver. Your adapter driver is most likely one living in
drivers/i2c/busses, and depends on the actual hardware you run on.

> My question is, what happens if a kernel driver is using the bus at the same time my user-mode application is?

It will work fine.

> Even if the user space app. may not be running when the chip driver runs, the adapter has an address written into it via the ioctl() call, I noted above.

Incorrect. The address isn't written to the adapter, it is a setting
local to i2c-dev and even specific to the file handle you got when
opening a /dev/i2c-* node. Each subsequent read, write or smbus call in
your user-space driver automatically includes the slave address, which
is only valid for the read, write or smbus call in question.

> Can unpredictable results occur in this scenario?

No.

> I think I could protect against it by writing a thread to serialize accesses to the I2C bus, but that only works if my entire application is running inside one process. I'm hoping someone on the list might be able to advise.

The i2c-core module already serializes all accesses to every given i2c
adapter through i2c_transfer() and i2c_smbus_xfer().

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
