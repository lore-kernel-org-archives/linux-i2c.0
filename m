Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4740FDAF
	for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636557; cv=pass; b=oIParoELotpIZLLU5dmzvgK7Lof8ZkTWIAEmdbfBPBHsg0Llmc//0YLhs8FHs66/v5384hQ1WEHAcTZUZ/tA+J0lv+Ri1YRtfduExKhD43PyngG/fwEFW7kZ9K3Exr37f/cJ2xorrkCXgVZO9tKFF4M0Mc+RhQwNzupF3m16dAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636557; c=relaxed/simple;
	bh=v5X0zYzLvx13iVIiY+jHgdPrq0zyDUhqyAsIlrZnjhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6tdvtrqUTBVelbvgP9cdArPveD5UVuNlqbxicc4cf+AjZs2NowHW7o/7/06hrB9cMGIUx54Bv/n4xsi3oHoAycNwqPzwYHUvpK/Amawm5nW46iV3NCw4IkK4PooM5qxf8odOQDLZlN/p7CSlgdmDIt0WV54xjMvX6JAmW+PLmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPryKOpP; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPryKOpP"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66b05026e82so4061035a12.3
        for <linux-i2c@vger.kernel.org>; Fri, 27 Mar 2026 11:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774636554; cv=none;
        d=google.com; s=arc-20240605;
        b=JwHsxggCUEy9rA6tgBtHQj+I2dgBnvxfKm2H94R/6EoLA+ALejAW7J/0AcABLv1Xfu
         /h5Pkv2Z42o9EuIdZvw0XuYXRTcgJicrPjvzvQ9pxrgcpftxo9vp76MaaVKz+L19Vca4
         mTfcvlHrdaeLDuvE8ifwPTBqZyccSp8hcx0kGFfpaOQjIF1fj5/X6xhjlZBnTyuwscw1
         Aze41B23uGvvhodI6Jn9rhKiE4AeHVjIytf0+F7wxyCwTDw89ZJgJG9erY2J8WvuQRWu
         BON/Jb1pTFaRdOvyAeggJxrvDF+rV2uqjNZvLLpSZIHehdbTW3K+50iE/HhGaj8QJ6MZ
         h/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v5X0zYzLvx13iVIiY+jHgdPrq0zyDUhqyAsIlrZnjhQ=;
        fh=oW+flFwwnm3vR1B/QmhfUP8HGcB7wR+BqGaJpZqWOmA=;
        b=Gx/89eSJMuzaY1UIESzgrdtYteqGIVweVh+UqPgSUS9iwv/OrSPnoX9Vo9yvvwCiA/
         v0Q3HFyfoDHqH4x0iSnJoTA72SB/NT9vuqtxdLdZpI1qMYH6zCMqqmAzy9Km7PSxW3TX
         zc9EGAxK/6+lOHrRNGUbeHiKvVF/xcvbDN9cSuxtVIK1K0Xcm+slveGciz7FRSt7XujF
         JdFoAhPRE0c42/r95kSxKqYYy94zF+v6zxrml6kcGimqnPrXFpK1c8ERliQXbUWYCBH4
         bHa7YtIlEQWvlAJ/ZjVqCRkXhT+x49JhubqWbgZiUAe8t7l008e3Cfy3QeA+LorWt4qe
         geyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774636554; x=1775241354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5X0zYzLvx13iVIiY+jHgdPrq0zyDUhqyAsIlrZnjhQ=;
        b=rPryKOpPzY16cdqL+RO7c6Vi8KkMV4fg4uaQ6eLGkQji1YKHG/sdkJKRO4NZZkft6m
         pbH/2gCZQV5J+FNIAcF2BF/Hbg1G0j1wCD+Us9ZalpE6SvHuCOFNDTyd7l8Ba0iRftiR
         3rFP5ISKQdNLtrd1gRBMxxgP+OF2y2ej3wozGmDapjt3GbO76d2O1J46LpWs5HtG7JPo
         DYpr75J+Nx8dk9pfWGySJ9aw2j7BY8ZszouBY54rA0/oYMwL2Yod8/D9TN5kRs8mKPnS
         EOWnP4MuGO1LJD5Gjr4AQPxZfNmOb3RHx5cWR/tQG15Y7ecxzreFLqsGI0P3N2c9xMDP
         OIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774636554; x=1775241354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v5X0zYzLvx13iVIiY+jHgdPrq0zyDUhqyAsIlrZnjhQ=;
        b=MYPYOd0m7KqIOxzX7yFnFRgS3G0XVG391AznZVfjoOoEHPu8nTODU1owxr+Kvtij1M
         zt4zUk11DAKXy2fsjszUDqVpDOiyS5qDZ6d/IZRSY2X+O3WdFMjako7T+0g197YC9UqP
         qHVeFjgKKeBJE1/QA5Jlfx9qNUAOe0jjeGd+rUAG+8RkVNlnp3lPj1tWPzCvEBoHm+kt
         BoZvgjowSsukpGvPrlSrW+Z3qnB3p4hjdkQ+16ypsPbJ0+W/E0wHqvrWKPK7b+qgWOMq
         +1GwrhGnJTgaDukwNOexi+UpCb8m3kqsMZciPCOXxdIft5DFQneXP7H5L/XCamhDiFd+
         WxIA==
X-Gm-Message-State: AOJu0YwR4poAgAv8RWL470Lwal7xRnR4B384Yfff51pjQnmJlIBx385h
	rGIUC6FwdfWAJuxYlc476vqPB5PA/H5JB2B34kTEMrNmeU+pDRBvH5mhMn1RMjvI5TIcefeEyCY
	J3/Df+EY9NK88wCXtSOq3oob09MSzXlg=
X-Gm-Gg: ATEYQzwkBxuCvREYZUlrtNqfMTWcgI9tCaDDQOOhJT4DRjm44ymsbBNYNhcPW+eiPB2
	drVGmIpP1ndq0nvtrWUeP2InV3jCTQC9CIOU3YuqpeNZT4Ns/IgZpOZdyCwGlspNUXk4DHnDfbj
	c3505I7RfPJ8IgtxLAnrADCfXmDrWDw+NZodahLTjo/FXwW+2ekwqyzKQiZrQJ7qQ8oxZNaN9f5
	ITkwWKAZu0HApCOhAbxWv2F6XlMSOZHCYQjMI+UmybK6l52DgCgQTOf4MYPkUA+Ova471p6E3g3
	mBHeYZa9NPjtlGAg7lAmchM3Fz6Zd/Et58BGu8pbDuAV1851dBw9QX7eFGXxNG3cbd0FBFjZeWM
	xzdDD7g==
X-Received: by 2002:a05:6402:4494:b0:663:6d0a:6f97 with SMTP id
 4fb4d7f45d1cf-66b28f72394mr2419395a12.27.1774636553813; Fri, 27 Mar 2026
 11:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327030310.8502-1-rosenp@gmail.com> <DHDEWIRRJTP1.58HXGTBGH4A@bootlin.com>
In-Reply-To: <DHDEWIRRJTP1.58HXGTBGH4A@bootlin.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 27 Mar 2026 11:35:42 -0700
X-Gm-Features: AQROBzBmB0kpJXECWuRS7Ed_1LjUhTq7PZ0stLx1p30txIODqyrw8I4yJhCfQ60
Message-ID: <CAKxU2N-21Zt3+5D5Q=ZjTdS27QtJWOPZZDTiqHGENqjxgCpR3A@mail.gmail.com>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-i2c@vger.kernel.org, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, Cosmin Tanislav <demonsingur@gmail.com>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 1:12=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Rosen,
>
> +Cc Cosmin, Romain
>
> On Fri Mar 27, 2026 at 4:03 AM CET, Rosen Penev wrote:
> > Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> >
> > Add __counted_by to get extra runtime analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> This is the second version of the previous patch, so the subject line
> should start with "[PATCH v2]". You may try using b4 to automate this, it
> takes over this and many other boring-but-useful details.
Didn't realize that. I searched for attr vs atr in Sent...
>
> Additionally I suspect b4 would have a more complete Cc list, including
> recent contributors to this driver like Cosmin Tanislav and Romain Gantoi=
s
> who might want to review this patch. I'm Cc-ing them this time.
I use ./scripts/get_maintainer.pl --no-git-fallback as it was
requested elsewhere.
>
> > ---
>
> Also a changelog would be nice after the '---' marker, to help reviewers,
> and a link to previous versions. It took a moment to me to realize I had
> already reviewed almost the exact same code.
Will do.
>
> Other than than the patch looks good:
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
