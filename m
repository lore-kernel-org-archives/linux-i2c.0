Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF671559C95
	for <linux-i2c@vger.kernel.org>; Tue,  8 Sep 2026 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873187; cv=pass; b=Zu6lInaq8ypADlpgdDbK8qIDgPlPLui4I9pkT9m2rUIj2UEwJ7mXZv7NQS9EUjkARCgUdHlClCILe/N223ipqtYWmtvzRUO7N3jFjeQh7IcD+XsfHs73b63x2KoaNMMo6MP7n5i0gqiIM8VB0B1w6Q2DpkLlkbldEuhWOke4YrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873187; c=relaxed/simple;
	bh=Wz7IZrJW1UapIj7FlBxMC/F5YCmC6GItgtFzsvZAj8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoE1C5lzEQa7x8KiNrsGRxZ2Kpa/osIHHn34oj9KXs7OnfSkgpe1HTORG8eJ8+HSpBKRazXACWPXBPIxTLzScf65hakQ9SMAFkg6Y+cJT9G+yFGuGu87004Yco7OWBGp0wrTKxrVB6+8+o/ybYJA1FqbS+RdYavXoAN6S6vc/9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hthW87jI; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hthW87jI"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so5032526e87.1
        for <linux-i2c@vger.kernel.org>; Tue, 08 Sep 2026 06:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788873174; cv=none;
        d=google.com; s=arc-20260327;
        b=pMa0/CU8i4griKWYJSzNOawKMnri4i/VdH9aiTrapW36I+S4vOuAanCrRh9FjejnLw
         g4UhOlH3KFFS/A69qdtCm6S21v9AfhuKWxL0ud3lNHQW5N4DJD1iikm6rZhUk70BmvEc
         60U3KH07wAjnasbnQzkPsKLPMWUM3Ew09v7Yhp0sqcc1JgjauwJKeabiFm5erO7XgcyI
         GoXj+TMKbHkSsH2apCGhv6HONgqUobqNziIL+oWd2K5oV2ri1U0vLSooxQCft26NJGMS
         fW1O+2SifQviKDwkd4sGeb0OhsOLttt32GEafc643TvKEcGIRe0zID5BFRuf17D3iGcJ
         3PXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Wz7IZrJW1UapIj7FlBxMC/F5YCmC6GItgtFzsvZAj8k=;
        fh=ykpf8/qJkGIWRv692EWq8TpdboESkCwUQFGbmEG9M8w=;
        b=Ligqgp40VwCcOFfmvjZJGi7afXjBdokVdTJuK36lKf6Q43VKgnRbqWvWwYnRoU2d38
         fWqZuiwfH7VZiITaZryyKmXRolK3VyLFv9Ard9SDOD724boUvmQhAHB/bz53XJvEOHD7
         JYGxzycVFSKyWnradmYnQlY/3c0YINZJGBHE/765Txlq7dKnxK7NZ8BlV2TP+Ds8Z8J3
         Nc1Al1OFliGIZ9Z5xLueCKqraD2RJLGAgvqKNoniaaflnbRhxe3xTpqVA1/DlJDVwaza
         /tlcBmtNY9LZjG8pbuMiBFF9oXnuLITz70Xn62hOrmIGlacjJitMLKHn3cENJY2tRsMt
         +DDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788873174; x=1789477974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wz7IZrJW1UapIj7FlBxMC/F5YCmC6GItgtFzsvZAj8k=;
        b=hthW87jIhBpiiYGqUdyOInp+OnGrNnQhF0JAGo5hZbptZEDHh8wBlgpQHcO3UTkzEC
         07gDn972zCPflcA3bMPRGsta8ymbolxJQvPIT93stHJoq8ptVgiabFk+bNCq56SfFiTL
         gtW68dm6dGFaGQZ/LMnkz0jEFs3VHqbBZSTb8IDwK46YyOMkJRf1SYTVzAXLz4/XSs8f
         SOeowigjbhNE5hvxALg9uGtXbzq5RNtC3d1ghLHCQ/hXV5dra3pfqu3uTEquwmk8KiWk
         76GPum4CurFPUopsG712juFDnO2hR02ZLfiRcaZUbFxOFwhrVbZSxj9DI5Os3sC95N5G
         +9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788873174; x=1789477974;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wz7IZrJW1UapIj7FlBxMC/F5YCmC6GItgtFzsvZAj8k=;
        b=iCcPP7DTlbHXGOuPyuDZADfOIViZwzzKq7CA5/IGHX4kcofsoz0QvniY5J46T+hnpA
         jNQpVMzqbN8eNkRo7LhLjdaLLhDtv+f91tgvKLXLy+M6Q8W5qXzFGfWdwppEPhoxGm6K
         QbApL6c6rrHEl+7WsMSzRmHNFvv3Drss4oGZ4wFKwGjM+ASzmljUyfyaFGYUEhNuerQ2
         WMlIVOrZSSDIeg5liJXGzK6sxWdjcdvwcMkyhWgPIsE7hzb8LaH4trnsvMw8/hYm/xP7
         i5wjjOwsBe92OyKGnFdm1n/mi0mqhQdbCPxtJqBdK8QdvpkmGsVjtBmVFaJBzhdixwgN
         0aRQ==
X-Forwarded-Encrypted: i=1; AKwUvBztktWo/pEjLJF2nnDsyF0leNNw3we7/T4haTADJPecQQn/Vxu5PTc6soFXMlWKaHI/JR99Vw4aH4Y=@vger.kernel.org
X-Gm-Message-State: AFuF++myF/AwoZ4mYgW4gxLN4qWhvovvCZLOGWOB7hWOXboebpVQi8LJ
	O9umwTcARyAgXhzKqiW49ejihPn4vthLLSpeH5KxDq0KsLGwEgJnh5xwyznbUnfGHTfgCbDI802
	/zrHvpW6YLcSf/emDsipVuWReYrWKBo8=
X-Gm-Gg: AYBFou09JkqwEuqurntqqbTjjaHQDBYVMtSbM3kj9L3FCe1qUf+iQxmsNF3dEF+At+d
	ItZ9pVxwSi6NjT9JYTmJWuIXrRKZLbPesns9+8iwYirXUPCW8l912/+vAawsrfXyPUdQ1LR8f8s
	TBb+ev5qBz9/Jt7gO1FfYlZuCuNB62bEdJvho1U2u+Kq90eRSApd1cIHhy39PbtA2+8ZJDMf+ol
	fxpFPom7ywtQbES+DhpPaEDuXGOoiWVq8+WM4sT4ZHA3FGMbFeZB3/h9xFYFAzkCn1G3ezAmo7V
	JCJJY+REwbH1fXi3/Vw3TVGmveGbb0SJ+drX8t2JflC9PCjP4ePdsfdjJ8dSmBCcq5zV7CjaAOZ
	YV5pYJ74kkcH2YK1BTFQqyltvWY8=
X-Received: by 2002:a05:6512:108d:b0:5b6:10bc:dc4c with SMTP id
 2adb3069b0e04-5b610bcde18mr4681829e87.35.1788873173726; Tue, 08 Sep 2026
 06:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788623619.git.ahmadexp@gmail.com> <00b33b4b352848ff87dd9089190b35d8732676f3.1788623619.git.ahmadexp@gmail.com>
 <ap_mtZa1bGidHXfq@ashevche-desk.local>
In-Reply-To: <ap_mtZa1bGidHXfq@ashevche-desk.local>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Tue, 8 Sep 2026 06:12:39 -0700
X-Gm-Features: AcwNN1VS8bqELjY4qMU91gkD-1lcpNW1D8zk_hGJp1BpHq5sUsNQjNRuWPYsAHE
Message-ID: <CAOQiBWMAgBCd4ssAFOdHO7kkNKj=k_XH1SOasH2kwLxCYtRE4Q@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] i2c: mux: Propagate firmware nodes to channel adapters
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Andy,

> I hope here it's just a mechanical stuff and we don't have side effects
> as per above.

Thanks for reviewing both patches and for the advice about renaming
variables when their types change.

I checked all uses of dev_node, mux_node, and child in the converted
helper. They use firmware-node APIs throughout, with no remaining OF
calls or void * consumers for those pointers. I did not find a
type-mismatch issue in this conversion.

Regards,
Ahmad
