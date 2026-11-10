Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794341724;
	b=QB0ZWc3dijLfDLGjzF4tLaHOrwKSRAphGSi12ySFWNDhWvuEMtTxUNAd+7jhPZCteW5r
	 cmfbFZWpZ7sC8vtK1DT9T95Xdi+uTd/qLsEll2FMyKd0+esTvI1nW5XAOa5D/m+fQS2Il
	 ydjcTghahiWm/gRjmYzaA4D5EZA5GajuoBFg7TGR8rFISq/75fP5nxyJP6XKDs/f7bc0+
	 khU+9MiCyhuvY8H0AG1saBJH+3kpU+vNcfpAtyIBsNLbLhnsV0NhrcHgaTJlo/P9VVZFE
	 5G/WrXFO0+cvJPMky6wBM+oHl5r5gCosESPYDYxst/kYRYR71lT5dSXi+s/p5yCMmSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lJiT+8IpY9D/26sFc0x6AV66fD9LP1gmMsQhUCQo140=;
	b=P4G+Im8eEGVuj2aKDDhbYSPlJiID48oK1YvYAZNcKVc9svmZjxSQ8In1PI0be5vxMn57
	 Ru6NOyEqN3KULfaAg/KHSEME7ewjLXgwX+rqW6RPy+G67HJ91QtOcDldYzRrkqRJb1zTO
	 doetP1toY/46xu1ZKqXS3ie26ua6s2dyXkQUU1480FWzYbwaYh9HchsS3248I6TkqzfnV
	 5AbGJGDdXRUs2xvXXU/e8BiX647EVGAfjME7MUtpWXJoVzH3s2pqjBYsZehxXMNmu25ae
	 scYu7/2VIsTZocGwluCNyIodx9FQhWSJIb6fO0GaU67PGxStrQ8TEvgwjwtYL7NITJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vi0rRR86;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39470606A323
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 20:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39470606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vi0rRR86
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b331cad3cfso20257247b3.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 12:15:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794341723; cv=none;
        d=google.com; s=arc-20260327;
        b=Vaf4glRgLrYBjwXS0bYmS1kmcVYdrU2zCCn60Fn9OIm0mse6Ry1A7PIqzPj3OAb8l9
         N3CIWRKwLP8i/aGoSAG3Ci0hLoOeIaZIzaptxV2pwn4HMHYr7M+eidjJ2/02krELhP1G
         PK45s5jyjzecHjGRenu/Rgu1iQJjfh30lurOaOK6CaeDYVzD1aj7Eo4cypCY3kd5T6Q7
         JA3O/0r7FfEy+AnESUQEtvpumDMaMduNy/+KccvioifpPwsX2NfQk8E/PMDnBqbpXvDD
         AJs1XhU0SfwiNVL6E0/Y4tyHzCLjNALWVjqrqMGqlAtOHLu+F2MTLQwfHPraPHXoY5yd
         CBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lJiT+8IpY9D/26sFc0x6AV66fD9LP1gmMsQhUCQo140=;
        fh=/7egGulqOdqQ3sELiaSF7MKGYH7/xToufcjb8aaZdJk=;
        b=l6r3r9DKcPBlyrKPwZVR7t0Wt86jaQP6wlHGbuahoBzPSF+nJH76Mh8Y31gHP3vgtC
         SdvbiFE4HRXTXirGi0YsVHFsXEXBMsEcNxdtwOhFbhf3OmlmUOGprf+kr2i4L1UJ2oCP
         69+UaIy1iS3D82XwlTrIxZn4FKeK55B7J2yh8unuAg//S3CpF4vzkNE83qKnFsvQsRsE
         8tUCQkqk14nhIkzOt/ezSE1Oa3O9jFfim2Gq+XkV338AObNAM2vVQTk25kf14H6aUswk
         kQt7KDwOkv12lmnKWC/QYJBDliiu8r4BDAiHx9u+Ukjq8kJVOURgyxJuYYyBOVzvnF6g
         fl0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794341723; x=1794946523; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJiT+8IpY9D/26sFc0x6AV66fD9LP1gmMsQhUCQo140=;
        b=vi0rRR86rLgaCrpxolO2NCtTdCGuzamlnVzJOpe33bEraVmDP6+GWqGypTu5hO4688
         gzEf8o0cDiBwAhmSQXGSlZTrXEjGYDy14awolWCbz0qTb2KMpsGWyR6DYNYmAUgTlDCU
         CMk5thnnAmX3TK0NBjNMaxg7r/AvXoH82dYxq6HhkeOnfsPrf3IJ4y2ksurH/ID/+ju3
         aPYuRRCxfQ/ZZFhAwNy64a4/HX3546ldnSlmP32BJeTvbP5dbFyY9n7nb5IUAc7TFP+F
         jUsQUR3zZp0w1VanZ4zM2Ju+hQ+5r+2XmtEcx0BCwY5E5KUAtMw4H0Iy6GvLsAGB7idx
         7w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341723; x=1794946523;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lJiT+8IpY9D/26sFc0x6AV66fD9LP1gmMsQhUCQo140=;
        b=AdCCmZRWP5Q7O+ISb8mo/FMUh6GNvuQIYCvBZuHNjcMid0S15qPpoIPHEbLDYldy28
         QU0vHPSWAZEEg8xVlK1Iprjmr+TjzP0CI94PYodX+PNhtukqp3r4JwUkpo0ZULGu2zoh
         bIqcGA5Wra9PLdTbSPUesyImnwKLUjK+5SPalwhl0ydSvrRQKMrLxW1/NzlgfvXVvhMb
         4Unb9Qtks4Q4bsj3SbWR0netOpvni0j687QmorQ254BAA/0SdPkoPQDg6qxTQR3W5AKw
         N1/SV6KCiSyUDzakByg0voJEQf8bFwIA08PEsS/FgqA9ws6cdDN5CL5OjM72rQweK9Av
         Np5g==
X-Forwarded-Encrypted: i=1; AL+hErE1VzdxGAGSLIbOCkSS1RVKEaQ+luW+NK5dLemVjc102Wm9uBNsfI/VtJXVoAKs5xZpkJHzZgNk/v0=@vger.kernel.org
X-Gm-Message-State: APuU4Z81HnOOixWrp3nnYs0vebotnyGiFspdW6oWbxxmIudYbAnHpb3i
	CCORLzmuTst2KuUf4PKoM8lwySh7fpHVLEFxhkfc1NdowkrFnPcIgtuMpAzY0R5/9/upBoj6fFB
	SiYdR+NITaRogZ16XDVq0yR8MqSDLwiI=
X-Gm-Gg: AYBFou2qIxDQq3QocAVIdyqdiS0SzDdH+MHFZTQkdzgU/t0XlHJTvZseajZYLI97zZv
	Na7KOudiob+6Mqqci2iC4mbaNbKs14y9ePEJgOyMmnB+66AkdMYrEoBJw61moWrehuOkmZXlYvm
	Kql6xFfqexR41dCo5hHOtrFqWgPbxX7DVvgeDikUZanT6xn/HfCvZTx4fhLwltEQDmAcWQoGWKd
	Rl/gP1i1+hClp8ASzE1nlOGM6+F8Y3ZyC5GfBJsyqqGHhyKhMNm65DwZFdhqUoP0FctR+z3bQII
	Ec2dNQOTNwgvkYS+tQgnwuj+UP6g5U6FPPEehVlRytZqZZ6Hb2lZlKdqr6q0nggpWNTqT3rehuI
	MApxW73hy6HzMU0XoUkVw8jL5dwyiiZHKhzDslnwAg6B9Y83rLTsdxOLlfYEgWEe8TjADTip5SE
	I9l00foEVoB/Z675p3/JMz50SZknP7cprIRPLds5NpLGqhroZVlV2SF8pKZ4+1raasLkX/HkO4C
	HEvMHA/4A==
X-Received: by 2002:a05:690e:43cd:b0:67c:28fd:8f1f with SMTP id
 956f58d0204a3-67c67f77ab2mr227205d50.57.1794341722999; Tue, 10 Nov 2026
 12:15:22 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109210146.57766-1-sidchintamaneni@gmail.com> <avI7g14oGpFKlJnV@ashevche-desk.local>
In-Reply-To: <avI7g14oGpFKlJnV@ashevche-desk.local>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 10 Nov 2026 12:15:10 -0800
X-Gm-Features: AclHuK-s036JOQbw6HtDykqOqg4xoznKSez1GVAhjg431vKNmBxRayoAL0gmlkM
Message-ID: <CAE5sdEg3VKZuGqpt1Sm22Dsuh8HUFi-9w2GWEAicALS4ECXQ_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] i2c: designware: Add ACPI ID MSFT0006 for
 Microsoft Cobalt SoCs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, apais@microsoft.com, rlmenge@gmail.com, 
	hargar@linux.microsoft.com, Jarred White <jarredwhite@linux.microsoft.com>, 
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 13:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 09, 2026 at 09:01:46PM +0000, Siddharth Chintamaneni wrote:
> > Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> > on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> > in acpi_apd.c.
> >
> > Without an explicit MSFT0006 entry, ACPI device matching falls back to
> > its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> > the controller's actual 300 MHz clock.
> >
> > Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
> > Acked-by: Jeff Kirsher <jeff.kirsher@microsoft.com>
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > ---
>
> Where is the changelog?

Oh I just dropped cc tags.

> Haven't I given a tag already?

no, I thought you were suggesting that I repost it.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
