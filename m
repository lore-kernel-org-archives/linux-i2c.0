From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-stub
Date: Fri, 3 Oct 2008 09:56:47 +0200
Message-ID: <20081003095647.5fb7f0de@hyperion.delvare>
References: <aea25fc40810021503i13ea57cal183a7bf9bc88e351@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <aea25fc40810021503i13ea57cal183a7bf9bc88e351-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: naitik amin <greatamin1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2 Oct 2008 18:03:35 -0400, naitik amin wrote:
> I was trying to use the i2c-stub driver.
> 
> What I did was I hardcoded the address to 0x23 and inserted the i2c-stub.ko

Hard-coded? How, and why? The address is supposed to be passed as a
module parameter:

modprobe i2c-stub chip_addr=0x23

> I then inserted ds1682.ko also part of the 2.6 kernel.

Which kernel version exactly?

> I was hoping to see that the probe function for ds1682.ko to be called but
> it didn't.  Can someone comment on what I maybe missing.

The ds1682 driver is a new-style driver, it doesn't scan the adapters
for devices. Instead, kernel code must explicitly instantiate the
devices. Alternatively, we could add a mechanism to instantiate devices
from user-space, but it's not there yet.

I don't think you will get it to work anyway, because the ds1682 driver
makes use of I2C block transactions, which i2c-stub doesn't support
yet. So you would have to add support for I2C block transactions first.

> Oh and BTW I did change the i2c_board_info by calling
> i2c_register_board_info in machine level init. The parameters that I had
> here were "ds1362" for driver name and 0x23 for address.

"ds1362"? The only device supported by the ds1682 driver is "ds1682".
But the way I2C devices are matched changed recently, so it really
depends on what exact kernel version you are using.

Anyway, what are you trying to achieve in the first place?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
