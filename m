Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538553672A8
	for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738327; cv=none; b=KnxDKyJiSLKiJx6S4ZPVt9EOBhlDxXB6BHUdRRvu+gpFrmNdA3u20YlPbxN0Wnh5M2mjLW9cZs4dAsqggrt4yPCTb7vP2PqiUa7kuvS0GXXoY3yUi0TLlJl4x5UnUbbYJRSuYS5Bn0HYDZCtrk6menga0E3AJ3hw1TePa/GgotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738327; c=relaxed/simple;
	bh=UHJGAO5caGRcGvQXt1/8l2kXfks8BZV1e1Niz/GuoHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro7/TlAsLTAaCNC+SThlqNa1dI1+GX3asXEn0LKzICtjt9drRxGG7GON9zmp1073W7tGQauOFFfiw3j+LyGq3P5w46FT1KfdEmSIUXY0APXOgvPItKZoFjSenfYExJQLAwNKdfvmSfFgKFM6IxUGvSkrMKuxq3ksokmhEEejOho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUpbJ+cb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUpbJ+cb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAA31F00A3F
	for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786738326;
	bh=UHJGAO5caGRcGvQXt1/8l2kXfks8BZV1e1Niz/GuoHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PUpbJ+cb/TsoHjKfXBv2DUZ14q8a0SQWmDQzSkEoO+fzbkdKNw9teK6UMV0sAfVke
	 qolNJGlACm65y9qT/V859HJK/CrcLK//NYTN7adKF9vQl/Pej0gzW4aYGOFlPU5IoU
	 JS0qY+/dFL+jrOPTgZ/tT377L0qHG/17Mj0A6qmJ+yusahhjSOH8IKR3mpP2O3t6Br
	 0mtCWojKvf4jJle0iyTnWyjCziGyhmZBC1PPlAFWedNfSl5m4tAm0IC6sOOHGRCk1z
	 J+e17q4AlpoR7u0foJPYbbrb4CToVS67p9xxwxv5rZgxbsKdRxD5nUd1cQN7so+VPs
	 vYtXKoKLeTTPw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aea0fff535so1457611e87.3
        for <linux-i2c@vger.kernel.org>; Fri, 14 Aug 2026 13:12:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp84Ly53VfegbzZnoBSNsgEaKagY6SyuHP4FOC1zqSubGCJcriotuTOeTs/QeVKR7oEmyHDXYDtoT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+rGVMLAMkio/AsJbtIlfyY7R1NbCKn7bGvz38ZhgreAyKV+KV
	1pAhUnzh+gi6OJ9bGBUEykGCPgadWQ4LN/6IReMLCOkTOG0dSOWiasZ0xlwJxJXHXWKSxiakKiI
	T8f3oOMjoFSe+4jSUhCDiupP1OKfnE68=
X-Received: by 2002:a05:6512:1304:b0:5b2:a31c:378e with SMTP id
 2adb3069b0e04-5b45919019emr1071334e87.52.1786738324476; Fri, 14 Aug 2026
 13:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722073031.1078080-1-clarke.li@hj-micro.com>
 <20260813063005.42925-1-clarke.li@hj-micro.com> <an1zzWb0mpm1huz_@ashevche-desk.local>
In-Reply-To: <an1zzWb0mpm1huz_@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 14 Aug 2026 22:11:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jMWgias-Xf8oArXtb9NUOhKw5GeM3y=y+Soym+oRx5ZQ@mail.gmail.com>
X-Gm-Features: AUfX_mxGnMOIDgEpDrKV742_u8fA6qOAmED4ouBrNyj0ggkFTsHx6Gm8QOhmXOs
Message-ID: <CAJZ5v0jMWgias-Xf8oArXtb9NUOhKw5GeM3y=y+Soym+oRx5ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI: APD: Convert fixed clock rates to use HZ_PER_MHZ
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "clarke.li" <clarke.li@hj-micro.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, andy.xu@hj-micro.com, 
	peter.du@hj-micro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:35=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 13, 2026 at 02:30:04PM +0800, clarke.li wrote:
>
> > Use HZ_PER_MHZ multiplier for fixed_clk_rate values to
> > improve readability.
>
> And actually increases robustness of the code as there is less chances
> to miss a 0 or have an extra one.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied along with the [2/2] as 7.3 material, thanks!
