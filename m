Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611ED31F99A;
	Wed, 25 Mar 2026 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469834; cv=none; b=YSfesofq/ORkN8iFDLpWqUhcWiynAZvdvoEfG8xCJQ42w1qUpw9mvVrwPDYIUPXJSeOq0GDRO1j61imsnw+AcXvoNtdsyPtQ+n5qeBELYEmpsIMsRwvWMIgVs64JtD8tkSCOpm+OeHSiqoFu/GelX04wA5yk7EJLqZtLwrGDb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469834; c=relaxed/simple;
	bh=eyiL26rfv9GlIzXO7zceGaWbWrBz6TpSU3eOieXvYrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdO6t1Br5VwzW9XZ8fw6BfWgqxBUm2G4baX8c7tJarX93pYHes7MGeDUB8JocyzpaUK3eAdn/fnByDVhKA9oZ1iv1eTuLfQoi8sZwy+XTw9E3MDXJuqHqdD/q9FD5x8qIz9EANs8pdH0Iuq6963ud4SBzpxFBEg8OdjGIVg8GGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw1l5upN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw1l5upN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1B7C4CEF7;
	Wed, 25 Mar 2026 20:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774469834;
	bh=eyiL26rfv9GlIzXO7zceGaWbWrBz6TpSU3eOieXvYrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gw1l5upNfOVKt4AGI7ChQIxmWj4sfssV12vq3QOI8DmE4wbOfqLctcfh46ktEwWFM
	 jTYIU1i0DAkqYbfqzAUXDXkN8FfdaH7N0J7Hhb9V7H5htIUD96YpTyKusC3KF9//KO
	 vCuWFfFvag+dC+iswfoaIDfeXs3zqalY6l3vkSVokaJwD6vfhTpT3y5mxlfAT9RKzE
	 E6uG4P2HbHPKQrPW2wnXphNYBrgBTORBJ7DK4YX5mXSFm+kQULmjv0Njv0/kcTKm5u
	 m+kIYFmeHAqlF+FfnUifBRtO4m7lYv608v5ko60jkhecvXUjWACMWepWvM8X7i8Gda
	 ypCiYqd3NihXw==
Date: Wed, 25 Mar 2026 21:17:10 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Pratap Nirujogi <pratap.nirujogi@amd.com>
Cc: andriy.shevchenko@linux.intel.com, mlimonci@amd.com, 
	mika.westerberg@linux.intel.com, jsd@semihalf.com, rafael.j.wysocki@intel.com, 
	benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: amdisp: Fix resume-probe race
 condition issue
Message-ID: <acRCk2muSdoEvbEI@zenone.zhora.eu>
References: <20260320201302.3490570-1-pratap.nirujogi@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320201302.3490570-1-pratap.nirujogi@amd.com>

Hi Pratap,

On Fri, Mar 20, 2026 at 04:12:22PM -0400, Pratap Nirujogi wrote:
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
>   - Call dev_pm_genpd_resume() to Power ON ISP before probe
>   - Call dev_pm_genpd_suspend() to Power OFF ISP after probe
>   - Set the device to suspended state with pm_runtime_set_suspended()
>   - Enable runtime PM only after the device is fully initialized
> 
> Fixes: d6263c468a761 ("i2c: amd-isp: Add ISP i2c-designware driver")
> Co-developed-by: Bin Du <bin.du@amd.com>
> Signed-off-by: Bin Du <bin.du@amd.com>
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
