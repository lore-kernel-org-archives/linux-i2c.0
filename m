Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43962BE65B;
	Fri, 27 Mar 2026 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577145; cv=none; b=oJOhbAKRlalEz+MDFyLQrdZFXsPcTxndNvo6QvTUeT1t1Fc4kgvsPN/BoTEGmLzCWnwuhEPDW/AKsJa9MjaIqgM6ZNptX3bhak/uY+NGIgIRQ+U97gJiR/I8GPJFOp+3u0+85TPixNAMSxxwF0LwDzZ5tsklD3DyIEAHEM3H768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577145; c=relaxed/simple;
	bh=I3+vM76RROlsr5DE3W8ojD/qPlnILtB5bMHYIL9PoPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+xUPnquCZ+cEzL6A7eSVic2EoJladc5fRWGHfYqyfV0UbAv/bf3h8bvDTWpmM0i4bM5WB2h8iDhHNmqZoH9mzkGAAFNFAU9sV1HMArDR0u0auSJXU+w0pjrgDuwQdZlHOEUe12Cf6eJj2vr5r+7c89ZJsHf8TmDZwhF31RCOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTwid/KS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTwid/KS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C77C116C6;
	Fri, 27 Mar 2026 02:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774577145;
	bh=I3+vM76RROlsr5DE3W8ojD/qPlnILtB5bMHYIL9PoPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTwid/KSiNHM4qXkkQl/gCuBOZeRmvMSv38BMxA3i2PvATL2v4Y5RTZ/4rcSRzluu
	 YUXJqDp/INBj1YNOskVBKEvdw/f8fUr5OyKdrnqdFMzS6Yt8dfqwiuF0y5c/rUsiny
	 qnrV/GwY0+M9xNlw38WFPuSVp0mMRyEaN5PLJ1Ksrk8aK5l7BlprDLvNPwibICKJIV
	 ADszaELnHkRhgaf887LQCsokOwoJYwR19t0JyjtQ0Ql1A8viLIfRFAW3ghuTRz0SjJ
	 rSx6MajniJ6CeN6+6T84p5FdZRSugiDW9K4jvP2kRsGQ42DTpOuSLyEtPztUeT7qKe
	 knNLwxccB16nw==
Date: Fri, 27 Mar 2026 10:05:43 +0800
From: Yixun Lan <dlan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dts: riscv: spacemit: k3: Add i2c nodes
Message-ID: <20260327020543-GKA847041@kernel.org>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-2-78f29c83d9ac@kernel.org>
 <acWxJNK_vZca_xCZ@zenone.zhora.eu>
 <acWx_31uT2ffcaSN@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acWx_31uT2ffcaSN@zenone.zhora.eu>

Hi Andi,

On 23:24 Thu 26 Mar     , Andi Shyti wrote:
> Hi agagin,
> 
> On Thu, Mar 26, 2026 at 11:22:31PM +0100, Andi Shyti wrote:
> > On Wed, Mar 25, 2026 at 09:49:25AM +0000, Yixun Lan wrote:
> > > Populate all I2C devicetree nodes for SpacemiT K3 SoC.
> > > 
> > > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > 
> > this second patch does not apply on my i2c branch. I'm missing
> > some other patches on k3.
> > 
> > Can you please rebase it on top of my i2c/i2c-host branch,
> > otherwise I will need to wait for the merge window to open in
> > order to take this.
> 
> sorry, this has to go through some other path, I'm going to take
> patch 1.
Right, I will take care of it, DT patch should go via SpacemiT SoC tree.


-- 
Yixun Lan (dlan)
