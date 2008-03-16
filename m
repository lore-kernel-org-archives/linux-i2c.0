From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: ISP1301_OMAP: New-style i2c driver
	updates, part 2
Date: Sat, 15 Mar 2008 19:57:18 -0800
Message-ID: <200803152057.19375.david-b@pacbell.net>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	<31e679430803071300w2f2e80ddqd4516a976df4474@mail.gmail.com>
	<20080315125940.2fe84f24@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080315125940.2fe84f24-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: dsaxena-k7pgMgclrJvR7s880joybQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Saturday 15 March 2008, Jean Delvare wrote:
> The above looks all wrong to me. The ISP1301 is an I=B2C device, it gets
> an i2c driver, not a platform driver.

Right; blame that on me, for a moment I forgot and so I
mentioned the use of the IORESOURCE_IRQ_* flags, which work
on busses using resources -- like "platform" and "pnp").
Not helpful here.


> That being said, if many drivers need an irq_type field in addition to
> the irq number, we might consider adding an irq_type field to struct
> i2c_board_info and struct i2c_client directly. It probably doesn't make
> much sense to have irq and irq_type take different routes if they are
> most often needed together.

Actually ... why not just require the board-specific setup
code to set the right trigger mode?  Use set_irq_type().

That's what x86 does, and it works fine.  Drivers don't need
to worry about trigger modes ("irq_type") at all, since the
board setup code (on PCs: ACPI or BIOS) just stuffs the same
registers that set_irq_type() would stuff.  Drivers can just:

   status =3D request_irq(irq, handler, 0, "name", data);

Platforms already do the pinmux setup, making sure that the
relevant pin is set up as an external interrupt source or
GPIO input as appropriate.  They can just as well do the rest.

- Dave





_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
