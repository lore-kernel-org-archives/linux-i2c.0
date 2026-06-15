Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53B3E7BA0
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526084; cv=none; b=R2kde7UcSvNhxRYBN/zVQfTSertGoXTCIny3vQdRqy9LGVkvPWH4SEj0k6FonppWQ/LFTC1tlY0NEthIwuItTPg2R5pYA++v/nWVqpr8HslxaJ7WNwLyRHEAb+aKajIVVA/Jyeu3n9s+vggzfKVPQ5mqCGcXEzzFGcxyDqdmi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526084; c=relaxed/simple;
	bh=ROD8BjDuhqrcHGOg3YU5pJx9aeO2ZrsENA67Q221pek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWS/GJLff1Ltu9JmBUl2k8GK7A+iSSiu/Y+CSfVpMEyg/QNmo75remL5p2oVh2T9exHhqHMVM0SfehDjIUPwtfk3X4g9w8DuRRFla2XbIlT+jhN0JHjxhLA6kATrk7jrYegsyLUpttZbjZwLiwCa2nqDv7GLauxDd9R5jXJ53QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkOVC1W3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkOVC1W3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9971F00ACA
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781526083;
	bh=F/R26Myyl0yIhGDi/iXaNrHDLf/HQBvBtxQkw+f6av0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MkOVC1W3ae0yWWtsGOcuUFNtaGeCwRKcGjsxebAvK3Kooo/iGRyV1LK9XkneRwnbU
	 Y7cQJwC6xQJVxrMDUZvPWWk7nK3KE30O+9f/DdZySbIh7BCqtDJdVIvI13aJtqkGNd
	 tfZl+XZQDTNfKy+YsbRfX0pzKggYa7EtOR6/wZH0NOldCpGp+D/dpsEce9GqRFXiMH
	 0yOi862Ui9Mbg9c1oD/whS26InRATQXCphBhqhht3tKyVeWk9j2dRWyq2VNgxE2nCH
	 pSew8sAQmdyx9lZ+kOyS/hke9Qau7olrMIidVBBneAL0WKL0Ge6XndE4m12G7f8tqZ
	 OFImQJlj0V6KA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa7a70c0aaso2945061e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 05:21:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9R71J6ApPUbL4bXGuttvO56e9EU/tjRZqvzpMKdmVTlxw4VQTIkdEzdmORcxih2t8874GuVnTE6r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpCsfrnUp8yfPg/a92h08fjTX5tzz59i86mi8W+sYjNzD1Oav
	V7dmD4T94rOwb/cbQ0Ur9pMOnStBysWO62Os5Gr2CqmlXe7o5dKQyPHupCsjl46VtZ5mNeQJ5E/
	yfkrURcdyQow/vftf3tUGd8SYXFf9FPA=
X-Received: by 2002:ac2:42d5:0:b0:5aa:8824:1571 with SMTP id
 2adb3069b0e04-5ad2db8b01emr2615896e87.49.1781526081757; Mon, 15 Jun 2026
 05:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610083701.18663-1-hardikprakash.official@gmail.com> <ai8jhK9hUGHpojB5@zenone.zhora.eu>
In-Reply-To: <ai8jhK9hUGHpojB5@zenone.zhora.eu>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 15 Jun 2026 14:21:08 +0200
X-Gmail-Original-Message-ID: <CAD++jLkZfFRBdbMzs3arLu61OO9KcJpS1pB18e4gdyu5PADvhQ@mail.gmail.com>
X-Gm-Features: AVVi8CelMRVH7oTzrLtejJtW_HL-yUSQgpLF7pD3CatF0zFZ_HBArAsp2CAL2-c
Message-ID: <CAD++jLkZfFRBdbMzs3arLu61OO9KcJpS1pB18e4gdyu5PADvhQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "i2c: designware: defer probe if child GpioInt
 controllers are not bound"
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Hardik Prakash <hardikprakash.official@gmail.com>, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, wsa@kernel.org, andriy.shevchenko@intel.com, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	nathan@kernel.org, chaitanya.kumar.borah@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 11:57=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org>=
 wrote:

> On Wed, Jun 10, 2026 at 02:07:01PM +0530, Hardik Prakash wrote:
> > This reverts commit ef76a3a28c79b628890431aa344af633e892035b.
>
> Is this in your branch?

Nope. It was too late for me to handle as fix, what was merged for fixes wa=
s
this:

commit 3f786abd23951f3f600a62fef42469d9200d5f52
Author: Hardik Prakash <hardikprakash.official@gmail.com>
Date:   Fri May 29 15:38:36 2026 +0530

    Revert "pinctrl-amd: enable IRQ for WACF2200 touchscreen on Lenovo
Yoga 7 14AGP11"

    This reverts commit 3812a9e84265a5cdd90d29fe8d97a023e91fb945.

This needs to go through the i2c tree at this point.

Yours,
Linus Walleij
