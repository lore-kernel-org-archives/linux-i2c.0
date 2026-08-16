Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB363264E2;
	Sun, 16 Aug 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896853; cv=none; b=Vg+UIVShDDVKuIeO+hSVddDBgRwR5ja7fP2/+yxKP1sYnpDG8SixyS9DFTn4oMzcskT8LAnZlkoXb0RNAtJ9s8O1vCDVJDXmXigBkuD1kD54PCewivJk6LTUrk5wzp0bXpmI0e4qX87xlQg07yNfyadh/itYS+X+0qhLQR7kHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896853; c=relaxed/simple;
	bh=uXPIcltGcWwN2om+LBWGHDvnMuzY2p/rIGfZ30QWQIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWbcS/wgU9BnN9LGP1W8iy0YHbTnnBgnQ+IMvfChrKfYpEmWyYDoPDkc7d64R1oTOK37vfDcLIysBalrfBXrtXTWhWLFFvt/V0pmJ0kVqQvenZ1vxN9g68I43+4OSmDe5VlPhyj16FEA8aLLkKT+NqyMLm4pcflFJpTvszZO4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiVLWG1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiVLWG1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D601F000E9;
	Sun, 16 Aug 2026 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786896852;
	bh=8FzcQCi1kf4udGDFr4XJawlSQdg+Dyp4fWZ2yxvZv04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CiVLWG1CLQhBlHniVTcRtmVj6G6mUEPTCGxcohj8XLdJ0s+EdAiNYCfheFKU1goEC
	 DW75yWyEHwP9siwH8fOyz7bhqr/wg0l6648OlcLiXRkQA35x+nqJDZ9bth4IfXBwFK
	 I+AO6MFZdes3jVCSybv/0juZ4rQqWOpY/VHpMVsoS6YYNCNG8WED+6GQi656DC+UEK
	 2XpupU5Vcny9oqC8vM7GTAxYu42Y6fd5PnXlK4wdMqqsT8clnx3hN82agXNqvqFqC6
	 n+toUybwFi7mHjFzeozbAkSUx8wGpZMbiMLlhy/1tiVyYlxYaYAm+sQkgRBBoXpxRe
	 Ix2mt4koenpPw==
Date: Sun, 16 Aug 2026 18:14:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: xiic: restore runtime PM teardown in remove to
 fix clk WARN flood
Message-ID: <aoHf6UDxD68YxLYm@zenone.zhora.eu>
References: <20260814-i2c-xiic-restore-runtime-pm-teardown-v2-1-7ae5d0c30ff2@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-i2c-xiic-restore-runtime-pm-teardown-v2-1-7ae5d0c30ff2@nexthop.ai>

Hi Abdurrahman,

On Fri, Aug 14, 2026 at 11:04:45AM -0700, Abdurrahman Hussain wrote:
> The devres conversion dropped the remove-time runtime PM trailer
> (pm_runtime_disable + pm_runtime_set_suspended +
> pm_runtime_dont_use_autosuspend). devm_pm_runtime_enable's release
> action then calls pm_runtime_dont_use_autosuspend() while runtime PM
> is still enabled, triggering an immediate runtime suspend: the suspend
> callback clk_disable()s the clock that the devm_clk_get_enabled()
> release is about to clk_disable_unprepare(), and every device teardown
> WARNs in clk_core_disable() ("clkN already disabled").

isn't devm_pm_runtime_set_active_enabled() calling
pm_runtime_disable() + pm_runtime_set_suspended() + 
pm_runtime_dont_use_autosuspend() at teardown?

Thanks,
Andi

> Restore the trailer: with runtime PM disabled and the state forced to
> suspended before devres runs, the suspend callback cannot fire and the
> clock enable count stays balanced.
> 
> Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
> Changes in v2:
> - Move the Signed-off-by into the commit message proper; v1 had it below
>   the '---' cutter line where it would be dropped on apply (Andy).
> - Link to v1: https://patch.msgid.link/20260813-i2c-xiic-restore-runtime-pm-teardown-v1-1-0e7dfb206790@nexthop.ai
> 
> To: Michal Simek <michal.simek@amd.com>
> To: Andi Shyti <andi.shyti@kernel.org>
> To: Andy Shevchenko <andriy.shevchenko@intel.com>
> To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/i2c/busses/i2c-xiic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 3e7735e1dae0..89636ca36915 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -1545,6 +1545,9 @@ static void xiic_i2c_remove(struct platform_device *pdev)
>  		xiic_deinit(i2c);
>  
>  	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
>  }
>  
>  static const struct dev_pm_ops xiic_dev_pm_ops = {
> 
> ---
> base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
> change-id: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02
> 
> Best regards,
> --  
> Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
