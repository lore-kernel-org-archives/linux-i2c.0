From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
 device_ids)
Date: Wed, 11 Jun 2008 09:02:56 +0200
Message-ID: <20080611090256.30031c79@hyperion.delvare>
References: <20080605193103.GA13062@pengutronix.de>
	<20080608115033.5dd91786@hyperion.delvare>
	<200806101402.44392.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806101402.44392.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Tue, 10 Jun 2008 14:02:44 -0700, David Brownell wrote:
> On Sunday 08 June 2008, Jean Delvare wrote:
> > You're going to quite some extent to obfuscate simple things ;) All
> > these defines are for the sole internal purpose of the at24 driver
> > (custom eeprom types would use platform data instead) and should
> > not be in the public header file... if they should defined at all.
> 
> The original notion was to get the driver out of the business of
> holding a large table of device parameters including worst-case
> pagesizes (e.g. Microchip pages being half or a quarter the size
> of Atmel pages) and address consumption (e.g. Atmel 24c01 vs 24c01a,
> or the SOT23 versions doing who-knows-undocumented-what).
> 
> So I think those #defines are somewhat a legacy of having had to
> change direction mid-steam to cope with the new "i2c_device_id"
> and its expectation that drivers *would* have such large tables
> with worst-case parameters.
> 
> Just so you know.  :)

I understand the history behind the code.

Having only dealt with read-only EEPROMs so far, I wasn't aware that
different incarnations of otherwise compatible EEPROMs could have
different page sizes. This is indeed a problem. If you think that this
makes default types useless, then I am fine not having such default
types (meaning that platform data would be mandatory, except for SPD
EEPROMs.) But then you wouldn't include arbitrary example platform data
structures either, contrary to what your original proposal did.

That being said... If almost compatible EEPROMs can be used in a
hardware design, differing only by the write page size, can the
platform code author, in practice, really assume a page size greater
than the minimum? That would assume the same specific incarnation of the
EEPROM is always used. Is is common to have such a certainty? I think
that our decision whether to have default definitions in the driver,
depends on the answer to this question (and you'll know better than me.)

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
