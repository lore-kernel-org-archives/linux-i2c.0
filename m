Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1812B93;
	Fri, 27 Mar 2026 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579175; cv=none; b=lhiwBkrflskc0VDLFxiYP+FmH9fr9t2dqJoQjCLA8oNbeSuZx9EBRiTm0D8BQslHmbLGaM4wWr8siZadEDmsoSrFWkbqwfVVAzeH6s0P3vgWv6QUCw0hq+5Wk5e/+IjD6rjAXjF6xK9UyKsitFkrc4Q1fNCRrzvStQvKKtw6Ow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579175; c=relaxed/simple;
	bh=nPT7x6y5OId4DsW14tOEiyeCCaLNclGNjCQE6YiTrPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMKDo+iGsRsTc1lbHTVhPM8CKop5/qLKHCKfSG3DA20OQ2Im1q7xf4PfGF7peLYGz7D3eLVMIITISxEzHe5ZNBWY2lalOiHKP1Gix46leQaT1VTzeafEBawAGY2YasS36wX4e6AMng1q5hDYuMQ9qFcIQYG+HOI2dg+0uP2ctp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev26ueLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev26ueLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52472C116C6;
	Fri, 27 Mar 2026 02:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774579174;
	bh=nPT7x6y5OId4DsW14tOEiyeCCaLNclGNjCQE6YiTrPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ev26ueLCManETECjx1/dcSq1/69edXtwNfKl/zr0ktQbMoiAivqI624JX9x5Wokiy
	 YW/nt/DrkJqKxJBwvV+1aIHjqLbnli/kNOB4ZM/haGyWfUZH5gVnlgf6DOLwxPJ9p8
	 U3J/HQvmH1cjbTsAn7xAM8zdTGPXuJvi0bV+Egds1cniXdE2zw0wm8NhvSvSPeGrWU
	 wmzS8vLDiP+/K9BN0iAQe80ydDQzAdEq4WPDSrN5OwU20D2ss3laTJbSNAGUIDGB79
	 s3UkD3COFqQ69QDx1fkfPWBOfu8XL/tX0DpIFs2GrHim7Yj4I5W2X5rwqcF+ZlhG/5
	 0UtCqmOsZ2ZHw==
Date: Fri, 27 Mar 2026 10:39:32 +0800
From: Yixun Lan <dlan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dts: riscv: spacemit: k3: Add i2c nodes
Message-ID: <20260327023932-GKB847041@kernel.org>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-2-78f29c83d9ac@kernel.org>
 <DHBSTI0A3SOW.PCIP544HUYP4@linux.spacemit.com>
 <acWxqkR8Z0rwe4hI@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acWxqkR8Z0rwe4hI@zenone.zhora.eu>

Hi Andi,

On 23:23 Thu 26 Mar     , Andi Shyti wrote:
> Hi Yixun,
> 
> > > +		i2c2: i2c@d4012000 {
> > > +			compatible = "spacemit,k3-i2c", "spacemit,k1-i2c";
> > > +			reg = <0x0 0xd4012000 0x0 0x38>;
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&syscon_apbc CLK_APBC_TWSI2>,
> > > +				 <&syscon_apbc CLK_APBC_TWSI2_BUS>;
> > > +			clock-names = "func", "bus";
> > > +			clock-frequency = <400000>;
> > > +			resets = <&syscon_apbc RESET_APBC_TWSI2>;
> > > +			status = "disabled";
> > > +		};
> > I think we should add a comment here to explain why there isn't i2c3.
> > Otherwise, LGTM.
> 
> are you going to add a comment here?
> 
I will explain and re-spin a v2, and add a short comment for this:
- i2c3 is reserved for secure domain which not available from linux
- i2c7 simply does not exist from hardware perspective, K3 SoC want to
keep align with K1 to use same index of I2C controller for the pmic

> > Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> 

-- 
Yixun Lan (dlan)
