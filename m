Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6E53C3B5;
	Thu, 15 Oct 2026 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078032; cv=none; b=C91y98WR9XEj0Sm1b22RsCPNVV1Y9luUKskVRPgN10vraWYZ14dCHWfIe0tCFiU4fxI/X1COgRBUrWMuBA1KlE65Ilt2iCpujhgovIwoTAMPDpQI+PKYzUQL8Kw3GSOGL0WOR3JcXCNyqW/Lr2BONYhCcG/XZ9A/K2WvC57KyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078032; c=relaxed/simple;
	bh=pyPORBOaSETWwpKIvWideeIaLROxf+q1qkpDqyb9AY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Edjn/YNUlyHkKVCUIy6hM/arP1wJuDTcrX7t2I0R5lf1Rx1PMEMNlY06TIKVAyJF216tYPfZNctBSVHCg66B3FpawT4XMDoWdTOJgrXzTpjtQ8yvSupzjK4rSvC4RsQ35/3HqOanAZlfE6dZIlKoFPDGVhcEaQO+sM4aGVXkK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnEKMWRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnEKMWRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E241F000C4;
	Thu, 15 Oct 2026 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078024;
	bh=KdD3lHX4MqmrGabojmzgAwKjvqjGGrSZcnYzYtxPg5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KnEKMWRd4fHiNeOVFo7Ow9b8JAlfA60+q0X3iZmdbcBnHLMx8mbxATOitZGz/eLuc
	 0RkR8T02sBTaBgS4V/k3f3x8vTW8jeRszVlhwZ2WiYFUgHKwqdHImmkLY1fUUNYaH8
	 tXvLDMdlHjKTvBYPbCO3nou7FxRjG8x5CJ3sleoG+QEfzShOsRat0H/8k+cHvSOeir
	 Q+Ui2nqvWH2qsqR9rm10H8Nzbk2aY/ifhmVbC42IECVeRmNdudcKfmbAyKFnPlYdTS
	 VqUmth8Shm/E7E70wgObXCCAlBe+djDepxXiLaHuuU1JXhPy+gy3M9RHh21tzh/eAK
	 QICRPOUs39OCg==
Date: Thu, 15 Oct 2026 16:27:00 +0100
From: Lee Jones <lee@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 5/9] mfd: cgbc: Use real I2C bus names
Message-ID: <20261015152700.GA2048969@google.com>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
 <20261002-cgbc-i2c-storage-devices-support-v4-5-eb42e0f1df59@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-cgbc-i2c-storage-devices-support-v4-5-eb42e0f1df59@bootlin.com>

On Fri, 02 Oct 2026, Thomas Richard (congatec GmbH) wrote:

> The adapter names described the expected purpose of the buses ("General
> Purpose I2C adapter", "Power Management I2C adapter") on conga-sa7 board
> rather than their actual names on the Board Controller.
> 
> Rename them to the real bus names "cgbc-i2c0" and "cgbc-ddc0", matching
> the naming used by Congatec, and update the variable names accordingly.
> 
> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> ---
>  drivers/mfd/cgbc-core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
> index 8522df882509..a58d9ffdc277 100644
> --- a/drivers/mfd/cgbc-core.c
> +++ b/drivers/mfd/cgbc-core.c
> @@ -55,13 +55,13 @@
>  
>  static struct platform_device *cgbc_pdev;
>  
> -static const struct cgbc_i2c_platform_data cgbc_i2c_gp_pdata = {
> -	.name = "Congatec General Purpose I2C adapter",

This is odd.  We only just added these.

This should be fixed up into the original patch.

> +static const struct cgbc_i2c_platform_data cgbc_i2c_i2c0_pdata = {
> +	.name = "cgbc-i2c0",
>  	.cgbc_bus_id = 0,
>  };
>  
> -static const struct cgbc_i2c_platform_data cgbc_i2c_pm_pdata = {
> -	.name  = "Congatec Power Management I2C adapter",
> +static const struct cgbc_i2c_platform_data cgbc_i2c_ddc0_pdata = {
> +	.name  = "cgbc-ddc0",
>  	.cgbc_bus_id = 4,
>  };
>  
> @@ -71,13 +71,13 @@ static const struct mfd_cell cgbc_devs[] = {
>  	MFD_CELL_NAME("cgbc-hwmon"),
>  	{
>  		.name = "cgbc-i2c",
> -		.platform_data = &cgbc_i2c_gp_pdata,
> -		.pdata_size = sizeof(cgbc_i2c_gp_pdata),
> +		.platform_data = &cgbc_i2c_i2c0_pdata,
> +		.pdata_size = sizeof(cgbc_i2c_i2c0_pdata),
>  	},
>  	{
>  		.name = "cgbc-i2c",
> -		.platform_data = &cgbc_i2c_pm_pdata,
> -		.pdata_size = sizeof(cgbc_i2c_pm_pdata),
> +		.platform_data = &cgbc_i2c_ddc0_pdata,
> +		.pdata_size = sizeof(cgbc_i2c_ddc0_pdata),
>  	},
>  	MFD_CELL_NAME("cgbc-wdt"),
>  };
> 
> -- 
> 2.53.0
> 

-- 
Lee Jones
