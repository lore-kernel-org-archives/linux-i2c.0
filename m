From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv3 2/2] i2c: cadence: Implement save restore
Date: Thu, 3 Mar 2016 21:40:13 +0100
Message-ID: <20160303204013.GC1711@katana>
References: <1456984240-17389-1-git-send-email-shubhraj@xilinx.com>
 <1456984240-17389-2-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44301 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755086AbcCCUlR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Mar 2016 15:41:17 -0500
Content-Disposition: inline
In-Reply-To: <1456984240-17389-2-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, anirudh@xilinx.com, soren.brinkmann@xilinx.com, michal.simek@xilinx.com, Shubhrajyoti Datta <shubhraj@xilinx.com>


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 03, 2016 at 11:20:40AM +0530, Shubhrajyoti Datta wrote:

> Implement save restore for i2c module.
> Since we have only a couple of registers
> an unconditional restore is done.

But you only save one register instead of a couple? Also, the subject
could be more descriptive IMO.

> zynq-mp has the capability of going off.
> the current kernel does not hit off however some day it will.
> since the overhead of having the support is not much may be it is better to have it in the kernel.

This sounds like the patch is not tested?

> +static void cdns_i2c_init(struct cdns_i2c *id)
> +{
> +	cdns_i2c_writereg(id->ctrl_reg, CDNS_I2C_CR_OFFSET);
> +	/*
> +	 * Cadence I2C controller has a bug wherein it generates
> +	 * invalid read transaction after HW timeout in master receiver mode.
> +	 * HW timeout is not used by this driver and the interrupt is disabled.
> +	 * But the feature itself cannot be disabled. Hence maximum value
> +	 * is written to this register to reduce the chances of error.
> +	 */
> +	cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
> +}

This...

> +
> +/**
>   * cdns_i2c_runtime_resume - Runtime resume
>   * @dev:	Address of the platform_device structure
>   *
> @@ -853,6 +874,7 @@ static int __maybe_unused cdns_i2c_runtime_resume(struct device *dev)
>  		dev_err(dev, "Cannot enable clock.\n");
>  		return ret;
>  	}
> +	cdns_i2c_init(xi2c);

and this...

> -
> -	/*
> -	 * Cadence I2C controller has a bug wherein it generates
> -	 * invalid read transaction after HW timeout in master receiver mode.
> -	 * HW timeout is not used by this driver and the interrupt is disabled.
> -	 * But the feature itself cannot be disabled. Hence maximum value
> -	 * is written to this register to reduce the chances of error.
> -	 */
> -	cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
> +	cdns_i2c_init(id);

... and this look like a unrelated change to me?


--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2KEtAAoJEBQN5MwUoCm2s1MP/2olWoy2ldWORxY+emphoR3U
de3Ue1KFIIoNYOBqHShCjIKTtdv21SQBiDNoDoY/iY/KAmKKJbiWqOchjYT0wSuI
W4xWw0iEqoO3PpT+7wEcUh7+lM/m7hwdvPkWeNp1PN9gLJ92jLHIIs8cvdgc9KgJ
x6qMyZ9Mv/2vhLwxjHZMVOWlTH24tJyV25jwgGXelXNbWINX039qv/yBK7lyvTAO
278lCm20dj+sNn7/Y/cANlGxoBoXiNqKg4NmWpF/Va/q2f0p6VAG0O7Q2NtGwiTl
2mrjYSFR4h1wWCcIw5y9ILDH7VRRGOqWxLhARYi+RMq3QzGFPiFFPyLddUNolFxK
phQsSdHqKK9lEjDZsypa28qjjXgDCaIIDRLegF0GQkm9fvPAHVCCxbncDOjRCyT9
N7xIht42Uu9eQ/+Ok8NdRbNDapAIbPlBKKd8ydvjiYVB/hQMJbQjfyDcBHmBiMpC
OHnAuNPspc801V+yiwZSLAxnLt0k5xfCp3D7j4+Nd8FX+02pVrwb+hg8Ih5a864f
yeG6BqY5pVViGSKHzDRH9vHJoDHadgUvhoq9YNEnPFzVBfqpuYm2TEJj5JI+Ffl9
jXKNUgvmc3ZuKjtg7557AnxXtT+PY56L4isCW57JlhGtlx3TNSxUNoS90V03z+av
JQRnmC7FsDHbGuj9pIdO
=cScD
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
