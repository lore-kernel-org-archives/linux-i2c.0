From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: i2c-ocores: Add support for the GRLIB port
 of the controller and custom getreg and setreg functions
Date: Thu, 15 Nov 2012 09:36:57 +0100
Message-ID: <50A4A9A9.5050903@gaisler.com>
References: <1352834727-16368-1-git-send-email-andreas@gaisler.com> <1352834727-16368-3-git-send-email-andreas@gaisler.com> <87sj8d86lo.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87sj8d86lo.fsf-D6SC8u56vOOJDPpyT6T3/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2012-11-13 23:45, Peter Korsgaard wrote:
>>>>>> "Andreas" == Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> writes:
>
> Hi,
>
>   Andreas> The registers in the GRLIB port of the controller are 32-bit
>   Andreas> and in big endian byte order. The PRELOW and PREHIGH registers
>   Andreas> are merged into one register. The subsequent registers have
>   Andreas> their offset decreased accordingly. Hence the register access
>   Andreas> needs to be handled in a non-standard manner using custom
>   Andreas> getreg and setreg functions.
>
>   Andreas> @@ -257,6 +300,14 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
>
>   Andreas>  	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
>   Andreas>  				&i2c->reg_io_width);
>   Andreas> +
>   Andreas> +	if (of_device_is_compatible(pdev->dev.of_node,
>   Andreas> +				    "aeroflexgaisler,i2cmst")) {
>   Andreas> +		dev_dbg(&pdev->dev, "GRLIB variant of i2c-ocores\n");
>   Andreas> +		i2c->setreg = oc_setreg_grlib;
>   Andreas> +		i2c->getreg = oc_getreg_grlib;
>   Andreas> +	}
>   Andreas> +
>
> Please also update the bindings documentation under
> Documentation/devicetree/bindings/i2c.

Sure!


> With this core you need to add both aeroflexgaisler,i2cmst and
> opencores,i2c-ocores to the compatible property, but the grlib variant
> is NOT compatible with i2c-ocores, so that's not really nice.
>
> Adding a type define (TYPE_OCORES / TYPE_GRLIB) and a 2nd of_device_id
> entry with .data = TYPE_GRLIB, and then using that in the probe routine
> would be nicer. Have a look at i2c-at91.c for an example of a driver
> doing something like that.

Yes, that is a good idea. Do you think casting to and from void * in the 
following solution is too ugly and rather have a struct pointed to, or do you 
think that would be unnecessary?

static struct of_device_id ocores_i2c_match[] = {
	{
		.compatible = "opencores,i2c-ocores",
		.data = (void *)TYPE_OCORES,
	},
	{
		.compatible = "aeroflexgaisler,i2cmst",
		.data = (void *)TYPE_GRLIB,
	},
	{},
};
MODULE_DEVICE_TABLE(of, ocores_i2c_match);

static int ocores_i2c_get_type(struct platform_device *pdev)
{
	const struct of_device_id *match;

	match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
	if (match)
		return (int)match->data;
	else
		return TYPE_OCORES;
}

Cheers,
Andreas
