From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 2/2] i2c: cadence: Check for errata condition
 involving master receive
Date: Tue, 13 Jan 2015 12:35:38 +0100
Message-ID: <20150113113538.GB7660@katana>
References: <1418357907-4215-1-git-send-email-harinik@xilinx.com>
 <1418357907-4215-3-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418357907-4215-3-git-send-email-harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vishnu Motghare <vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> @@ -541,6 +541,18 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	 * processed with a repeated start.
>  	 */
>  	if (num > 1) {
> +		/*
> +		 * This controller does not give completion interrupt after a
> +		 * master receive transfer if HOLD bit is set (repeated start),
> +		 * resulting in SW timeout. Hence, if a receive transfer is
> +		 * followed by any other transfer, an error is returned
> +		 * indicating that this sequence is not supported.
> +		 */
> +		for (count = 0; count < num-1; count++) {
> +			if (msgs[count].flags & I2C_M_RD)
> +				dev_warn(adap->dev.parent, "No support for repeated start when receive is followed by a transfer\n");
> +				return -EOPNOTSUPP;
> +		}
>  		id->bus_hold_flag = 1;
>  		reg = cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
>  		reg |= CDNS_I2C_CR_HOLD;

Have you ever tested this code? There is a huge bug in it :(

Also, in the comment, use "message" instead of "transfer". One transfer
consists of multiple messages.

Maybe the warning can be simplified, too: "can't do repeated start after
read messages".


--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtQMJAAoJEBQN5MwUoCm2GbkQAJ1ou19WCsD54vaH/GhCL3Pq
+ICDCBX413n3hW7+0rBH+iglu8gOitCjzig0rITukINHpKjuUmGQwqtyuUQCpiQM
3ba5WCF9i4EyS5STwuL9vrWuBug9o5ZK2nHFpDT2z/g3RzeY+8Fd0D7FCObIFA84
rud55GY/GUsn7g/MqAOe59C65/ZAGvBxzgwotSrMrUwP2q8AVRcExXHn5jZqKbrr
zXNxu3XZmx7zuc61o1jldQRHXP62bbdEy/+tH3UuLAsvOQc5pxXEClb5TTDsrqWl
YGfnKZ43Nr4DMzUhtnhMQJoh9mdsRUtry6xRUwK5dkdDWSbaiDyd3rYuWHUcK6rn
EgG8DrESnVTThPAOUgov5LMv3GUWtGqJTJciWrwudaX4lgOcDGlVWS/07ndEPRhX
UCP+WvNNhThQjZHdtil0G07Hbobu+OFNnYy5euL6fNgVUZbYtKh+irZMR0G9wSAe
ZDWuuq4ekT7JMXD6gTS9QxXa2whjxQ7D0l5brqvt2WYt4Y8l+fqIg5G6c+7EiSll
fFnEQWKVVyz4m6vlwC2KUo0qNO33nYRXR6PclbuD9eVMmNDQPBJPfh3TD/mxraMW
lXo3BPRfFIGgbQ8uHESqmxPs+f9AseIJeT+lHbyQWi20vs3jycyrP5/YQakW/w5t
Pl0GYHcj6MMCOdOGATxe
=7H8d
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
