From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Thu, 13 Nov 2014 18:38:25 +0100
Message-ID: <20141113173825.GD1275@katana>
References: <1415885111-4138-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1415885111-4138-2-git-send-email-ezequiel.garcia@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415885111-4138-2-git-send-email-ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for this submission! Wow, this is a lot of code and I have
only very minor comments. Good work and thanks to all previous
reviewers!

> @@ -0,0 +1,1415 @@
> +/*
> + * I2C adapter for the IMG Serial Control Bus (SCB) IP block.
> + *
> + * Copyright (C) 2009, 2010, 2012, 2014 Imagination Technologies Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * There are three ways that this I2C controller can be driven:

Interesting beast. Offers a lot of possibilities and complexity :)

> + * Notice that the driver implements a timer-based timeout mechanism.
> + * This is done to avoid slave events interrupts in automatic mode,
> + * given the driver gets a slave event and transaction done interrupts
> + * for each atomic mode command (start, data, ack, stop, etc) that gets
> + * completed, none of which are of interest when using automatic mode
> + * since those atomic mode commands are managed automatically by hardware
> + * rather than by the I2C state machine in the interrupt handler.

I read this three times and still have no clear picture. Please
rephrase. Smaller sentences. Simple ones.


... all down to probe()

> +	i2c_set_adapdata(&i2c->adap, i2c);
> +	i2c->adap.dev.parent = &pdev->dev;
> +	i2c->adap.dev.of_node = node;
> +	i2c->adap.owner = THIS_MODULE;
> +	i2c->adap.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;

You probably won't need this one. You have DT probing.

> +	i2c->adap.algo = &img_i2c_algo;
> +	i2c->adap.retries = 5;
> +	i2c->adap.nr = pdev->id;
> +	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
> +		 "IMG i2c%d", i2c->adap.nr);

Please use a static name, like "IMG <some type> I2C". This describes the
IP block, not the bus in use.

Very close to go...

Thanks,

   Wolfram


--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZOyRAAoJEBQN5MwUoCm2wf8P/jlgbCFhIpQY9WKribEX2sbF
WqgdpDSrq/NPGRrQV9H15yjEo/EHiCMLgzyR9i61I7JAulVlKPcw/PheLz3EyTkr
cbTMDcvrZRq4QkIktaNIkc5xUHwcJZ5f86MP0XGRB1sRkMLgVHdzhdHLg1eiHmUg
pzsUR+BtZqFDjqt3Rz77sJzK7WGY+PLRlDGkP3fqh+TGBAL9ytk43oJ9n7jqvSLf
BSB9OApceu7ghl0Ne2rUUPSkZJYNSV03E8AqdusXeq8an4J2rwIe9YMsbTs0mtc0
3FGNgCnAucnjNS5XWMNshKC+KKsj5xob1ueAuy2E7uB1rZ4AmVcEIhZNjqcvLD83
0p7Dw1zSoiXLxvRpY3kLMq8ceTkck3ZLZxZbMhu8XVbJthcQi7+65EAAkGGPFLHp
qhAy40L2avFX9aoX0JgGSlkAwtikhWflvrBw3JKFRhoRify33rVGriqTH/D9ZUdG
+nq/wB9+nNm1cr2qyojf+xoujlsCScvTraLOz0iLYfopW+cbQw9G4XnKGanUPe/Y
1B9/s1pZW4+xDipUuzzMktNjd8FFhOVomSCGzDProB+ORJ48VYIqFNRqvyiE2Rpx
Gs9L8pHCMG1ucQBLZyePs7gLtRlh/c1xQjaaFN63QS/E7FP7k0wBB22V62p6jc7s
6Tvqyazpmjj3YPAVoHXF
=IeW0
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
