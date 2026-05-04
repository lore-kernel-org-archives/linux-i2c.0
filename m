Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BDF33FE1F
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883466; cv=pass; b=AtrQg0bgJrg0nPU7dXtomYwRA0HiF1e4I78jtRIiGMg/CPyVFVOFaVo0OgVllNcRGMvowDg14qv70zt6WNschqNZYts34GhEBTLLVizU3N4p5v8G7TNXWs0wSBygdnSpsEWSx8AYUT4Xkr5mZtJ8rKNxk39xrMYalSh2PkgaQLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883466; c=relaxed/simple;
	bh=h2ln3jz2XSiQPlSzizSSg4UuUtOl6OzqKXpUrWbUC0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYEmKYORLwdNQLrstgYXI7Ojy8zaBc7D8qkk4YTsTn7uDxEq4tNwgeJ7d+wGH+NniimbHyfEhTpKLrVkRAdMMea4i+l5LzQ3vY+Od33OEpDBHQD0bernmrdjNG/ps8+bnnvnMUTTaVW2/0uKngiRdvnThEgoy2NGQ5nbem5yCes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K8iKDb3n; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K8iKDb3n"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso4177885e87.1
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 01:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777883463; cv=none;
        d=google.com; s=arc-20240605;
        b=iVv1QJU7bS4jTP3wCfo3a9V2/5ZU7mj48PD++UgzndbrLcov55gNLb5wwRirpmWmhh
         UZyraU7qUFXXzk5YgwRTUOKQbu8PrjYkrhCHxiLWS8YN5UW59Ne5G/lPjQLsZ0vHGOoS
         //Ype3JCnT8CH2MsvseGtv4AOENkOJ04yaTB1OSY7hqGdKZ8KKYrBuFVWBcY8slLi1ac
         RopnFpWu5XXH2r4VMMD9cgUfUS+qkOK9JbXDsIloaIfjBK0wlNY+xX7v1xCXlBrQRbBr
         7NCOJgFTXHi5iJ2Lity+rI9lMew8wzhkXO9Dj+OWpLKXugI39/NfDxmNGwL9ZaW0ry6x
         qXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h2ln3jz2XSiQPlSzizSSg4UuUtOl6OzqKXpUrWbUC0c=;
        fh=drZvLor/eDgQ0W8wggu62veXqg/IX+lrNazxsoV72DM=;
        b=A+cEumBHrsNPx/tmWi21o6szJlaQtZZeV8YaVjPVm+AeLzkj4xCtXPwbinTNhSbIqS
         sJn7d0tJqsCg9o9ktWdfDte+QoX2hrafzRF/9/3r47rBVDYIZ2oSW3/DvEs3cclIHLu6
         JtL/muqpmW/v+6kUrruUMoN9sGQqzaWt17GNEAANTiknPHkRpjmrAlHNdltnR+tf2LMA
         v2pCzFggcfN7Y+v4UyCDBpLVd72RVIfpwjNsZwTgGo1hbU1FrYutshOh2sMsZ8MCrgos
         7iVfzG7Z4ADtrX7CRVPSKSiMYqV5xV2iXpPgPdRHKfb/vmk1haFAplcdF5kIS6CZj51Q
         /Trw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777883463; x=1778488263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2ln3jz2XSiQPlSzizSSg4UuUtOl6OzqKXpUrWbUC0c=;
        b=K8iKDb3nFLuVPPBdTWW3jwN3cY1R+jmKtciiEIUzE2gHnlgUjJaIM+uEKVijxaBCZC
         Kh1yRrAhOiOoVKomMpGz3ndi+tY+F4lT8GJKdbZqgZXo88hMMyY8nZXTNta+Wmy7q5JT
         93H6d/uxJ0ejVvoDHabFptE36WT8MGuS3edlybZidaw5V5/mL+MzP7xeSdkBMQvIFd9F
         coI0U7JAGu3NWo7Rr8K3D4CR3LfAEQfX9Dg2sBUzzozuV64rSrZ66MQlSMoPPAORjj8V
         qbt1HmzhiIpNCf/iEGJdLp6zQ0OlKt+41kizqbNDxacQYlT3lfBdftubkVgtHDpsqxEK
         DXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883463; x=1778488263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h2ln3jz2XSiQPlSzizSSg4UuUtOl6OzqKXpUrWbUC0c=;
        b=qU0LugMZO1rP5A71tYFUUF4jf5VfW903DT2UGKZtS/H5HCKBlP0OU36EJPvYUybesd
         TG28VYHGqCpXAD5U2Mk/qk6FoxRsBJGU3SM7wieCDchqqiX429MQ9HzcgKw28ZuS7v6Q
         qfA8BVs4F8RTgjSyghS1oUAvYK3bS6K46rcEPmwCoMxMKvKh1MnyKwpCvbaIobFaz8NV
         EMU/sX+tWk0IAcBvFYlJD5mtxHVxpAWsb8B4nZLO7lYKGloI/AWW0bJAHhVKyJY1Sq7u
         8XY0ouOjotrDWUHN/ixj9lWCJYnnEtVt7yZoq6WVXChRyYKNhUWZAWibgDynthi7XVA8
         Ajmg==
X-Forwarded-Encrypted: i=1; AFNElJ9LzH39xNjpvMBlqI4JIL7zPdcwOdLSuiSG9sX7qD8mVVYZzDQHxUwD9aXplWJztc7uWDylvd9EtLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQmb5q1knnyDhiUE2NY9rbABc3piFKpqmRZiNaTMFb3MsnHgP
	gEr3r4gaQgTOOCtbT8oEs2x2ymMdoukdiCyBbaF0fxbYoTGUELUhfI6032mg7jqTZ7/fjBZzmMH
	FgRfX64hFctpin9hcv7a+SHqmxqxbip+4wc7lGcM2Kw==
X-Gm-Gg: AeBDieuvbXHOhEO77s8qEIfO2AyOWl8iXijwzPQ8XvxvRDWhYvr7qfcjpMeFdetKKj/
	OWb/XstyZIC2PXW7ZD7j8z5S0WElC1ecQC6UlRwWN5O+i/1DVim9jdy+RZvSnUWfFfn7sRXtAwy
	r/aC6FUbhhMS0rugpV4+OL94Js2FAN/ExZKPJDMbWOKlC3eotd7pedcjVSED0YNsFCHOHNuss+M
	q+LeaHPuDdwkgnXRGwsgHszFO+mhLW1z+QsN6wi7Inkq4egHlQ4C7vkmxPKlSG7U7C7hNPp4dHt
	J4p+QLXdoeN9XdaVv2P+vGPOruJzQYfqK1IW81QK+cXSt0pKpKQq28ofyiYR5w==
X-Received: by 2002:a05:6512:2310:b0:5a8:757b:80ee with SMTP id
 2adb3069b0e04-5a8757b8206mr414306e87.17.1777883463576; Mon, 04 May 2026
 01:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430090810.109232-1-marco.crivellari@suse.com> <afhTvm8OmSpj633b@ninjato>
In-Reply-To: <afhTvm8OmSpj633b@ninjato>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 4 May 2026 10:30:52 +0200
X-Gm-Features: AVHnY4JDuzMghB2w1R2IKo_b71kWBn6jzRW6HZf_PqAW0hXQwr_ovS78SjIZ65w
Message-ID: <CAAofZF4H89S=eA5GF3b2MKscij0yxj_bREWq7LMxi2L95vR7Sw@mail.gmail.com>
Subject: Re: [RFC PATCH] i2c: testunit: Replace system_long_wq with system_dfl_long_wq
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:07=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> [..]
> Applied to for-current, thanks!

Many thanks, Wolfram!
I completely missed the FIXME on top.

>
> BTW, what does _dfl_ stand for?
>

 "dfl" stands for "default". We're keeping the same naming convention
used for the
unbound workqueue, system_dfl_wq.

Thanks!

--=20

Marco Crivellari

SUSE Labs
