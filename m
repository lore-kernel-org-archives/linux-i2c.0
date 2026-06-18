Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502343FB067
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789365; cv=none; b=opOfu3rgxGrUBc+dTM2ufUEqhdvYYh9R108VAEop91S4fQwnUt5SPbELvxdclRMr6ARwxhUjE9A7NygmFVbz+PpU4EvDxprS9ZJwde2pvxcHJUHtwO6WKu15VyTx2qV5YCarHHOJvRQt3fdgWGRFbzexom0Tv2GHAopqbeOt95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789365; c=relaxed/simple;
	bh=U7Bbg5tgaZ3S9d97wN/aw++T7lMm1tDnJMAxIOeRwLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=es5YQMkKRBETBILJBEZRqEBzxRQSntL/QmJRavSBx0g9APujWfynxN3YRpqVzMEvOt5P9QSgqap01n8b7S05m6Nu/I9C5/G7A5D2mhNRL7PwPQNtWNcbmhrYZ/RhnuXY5AlEu9HhFGXezrNzq5Deu32dyeph5DfFe9rjeTeCzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJqDnySi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJqDnySi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5621F000E9
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 13:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781789364;
	bh=wVOOi63ZhPXMxempK5lZHLkxz38ev6/FULudejb/aYM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=FJqDnySiiQggoMnvVag4iimdFdyfNCrz6C4LC2zDdRov2lhC6+T6/F1uD4JNanERV
	 UEExDkLvzRWLEnNZbOm4twkIElmffckM47WnnaIy8C8+bFgE7ndBQYaxa1fahaICK6
	 L6sAICvD7Aeuh6AUZWo8omK75anpjQhQVuPMvGBwpvrxUhOtC/aJBxVPGc3cniC/Wo
	 hvRf7OgASfVyAAw+Jp5QmQ/rmSp9hSmu1FpVozmbAp1Pn15/xZ2TqtwpRfZzmMHdeu
	 tP8+/NsmgLZs+QRFTBM4jJh7lbU2yvVL080UAbM4pRf+YWtF/5+dCuP2FUTIHWIadE
	 8Tqqx7JgleQEQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3997a448ecbso7142921fa.0
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 06:29:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8g74wpharOTnIpcHOMI2Nu4Pq5fp37p4tnpYiMrtq8BE+aQYEQL8Bf/XM6gVa5SNV4Id4jEuD0EGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaNoP/uU1Oonq58YNV3gvSJ6DgL2oA/Ho0LGdZk9CBVF9+7d97
	AUtUqlVlPd9YLHNsii2Qvx4u0SVKWJFSoqPiSwsFEjJ2goUgHf6GpoHlHezntpci498mUR2f7Mh
	Sl5baRq8zzSDmA/LT//4gCzQQ8Fi3Te8=
X-Received: by 2002:a05:651c:3c8:b0:399:87c9:4573 with SMTP id
 38308e7fff4ca-39987c94856mr1182931fa.22.1781789362548; Thu, 18 Jun 2026
 06:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618132139.11114-1-udaykhare77@gmail.com>
In-Reply-To: <20260618132139.11114-1-udaykhare77@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 18 Jun 2026 21:29:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v65GFVkJ+YL2=kCRX4mDe_xE0fgvpjsVD6biOga3cFwNPg@mail.gmail.com>
X-Gm-Features: AVVi8Cf_QbtsxS3-TRCHlybZZ480cZ0SxK9nD8A_JEFe5k3XZDF_8tXlFc7mpuQ
Message-ID: <CAGb2v65GFVkJ+YL2=kCRX4mDe_xE0fgvpjsVD6biOga3cFwNPg@mail.gmail.com>
Subject: Re: [PATCH 2/4] i2c: sun6i-p2wi: Fix device node reference leak in p2wi_probe
To: Uday Khare <udaykhare77@gmail.com>
Cc: andi.shyti@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 9:21=E2=80=AFPM Uday Khare <udaykhare77@gmail.com> =
wrote:
>
> In p2wi_probe(), the device node reference obtained via
> of_get_next_available_child() is stored in childnp. This reference is
> never released via of_node_put() - neither on the error path when
> of_property_read_u32() fails to read the 'reg' property, nor on the
> success path after the target address has been read.
>
> Fix this by calling of_node_put(childnp) on both the error and success
> paths.
>
> Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) c=
ontroller support")
> Signed-off-by: Uday Khare <udaykhare77@gmail.com>
> ---
>  drivers/i2c/busses/i2c-sun6i-p2wi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c=
-sun6i-p2wi.c
> index dffbe776a195..1ef0e82eeb63 100644
> --- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
> +++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
> @@ -220,10 +220,13 @@ static int p2wi_probe(struct platform_device *pdev)


I would just include linux/cleanup.h and make the following line:

>         childnp =3D of_get_next_available_child(np, NULL);

          struct device_node *childnp __free(device_node) =3D
                  of_get_next_available_child(np, NULL);

No other changes needed, and much cleaner.

>         if (childnp) {
>                 ret =3D of_property_read_u32(childnp, "reg", &target_addr=
);
> -               if (ret)
> -                       return dev_err_probe(dev, -EINVAL,
> -                                            "invalid target address on n=
ode %pOF\n", childnp);
> -
> +               if (ret) {
> +                       ret =3D dev_err_probe(dev, -EINVAL,
> +                                           "invalid target address on no=
de %pOF\n", childnp);
> +                       of_node_put(childnp);
> +                       return ret;
> +               }
> +               of_node_put(childnp);
>                 p2wi->target_addr =3D target_addr;
>         }
>
> --
> 2.54.0
>
