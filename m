Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC90224B13;
	Tue, 18 Aug 2026 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061697; cv=none; b=C6udXEREXio4C9YojbHrkzT7d3mjO0jVFrbnS4PaHWz+E4VymMo95Uy/4yvNYVdNWzYBUeDNf26YoS1PpFelR2n0LXwoG8yrS0/tOURhLdXgFezA868mLkA6yUW7cHQFkWGkBz33mWF2DUQ55KGEPQW/jLLIHMF5xcveoZb5GjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061697; c=relaxed/simple;
	bh=vOkiM9ZzUw5I6Ba5uUDvzrVp8vsB5t29AT91DxpSyC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnXREey5LuZl803cqSv9+MdvnzxoKaDuoKzVS2gwns542iuHW+0TcH1VCHCQoDneFxY56n9cojN83VkW0bMd8R0zhqeTbzTaPua03Ps3Pb5WQAmuEvUp1qtycFOfut/2kUljma4Zml4sMo4Kqwr03JtXyUE1CsX2Sbsh/P8QNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1+/wWoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1+/wWoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5256A1F000E9;
	Tue, 18 Aug 2026 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787061696;
	bh=ykbQlCa7J6C28i7kq2wMzYIqF6+RmFZD3/yjwHRaUEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l1+/wWoH3vnB0QxxDKA9hFRKOxNfDV7yYJAuihwncLlnp+gSdKfyuCh3I3I8Tir0l
	 vmjkU4WSSS42QZTChcZOTu8tSKmhwy4t4ZiNAmbrzRbnR6/axjoj1eqfWEdy6XT6B8
	 09G2OhYBxaKhTRl91Ac6afcYyp4OrE7jPRt8UDly0S+NOc8ywDW3clyQKlTqMGIQf2
	 T7S86EhxZeiu/sPF5C/MHuJ6e4LZG43ivLkof7AyjZPtAirAQTqbz+datEgjAZCTB2
	 yYAxnAmt1d/MdCONPj92/e9y+tdJ/iS0QoehtrC7eTMF69RkmV0g3CxEm6RM0iSh6r
	 eMPSUm5nmd1sg==
Date: Tue, 18 Aug 2026 16:01:32 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jiawen Liu <1298662399@qq.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: i2c-rzv2m: fix runtime PM cleanup
Message-ID: <aoRlkG2m_cLra_KQ@zenone.zhora.eu>
References: <tencent_A4A9EBA18AE8212574B59C8001217FC12A09@qq.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A4A9EBA18AE8212574B59C8001217FC12A09@qq.com>

Hi Jiawen,

On Tue, Aug 18, 2026 at 05:15:01PM +0400, Jiawen Liu wrote:
> Update rzv2m_i2c_probe() for the confirmed driver lifecycle defect.
> 
> Keep the change limited to the concrete operation shown in the final
> patch.
> 
> Signed-off-by: jiawen <1298662399@qq.com>
> ---
> diff --git a/drivers/i2c/busses/i2c-rzv2m.c b/drivers/i2c/busses/i2c-rzv2m.c
> --- a/drivers/i2c/busses/i2c-rzv2m.c
> +++ b/drivers/i2c/busses/i2c-rzv2m.c
> @@ -461,7 +461,12 @@
>  
>  	pm_runtime_enable(dev);
>  
> -	pm_runtime_get_sync(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		return ret;
> +	}

Please, consider using managed resources.

Thanks,
Andi
