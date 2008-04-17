From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Thu, 17 Apr 2008 18:05:32 +0200
Message-ID: <fu7sgc$lgt$1@ger.gmane.org>
References: <1207914198-8561-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1207914198-8561-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Greetings,

(this goes mostly to David, I assume)

In at24_ee_write:
> +	/* Writes fail if the previous one didn't complete yet.  We'll
> +	 * loop a few times until this one succeeds, waiting at least
> +	 * long enough for one entire page write to work.
> +	 */
> +	timeout = jiffies + msecs_to_jiffies(AT24_EE_TIMEOUT);
> +	for (retries = 0; retries < 3; retries++) {
> +
> +		if (at24->use_smbus) {
> +			status = i2c_smbus_write_i2c_block_data(client,
> +					offset, count, buf);
> +			if (status == 0)
> +				status = count;
> +		} else {
> +			status = i2c_transfer(client->adapter, &msg, 1);
> +			if (status == 1)
> +				status = count;
> +		}
> +		dev_dbg(&client->dev, "write %zd@%d --> %zd (%ld)\n",
> +				count, offset, status, jiffies);
> +
> +		if (status == count)
> +			return count;
> +
> +		if (retries < 3 || time_after(timeout, jiffies)) {
> +			/* REVISIT:  at HZ=100, this is sloooow */
> +			msleep(1);
> +			continue;
> +		}
> +	}
I assume 'retries < 3' (always true) and 'continue' (nothing follows) 
are left-overs from earlier revisions and can be thrown out? My main 
questions is 'msleep(1)' though: As I understand it, this means the 
for-loop will wait roughly 3ms on failures until it reports a timeout 
(assuming good precision of msleep). Comparing this to AT24_EE_TIMEOUT 
(25 ms), it looks to me that the msleep value could be increased a 
little (maybe to AT24_EE_TIMEOUT / 3)? Or is i2c_transfer slow enough 
and can we count on that behaviour?

All the best,

    Wolfram

-- 
   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
