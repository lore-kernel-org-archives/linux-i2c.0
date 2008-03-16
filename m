From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates,
	part 2
Date: Sun, 16 Mar 2008 09:55:48 -0800
Message-ID: <200803161055.49158.david-b@pacbell.net>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<20080315131309.GA24990@kedavra.cpe.vivax.com.br>
	<20080316105617.GA4503@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080316105617.GA4503-4vvIQG7NF+ITKvXZea5imILpUPVTGn5w@public.gmane.org>
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
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 16 March 2008, Felipe Balbi wrote:
> +=A0=A0=A0=A0=A0=A0=A0set_irq_type(OMAP_GPIO_IRQ(14), IRQF_SAMPLE_RANDOM);

You should provide *only* IRQF_TRIGGER_* bits when
you call set_irq_type() ... while the docs are weak
here (too), notice how kernel/irq/manage.c masks
out all except the four bits in IRQF_TRIGGER_MASK.

No irq_chip should pay attention to other bits in
that call.  Other flags, like IRQF_{DISABLED,SHARED},
are driver-specific.

Plus, the whole point is to specify the trigger mode,
so calling this the equivalent of "use the default"
(IRQF_TRIGGER_NONE =3D=3D 0) is pointless.  :)

Also, I'm sure someone will be tempted to remove the
IRQF_SAMPLE_RANDOM here, and it's something of a fair
argument for externally controlled signals.  It's not
random when an external agent can control delivery of
signals at the millisecond level... hence it's not a
crypto-strong source of randomness.  Luckily most
OMAPs include a hardware RNG (except the 35xx series,
for some odd reason?) so that's not a real issue.

- Dave



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
