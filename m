Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770D30E0E5;
	Fri, 31 Jul 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534515; cv=none; b=IEwVDbvkAMKC97eQJLHDK6P1JIwz8qew8tGdNluAul5marpVCLSaTKENvLLwKw5IrkDVF/Gg6BSbsSUCVYSMkIz5t3ueRaY3dIqPLn1lynt+m/W5VxtLoZk1cWXhSce7DfvJdpaHE6T0v1jg3cFXPYXWnSxHX30YrUXrAT8TR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534515; c=relaxed/simple;
	bh=tCz/ZvoyXT2Yt5cc7mssElCMLGtgowCCmlUPpxkoYWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvn9oP3qzHeGRnYCmV2e5Co8oU8MThPD7WOLyIK9hImt3FFYbZTikXUgkJulOaApXpz5einXqrJLtfCs0XAjRo+mYD7DrmsN/lMoGeT4nGkziBL783Gjy6t+j4K3SlNhc0VAkgySUQTXfhkZtLGzmFkl3CgnvCyyNaGoNlTy4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx/dHYrr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx/dHYrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB821F00AC4;
	Fri, 31 Jul 2026 21:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785534514;
	bh=RTtGIKL9RPgJ0U1UOip0fsT74kLUBfK0n1Jz4UE8dRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wx/dHYrrQtn3tGbiN9D8P34uMpclbbxHgTa/ySZKR4z5+yqLxfTesd/CoGhRjpA3c
	 c5tP4MdapZystPEDIsgp9uBcEMeUz+BE9y1KB9UU3RPWzxkT/0dk5CGuPWMyZ8vccc
	 tV6EmRDaXTwDPnvLjS0maSuH7QhTRQvMiZNNcm81OiXUvJF5kJJMufC6uLljZsO4MM
	 HVUAZ/+TM3R661VnmJXgRNZwCYyA/Npj6b+MaPG2l7iBVzyJYpf7Nr7BAxUHKsSUJo
	 ye72jQcuANOD0OIwosJ+35R88TS3VBIgNlCHmaxQl51xbrrO3ryd4TCjQXP4UpjqnE
	 +EttKrW2B1XDQ==
Date: Fri, 31 Jul 2026 23:48:31 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vasileios Almpanis <vasilisalmpanis@gmail.com>
Subject: Re: [PATCH] i2c: prevent new device registration during adapter
 removal
Message-ID: <am0WA-ar1NsjNXYw@zenone.zhora.eu>
References: <20260730071831.352749-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730071831.352749-1-yun.zhou@windriver.com>

Hi Yun,

uuhh... woow, check this patch here[*]. Your AI agents look to be
in sync.

I read Vasileios patch first and then yours.

On Thu, Jul 30, 2026 at 03:18:31PM +0800, Yun Zhou wrote:
> Remove new_device and delete_device sysfs attributes early in
> i2c_del_adapter() to prevent concurrent client registrations during
> adapter teardown. Without this, a racing new_device_store() can
> register a client that will never be cleaned up, causing
> wait_for_completion() to block indefinitely.

You can also mention the UAF that Vasileios AI found.

> Fixes: 99cd8e25875a ("i2c: Add a sysfs interface to instantiate devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  drivers/i2c/i2c-core-base.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 3ec04787a737..0f207520d6f9 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1817,6 +1817,14 @@ void i2c_del_adapter(struct i2c_adapter *adap)
>  
>  	i2c_acpi_remove_space_handler(adap);
>  
> +	/*
> +	 * Remove new_device/delete_device sysfs attrs early to prevent
> +	 * new client registrations via userspace while we're tearing down.
> +	 * kernfs will wait for any in-flight writes to complete.
> +	 */
> +	device_remove_file(&adap->dev, &dev_attr_new_device);
> +	device_remove_file(&adap->dev, &dev_attr_delete_device);

I prefer this fix, though, but I don't think we need to manually
remove delete_device.

Andi

[*] https://patchwork.ozlabs.org/project/linux-i2c/patch/20260730162540.291570-1-vasilisalmpanis@gmail.com/

> +
>  	i2c_deregister_clients(adap);
>  
>  	/* device name is gone after device_unregister */
> -- 
> 2.43.0
> 
