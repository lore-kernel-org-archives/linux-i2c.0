From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Mon, 2 Jun 2008 12:33:46 -0700
Message-ID: <200806021233.46781.david-b@pacbell.net>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<20080602162154.GA11141@pengutronix.de>
	<20080602205034.3e2b392b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080602205034.3e2b392b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 02 June 2008, Jean Delvare wrote:
> Not really. The 24C00 might answer to 8 I2C addresses, but how do you
> care? You only need one address to access the whole data range.
> Registering the extra clients is a waste of time and memory, so just
> don't do it.

One reason the driver claims all the EEPROM addresses used by
each chip is to address review feedback from Jean Delvare.
ISTR the point was safety:  letting other drivers potentially
access the device was a bad idea.  ;)


> Problem solved :)

Not really.  The "eeprom" driver, or various other legacy
drivers knowing about the 0x50..0x57 address range, could
bind to those addresses.  That problem would not be solved.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
