From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: Let bus drivers add SPD to their class
Date: Wed, 4 Jun 2008 13:05:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0806041303340.10290@shell4.speakeasy.net>
References: <20080603130221.1f819e64@hyperion.delvare>
	<200806031319.56606.david-b@pacbell.net>
	<20080604080933.456c8ce2@hyperion.delvare>
	<200806040018.10191.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806040018.10191.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 4 Jun 2008, David Brownell wrote:
> > Also, couldn't these platforms have other EEPROMs on these buses,
> > either EDID EEPROMs or proprietary ones, for which people might be
> > using the read-only eeprom driver at the moment? I don't want users to
> > experience a regression by applying this patch set. I'd rather have
> > them migrate their platform to the at24 driver once it is upstream and
> > remove the I2C_CLASS_SPD flag when they do.
>
> Unlikely.  At least in the cases I called out.
>
> Oh, and parport.  DRAM sticks, or LCD displays, over parport
> links would be strange.  ;)

An eeprom programmer or reader using a parport i2c interface doesn't seem
all that strange.  If I needed to make an i2c eeprom programmer, that's
probably what I'd do.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
