Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43530E0FC;
	Fri, 20 Mar 2026 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038757; cv=none; b=We4A3XdWO5IaSj+wfIToabc3jm2XaRnxDdkHdcTwVHMlKovvYy+zFVJotWRDEHkM6jUxsNiIxC1w2w2rwWOg4yf2NqstBTkAlMlqHLH9HerJVImjWLLLk2YtsGrcAHFmaSJWoBQISTUTDpd04GNpSGpaWPqskpu0BDux5v68i9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038757; c=relaxed/simple;
	bh=n7TK/rbWycBCo7RI75unGdc9gTLxWuzNSvCJlbKYxp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVw3l5Bbgj5g1tROAEDUmzNxaksD/W9Zn/iLjFPUDa6MIFFL2SYe07vZhJV5oHXYhjFH61Usu1WCCV7KaDKkkW+Q6157wdIt/SsdBGjommat5l31zD+HJuUthMUq92NIq7lENl7dnJ40J2Bgoa3us8X7CesL2zerhKyjOR/vz/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkbdJQjM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkbdJQjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1A6C4CEF7;
	Fri, 20 Mar 2026 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774038757;
	bh=n7TK/rbWycBCo7RI75unGdc9gTLxWuzNSvCJlbKYxp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jkbdJQjMwPbeqlbKiEr4sk4UlzhW8Br1rootYOVrmNppuO5oFa5kT80xws8G8MAEZ
	 yoixHnexNOw2NAZedsf2THJfEC3dUxmjduVn5a/5LoUD5/rcNC8FMLP34uE+Fok6bJ
	 b7MqmuDQyKDdIXnjH1qxVmsKSDWCzuPMPW+r8rVYpbkPSZnIuKFCxqjnLGBIeDXYjJ
	 Kd6Q1D1+fQ6XloMDkiURJ7CQRQYPSO7hNxfwJKuJRf04ox8s367NlCNXbHhLq7zmuk
	 dzcUfb1UPqyixZPEuWiKJL6aqulj/eTAjtmnpHBzTy46l7iOP7WjfcATpSscjtwQRp
	 rMEPbDYZZh7KQ==
Message-ID: <4e90b485-da1b-40e5-95ae-17f6bc99cf57@kernel.org>
Date: Fri, 20 Mar 2026 15:32:35 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: designware: amdisp: Fix resume-probe race
 condition issue
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, andi.shyti@kernel.org,
 andriy.shevchenko@linux.intel.com, mlimonci@amd.com,
 mika.westerberg@linux.intel.com, jsd@semihalf.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260320201302.3490570-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260320201302.3490570-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/2026 3:12 PM, Pratap Nirujogi wrote:
> Identified resume-probe race condition in kernel v7.0 with the commit
> 38fa29b01a6a ("i2c: designware: Combine the init functions"),but this
> issue existed from the beginning though not detected.
> 
> The amdisp i2c device requires ISP to be in power-on state for probe
> to succeed. To meet this requirement, this device is added to genpd
> to control ISP power using runtime PM. The pm_runtime_get_sync() called
> before i2c_dw_probe() triggers PM resume, which powers on ISP and also
> invokes the amdisp i2c runtime resume before the probe completes resulting
> in this race condition and a NULL dereferencing issue in v7.0
> 
> Fix this race condition by using the genpd APIs directly during probe:
>    - Call dev_pm_genpd_resume() to Power ON ISP before probe
>    - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
>    - Set the device to suspended state with pm_runtime_set_suspended()
>    - Enable runtime PM only after the device is fully initialized
> 
> Fixes: d6263c468a761 ("i2c: amd-isp: Add ISP i2c-designware driver")
> Co-developed-by: Bin Du <bin.du@amd.com>
> Signed-off-by: Bin Du <bin.du@amd.com>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> Changes v1 -> v2:
> 
> * Fixed resume-probe race condition issue
> * Removed NULL check in runtime_resume
> * Updated Fixes tag with appropriate commit
> * Added Signed-off-by for Co-developed-by tag
> 
>   drivers/i2c/busses/i2c-designware-amdisp.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
> index c48728ad9f6f2..9f0ec0fae6f23 100644
> --- a/drivers/i2c/busses/i2c-designware-amdisp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdisp.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/soc/amd/isp4_misc.h>
>   
> @@ -76,22 +77,20 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
>   
>   	device_enable_async_suspend(&pdev->dev);
>   
> -	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_get_sync(&pdev->dev);
> -
> +	dev_pm_genpd_resume(&pdev->dev);
>   	ret = i2c_dw_probe(isp_i2c_dev);
>   	if (ret) {
>   		dev_err_probe(&pdev->dev, ret, "i2c_dw_probe failed\n");
>   		goto error_release_rpm;
>   	}
> -
> -	pm_runtime_put_sync(&pdev->dev);
> +	dev_pm_genpd_suspend(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
>   
>   	return 0;
>   
>   error_release_rpm:
>   	amd_isp_dw_i2c_plat_pm_cleanup(isp_i2c_dev);
> -	pm_runtime_put_sync(&pdev->dev);
>   	return ret;
>   }
>   

