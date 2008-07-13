From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C Port Expanders
Date: Sun, 13 Jul 2008 11:13:06 +0200
Message-ID: <20080713111306.791bbc41@hyperion.delvare>
References: <4875A893.3090402@gmail.com>
	<200807111425.00961.david-b@pacbell.net>
	<20080712091610.4ec242c3@hyperion.delvare>
	<200807120046.29389.david-b@pacbell.net>
	<f17812d70807122304o533d8af9k1384db653b264912@mail.gmail.com>
	<20080713092050.6dffd8d3@hyperion.delvare>
	<f17812d70807130153g290e17ecq10ab12529effc8d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70807130153g290e17ecq10ab12529effc8d4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 13 Jul 2008 16:53:19 +0800, eric miao wrote:
> >> 3. for chips like max732x, actually, the range of 0x50 - 0x5F will be
> >> monitored by the I2C chips at startup to decide the connections of
> >> AD2/AD0 pins to GND/VCC/SCL/SDA, so actually, even if the chip
> >> is finally decided at, say 0x56, no sane hardware designers will put
> >> another chip whose address falls between 0x50-0x5F together with
> >> such a max732x chip, ugly, but true.
> >
> > Why do these chips have a selectable address at all then, if they
> > virtually use all the range of possible addresses? I don't buy this
> > point at all. I see no reason why putting another chip in the same
> > range would cause any problem.
> 
> Selectable address is used to decide the initial state of each
> pin (especially the output level). Due to the fact that SCL/SDA
> are initially held high, the chip has to monitor the first I2C activity
> to decide if AD2/AD0 is tied to one of GND/VCC/SCL/SDA.

Ah, OK. I had missed the fact that the address had an impact on the
initial pin states. This sounds a bit weird to me, BTW, as the chip
doesn't know its address before the first transaction on the I2C bus,
it also can't set the pins to their "initial" state before the first
transaction on the I2C bus. This is a strange definition of "initial
state" if you ask me.

Anyway, this still doesn't prevent other I2C chips from using other
addresses in the 0x50-0x6f range on the same bus.

> So , do you see any chance of this getting merged during this
> window? If that's possible, please consider merge, thanks.

You probably want to read MAINTAINERS again, to find out that I am not
the maintainer of the gpio subsystem. Ask David Brownell, or Andrew
Morton.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
