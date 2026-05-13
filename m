Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C8255F52;
	Wed, 13 May 2026 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674298; cv=none; b=SJ95P19nAHY+c1pMoX285xZpPzikwoECnKhYgmVVv3DF/dRLxtsR/tppbrulLM1jMjY6gyBVp7f+jY3xVSF0zeMXiaFWGOm1vv7CZ8iOuGvtgGAI85vvlye0x3hYFKdcFzC6Kky6SWKqvoAqqUYXtTN8v3h1vlSaaTcr4aCOfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674298; c=relaxed/simple;
	bh=yeqD45+3/MnvE3oQPNQ8uNItA+45Oar1Fl18kCZc/WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSv7nq6utNgTiql15fbLoaIkwCtabS+srlY8AguUxu1PmiCfLcariiybVrR0Gu/t2Pk4eQGMPg3C/z9UZiBx7FjLvmHCspp/3bG/eQm7U47uW5AH2ix7wHSWww6uwVq8uu9MNUlyyyv2RDJjq7+TiQEFIrOcqIB+QlIFrxtLlRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JINf5OLU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JINf5OLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E55C2BCB7;
	Wed, 13 May 2026 12:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778674297;
	bh=yeqD45+3/MnvE3oQPNQ8uNItA+45Oar1Fl18kCZc/WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JINf5OLUH+jAbvHJsQu+x21GPdJofr0IXr5I3bz2rtGmHyXjYtbl6vk+TEcI/KOrn
	 uNYJOundYhsWnipo5UXGaC9/NU5Ua1g9rPvDjAYCy+B+No2SbEdNawUWQST6lBftOb
	 Em3AgVM6Yai7p+kyJIsieLx1nkN4qFrqBdReY4oD3p/OEoLXtvn6qVi+dUnuyzUUI4
	 KLWgVS+X8AnOS1/JQoLUC18O0+KljMN/C+YEPEGiWzaVkDJyi7Mb9EtuAwoLKzoryj
	 0LORofDQN3T+gk+f3iNPZhNpc92VxQY+Qzn6rIM7vzVKrIq0kqthFsbCXa0AWX49YH
	 m4bUT5d9LoQwg==
Date: Wed, 13 May 2026 07:11:35 -0500
From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
	wsa+renesas@sang-engineering.com, andi.shyti@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
Message-ID: <20260513121135.GA432696-robh@kernel.org>
References: <20260511162528.84508-1-markus.stockhausen@gmx.de>
 <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>

On Tue, May 12, 2026 at 01:00:08PM +0200, Bartosz Golaszewski wrote:
> On Mon, May 11, 2026 at 6:25 PM Markus Stockhausen
> <markus.stockhausen@gmx.de> wrote:
> >
> > This series adds support for hardware designs where multiple I2C
> > gpio based busses are realized with dedicated SDA lines and a
> > shared SCL line. This way N busses can be realized with N+1 gpios.
> >
> > Currently there are several Realtek switches that make use of
> > this design. Samples are:
> >
> > HPE 1920-48G
> > Linksys LGS310C
> > Zyxel GS1920-24
> > Engenius EWS2910
> > D-Link DGS-1250
> >
> > While at first glance this might be a usecase for the new shared
> > gpio architecture, discussion and testing shows that this is not
> > trivial at all. A shared gpio is handled by a voting system. If
> > there at least one user that votes for the GPIO to be "high",
> > it stays high.
> >
> > So the implementation manages several classic bitbang buses with
> > locking/unlocking in the pre_xfer/post_xfer handlers.
> >
> > Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> >
> 
> Hi!
> 
> A couple high-level issues. You'll soon hear from the DT maintainers
> and they'll ask if the i2c-shared-gpio compatible corresponds with an
> actual piece of hardware on the board. It does not, so the bindings
> will be rejected.

Perhaps you missed I've already commented on this. I'm actually fine 
with the binding at a high level.

But if we want to model it as N i2c-gpio nodes I'm fine with that as 
well.

Rob
