From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
Date: Fri, 9 May 2008 01:39:13 -0700
Message-ID: <200805090139.14285.david-b@pacbell.net>
References: <200805070120.03821.david-b@pacbell.net>
	<200805071625.20430.david-b@pacbell.net>
	<20080508094620.5e6c973b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080508094620.5e6c973b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 08 May 2008, Jean Delvare wrote:
> > > =A0I think a pair of functions called i2c_smbus_read_i2c_byte_data() =
and
> > > i2c_smbus_write_i2c_byte_data() could be added to the core though.
> > =

> > Too late. =A0Those calls have been in the I2C core for a long
> > time now. =A0;)
> =

> No, we don't have any function named that way. Not that I think that
> these names would be appropriate, though. I'd rather have
> i2c_smbus_read_i2c_block_emul() for example.

I didn't pick up on the context switch Maciej stuck in, as a
not-quite-response to my comment about the functions that the
m41t80 driver could *portably* use:  the ones that have been
in the I2C core for some time now.  I thought he missed the
point that those operations were already present...

It's not at all clear what a "read i2c byte data" function
might do, for that matter.  I2C doesn't define semantics
even to the weak level SMBus does.

If I had noticed that some previously un-discussed primitive
had been introduced, I would have asked for a definition in
terms of protocol, and expected semantics; I can't guess.

- Dave


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
