Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05A5038E8
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685022; cv=none; b=ryhm4m20+v1P7pXqnaWFiHBhtONUc7jwJsSGYGVn+3vMkc14a9VxaSo67GaQPC5eS027Gv6QsigWZW/YFRH3CXnMjpkdNFEO87lW3R3B6k8M/5omh92AJMXMnXZIMhtzv2IgugYw0DoxnpEuMkR/cDdNgLq+0qbfz2BdZ2qxLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685022; c=relaxed/simple;
	bh=TT3Ezw8uMk6ihkrB83jG6PetC2CUsZO/OnzOh3O2VNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRrZSKjv1lFkOkiD+SU4Jlp0WpExb6qZKC99X1a4OVOD9s2//wsltw6xbiw8CmtkoxXTkFPR8Ks6dWgMKmc8aWRzGp52GhZOPFAtfobDZtxBRVB4A5p6WiLeTily6IpjICB8dAV0csoqyFeP2l+H9svXUToqybqo4NC8Q4ditJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3hcjsuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3hcjsuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4098B1F0089D
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685021;
	bh=Ffx5iJJQQI8+oq7N+TFeO/aFkaW6Y6DByPQ5OFdmPbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k3hcjsuhqOXdntA6oKtsZdcRq8OPBPv1scP5hVc773xC2Vq5o568JE0lOXpkiYaSe
	 dMDMPrSKxRynnsze1Ws/7ip9T7CkYyU9siXMGvP0EbxXSe9v2rby2Do55Z2MnxN8JD
	 ak30Ytfmo0GJvav8fEi5UsBI0YN/XipzdASdMHAZzJlD60kqfQ9hMJyfiQlNkJcMmC
	 xYvIxXg9PxB1X8GAcO02bDlT0S2FIVyOetGrxyYSwJVKJGOEMIg0rianif2OsVK3iZ
	 736BxOAJqjKHVIGqTJHVc9MAjwfFEkzZBYPtGjuj/pc09gOTnNp4lAEOql2xSdb5TA
	 BBG7eFv0zzVjA==
Received: by mail-lr2-f22.google.com with SMTP id 38308e7fff4ca-3a65fd1534aso19684921fa.0
        for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 05:30:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzHX8vBuVUvvdSFeL9OTCx0hmRsjZLSs+KFTZjCpVLanwKD3MYVYKjIFlX677ayfybKxOICJo4iV9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgmxiJ5s13J6Z/xqb0rNeFQ8/6AulMIDjG4umQyqhpj1sWfbZk
	fh0b4ioFrQw2wwt18s9mQSog/wIX2hrSqigx9yQ4r5AbrPeM1JsZuKcGGt4tRIZZ1z7LiokHOKK
	JjwNU5jN2Htf4hpXkqQovCBuVnIWXoYk=
X-Received: by 2002:a2e:a99c:0:b0:3a4:8913:a259 with SMTP id
 38308e7fff4ca-3a63c42a68bmr43318821fa.29.1790685019644; Tue, 29 Sep 2026
 05:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929121348.109556-1-yubowen8@huawei.com> <20260929121348.109556-2-yubowen8@huawei.com>
In-Reply-To: <20260929121348.109556-2-yubowen8@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 29 Sep 2026 14:28:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCnT-47ar_fMwML_Qo_nsgc6xPrE4ha=zERoQ2P+0Rsw@mail.gmail.com>
X-Gm-Features: AclHuK8oY0e0bz6e3NL6F7Df6n9DeKajYeBoXSsjfqEZswV4mCHzOyYX_kQvez0
Message-ID: <CAJZ5v0iCnT-47ar_fMwML_Qo_nsgc6xPrE4ha=zERoQ2P+0Rsw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ACPI: Add stub for acpi_has_method() for !CONFIG_ACPI
To: Bowen Yu <yubowen8@huawei.com>
Cc: linuxarm@huawei.com, liudingyuan@h-partners.com, andi.shyti@kernel.org, 
	linux-i2c@vger.kernel.org, acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, lenb@kernel.org, zhanjie9@hisilicon.com, 
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com, xuwei5@huawei.com, 
	ouyiyong1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 2:13=E2=80=AFPM Bowen Yu <yubowen8@huawei.com> wrot=
e:
>
> acpi_has_method() is declared in <acpi/acpi_bus.h>, which is only
> included by <linux/acpi.h> when CONFIG_ACPI is enabled. Unlike the
> ACPICA core helpers (acpi_evaluate_object(), acpi_format_exception(),
> ...) that get automatic static-inline stubs via the
> ACPI_EXTERNAL_RETURN_* macros when !CONFIG_ACPI, acpi_has_method() is
> Linux glue and has no stub in the #else section of <linux/acpi.h>.
>
> This forces drivers referencing acpi_has_method() to wrap the call
> site in #ifdef CONFIG_ACPI to avoid -Werror=3Dimplicit-function-declarati=
on
> on !CONFIG_ACPI builds -- a valid config for drivers that
> "depends on ARM64 || COMPILE_TEST" with no ACPI dependency.
>
> Add a static inline stub returning false, consistent with the existing
> stubs for acpi_check_dsm() and friends, so drivers can drop the #ifdef
> and rely on the runtime acpi_disabled check instead.
>
> Signed-off-by: Bowen Yu <yubowen8@huawei.com>
> ---
>  include/linux/acpi.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ddacac812094..141a322435c2 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1028,6 +1028,11 @@ static inline bool acpi_driver_match_device(struct=
 device *dev,
>         return false;
>  }
>
> +static inline bool acpi_has_method(acpi_handle handle, char *name)
> +{
> +       return false;
> +}
> +
>  static inline bool acpi_check_dsm(acpi_handle handle, const guid_t *guid=
,
>                                   u64 rev, u64 funcs)
>  {
> --

Please see

https://lore.kernel.org/linux-acpi/3717753.iIbC2pHGDl@rafael.j.wysocki/

in linux-next now.

Thanks!
