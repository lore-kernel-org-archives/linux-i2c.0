Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490103F8717;
	Thu, 16 Jul 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204921; cv=none; b=bou+tscAjM5Q0g5F5qVnBKetg/8Sb2XpvmmopZm1hioU/wGdmzIinkrv7NQUXR3j/JoE2yzlFxmXjM82d7yCXuJoA3y0G+WzNj56TrNEV9lgkow39AWncJsBTjIMJNa2NsCcdFZdFFo/x9by7WAq1HB9tBtFq6wC7vAsegmbJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204921; c=relaxed/simple;
	bh=MAHgUSL0hA+atxbPa9H+Sdu2ii1jUSrhzcw3OCN+ylM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUMaLEer4GBrffPxLVjldmmIqHpCQuDMlQuT6HoYYiNYImTgohSt1HdwgIYkYB04bCWcnDaTJ/vPekOpTSSekzoadIhDHyLGpizSw6dnE4Y8yo9dKCLG27bxDc3/frR5959MzpAqeJdnXTfcgpIs6Uh4tBxscO5J7Uolp1E9mZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6kzhnaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6kzhnaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DB61F00AC4;
	Thu, 16 Jul 2026 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784204920;
	bh=n3MeYOo8+Rr19Z4v7W3hyO2QLqc+eSJagB6reml0gzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q6kzhnaa5UWnFB96fNrm7zS1X5V1xJrU86Kp2kxNfgDx8XVOfG1vqvLg62bAY+gRC
	 hB8uzWiALrG/3m/2Z9jFgY5GovomS/vmDDBU2wf4Lnx9EsYRLAYhptoNv5sGgzXzVk
	 tDph2ZJyR+h2HVp9XlUCS73+md2Dw/Tds2ccu0qV7s7lOZ8ywDVwr0PvjSTkr7XGlD
	 Ycm8UXMXadXNBxSfEp99GAxDyHNFCiYu6m/napdXEoSDwK5wWWy4yNYdBg3ZruYUDE
	 +9jLmV79hQ+V+/6iehrX/8S/gs7mM5RqmWo+tUtfGEFc5DNdMZHo1oNFXeqk96blwT
	 V7EIVN3sjRQXw==
Date: Thu, 16 Jul 2026 13:28:33 +0100
From: Lee Jones <lee@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>,
	Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: mfd: syscon: add ESWIN EIC7700
 compatible
Message-ID: <20260716122833.GE1260374@google.com>
References: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
 <20260706081055.1126275-5-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706081055.1126275-5-pinkesh.vaghela@einfochips.com>

On Mon, 06 Jul 2026, Pinkesh Vaghela wrote:

> Document ESWIN EIC7700 SoC compatible for syscon registers.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Still doesn't apply.  What tree did you rebase on?

Whatever you rebase on needs to have the following commit:

   1d02f2a79ebe ("dt-bindings: mfd: syscon: Drop custom select for older dtschema")

-- 
Lee Jones
