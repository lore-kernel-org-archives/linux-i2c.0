From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: Let bus drivers add SPD to their class
Date: Wed, 4 Jun 2008 23:01:44 +0200
Message-ID: <20080604230144.424e6047@hyperion.delvare>
References: <20080603130221.1f819e64@hyperion.delvare>
	<200806031319.56606.david-b@pacbell.net>
	<20080604080933.456c8ce2@hyperion.delvare>
	<200806040018.10191.david-b@pacbell.net>
	<Pine.LNX.4.58.0806041303340.10290@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0806041303340.10290-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Trent,

On Wed, 4 Jun 2008 13:05:31 -0700 (PDT), Trent Piepho wrote:
> On Wed, 4 Jun 2008, David Brownell wrote:
> > Oh, and parport.  DRAM sticks, or LCD displays, over parport
> > links would be strange.  ;)
> 
> An eeprom programmer or reader using a parport i2c interface doesn't seem
> all that strange.  If I needed to make an i2c eeprom programmer, that's
> probably what I'd do.

But then you'd use the eeprog user-space tool (or equivalent) to read
from and write to the EEPROM, rather than the read-only eeprom driver,
wouldn't you?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
