Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1A3C198A
	for <linux-i2c@vger.kernel.org>; Sat, 17 Oct 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257473; cv=pass; b=KieVzBpNB8pX+3FLP8zjy5oiDzvKEkUp8fEWdCkcT3qbw3a2G++1fjjPVccLK276wpur0AebCSug5Q1Ucdc7FmaSXSeKn1pj1qJ2Erj6t76VU4yttX/UVcNV0Rb8mVhwfFmq/6p/lTmuB2QMxqYBYRsJ9YaxbaW+OXo8ScbdKfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257473; c=relaxed/simple;
	bh=w2T8FHdfNF5NvbmlR5/foiz0hmQwj34PxDR30yrTsuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQdxnWbHm2R6cY7FCJE38pqHYMWfRfEPZacs6BKovoKOnIjAbGFISqkZ361gjnhDNEYQbK2emj5eTRg3buRabspQHHrIFd96FkaFJ7+xnRhDtnFEWC94IceOo12vIhpg+aJfpzYbwVgAyLPJSaeM3upvN7va8+WLR5cS+rkgpRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBH9I7To; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBH9I7To"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35d7fa491deso1008196eec.1
        for <linux-i2c@vger.kernel.org>; Sat, 17 Oct 2026 10:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792257471; cv=none;
        d=google.com; s=arc-20260327;
        b=ewPLJX75ceWxPEvbfXtvmOgOi44/tiyJj1S6zNOQrdAZ3qGItYGyKKpAvqk/mKN1Ku
         K4B2U/k87/3W4CG2GxBppEj33j+dC5B+0OZXtCdSuL6j08ol3BjdsAJ/uStWpHfDebXk
         ih3axvXNQS2V9KQBW56ucB/YdHQ+K4uM/i8shp9J5HIF/nvDzCPkQKQg2ge8XVfG6V9f
         rfTeKyo/P7lKy4MBkUQmqDIWuw+PD57z/23uD4fFQ9+QR8yPxcHXT9/4xVC2x522NyIk
         R2YtKN6i1UN9nss+T83ZXb8mu+ZiOIljkgvpuUJArHiKegXb5LzvzkcuLyA/1AFJAaqB
         KRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w2T8FHdfNF5NvbmlR5/foiz0hmQwj34PxDR30yrTsuA=;
        fh=+UpPlDL44FTrhvxSAgFAzxz2vyRfXeU58Ts02PWq4YE=;
        b=ad/Alkvb/n6+2bN5aFf++/1xUUgYLB04/Q13BXWF24zqi32Z3bx6Iu0XE1tsOOkU7Y
         2O1sAiJuRVnZWlqItgbTH8Hdqv4Wno9oD20A3wlV7BrySnW/AODGA4spGSV7pLJpPzuq
         rq2Onf6UEiL4UuTSa4TvyUR3Y/2tTQyfd7VDxOYER+XCgoI9edCqfU7Uhmc3ouo2nRwI
         OA0tWHIhvSXtCgxUvkYaXRmSlXH1ovoyDGJA4rINGh9xoH5AhQ5vEY32X0K2aN7ZOSoJ
         Ta3TBKwkJNdC4rGE/olTdfKF+JR25Qeeqt+MMS2Tveee+zKPLy3XsU/j+51M65uJb2r+
         USeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792257471; x=1792862271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w2T8FHdfNF5NvbmlR5/foiz0hmQwj34PxDR30yrTsuA=;
        b=nBH9I7ToBPazLmK4KOED9iC1+yglSlOE55oq0Uulb85R/fos9Gr7XiHZP6y5PqTPBX
         eh71OlUqwhxhZXnJ9Fx2bbyP+kIUT5QRd98+ewhSvPlOtiK8Pw7KYu2LqHQe7E69OJaD
         4SzH2wAJ4kD7jSbR6pCQWeehND/JWH1N6PiYTmhgQZd95ftKmO0Yx9Uu44q6AX7Jo0E0
         MqnwxiVDeXFEDkgZG4tP+XZ/Jz2m/AyVsie76xAtda64h0IOuG0rkwgPolikbsEroU2D
         LFK8fQJqKcsrS/Yk0bDjYDH9VNkWNH1Qdf5LS/Z3tZUOoGU6epxkEkuexeD9SIqz4M8D
         wXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792257471; x=1792862271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w2T8FHdfNF5NvbmlR5/foiz0hmQwj34PxDR30yrTsuA=;
        b=YvXrYs7gYTp+7kwZFGcjJ8lqFarQoYuR40kDuOQ/gqV89IBbMkG3gXQJt2q7Fdtqv7
         sDNi0wWOREINndFHrPr3t0WIp2eLXhV04cIVMoIC3N4LqTgk0fBfLDw8S70JDbCMt+n4
         pQoVwlQp4TvEvS549cIgKNHioiSoB5+l0wXzfxJERO6+hqkfYW96aI7lZPoh5aSqDsba
         b6RsMYiomxvmtudh1MHo25/yRYBDpnjejkqkM9rQO6Bq7jMyX4YWoWb7cc6WnsT1nWRv
         tcpDIpGG0/60czCgfM3qZn9zXpqK6VVCIdLBNn/sgXlkMN//uRyBUeyF5510AYFrKQDO
         hG3w==
X-Forwarded-Encrypted: i=1; AKwUvBw9gVGCZ470pIwdlpyjlgoHIaRbbkcqes3xGA7KHePg63ZEzlIXYMAoUIEFMeuKZkZP5bcZBe55yQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYA3YSwBqca9ndyxlpfDaTqI4RVWCZokXLQg8RvqWRmI+Jf0SS
	KY2qqDVUklsYqG9FT9PcxkArFYxSy8MgbZE80Z6HDw56j8YYVsGr6cK2hV+F4qAq5DKXOrCcmp7
	X8Qjk+IEbswQQF7T9L27xaD+BvIsp4qw=
X-Gm-Gg: AYBFou0lPxD/tdBOHgsS8w9RytzNjozuLrvsW/z343dcKaTwZZsK+PnI3bgKhgP7xXC
	vZU6+wgLBmLTT+WKYPrjPwxd5CXlC+2P5NcO49oNqTTCRLezwl63U6ERnjHOkFAgvZ1FqiiUvrR
	fEAM6qLIO9csCde3JPxV+SIiyjWblrL7GqDQ3pWJjLVzMY78RlwYcEpnluLeFiV9iMg7QHdWt0J
	lpq6GoAa+8fAl837Qv2DbobFZrLaJkKm2KuQIb5isNeqs5HfN7AzPOhpKvwfW1t0okgETAmdOOU
	zkhHf4vOxVfquLwTUlG9CPENtRrKGwbs+LblB0ntL7Vl5hMmtbULaTX3BUJ422YFP97Uk1doQL/
	mP01Vl6HMWKZw
X-Received: by 2002:a05:693c:42d2:b0:34b:3f7d:6105 with SMTP id
 5a478bee46e88-3602e3a6861mr7547000eec.14.1792257471057; Sat, 17 Oct 2026
 10:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013060018.43851-1-clamor95@gmail.com> <w3bn5bqxqjhf4uvxov47rwlvmnbic6xnlk25xbpnbmi2eyup7q@tjuiu7pl3mmo>
 <CAPVz0n1-jN5WLFq4e0CZrneExrN_A=GNeGTwGHTCj14NAta+jQ@mail.gmail.com>
 <aPCfiJxyKOXsgNJe@shikoro> <20251021132529.GA4133357-robh@kernel.org>
In-Reply-To: <20251021132529.GA4133357-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 17 Oct 2026 20:17:39 +0300
X-Gm-Features: AclHuK8PuqDaMJH61jp9QkgVw3Jnjuhi4eCGIeZsSWyWbl9ymhpiZkdInIAvvRk
Message-ID: <CAPVz0n3jt04xEwGr1aiDTJ7OonYYgOy3QneteLXgdGruXGMP_A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2 RESEND] i2c: muxes: Add GPIO-detected hotplug I2C
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Luca Ceresoli <luca@lucaceresoli.net>, 
	Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	=?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 21 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:2=
5 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Oct 16, 2025 at 09:32:24AM +0200, Wolfram Sang wrote:
> > Hi Svyatoslav,
> >
> > > Herve and Luca did not come up with anything meaningful, they provide=
d
> > > just a few rough ideas. It will take an inconsiderate amount of time
> >
> > Well, IIRC they said that your use case can be mapped onto their
> > approach. Which is meaningful in my book.
> >
> > > before there will be any consensus between them and schema
> > > maintainers, and even more time would be requited to settle this into
> > > schemas and implement into drivers. Why should I suffer from this? Wh=
y
> > > should changes I need be halted due to some incomplete 'ideas'? This
> > > driver uses existing i2c mux framework and fits into it just fine.
> >
> > I am sorry to bring you bad news, but you need to suffer because this i=
s
> > how development goes. If I get presented a generic solution (see Herve'=
s
> > mail) and a specific solution (your driver), for this case I as a
> > maintainer will prefer the generic solution. Generic solutions need mor=
e
> > time because there are more things to handle, of course. This is typica=
l
> > for development, I would say, it is not Linux or Free Software specific=
.
> >
> > I appreciate that you tackled your issue and were open to share it with
> > the community. I see the work being done there. However, there are so
> > many things going on independently that I can't really prevent double
> > development from happening despite it having a high priority for me. As
> > soon as I get aware of people working on similar issues, I connect them=
.
> > That's what I did here as well.
> >
> > So, if you want upstream supported I2C hot-plugging, you need to wait
> > for Luca's and Herve's work being accepted. Or provide a superior
> > solution. Or, if you want, join the ride. You already have experience i=
n
> > this field (and hardware plus use case), you would be a very welcome
> > contributor, I would say.
>
> Agreed.
>
> What really slows things down is when there is only 1 user of a new
> binding. Too many times have I accepted one only for the 2nd user to
> show up right after accepting it and wanting something different. So
> now I just require more than 1 user and it is on the submitter(s) to do
> that. After all, it is their itch, not mine.
>
> Rob

Hello there!

Were there any advancements with i2c-bus-extension so that I could
finally configure and make my tablet work? Could anyone point me in
the right direction? Thanks.
