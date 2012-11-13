From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: i2c-ocores: Add support for the GRLIB port of the controller and custom getreg and setreg functions
Date: Tue, 13 Nov 2012 23:45:39 +0100
Message-ID: <87sj8d86lo.fsf@dell.be.48ers.dk>
References: <1352834727-16368-1-git-send-email-andreas@gaisler.com>
	<1352834727-16368-3-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352834727-16368-3-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> (Andreas
	Larsson's message of "Tue, 13 Nov 2012 20:25:27 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Andreas" == Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> writes:

Hi,

 Andreas> The registers in the GRLIB port of the controller are 32-bit
 Andreas> and in big endian byte order. The PRELOW and PREHIGH registers
 Andreas> are merged into one register. The subsequent registers have
 Andreas> their offset decreased accordingly. Hence the register access
 Andreas> needs to be handled in a non-standard manner using custom
 Andreas> getreg and setreg functions.

 Andreas> @@ -257,6 +300,14 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 
 Andreas>  	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
 Andreas>  				&i2c->reg_io_width);
 Andreas> +
 Andreas> +	if (of_device_is_compatible(pdev->dev.of_node,
 Andreas> +				    "aeroflexgaisler,i2cmst")) {
 Andreas> +		dev_dbg(&pdev->dev, "GRLIB variant of i2c-ocores\n");
 Andreas> +		i2c->setreg = oc_setreg_grlib;
 Andreas> +		i2c->getreg = oc_getreg_grlib;
 Andreas> +	}
 Andreas> +

Please also update the bindings documentation under
Documentation/devicetree/bindings/i2c.

With this core you need to add both aeroflexgaisler,i2cmst and
opencores,i2c-ocores to the compatible property, but the grlib variant
is NOT compatible with i2c-ocores, so that's not really nice.

Adding a type define (TYPE_OCORES / TYPE_GRLIB) and a 2nd of_device_id
entry with .data = TYPE_GRLIB, and then using that in the probe routine
would be nicer. Have a look at i2c-at91.c for an example of a driver
doing something like that.

-- 
Bye, Peter Korsgaard
