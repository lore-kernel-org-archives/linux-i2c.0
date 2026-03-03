Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A44386548
	for <linux-i2c@vger.kernel.org>; Tue,  3 Mar 2026 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527586; cv=none; b=RUmKWngFJ8kaPSrJ0j0sWfSs7Db/hGRH9zYvvq1LnBfJtkgdK1x/YGQ7j/8Cvf9yu+z85LPj33dYYbKlxgoegoYmHrJwtQc8NF4VqpZk+OtSjKWHNqoVZ1AwGFZ8DXthAfjPRFgnQPvRPl6AsSD7BgtC+oFe2EZX47N5imvJIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527586; c=relaxed/simple;
	bh=5Z7+bYSaNPmC4PktLLuc8kuSXp4ZPqUxuRUjrSqcPmA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq1vgfK35DtP9PCSvg2BGOSMB0YeSqajUV0CNCTTstycwfAygHu+wTYLIcvtGwE8lWZkYnyMza200JSL+9gohzdRdjyDootyNFXYKkEC7J0zhL8CJ0yIgneSUIlhmtTjOFjdjnfzJVsUwiGpnqC1T3HcYuNbtzzF1bNqeFuMcK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCHYT1dP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCHYT1dP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6388EC116C6
	for <linux-i2c@vger.kernel.org>; Tue,  3 Mar 2026 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772527586;
	bh=5Z7+bYSaNPmC4PktLLuc8kuSXp4ZPqUxuRUjrSqcPmA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=iCHYT1dP6cQC5pcDiFAWZiwkM0kjma2eKslIDT9Lxx6Uaw0pwAD4VAnRwRv+6vYmj
	 cOEhYN2WPn5DZaFGwvcFxr8CyJ8LCIMZJdDHv6s1zHJuuvonSO81lV2ESYSIT0azNw
	 BdmyvRz6clQlVBe1Kj0dM5LuYI7uAPG0kYDhgrNvIOSc5mgazC8hy6JjlLT+Wjd9iQ
	 SPp+M9bREk1GWYUJbQCx3sMhrNE26zVBMTTuEO00XjCfjFZlPd7oZ7D/ED7IlmstRZ
	 pOxT1hg2yCUGKyMet5D41SsDcBNDTGjSbpntluUbunU5iojmaer8FA9AbyjZnz0zFt
	 FKphOf67TpR9A==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389e4330e32so79569281fa.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Mar 2026 00:46:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWM8rDlCJpiar0Y663ftgSmJGccc2tOi3zUOjtjW+Z9GJUlyYb/65OiQ5d0wuzt9fNjPw/kSzGSevY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6yNOhubdtJKXiKHD2T+a4wnJWqQvkhVh5rfbmV7egnh0vyy+
	bIDsSStlrgMo9zyBni0XFLt0svN7Jn/jHH+i9T6ts/YvomFm4M5D3FQTdglKthTQgYSWeJtYg3o
	DtAd4o867baHRg/E4r3EcgiWvID1P5e3cmJWZElcVng==
X-Received: by 2002:a2e:a547:0:b0:38a:45b:420c with SMTP id
 38308e7fff4ca-38a045b65d9mr95380831fa.7.1772527585023; Tue, 03 Mar 2026
 00:46:25 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Mar 2026 00:46:24 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Mar 2026 00:46:23 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260302-i2cfix-v1-1-a95418e9217e@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-i2cfix-v1-1-a95418e9217e@kemnade.info>
Date: Tue, 3 Mar 2026 00:46:23 -0800
X-Gmail-Original-Message-ID: <CAMRc=MdGW3hPHOb_1UxH8+H8XDDywtcjGSj9ZqPzgqSGz5YMAw@mail.gmail.com>
X-Gm-Features: AaiRm50TVCRt4pynZovM7oFz_5UEfXvWaULFc6gb0GiY1gfWCyY5adpwMkHBUVs
Message-ID: <CAMRc=MdGW3hPHOb_1UxH8+H8XDDywtcjGSj9ZqPzgqSGz5YMAw@mail.gmail.com>
Subject: Re: [PATCH] i2c: i2c-core-base: fix devicetree alias handling
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kalle Niemi <kaleposti@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Frank Li <Frank.Li@nxp.com>, Linus Walleij <linusw@kernel.org>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Mar 2026 18:04:42 +0100, Andreas Kemnade <andreas@kemnade.info> said:
> Parent device is not set up there, so use the new of_node pointer to
> handle aliases.
>
> Fixes: 0ab80451c70f ("i2c: allow setting the parent device and OF node through the adapter struct")
> Reported-by: Kalle Niemi <kaleposti@gmail.com>
> Closes: https://lore.kernel.org/lkml/EDF3FB58-4747-442E-8463-6F1C6E568962@gmail.com/
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/i2c/i2c-core-base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index dd8cec9b04c6..e22d784202b8 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1657,10 +1657,9 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
>   */
>  int i2c_add_adapter(struct i2c_adapter *adapter)
>  {
> -	struct device *dev = &adapter->dev;
>  	int id;
>
> -	id = of_alias_get_id(dev->of_node, "i2c");
> +	id = of_alias_get_id(adapter->of_node, "i2c");
>  	if (id >= 0) {
>  		adapter->nr = id;
>  		return __i2c_add_numbered_adapter(adapter);
>
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260302-i2cfix-56ec3cfedff6
>
> Best regards,
> --
> Andreas Kemnade <andreas@kemnade.info>
>
>

Thanks for fixing it!

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
