From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Mon, 2 Jun 2008 20:50:34 +0200
Message-ID: <20080602205034.3e2b392b@hyperion.delvare>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<20080522222022.68d65cd7@hyperion.delvare>
	<20080602162154.GA11141@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080602162154.GA11141-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 2 Jun 2008 18:21:54 +0200, Wolfram Sang wrote:
> some more comments while working on the driver:

I concur with everything, except:

> > Oh, BTW, can't you compute this value yourself from byte_len and (flags
> > & AT24_EE_ADDR2)? I think so...
>
> There is at least one exception already (24c00) which covers eight
> addresses but actually just needs one. This spoils the calculation of
> i2c_addr_mask (and if there is one case, there will be others) :( I
> agree, that num_addresses might be more apropriate than i2c_addr_mask.

Not really. The 24C00 might answer to 8 I2C addresses, but how do you
care? You only need one address to access the whole data range.
Registering the extra clients is a waste of time and memory, so just
don't do it.

Problem solved :)

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
