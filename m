From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates,
	part 2
Date: Thu, 20 Mar 2008 02:56:14 -0700
Message-ID: <200803200256.14466.david-b@pacbell.net>
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
> -=A0=A0=A0=A0=A0=A0=A0if (machine_is_omap_h2()) {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* full speed signaling by =
default */
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0isp1301_set_bits(isp, ISP13=
01_MODE_CONTROL_1,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0MC1=
_SPEED_REG);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0isp1301_set_bits(isp, ISP13=
01_MODE_CONTROL_2,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0MC2=
_SPD_SUSP_CTRL);

Where did this code end up?  ISTR it was required since the
transceiver's reset mode didn't match how this board was wired.

The details of how the transceiver is wired are something that
should go into platform_data for each board, unless there's code
to pull it out of the transceiver configuration register and
then interpret it here (yeech).  This would be at the level of
whether it uses 6-wire, 4-wire, or 3-wire signaling, and a few
more related points...

ISTR the original patch I sent didn't try to do so much, and
left some of the board-specific code.


> -
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* IRQ wired at M14 */
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(M14_1510_GPIO2=
);

I don't recall seeing this pinmu directive move into
the H2 board setup ... or the gpio_request, below.
Only the IRQ setup moved; but IRQ setup presumes the
pin has already been properly set up as a gpio input.

The result would be that this couldn't possibly work.


> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0isp->irq =3D OMAP_GPIO_IRQ(=
2);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (gpio_request(2, "isp130=
1") =3D=3D 0)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0gpi=
o_direction_input(2);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0isp->irq_type =3D IRQF_TRIG=
GER_FALLING;
> -=A0=A0=A0=A0=A0=A0=A0}



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
