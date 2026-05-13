Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC03356A0A
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657194; cv=none; b=rJpCfmOBNwzFl75YdBTd2plFHxTDcSi1KPsl8DaSupWpe4RmCSW88tuzG0aW8A61k0R/5unsMry2zvqYfASpm0MV3auz0UE1hkVQOwjtKqZ8jaDYKdRoAlS60URVo6I4c7KmVShqo736Oz35ORQ8BM34H5Eov/qlr9MbEnSbfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657194; c=relaxed/simple;
	bh=E+JE9icB5V26orC9/BsI9aWEXGk6JqUtaPsGeOk+XRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bgrg/1eidPIntgRQcgTFN8r9pHDa0dd0g+NN7sCelBk9NU69Kb5+J5sCLHcOEZIFjCYTxaXcmEJHXEraL22ZMjwN8bn+4JcqUT4ooC0jUgN5MfciJvw9UvZ6hq4A6SOkspgeOXu6DVVGSUKaJ1S42kKKb4vWPgmRda5pNiwgZlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg5M7J35; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg5M7J35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E42C2BCFA
	for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 07:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778657194;
	bh=E+JE9icB5V26orC9/BsI9aWEXGk6JqUtaPsGeOk+XRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tg5M7J35RL++dy5rM2i9jGcb4V1HsMF+ZFRiB5igzqWIiWHmo2hw7NGykBH7TPfkn
	 TwvTw5UzFCAaGdXfIn6W87OZutgw4SR4w4ND9Y+5DGAuIZwJ7Q2InXnWuei2W3AvOM
	 brgsQgR3KV5hFvijpl+HMQadZPt9e4nH50i/RTV7pP2w9LY/oPh0Ph9DG9qMOl4D1o
	 uOgfAc4Rm8+g/fl6lrm4OcTC247p0CZGAPQ9Gy++Bg5OsyKNEoddEgZj9ypHFFPoYb
	 LFn4H+vh/TbsiOYSguYqj9d3ZiOlpa+J1nrkOvtwKF+v13MzWs1ee4fF4iOv31qL4n
	 jLrlcx4VCgvzw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39396f873adso78379051fa.3
        for <linux-i2c@vger.kernel.org>; Wed, 13 May 2026 00:26:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ92lsCC0gzpB6BUSPBRuq0gt68x7MI3Q5qURU6I2xwScpObBbkrMG1pTyDiFBvYqs4qu+3Sn4+yiD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2mjKhLKPjqAjF/QTAjf1qKzC9QuQTYGu4eTOj85qzexXluyZ
	vK6GdTTIEvGZdy57UQ4gag24yoWmZxDkFSqhv35F+8anCuWusRchXQ3H82soJ2Yf90l7R72v6hc
	YFwOVkSH1vomwAjPwzVuXnr0kkUlL6bE8/gLxXwKGBQ==
X-Received: by 2002:a2e:bcc5:0:b0:38e:298:96de with SMTP id
 38308e7fff4ca-3944b387492mr6741121fa.1.1778657193113; Wed, 13 May 2026
 00:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511162528.84508-1-markus.stockhausen@gmx.de>
 <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>
 <004c01dce29a$0e44e7b0$2aceb710$@gmx.de> <agQkbnSHblUNz-IZ@shikoro>
In-Reply-To: <agQkbnSHblUNz-IZ@shikoro>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 13 May 2026 09:26:20 +0200
X-Gmail-Original-Message-ID: <CAMRc=MddGonpdukfZ_eHa8C4ysdCTqhYva6yVRue06LVkyubxg@mail.gmail.com>
X-Gm-Features: AVHnY4IbeBnxCsEVOACIFpDhGo4KBQHQm4bwriO95CYZWMAimSvyOAniIsiXIoI
Message-ID: <CAMRc=MddGonpdukfZ_eHa8C4ysdCTqhYva6yVRue06LVkyubxg@mail.gmail.com>
Subject: Re: AW: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: markus.stockhausen@gmx.de, andi.shyti@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 9:12=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > It just so happens that at the same time as you submitting this, Mare=
k
> > > Vasut wants to enable shared write-protect GPIOs for EEPROMs. This
> > > seems to be a similar situation where the default is to keep the line
> > > high and drive it low if there's at least one consumer that wants it.
> > > I will rework the gpio-shared-proxy driver with that logic in mind.
> > > Would that be enough to address the issue here?
> >
> > I'm unsure if this helps. From my understanding SCL gets toggled
> > high/low for each transferred bit during an operation. This data block
> > may not be intercepted by other consumers
>
> I agree. SCL is shared between the busses but if one bus uses it, the
> bus needs exclusive access to generate the desired clock rate. The other
> busses have to wait until the on-going transfer is over. This is
> different from the shared-GPIO examples Bart gave which need all the
> input ANDed together which would result in a chaos clock rate here.
>
> But thanks for the explanations, Bart!
>

Yes, in that case it seems to me it needs a separate virtual device
driving it. In general, the idea Markus presented is fine but it must
not be described in DT. Instead, you need to create an auxiliary
device from subsystem code. For instance: if you see the `scl-gpios`
property, you create an auxiliary device, assign it the GPIO as a
software node reference and make the bus use it somehow. I don't have
an exact solution because I'd need to sit down and figure it out
precisely but that's the high-level idea I think may work.

Bart
