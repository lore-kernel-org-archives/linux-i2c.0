From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C device driver to simutaneously support 2 devices
Date: Fri, 16 May 2008 21:54:56 +0200
Message-ID: <20080516215456.097c248c@hyperion.delvare>
References: <213411.97989.qm@web30304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <213411.97989.qm-1S7A5l4uV2KvuULXzWHTWIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wei Liang <weiliang10-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wei,

On Wed, 14 May 2008 23:18:46 -0700 (PDT), Wei Liang wrote:
> I received this email address from Gregg Koah-Hartman.  I am writing
> to seek your advise  on writing a I2C device driver.  
> 
> I am currently writing a device driver based on the sample code by
> Gregg in Linux Journal (http://www.linuxjournal.com/article/7252).

I didn't even know that Greg had been writing articles about I2C.

Please note that this article is getting old, and many things it
mentions have changed since then. I strongly suggest that you take
a look at what i2c drivers in the current kernel tree look like, it
will give you a better picture of the current situation than Greg's
article.

> I am new to linux device driver development and am currently attempting
> to modify the code to enable it to simultaneously support 2 I2C devices
> - both devices resides on different addresses.  
> 
> I have tried
> adding another i2c_add_driver function in 'static int __init
> tiny_init(void)' and subsequently reduplicate all functions involved in
> registering a
> new driver (e.g. static struct i2c_driver, i2c_detect, etc).  However,
> the code didn't seem to start.   I have scoured through I2C
> documentations in the Linux kernel  and also the book Linux Device Driver
> (O'Reilly) but have yet to come  across any reference for the
> above-mentioned task.  
> 
> I am hoping that you could provide a few pointers on how best to proceed.

You definitely do not want to have more than one struct i2c_driver
in your module. If you are going to support really different devices,
you want to write separate modules for them. If your 2 devices are
similar enough to be supported by the same driver, then a single
struct i2c_driver should work fine.

I don't really understand what your problem is. Having an I2C driver
supporting several devices at different addresses doesn't present any
special difficulty, it is the default behavior. A lot of I2C drivers in
the kernel do that, just take a look at them. For example, the max6650
hardware monitoring driver supports I2C devices at 4 different
addresses, and declares them with:

static const unsigned short normal_i2c[] = {0x1b, 0x1f, 0x48, 0x4b,
						I2C_CLIENT_END};

If you write a legacy i2c driver (which is what Greg's article
describes) then you would have something like the above in your module.
Your i2c_driver will then attempt to attach to any I2C device living at
any of the addresses in the list.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
