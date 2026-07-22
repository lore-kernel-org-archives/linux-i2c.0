Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99175464D;
	Wed, 22 Jul 2026 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724914; cv=none; b=lVnxl8kOB4x79bUWxYPf9Wb/VPivj/wbrzMw3aMjvOuKoakPQqCvAG8mjMHs3pV/+yCysmtcTmSCLwrJ+OOiknT2MaLU2Qi0XulfSjtQmRNRfEjb2PidMjR4zrE+oKm5S54z8JXVmk4kB8EBehla8zYL0/OTMqy8TSVI4qSD3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724914; c=relaxed/simple;
	bh=X92Wq0YEKuBV9IS72k1ngn60oSaXhbJCvFa33SNLS2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0OrUpY+8izh5ICXuAAQV1OeHa7OB4FGpdy2vdbqwoNWDzY9Uqaj+JskbQyyxFiyjeFjGAy22FA8mVqddNuurlgDtsIiRpEFGTv/Atm9h6V30lrGZT6cHOzJ2F6zXuDt0gbcExG9C4ywba88OOxeXWXDhlOEtF1aPOOHp27R42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVEAhk/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVEAhk/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31831F000E9;
	Wed, 22 Jul 2026 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724913;
	bh=y+cYNS3GNG+yvCv7Nu5Q9lqW/Yk+nVvFNZIaz2UfTEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nVEAhk/1YYKqQU+jVIT6MIXdaT5GvEZl/11nUiw0GXBiqn14qcM3mLuhpnghUlj9X
	 +8uagqlYI0LzTUU98MocG+8Pn5R7gGfOijocDymn1M2kz1Oo6WEN2os/LtmEsklOv1
	 zgsZ9jzhfSKLUr12Erc2+QnzR8Rbu7TL+yO2mTxOnO0iQkw7km7v48rEIjalUnGLsM
	 i8jpnjC6fpf+fxK3hsi7RfOL5XKp/yNv8QH8WKfRntxN8nrGKif1hFxt/9ETx32sQq
	 RJ9k4tRYxr0vFm5l5M1O58zQ012Th1CvbUzqHBJe4kG3Bj58z3kli4VcZr+Cugd0iZ
	 mQ5KQuvaAtSfg==
Date: Wed, 22 Jul 2026 13:55:07 +0100
From: Lee Jones <lee@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Min Lin <linmin@eswincomputing.com>,
	Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: mfd: syscon: add ESWIN EIC7700
 compatible
Message-ID: <20260722125507.GD11805@google.com>
References: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
 <20260706081055.1126275-5-pinkesh.vaghela@einfochips.com>
 <20260716122833.GE1260374@google.com>
 <SJ2PR04MB88965A802336D3FB947B736083C32@SJ2PR04MB8896.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR04MB88965A802336D3FB947B736083C32@SJ2PR04MB8896.namprd04.prod.outlook.com>

On Mon, 20 Jul 2026, Pinkesh Vaghela wrote:

> Hi Lee,
> 
> On Thursday, July 16, 2026 5:59 PM, Lee Jones wrote:
> > On Mon, 06 Jul 2026, Pinkesh Vaghela wrote:
> > 
> > > Document ESWIN EIC7700 SoC compatible for syscon registers.
> > >
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > Still doesn't apply.  What tree did you rebase on?
> > 
> > Whatever you rebase on needs to have the following commit:
> > 
> >    1d02f2a79ebe ("dt-bindings: mfd: syscon: Drop custom select for older
> > dtschema")
> 
> We rebased the patches to v7.2-rc2 on master branch of mainline tree
> before sending v2.
> We see that the patch series you are referring to is not present in
> v7.2-rc4 as well. However, they are present in linux-next.
> 
> Could you please suggest on which tree should I rebase and send this patch?

Mainline lags Next by quite a few commits.

You should generally use Next or the Subsystem tree you are working on.

95 times out of 100 Next is fine.

-- 
Lee Jones
