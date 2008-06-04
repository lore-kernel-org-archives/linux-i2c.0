From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: Let bus drivers add SPD to their class
Date: Wed, 4 Jun 2008 13:48:26 -0700
Message-ID: <200806041348.26267.david-b@pacbell.net>
References: <20080603130221.1f819e64@hyperion.delvare>
	<200806040018.10191.david-b@pacbell.net>
	<Pine.LNX.4.58.0806041303340.10290@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0806041303340.10290-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 04 June 2008, Trent Piepho wrote:
> >
> > Unlikely. =A0At least in the cases I called out.
> >
> > Oh, and parport. =A0DRAM sticks, or LCD displays, over parport
> > links would be strange. =A0;)
> =

> An eeprom programmer or reader using a parport i2c interface doesn't seem
> all that strange. =A0If I needed to make an i2c eeprom programmer, that's
> probably what I'd do.

The "eeprom" driver doesn't support programming;
those are all cases where the at24 driver should
be used.

SPD and DDC are specific applications of EEPROMs,
and they are not applications that work on parports.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
