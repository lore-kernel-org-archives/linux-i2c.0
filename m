Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27B431A4A;
	Tue, 21 Jul 2026 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617865; cv=none; b=Hp87cfXQp+8u4SHUGGWq8JkYNL5shF8tsEPYPko9uu9FMPIosD8EotS51OeqOiUOuYKhWTpGDCuljjMK6sY4aTPGMqzjKUPdQSFKvdQCVSX2etMXURGQWzIqLqxsXIB912hsj86veRMBN4hxRCVPTcRaUZpDiP17yDQMyIaLv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617865; c=relaxed/simple;
	bh=tahfME5BV/Ewlw6r/fATGJoi1Kg8DCjhCZZugLGcFrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1sr614SEPaifoerCszDkoiXawebqw/9XU5t2T3ESd++XtwgJjbluhywrPH+LTx7yOz1i5pRzt+8SvFCP4B0EiSw7yiNjOsvIrJwOqzeAUa7nhwdPcIz7FOmgKyKGNuHDoUbhvoX7NSq3EtoBKgsuTUjeuozylZrGb1IVXpKJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoUZ7jYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoUZ7jYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF31F000E9;
	Tue, 21 Jul 2026 07:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784617864;
	bh=xqjPSCZHcwkdkGGutjPyOoZ2XfWL478wvsrVESd055I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YoUZ7jYF1vrWypjRXMouBThTVWJD2IhxRDiYvSzgpD5G3ExpURmvzU/nzCpRxfLyx
	 bTcnbuVgepZQ+5rmzruaUNhp8D6mO0w/p9//vRsmAAIsqK0dFuMK9IOX6jKeOLIiDh
	 c28G44bZ9+LYeUzy2t9fxJ4fEWDn2SaCKA7iI63EJS+PKe3CA2citObmVPKNNqTsS2
	 SYRYY+vwGzhnabxtkxwjaAEDpIBIwFkF8ZAoemodaK5N42NZiivjrAcnEnWJ+z67B8
	 2251Drzrr2nQ5HgE8nb+5h7m7aqIceNW2o/Qp8vXZR6ZLCaHMKtz5rmd5GoSJZz6Mo
	 s28hIw+7gnSLg==
Date: Tue, 21 Jul 2026 09:11:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nina_Kuo@novatek.com.tw
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ben_huang@novatek.com.tw, toby_chui@novatek.com.tw, 
	shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Add entry for Novatek NT726xx SoC
 I2C controller driver
Message-ID: <20260721-comical-dragon-of-competition-f1b6da@quoll>
References: <20260715073443.147490-1-Nina_Kuo@novatek.com.tw>
 <20260715073503.147552-1-Nina_Kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715073503.147552-1-Nina_Kuo@novatek.com.tw>

On Wed, Jul 15, 2026 at 03:35:03PM +0800, Nina_Kuo@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> Add entry for maintenance of Novatek NT726xx SoC I2C controller driver.
> 
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 806bd2d80d15..15df47f9e81f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19234,6 +19234,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
>  F:	tools/include/nolibc/
>  F:	tools/testing/selftests/nolibc/
>  
> +NOVATEK NT726XX I2C CONTROLLER DRIVER
> +M:	Ben Huang <ben_huang@novatek.com.tw>
> +L:	linux-i2c@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml

There is no such file.

> +F:	drivers/i2c/busses/i2c-nt726xx.c

Neither this one.

Apply this patch (important: this patch!) and check yourself.

Best regards,
Krzysztof

