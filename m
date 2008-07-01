From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
 device_ids)
Date: Tue, 1 Jul 2008 16:28:08 +0200
Message-ID: <20080701162808.28c070a5@hyperion.delvare>
References: <20080605193103.GA13062@pengutronix.de>
	<200806111025.08951.david-b@pacbell.net>
	<20080611214135.090ea690@hyperion.delvare>
	<200806121417.51446.david-b@pacbell.net>
	<20080613101644.6333fcff@hyperion.delvare>
	<20080701132050.GA3836@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080701132050.GA3836-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Tue, 1 Jul 2008 15:20:51 +0200, Wolfram Sang wrote:
> hopefully, I now have the time to finish at24 for good. Do you think it
> can go through the next merge window?

Yes, it can and should.

> > > As I said, my thought there is to make it safe for most
> > > developers to just say "24c32" (or whatever) and have a
> > > sane default ... while making sure that they *always* have
> > > a way to set chips up to be readonly, or provide a better
> > > page size (if they need better bulk write speeds).
> > 
> > I agree on the principle. But the question remains: what is a sane
> > default in this context? Using the smallest page size amongst commonly
> > used EEPROM models? Using the smallest page size amongst known models?
> > Using the smallest possible page size (that would be 1 byte for all
> > EEPROM sizes as I understand it)? This 3rd possibility would probably
> > be no better than defaulting to read-only, as the write performance
> > would be so bad that every developer would specify custom platform data.
> 
> Hmm, I tend to set all page_sizes to 1. It is a bit awkward to write
> "double check those parameters" and then provide values you cannot be
> absolutely sure of. Still, a minimal write-possibility may come in
> handy, I think. I agree with Jean here, that it will be so slow, that
> developers surely will create their own platform_devices.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
