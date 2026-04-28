Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8D3264DD
	for <linux-i2c@vger.kernel.org>; Tue, 28 Apr 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408070; cv=pass; b=mnjTtgJEd8n9rRp9WW1iK804Z0NuQGxlgmEMurptujQ+XwLTmAoE66V6UAfvjOYJQCJ/F6IbIZj2ouHAqZjI7D/EuXOBXp1Xu5AZA0UlR2+ISWvFIBusBMG0OnfdKLpWVTO6VeTim+2wyizOK8Lz13W4jtOrP/yFMDgTsex4BUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408070; c=relaxed/simple;
	bh=8pZqDLVXGdKS4vEGYY/DHdErCtozb81IbFmeZdDnZOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMKR6dL47dKRJaGqbM7WLXq9/HGocUE5n/bZxK6MI+wq38Lt7xpub3rsB8ztgT6Jfpq2JTw06fyIwipTfAPyhrvJ2z8C7KMjiXvyRmaoizUf85WgPQA8iR0sFq3u/idZVL1RBq++TKg0H3KUTm/IUXYUB8go6YuPmnOZcHz+Lgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYgXDGyj; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYgXDGyj"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-678a1642a81so7295730a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 28 Apr 2026 13:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777408067; cv=none;
        d=google.com; s=arc-20240605;
        b=fQeym7Sqb3gXQ2SuFJQ1HQDk6hbB4n9qvk2xhZDLg3dfjoqZkThJltJkWB4RulnCh+
         ylFhpnnqIQG6nLjpKjajz4tdjYwby3QYUYLA2Ubk+87i9mm4m56OnsKsj9ryZbbPhxb1
         dj9qnbTGiFkn4SqMRAH+Zel1TcSTql+1M49cENhPEfM/fB+xYT7YohEtI+FIaUd5mBCh
         2sQzP5mwEUznoKN1TptbjDKZBUh2a5Yf+zZSOkQAmkWCHsSOY60WFPGpUM10Spu5z3Jb
         yCl9iHZsyDvKmXbYWiGimZZ8426E0a8aKOGegjI14vzBcDfStHERUYUPuCO74oqu12bz
         u3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ep7cTthGT0TRjukvSCw1U5zbGWRlXkdi2Yh6rincrk=;
        fh=1HlMTb7X1TtQ6tfIYutf8/StXEJCk5l3KgE/wImccI8=;
        b=Njg48nY4e4UIIzipU9CLcMH77ETXTSkbTuacrAruojQt1lmv+USVcOy3F2Xm57oB6Q
         lAIaNkb7UF4lgjl60qRjuJY7DwDZ77WfbVJGHTpgXa1WmU30k5p/sTe8FRj7E5Tfbi6F
         FgF+lMHmgT4z9f4oY4YEfxELBLewxz1cF4t1hm9OQTK2yGst4jCG5qrPgV64IETz6uSH
         O3EEDMpKNOPHNQ2n0rnxVjdVx5SkERk3A3+RkGdh3ZKYcsXdbQswOSAl7XSsge11u7So
         MTDlOYtrTec+NH9Fnw5L03/fx4816lMCRpwoEblIYJlt/Vx7T0pcxm+YUOXaVVzpUV44
         fDXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777408067; x=1778012867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ep7cTthGT0TRjukvSCw1U5zbGWRlXkdi2Yh6rincrk=;
        b=bYgXDGyjWJZMsmVGWhGSIGIDyj+PqD7RHshfyw5CpKA7Bmpmd+5MiKTD6lCsFczOzT
         A+D/orHAHFm9JaklPGvS43eftIPkAWtL48QGRim2+VPFumuCfQTaD5m69qbC7tlGIHbe
         5I9l+DRten1uo+GqZjHoUSqIDo5DwOcTSL+2GsdSn6F088TZ4av5OSUw3RjEf2xKsZMk
         BY0+FZm/9pduSozg9lr4fH6MwuF/uuNFq45Xbx5gRj0rpI7CUB9IgQx7vH/zBBGOQqnh
         WZ2fxj298x1Lw231rn3OS8hwxWDw0gp+BYMXxw8B0ixV/fGf8UmogmROz53QftGYpKyM
         S8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777408067; x=1778012867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ep7cTthGT0TRjukvSCw1U5zbGWRlXkdi2Yh6rincrk=;
        b=UsBaapoDDekp3Rml2wPCojuW56vU9r7kcb5xVIokauoz+cLrYjhmUfdyBkc2NcnGw+
         fqEcbyW10Rtv6RIXkbOf5X/hWk9xwGXxcQjJJfx8drvGEkuE2pAnLLLUYgHs0eZWQyov
         twB0VbvzR0/YdOOVyZn//QQtgDDeeYoFiMqbJB9c3zNZMSffwXDBkzc9ywpjP28d6H0P
         eSzwkih6odcvBwxuPg8/Qot5tyhlzl/wqyGM15/toSR4hPLUxcJ8nypbnbRUZnNHF4hw
         6OMMPrCOT6hj0Fc6KNpgpDEflFELzi3r7nOvA3Wy+i7qpMg62ZRzp2HGv+szV2zvj6mG
         0ZJg==
X-Forwarded-Encrypted: i=1; AFNElJ8O0S4qp7+dQmBFFpZ97m/W7O+C/HhDINWZYBJplImE5J8nRyTWGgXqXcQBfftDxzniDuJ6S2zhijA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROCYVCTw8KgYAFlMAeD+4Uo9SiM/hhLP8QH3EVlpvrQ4A1C9i
	TcgGa9CJ88TFCFp/h3rBML9hsq3lTLEYclZmDtKdE26pLY7X9vhPDqAngj9w2c+ay2Wfd014Zr7
	n0BWWn0xKPSubQ1hjHEC8Cr5qokDucbg=
X-Gm-Gg: AeBDievkjkn4hEppcLWoC1clYwqLf8ZF6acCHOURB2EP6KAMt9idGnrorc/WFiJJs93
	UY1IlbRbdR/5SVYZjRF5wU+ydsOclSIj24oNC0g3XPh2xeh/jDJXtYq2APYlg0OyMWUFmBt+WB9
	mWb7NHINwbTC+qXHI9lLTUfxfEiaf2Lc/ke/qCh38Sz+RTESowcA/eP5ieGbOxSqUZI3PtO8zlT
	Kwkk7tHd9scg6o3hD/KjYc09XDgoOif9tsHh+xHSSwktIMS9Ui9bfYj13MG4+EKrFUlmZ01VnlD
	kwNLrdMkAU4toDNPKtleeyxP/BlIrvVe/EYq6a08XJmEZPSnn8DrK8s7Gp0WcPkHRKZaHFNAmrW
	1HPRJLGGj7L0qLoV2hUU6DepM4Q27yeT1orI2DzBqsAKoVfj9s0qANu2f93k=
X-Received: by 2002:a05:6402:e94:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-679bb0982efmr2165877a12.19.1777408066633; Tue, 28 Apr 2026
 13:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427172817.417614-3-thorsten.blum@linux.dev> <DI4OKZA3428E.5TJAYEV50JH2@bootlin.com>
In-Reply-To: <DI4OKZA3428E.5TJAYEV50JH2@bootlin.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 28 Apr 2026 13:27:34 -0700
X-Gm-Features: AVHnY4Jkk0RBV4cH1i-ipNNk5Jr5JuI7AhhHwp3PjTVZY3bKpVhsokcMSgzE7Yc
Message-ID: <CAKxU2N8OUcsTxG4XDH=cbROz4954-V5ximN-XHQ5RrPagTfUjQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: atr: annotate i2c_atr_adap_desc->aliases with __counted_by_ptr
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 2:30=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Thorsten,
>
> +Cc Romain, author of the involved code
> +Cc Rosen, author of a similar patch elsewhere in i2c-atr [0]
>
> [0] https://lore.kernel.org/linux-i2c/20260327030310.8502-1-rosenp@gmail.=
com/
>
> On Mon Apr 27, 2026 at 7:28 PM CEST, Thorsten Blum wrote:
> > Add the __counted_by_ptr() compiler attribute to ->aliases to improve
> > bounds checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  include/linux/i2c-atr.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/i2c-atr.h b/include/linux/i2c-atr.h
> > index 2bb54dc87c8e..b52a7b9ec536 100644
> > --- a/include/linux/i2c-atr.h
> > +++ b/include/linux/i2c-atr.h
> > @@ -71,7 +71,7 @@ struct i2c_atr_adap_desc {
> >       struct device *parent;
> >       struct fwnode_handle *bus_handle;
> >       size_t num_aliases;
> > -     u16 *aliases;
> > +     u16 *aliases __counted_by_ptr(num_aliases);
>
> I'm not fully proficient about all counted_by things, but the patch looks
> OK to me, and definitely @num_aliases is the number of items @aliases mus=
t
> have, so:
I prefer my patch.

__counted_by is supported by more versions of GCC/Clang than __counted_by_p=
tr.
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
