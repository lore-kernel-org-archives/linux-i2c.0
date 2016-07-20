From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH 2/2] add w1_ds28e17 driver for the DS28E17 Onewire to I2C master bridge
Date: Wed, 20 Jul 2016 20:34:32 +0300
Message-ID: <132011469036072@web17m.yandex.ru>
References: <578A95E4.1080903@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward5j.cmail.yandex.net ([5.255.227.23]:39753 "EHLO
	forward5j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754355AbcGTRm0 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Jul 2016 13:42:26 -0400
In-Reply-To: <578A95E4.1080903@gmx.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kandziora <jjj@gmx.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi Jan

16.07.2016, 23:15, "Jan Kandziora" <jjj@gmx.de>:
> This subpatch adds a driver for the DS28E17 Onewire to I2C master bridge.
>
> Signed-off-by: Jan Kandziora <jjj@gmx.de>

Both patches look good to me, I ack and recommend them for inclusion.
There is a tiny typo and a bit general question below.

Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

> +/* Contants for calculating the busy sleep. */

It should be 'constants' I suppose

> +/* Wait a while until the busy flag clears. */
> +static int w1_f19_i2c_busy_wait(struct w1_slave *sl, size_t count)
> +{
> + const unsigned long timebases[3] = W1_F19_BUSY_TIMEBASES;
> + struct w1_f19_data *data = sl->family_data;
> + unsigned int checks;
> +
> + /* Check the busy flag first in any case.*/
> + if (w1_touch_bit(sl->master, 1) == 0)
> + return 0;
> +
> + /*
> + * Do a generously long sleep in the beginning,
> + * as we have to wait at least this time for all
> + * the I2C bytes at the given speed to be transferred.
> + */
> + usleep_range(timebases[data->speed] * (data->stretch) * count,
> + timebases[data->speed] * (data->stretch) * count
> + + W1_F19_BUSY_GRATUITY);
> +
> + /* Now continusly check the busy flag sent by the DS28E17. */
> + checks = W1_F19_BUSY_CHECKS;
> + while ((checks--) > 0) {

This will burn CPU for 1000 cycles of timebase[data->speed] useconds.
Is that a hardware limitation that there is no interrupt or other completion mechanism which would handle this case?

> + /* Return success if the busy flag is cleared. */
> + if (w1_touch_bit(sl->master, 1) == 0)
> + return 0;
> +
> + /* Wait one non-streched byte timeslot. */
> + udelay(timebases[data->speed]);
> + }
> +
> + /* Timeout. */
> + dev_warn(&sl->dev, "busy timeout\n");
> + return -EIO;
> +}
