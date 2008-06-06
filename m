From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 19:47:30 -0700
Message-ID: <200806051947.30697.david-b@pacbell.net>
References: <20080604201334.19636f30@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080604201334.19636f30-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 04 June 2008, Jean Delvare wrote:
> I would appreciate feedback on both the concept and the implementation.
> David, I am particularly interested in your feedback, of course.

Which, for the record, will be a bit delayed with respect to
the core i2c_listener abstraction.  This deserves a bit more
thought than I can put into it in the immediate future.
(Ditto firing up the rig needed to test the lm75 updates.)

Except for this small bit of instafeedback:  the approach of
splitting the detect() logic out, as an adjunct to a core
"new style" driver, is an interesting way to address some core
problems with legacy drivers (vs the driver model).

It gives a graceful migration model towards new-style code, and
lets drivers get updated without needing to start by abandoning
the "poke at the hardware" style enumeration in those cases
where it seems to act mostly OK today.  While I'd like to see
that poking be largely removed from the kernel, factoring it out
(in i2c_listener or whatever) is clearly useful.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
