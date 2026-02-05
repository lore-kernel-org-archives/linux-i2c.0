Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936742D191C
	for <linux-i2c@vger.kernel.org>; Thu,  5 Feb 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289009; cv=pass; b=Pr5Jr4Sdt020dF4CDTaZ+UD/DRQbrmNmT4AQQ5JVfXN17xNvqhhU35x9YPUwQ75EaxWFTymXTcrgJsVO4P+cV3wgzqXmtSAjEFuuiMTzEsgEmENPJKwKhWxuetwPNLtSYY2cvekCcjog8xs6ATmdHJJSZcKg2Dr8oZ8b3qKBc3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289009; c=relaxed/simple;
	bh=PQ0XLxJEHR+xjcoSbv5TfmjPJq/RfvUrKW0NqmUEhOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dby4qRz4VaYxuCc5gbkxY42ctTbglcrucnWNBsJNOuQEHG4PQ9P9L5U+ElJqjKDL0Mg3vt8X1e99rU+A6yHK3Yppk3MqN0TQYgTMRK1cWFt95zSW7MibOcNcjQ0Tf5BcQ2FIyijO6dV5zMetGDeQQZirCucm/YCF4jUSuAJltK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH1o5pt2; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH1o5pt2"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b872f1c31f1so98859166b.0
        for <linux-i2c@vger.kernel.org>; Thu, 05 Feb 2026 02:56:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289007; cv=none;
        d=google.com; s=arc-20240605;
        b=SJc4g4MT59KU2pyq5N/KtIbbtV3oF0HxQ21eK2enpKnbme+/3wb3aRvNqghtH6RBBr
         aSDqerz4DZWzk4OOflepbe3I/IgftVULlx9fqU5vY3TzHCVinufWZipqOrmFoNexOSoZ
         4chG5q73mKySHMoTcVYCa6ZcsDKWg7dSq98JI3/86dUMbJRVUewwjY9IvTezIc8oxLCr
         hosierJ75XuAbLpzoaaMlgoZsPSqjqQiQf5FivgIq7RpmGyPECqSdmd5lw3DLC+j3J7f
         6KMFPf8h7F6mG8yrTUNTMOFsTA++kIV/P4xjb++94QwzGK/uG2MM59Bwy128j4MKjM1+
         Qntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PQ0XLxJEHR+xjcoSbv5TfmjPJq/RfvUrKW0NqmUEhOE=;
        fh=QJa7gsNAxzz8jx4A3V7vnU2+b/n87kxGWZj2rWodAWM=;
        b=JVJoNjT8ofyKLKVSzaCDO/nObpLq6sheLsJf9rBkEk6pJxO5+sD4zHvsFJLWVNPr4M
         s2HDGh6is9EgSLTEN6EZrw4XgM+FCaYAEkPgp9X5aTKBKBUznsepky1aXgPbuRrMOwcY
         s9VFRHJWCABCQ4NUKyogwJ2E7YB6iSJ/m+DWTkv+Frr+SF02n63Z2v8cQRNXJgLuYnTM
         pNg5GqYHygt2v2FeBhR7DIU+CWdFU7HBL9GX7oMWI9la0r0kA1vpJqHvuP5xEUpaCJRS
         dZ4XoO8x9/H2i3q8Pmw4JZyK+jYVjyt5oDKciMaOX5dP4vjlCfZJcAuBvIVhs5zoiZE3
         la2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770289007; x=1770893807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ0XLxJEHR+xjcoSbv5TfmjPJq/RfvUrKW0NqmUEhOE=;
        b=kH1o5pt2aWn3pEyfdmmPEXtn9oDNDITAuO6zYfy6+N6h9TFDKajViACHBjDTi2K/F8
         L6opQ5DDelowdGg32JpyzLtY7GCxj8IlWXV3wxC0OpNT/L8hK/RXNmvQROdRCshLy/4M
         6JBsFctB8fhVq38L6GG7zcsUgee/vlNgRJJQrzO4/ujm+gDFh9T+PhaueSKX9tSPBsjy
         KhG8M73J3NXcAGGGFfT/zMMBp8raR90uMUq0YhbQkt9uWoMtKLqCgkkRcRv80Sz/NCeg
         e1BWdnmgEPgzi0zJNQ7h/hcdfA7Au7zZ0oTHVB+uInAK1I27TgBX9p7babDuHiYtp+eG
         WM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289007; x=1770893807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQ0XLxJEHR+xjcoSbv5TfmjPJq/RfvUrKW0NqmUEhOE=;
        b=axpnavTx3/LVnUTj7wvVlF5SwaCwq0BVON+TZDYPJE4j7ptvsLJ0Ek7MLiBIWL+8P5
         TUrPm4ofBg+6W/DivgRLZAgQ06RiimMJ0zwO9MM8a4LaUbxf4BUHZd7Fy5x4zWDpKa6V
         T2AXgUoQ4LRgzfiRslK/2d1rFUeG9so+OFB66fV4r1lfmBQdFuiBkigGQsQfrIHh4plS
         HcJUWwNfIgl5dDLk7jn82Pgcv3XI/CBLcfUraTTpkpdMLYzoz+RRN/ANeyjwT11vk3bu
         72WkbMrnKJPnypovLb05xSQWXNLfIFuZNJVTNV1Ka5HDzaQ89nfe+dxN3xK0uAEuTH08
         +T/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIrS6PDRQ49vJJZlI0nzOVwj+s4cinm1WApNgWzFuqr/GZyX4/1u8PXZKJ9nev4IGbGAv29CEhKGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQkmPkLN/D6xgahU1VsKWK+UMbPzmsYuP1i7kAeFE8G3DTDol
	neYg3Rf6ExOJ1r8/3rgEydfsmpwvN1NDjy9fWQ3rt70LeifednXd+1MvuAH5HhiRfNlRhMgyQ5q
	DnoFaFfZuijUPzIw7zYDsXH88WcxgK+Y=
X-Gm-Gg: AZuq6aK7VJBkmvbMbHfBbcSDBhGu0WklkJe6Yb5xuVl/y+hbzmjMxuQ1jU6am25MfTG
	N2Nue72jfxfEtFrF3HASYzyAXC8IAD6h8O2KKBa/OQWAP6RT2LmJTziLpzuQDqMXMyg+15oJPlF
	EvltStLzZzVak/9MFEUVQHoKes4xdBvUqVUcXwMkT3WXRP+GHBhcKw/iaUBTKGClmdL2B78ylE2
	L4P+AHgM/OQnCJJdAVRWghb+KONkqy2Qlw2Iit3CIGKe01VUH1tXgR6ViGsw07WyG5Kc/PJBQ==
X-Received: by 2002:a17:907:d78b:b0:b87:1669:de1a with SMTP id
 a640c23a62f3a-b8e9f35d918mr408834766b.64.1770289006690; Thu, 05 Feb 2026
 02:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
 <20260130111039.874548-2-a.shimko.dev@gmail.com> <aYKj31hi1bF4wmsi@zenone.zhora.eu>
 <CAOPX744QCxpXZuVDfSHkw44SGe+Pr=gXt=MetcK22C7aVrv5hQ@mail.gmail.com> <aYRwJKdaleP6R6Qe@zenone.zhora.eu>
In-Reply-To: <aYRwJKdaleP6R6Qe@zenone.zhora.eu>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Thu, 5 Feb 2026 13:56:35 +0300
X-Gm-Features: AZwV_QhRP0O_hO5_B9weOUAdmUZjUOW8JZJmQfB1-A2s40j6zeyPqMw4-Jc8qx0
Message-ID: <CAOPX745UE7MHGHCOoDU5prf3orGM=nZMUwqGUZ19kChVDV04=Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] i2c: designware-platdrv: simplify reset control
To: Andi Shyti <andi.shyti@kernel.org>
Cc: p.zabel@pengutronix.de, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, jsd@semihalf.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:27=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org> w=
rote:
> The patch
> is fine and I'm going to apply it in i2c/i2c-host-2 (it will be
> sent as a pull request next week).

Great, thank you!

--
Regards,
Artem
