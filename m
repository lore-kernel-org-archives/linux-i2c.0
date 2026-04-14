Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FEB3346B4;
	Tue, 14 Apr 2026 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776207792; cv=none; b=EYDI8rGUgUOBneo5R5I+ELTVbQ/rpaw202xltaaPQU7a6gBAuUB99O1XWGIs4k+Cseg2TLTDQOjbCAiTVCRpEn3+vnoE3XEyX5cBQv6WCy17q8rBiuPfclkdZhgFeN2oJ+/XwWRgKCe957TXp8IfO2fwp6iIS5xVy1hFwKhf3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776207792; c=relaxed/simple;
	bh=DPMIG0JyHD8TiANVF6tKn1krzB0C2AAq7YcH8D+L2w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txr+Pqe5rXwzj60RCSifVjt4BMTk4w6/0sHdKiG4OQUV/pRbmK4Ra2RKtDmbEAorPlEstqA7epSBIB/nu7UOqghHho+iCsxP+BTpxYAxDsrN3OPFUYN3Ka6CEEchj5RxHlmuJRSI10s4wK/5GrEFXXsAHf2De6H32AlScd250JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMRqA8NW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMRqA8NW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39872C19425;
	Tue, 14 Apr 2026 23:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776207791;
	bh=DPMIG0JyHD8TiANVF6tKn1krzB0C2AAq7YcH8D+L2w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMRqA8NWtpwh46bcDmDtPfeFSsI7VfEvufnIj70RnhOpvKpu2H2OdtOvM28jJ/Ujj
	 9+jkDC1wW77PceNKP5EnwBPHQltH4H80Yk98xbMrQUK/Y2PTwlWgiTVdQfE4Bs5Pak
	 dvLbqPBc2M65FwlOprrcEMb+9IbUaFGTtnNf7+S7d6471VxFutgK6KwJVnheiOAYHn
	 zJLsGczmt4x0z+X26vysLjD50SGqRe9XBkrHhS5jGRbv1EniaqNwP9lFNYQD6l9URe
	 j5f6u7Uk8ZpYlCxHTs3LgySB5fk+754sojJIaC8M290UrrYxXExY3VwZpquhJqO3Qj
	 /AtIApwXUlJ8g==
Date: Wed, 15 Apr 2026 01:03:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: adlavinitha reddy <adlavinitha.reddy@mediatek.com>
Cc: Qii Wang <qii.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v1,PATCH 1/1] i2c: mediatek: add bus regulator control for
 power saving
Message-ID: <ad7FOoevcOm0AxP8@zenone.zhora.eu>
References: <20260318084621.4127757-1-adlavinitha.reddy@mediatek.com>
 <20260318084621.4127757-2-adlavinitha.reddy@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318084621.4127757-2-adlavinitha.reddy@mediatek.com>

Hi Adlavinitha,

On Wed, Mar 18, 2026 at 04:46:16PM +0800, adlavinitha reddy wrote:
> Add conditional bus regulator enable/disable in mtk_i2c_transfer()
> to support I2C bus power gating for platforms that require it.
> 
> This implementation:
> - Enables bus_regulator before clk_bulk_enable() if vbus-supply is defined
> - Disables bus_regulator after clk_bulk_disable()
> - Only activates when vbus-supply is provided in device tree
> - Has no impact on platforms without vbus-supply defined
> 
> This approach provides power savinggs for platforms with an extra I2C bus

I changed /savinggs/savings/.

> regulator, while avoiding runtime PM complexity.
> 
> TEST= Build and boot on MT8188

'"TEST=..." is a tag. There is no need to save characters in the
commit log. I changed it to "Tested on MT8188.".'

> Signed-off-by: adlavinitha reddy <adlavinitha.reddy@mediatek.com>

Please use capital letters for your name and for the committer's
name as well. I fixed it.

Now you have to explain me why you sent three times this same
patch.

Next time, please use the format '[PATCH v1 1/1]' instead of
'[v1,PATCH 1/1]'. Normally for the first version you can omit v1.

For single patches you don't need the 0/1 cover letter. Just send
as [PATCH].

Please read Documentation/SubmittingPatches.

For now I merged this patch in i2c/i2c-host-2.

Thanks,
Andi
