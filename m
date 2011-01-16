From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: multiple threads support
Date: Sun, 16 Jan 2011 12:01:19 +0100
Message-ID: <20110116120119.43f27f15@endymion.delvare>
References: <AANLkTikS8XiA48HnFXZpC2p1qBqpntT7mJG=7YFVKOYY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikS8XiA48HnFXZpC2p1qBqpntT7mJG=7YFVKOYY-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 16 Jan 2011 12:56:40 +0200, Felix Rubinstein wrote:
> Hi Jean,
> 
> I've searched mailing list and skimmed over the code to understand whether
> kernel supports multiple threads support.
> In other words, what if I have multiple threads writing over the same smbus
> bus, i.e. the same /dev/i2c-X device but to different chip addresses.
> Chip address is passed by means of I2C_SLAVE ioctl and not as part of the
> i2c_smbus_write_... API meaning any thread could overwrite chip address.
> 
> Is it possible to have multiple threads writing to different chip addresses
> on the same bus, to get better (in parallel) performance from user-space?

Access to every I2C bus is serialized by the kernel. So yes, it is
possible, but no, this won't improve performance significantly.

-- 
Jean Delvare
