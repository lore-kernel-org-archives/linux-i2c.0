Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB4411FAE
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807560; cv=pass; b=Yns+tjUqunrwtY5Ld3PPHcu4tbBeHLJoFKbIrwQxpi4oreaenkmXKHJUdecEo8YUCZZ3bxCD6xBCYoZ6nHvRe6gNBzVvJK/bI1M9Z8g82Hyy1Bp1fbqw5S4jBzkk9GivYDH/6nQkjM1OtzJ97i65aCx0Y/q+OgIU3rCLeETorXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807560; c=relaxed/simple;
	bh=41zHe/K0N0YlTXyKVd4alQL08QPKvIb2rovNiRRenF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqx7azQjLLWTEqi7TmDgp/aB/ZIWbC2a4GloeT3pwgG4PwgQDO1HDw/UG5J435YDjbi3/KhwAHVAyKfyDOgq/ehHqn+0JbJNwu6GUVnIQJrfzqgDqY3Hz2NvEqRaX3ImGcpYc+B2ZEkrpxyOgjyautU5iu5y5oUV0+MhJjCzvMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxsunMc0; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxsunMc0"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1d00daaaso10383694a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 15:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790807556; cv=none;
        d=google.com; s=arc-20260327;
        b=ZES3Fia5tmMUObibPNaVXyl17SmgVeOVMfTi2CcLcVpfzFgkWduEE1LBCjywc1BOxJ
         g1OK6lMryKpRy1esMUda6gYQ0qEMU7qtuj7/6D9Q6CKULe7WINxCBCW4PcsunRJOGizH
         3pmzdXQjo2vXdMzx6OeEj2ab+WEjAYKy86rclyoL2FkpQxO1W2d+1Uwp/87KK6m+yqsv
         WPEUxTw9QPw3hB5tSPjQqUe61kUPmUlHiJigCvUOuPhlgo6FV/9Bu5YINs/zn+71sYeB
         1miNZfA/7qTaXxA6vcRkqYJlCFK3DbFiXjUAlgce1fXfpVlpSujLHRHwX1oRkjmjjTlQ
         l5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BKIG/76pbPLgFFPRNg72x+oOwy0I50VygoCLcB5wFPM=;
        fh=qSWfPUK5dnpX+7Z7LWaFRMkXx/N1DxJAr97WwSDv7hg=;
        b=qjvKtnLGmn5dQHgwKe4IZfT1ne3pm4Ad1chrI7B37Cm2b9pQpI4TqiA5MZgVeheTKj
         zjFcBqF/1Nu5TGtzqFv5soNjUeoQ7mZosOHaCfhK1Ik/NIA08ziOjtPylsA6c0MNSM6J
         X/zRRkUa2NSR+RPgjkunxO13FVhTPV3oxr2tzuzzez6mG37LivX0Oa2RRSERVA+H6BEz
         NPeKAqM5bRNqqCdZnFQx7SNwOwYYDesN5vZzF/sSoO/fi50yTSlh+YW2FV/5pcgCvB9A
         n2u/zmTyGtltHjBsk7jOdgaJyL1e3n7Mf31KrAXEeIjNPYC+EL7O7t4twhjN8p235r8X
         nErA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790807556; x=1791412356; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKIG/76pbPLgFFPRNg72x+oOwy0I50VygoCLcB5wFPM=;
        b=oxsunMc00sYDokCiKAqu9EnLkd3Ha2oCguW9tcgjPsyySE/nIqxZkl1QgKwzf2S5/b
         OCXelFmvjLb5daZWBSPRSjVOyItYf4LeSda7x5xQ7HxNEF0w69eeFL4XJ1PJUvPAT5JU
         bvpUeguizgAs6+tZEjKRq/hxNO71ugweswqBzV40Qz74PuN1PBLS8fXdyM2KvX0MNNf9
         KxPJIf1L+/d2qamkBJu3v1jpiSQAlDaxyr0kZ6IwrIp60Su4JD9HsRDqpEsGtbaFT/DF
         nBCgJjL/OFGgPSs4bupNfcj1PdwWzOEEt7pO6YSVjIPHNHzLaf5+2UHApH7Nl3DhR0mO
         RzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790807556; x=1791412356;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BKIG/76pbPLgFFPRNg72x+oOwy0I50VygoCLcB5wFPM=;
        b=KlvY7gqp/BAiXqofpagMMW8rxhczxigzIRrePbybTt7vmIqZkJhhKeqydXCD4i2kPL
         3h5qI47seDg2E1AWCFCgwzMUbiPCdDnlreW5ADZDI9J3o+xnqNta61FI7fdjdO9OxfCY
         bP2hRrYeWc5caLcKzGRB/4hSuqZNNezxFGl2tZEUBvz4I2l05pneJBF/9PzcMJvaP8Z7
         i7YhM960P1NF6hendKORuNdbtVFy/KneIei2EIVZ1SIzybP5W149JhK42XU8pM/ItSvv
         sgb27sC+TNSZ2hIzhjctoUxXl7hAipz2n852LT0r+E22huLCFTkdJg2xLy0Ukm0n0XEw
         SYMw==
X-Forwarded-Encrypted: i=1; AKwUvByuIlT1sUBTDDWdSe0CF/qjZTDTa7pqao+cihDEyGoxw17q1TKvcB3LNuGRcjw8eOu5DAEH9qVDPy8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAy5ni3IRycTEOnaS7XolR5sj7tyDk81yudzYmoohCjhIqiJr5
	fria87hqxIfKEs4P1L/aVDEJTvYx51YaDzH6IQiF+lour7WaygGyOIFQb3y/2psKCviKju5Mevb
	qT+xb5Ll2Y8i+lUHMagFwfi5L7+GZfmQ=
X-Gm-Gg: AYBFou0nZ8ktZxq6XU5nc7HF2nqxqRVgPgw1nnlEPC2kWzYFzBaB01igSk3fh6zltNn
	uRD+zzfE37emoJyJuqB8y5ubfLORbP74RGBi5vy/RuWElEc42R0fL4wNRJzr/EFsNLRs+zuScjf
	j37gIHQ4/5hSDtd97xxIPTFKEdMJLlGjvmbSlpGZHqx8n3sHuFC6tynulaTwPfqWUhBN6aY+olF
	r0+IasPAm+KTOpMZbY+qjQtkurzQyk1iTxE/MCnGvdxRZiTYWVtEqFBrM+UKg73SwbcyNsutrUZ
	tJk9YKg8vXyYEbSsmw5wPZwEA3FYsAb68HwIZjzROdTF4OGwvB+WnMfdSXm5qjBHppdiC2sYaRS
	B/LTe6tLYCjrCv0MDxM+Qm/g3uoW6NeYlMd+Gf83nRA==
X-Received: by 2002:a05:6402:51d0:b0:6aa:9f53:221b with SMTP id
 4fb4d7f45d1cf-6ae1988fb77mr2014945a12.4.1790807556270; Wed, 30 Sep 2026
 15:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728122423.358416-2-simone.chifari@gmail.com>
 <202607291626.TnSyWh0f-lkp@intel.com> <arwp1oCq48PBVmNx@zenone.zhora.eu>
In-Reply-To: <arwp1oCq48PBVmNx@zenone.zhora.eu>
From: Simone Chifari <simone.chifari@gmail.com>
Date: Thu, 1 Oct 2026 00:32:25 +0200
X-Gm-Features: AclHuK_dMoVuR_HSmOdtup3JFWShsutsoR1OXuAiRbxPtcD_ducDXt7oVtB0A0E
Message-ID: <CABe7xuZeeVPHhrU77M1poZnjVmCHb_84782-wrWmo0cWdDCWiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] i2c: imc-skylake: add Intel Skylake-X iMC SMBus adapter
To: Andi Shyti <andi.shyti@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Stefan Schaeckeler <schaecsn@gmx.net>
Content-Type: text/plain; charset="UTF-8"

Hi Andi,

  On Tue, Sep 29, 2026 at 11:14:00PM +0200, Andi Shyti wrote:
  > Please, be aware that with a test robot failure or warning i
  > don't look at the driver, but I expect a new version coming.

  Thanks for the heads-up. The warning is fixed in v4, which I posted
  on 2026-08-08 as a new thread:

    https://lore.kernel.org/linux-i2c/20260808212414.217511-1-simone.chifari@gmail.com/

  The interference check now casts the complement to u32
  ((u32)~COMMAND_OUR_BITS), and the changelog carries the Reported-by
  and Closes tags for this report.

  If v4 no longer applies to i2c/i2c-host, let me know and I will send
  a v5 rebased on it.

  Thanks,
  Simone

Il giorno mar 29 set 2026 alle ore 23:14 Andi Shyti
<andi.shyti@kernel.org> ha scritto:
>
> Hi Simone,
>
> On Wed, Jul 29, 2026 at 04:22:57PM +0800, kernel test robot wrote:
> > Hi Simone,
> >
> > kernel test robot noticed the following build warnings:
>
> Please, be aware that with a test robot failure or warning i
> don't look at the driver, but I expect a new version coming.
>
> Thanks,
> Andi
