From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: xiic: Implement Power management
Date: Tue, 1 Mar 2016 19:29:47 +0100
Message-ID: <20160301182947.GB1488@katana>
References: <1451893834-1066-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35881 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbcCAS3v (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 1 Mar 2016 13:29:51 -0500
Content-Disposition: inline
In-Reply-To: <1451893834-1066-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Shubhrajyoti Datta <shubhraj@xilinx.com>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	ret = clk_prepare_enable(i2c->clk);
> +	if (ret)
> +		dev_err(&pdev->dev, "Unable to enable clock.\n");

Don't you want to bail out here? The clk refcounting will be messed up
if you continue.

> +err_clk_dis:
> +	clk_disable_unprepare(i2c->clk);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	return ret;

To match the inverse of the activation order, I'd put the
clk_disable_unprepare after the pm_* calls. Couldn't it happen that
those calls need to change the clk state?


--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1d+bAAoJEBQN5MwUoCm2G8AP/AzIsPNkCRsXuq37aMjKv5Qs
SOTAOd+ITz8jRq6Su1TyiFY+izJsse0gKv4QZx+97fx32yee+Iy6YyxjO/4/AcTZ
RL2UHgtUr0XTaZrQ3YCdvM8/s6DxsBllB4kYtiKE1f/PZKYvbd2A/hameR/ELlYo
FOyTmEioqsGhgtAAyywsh5O9iC/4mgLS506A4HiwG9CgUKt7FMuq37fKv03Kq9pV
rM1L2AzLqHWrwg2SenzeoZZHil4U48XM6fNTaFw8drrS85Ug2fw/qka9xJ5H8KwF
thjMi7DJ7v0tDr+3k9wGR0e62ue37Wb0QeVtaw2RJE8qN0QpwISnxuMEpD+6njDF
W8UIWWZZB7RRF6ERwVsB/rtwwjTT7lANPc5ZkWw6kPFg9wgJpxXeaQpiPy9Lhx2d
xoa+Kn1rseVptwtswFz6o0ArqpDcKHS6GDrzPqb5+eRFK+z1++p5WK4P+Dp8Wurm
kgzcnZsm+uzEQPZAJMCIos6tfBmDKymuXBbOWa8B9uThOXwWs6v9MJduaahyUo3I
Gei3xhMjd81Z9TWhs2sQIXUqa451eseXi3RK+mztUn+8PuNk6r/hMEgRGJEFkhjN
EdWHw59icWLW6g/CZi54rn8bA0PKXBf0Xciw42L/ESed/Rd+bhBwTdbOt69ffuTZ
Kd5xz7Uk4R98CC+GhF7/
=NbB2
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
