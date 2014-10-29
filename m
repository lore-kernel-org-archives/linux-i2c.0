From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] DT: i2c: Add binding document for IMG I2C SCB
Date: Wed, 29 Oct 2014 16:32:59 -0700
Message-ID: <CAL1qeaEzg5Qh9B62zFkbnhRgC9Ewxs7xkvwNdOO5t6bZd-HV-A@mail.gmail.com>
References: <1414612641-4259-1-git-send-email-ezequiel.garcia@imgtec.com>
	<1414612641-4259-3-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414612641-4259-3-git-send-email-ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ezequiel,

> From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>
> Introduce a devicetree binding for Imagination Technologies
> I2C SCB controller.
>
> Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

This should have your S-o-B as well.

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt b/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt

> @@ -0,0 +1,14 @@
> +IMG Serial Control Bus (SCB) I2C Controller
> +
> +Required Properties:
> +- compatible: "img,scb-i2c"

Is there no difference between the controller present on TZ1090 and Pistachio?

> +- reg: Physical base address and length of controller registers
> +- interrupts: Interrupt number used by the controller
> +- clocks : Clock specifier to the SCB clock node

On Pistachio there are two clocks per controller, the I2C operating
clock and I2C "system" clock (which I assume is the system interface
gate clock).  There should also be a "clock-names" property with an
entry for each clock.

> +- clock-frequency: The I2C bus frequency in Hz
> +- bus-delay : Bus delay in ms

Probably should list #address-cells and #size-cells here as well.

> +Optional properties:
> +- linux,i2c-index: Can be used to override the I2C bus number. This is useful
> +  when some of the I2C adapters are used by other non-Linux cores so would get
> +  numbered incorrectly by default.

I don't think this is necessary.  Aliases can be used to set the
adapter number instead.

Also, it's generally good to include an example node.
