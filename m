Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3D388368
	for <linux-i2c@vger.kernel.org>; Tue,  3 Mar 2026 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525197; cv=none; b=L2A9Jjez6leOogotZ56t3sjDJHSaktEpOqNX4WqV8N7LU8QgTqFSJDrepw8DFJQjPXPYV4cvRw0C4BdQsIhLEaZeFSs/GGBwLkX13CPfCeaPKWuu3O/gj1J2nu6eL/BhOlkwfjSP25BpBvGxtplNKJItRZvhLBMYaZZ+WtM3tCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525197; c=relaxed/simple;
	bh=1oB+ssKa84QQr+DH2XwQr5+wYZ8dPt/WJK7NpmaOUqA=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Db5twfBbkFrM91fXbIfV4uGqY3isDz/PKNQc63cJWLQFYE8pKSKczMoSbSy+RHC3ZtVnMGPUT7LtPUZgB5QHtbiQY15cVJMZwzZyzC8zA5gJxlwIHqnpnqhrR918qFOsAn6uu9bA4y+q1qOIVzKqgXw67VxpoqQQz+wYbg0yfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmLj72Gq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmLj72Gq"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3870d178a9aso83601681fa.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Mar 2026 00:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772525191; x=1773129991; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2h1mLfGIlFyqf3WlI137U7KtFrfJl8BK4TYIS/tiF0g=;
        b=lmLj72Gq2YYZDUVVywAx544j8mrqZkJkNOeLzm/mkc0oc9k71HNVo2fJ7VPLc9RSeM
         WCyH4FPdAcvxqZny73GzfjawtsBFGcf6pguHU4u1q3EHDi7aKyXtYtw7PsajHpbMU5Oh
         DX/q0GKq56/WmJBYBLawSUbQ/fyPD0NM20tl2fXxDr2VNDkXRZJ2HPW09wVkWDKj0ZeM
         uv1+rMjA6vBENZ8lKErt9mXc+TyOMJCbM4SHr3+ihRhvuma/83RJtAUx0OGUhKffcPSi
         znY283XPqdUuLS4xmzlcx5VyVgbssERtz4O4ExEsbzHpaU577wVa7l/PIbUjH/9u6ZWd
         B/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772525191; x=1773129991;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2h1mLfGIlFyqf3WlI137U7KtFrfJl8BK4TYIS/tiF0g=;
        b=pZeN3jZP8n0PgirmXOZaBAs9bSCRXmb9flomfquO3A6fOg5fTCZcBhE8kvCNRIRH+V
         3tYoQVkY6iuIq+6sYvKXjeZ82m9p5Z/bMk7zGSV3lw6kl4Nx+PiC/zZP6kgLoaOa3EFh
         EyxC3rCqGVLijPxdHFCe2BxrnmK9NdwzzB0I12igFQ3a55HN5NDSleb1Dg5q5A9JMyxZ
         zetSEiR86JeAzMdYivJnn3Rh8yjQ91JeDo6d3oPhesEGkHsQfqsNxqnNS5FD1yWUsQHp
         tCNRn34eZDBv6trGkwN976b3XgCC8Jdp313b3aqyhfM2clOOWmKtKDUZbHxnrNsSa24U
         rSZA==
X-Forwarded-Encrypted: i=1; AJvYcCXK77fFKWmGC7/2HQyJ+nMaZgc+zdLkz+wc/KvLUA7fuZkUtXBXCEj1e+o0IpoMXsf37M4y6N0LRyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBjEU/X4An8VSr2iMjJUiwItxPKZ2yvk6oqSpwR7u0Ww9i/YJ
	B8ff19BItAQgXeHydZCn/rw9kFaR7Fji4smS+gxuCQ8RKvwXn9HatSN7
X-Gm-Gg: ATEYQzyYa/+XDABBB/BkFzuBUmhyMqzIYzNOwZerSB8Og4XN6Xgc4K44ab1D2hEhYca
	dQop/OPrSr2TVqauNd7BajFEwXPoIWYUZ1vV439EU/HAixZuD9zDD+NKTbel0YUwOkMVxP/Uwg9
	rTygyfvXX05CBmaDI3kWy3MzVK9v7A9JyIo/ddMXzrlZh4AZGQlAY5yUu0A2GGe9JZJ/OVG7oFG
	tXw9RK+qR9ysnrv9fhI5jBNe/f1XAqulZyqO+iY8JOOFP5l2hPoRnkuH9ggRTK98leAecViF3R2
	oTeTSiOp5uV9v0zATYfqcZ/iUudm6yz7pjPtnqo8nBEMxKj3NzIO0vUSMgLAmhMxRkrxB3l5xfT
	Bo9vUNLDhQFNc5PLWgXAMQj2jy5UuGFIEkGLP/Si4BqEmNEGXMusiO+fIUR0h+ODHGgnnUQQVZI
	12+4H6hK5jxwXWOHQ8oqJX+fPAVoTfMMCSrQAHzDOkHLb4Axao8vBzq5c4k1RdN7Er3GYBcKAv1
	RKaWDb0JvIx
X-Received: by 2002:a2e:8941:0:b0:389:f9db:bdcf with SMTP id 38308e7fff4ca-389ff136975mr87911841fa.13.1772525190646;
        Tue, 03 Mar 2026 00:06:30 -0800 (PST)
Received: from smtpclient.apple (mobile-access-2e8433-189.dhcp.inet.fi. [46.132.51.189])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1237b8177sm394948e87.59.2026.03.03.00.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 00:06:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Kalle Niemi <kaleposti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] i2c: i2c-core-base: fix devicetree alias handling
Message-Id: <5D358835-047F-4A79-B610-4DEBD562F9B4@gmail.com>
Date: Tue, 3 Mar 2026 10:06:18 +0200
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Frank Li <Frank.Li@nxp.com>, Linus Walleij <linusw@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: iPhone Mail (23D127)

=EF=BB=BFOn 3/2/26 19:04, Andreas Kemnade wrote:
> Parent device is not set up there, so use the new of_node pointer to
> handle aliases.
> Fixes: 0ab80451c70f ("i2c: allow setting the parent device and OF node thr=
ough the adapter struct")
> Reported-by: Kalle Niemi <kaleposti@gmail.com>
> Closes: https://lore.kernel.org/lkml/EDF3FB58-4747-442E-8463-6F1C6E568962@=
gmail.com/
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/i2c/i2c-core-base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index dd8cec9b04c6..e22d784202b8 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1657,10 +1657,9 @@ static int __i2c_add_numbered_adapter(struct i2c_ad=
apter *adap)
>   */
>  int i2c_add_adapter(struct i2c_adapter *adapter)
>  {
> -    struct device *dev =3D &adapter->dev;
>      int id;
>  -    id =3D of_alias_get_id(dev->of_node, "i2c");
> +    id =3D of_alias_get_id(adapter->of_node, "i2c");
>      if (id >=3D 0) {
>          adapter->nr =3D id;
>          return __i2c_add_numbered_adapter(adapter);
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260302-i2cfix-56ec3cfedff6
> Best regards,
> --
> Andreas Kemnade <andreas@kemnade.info>

Hello,

With this patch applied all previously failed tests pass now; i2c busses get=
 indexed as described in the devicetree.

Tested-by: Kalle Niemi <kaleposti@gmail.com>

BR
Kalle=
