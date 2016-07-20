From: Jan Kandziora <jjj@gmx.de>
Subject: Re: [PATCH 2/2] add w1_ds28e17 driver for the DS28E17 Onewire to I2C
 master bridge
Date: Wed, 20 Jul 2016 20:01:49 +0200
Message-ID: <578FBC8D.4030108@gmx.de>
References: <578A95E4.1080903@gmx.de> <132011469036072@web17m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:56035 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbcGTSBy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 20 Jul 2016 14:01:54 -0400
In-Reply-To: <132011469036072@web17m.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Am 20.07.2016 um 19:34 schrieb Evgeniy Polyakov:
> Hi Jan
> 
> 16.07.2016, 23:15, "Jan Kandziora" <jjj@gmx.de>:
>> This subpatch adds a driver for the DS28E17 Onewire to I2C master bridge.
>>
>> Signed-off-by: Jan Kandziora <jjj@gmx.de>
> 
> Both patches look good to me, I ack and recommend them for inclusion.
> There is a tiny typo and a bit general question below.
> 
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
> 
>> +/* Contants for calculating the busy sleep. */
> 
> It should be 'constants' I suppose
> 
Sure. [^_^;]


>> +/* Wait a while until the busy flag clears. */
>> +static int w1_f19_i2c_busy_wait(struct w1_slave *sl, size_t count)
>> +{
>> + const unsigned long timebases[3] = W1_F19_BUSY_TIMEBASES;
>> + struct w1_f19_data *data = sl->family_data;
>> + unsigned int checks;
>> +
>> + /* Check the busy flag first in any case.*/
>> + if (w1_touch_bit(sl->master, 1) == 0)
>> + return 0;
>> +
>> + /*
>> + * Do a generously long sleep in the beginning,
>> + * as we have to wait at least this time for all
>> + * the I2C bytes at the given speed to be transferred.
>> + */
>> + usleep_range(timebases[data->speed] * (data->stretch) * count,
>> + timebases[data->speed] * (data->stretch) * count
>> + + W1_F19_BUSY_GRATUITY);
>> +
>> + /* Now continusly check the busy flag sent by the DS28E17. */
>> + checks = W1_F19_BUSY_CHECKS;
>> + while ((checks--) > 0) {
> 
> This will burn CPU for 1000 cycles of timebase[data->speed] useconds.
> Is that a hardware limitation that there is no interrupt or other completion mechanism which would handle this case?
> 
The main completion mechanism is usleep_range() above. It suspends the
execution for at least as long as the DS28E17 I2C operation takes. This
is calculated from the transfer speed and the number of bytes transferred.

After that, the driver checks for the busy flag actively. It does so
because the I2C slave device may have used clock stretching. There is
that "stretch" parameter but we need some measure of last resort.


>> + /* Return success if the busy flag is cleared. */
>> + if (w1_touch_bit(sl->master, 1) == 0)
>> + return 0;
>
This check will usually succeed on first test, given the I2C slave
device hasn't used any clock stretching.

I've set the loop limit as high as 1000 to avoid "busy timeouts". We
could set it to 10, then watch which I2C slave devices produce fallout.
Could be interesting.

I even thought about putting in a "stretch" array to make the timeout
calculation configureable per I2C slave. Then I realized no one would
ever use that feature because the most likely configuration is to have
one I2C slave device on one DS28E17.


>> +
>> + /* Wait one non-streched byte timeslot. */
>> + udelay(timebases[data->speed]);
>> + }
>> +
>> + /* Timeout. */
>> + dev_warn(&sl->dev, "busy timeout\n");
>> + return -EIO;
>> +}
> 
