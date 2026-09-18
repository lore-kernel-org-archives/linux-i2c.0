Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83693955CB;
	Fri, 18 Sep 2026 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756246; cv=none; b=IeqUBNN9r8a7k3qwFZTF08xQWn/8LCPKZN5dk8yEzaN1SxgFDOQ8jqiviSuFc3v37c5gElSMpI0huJfi/dKIfZtgJa45/bwOh2U6gzJZUv5LOC2WIHn/0y7WTramHOLJSaf6QpxYTf+h3zqMzNC7PBgPDzyS4MkcXLa71iWAHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756246; c=relaxed/simple;
	bh=+QRNQ0xfCiDliM0uA1tGSycE0X+at6MCvRu4NYD/kCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us4sDWXlFHlJryytYyAHuTmVD5dR1CveECEqvQ9I+nKm5MwxHGex/ZXdCWRi+ZAHWas3l0QpDPr732uPTBAXaQKX/HB9VvCq9jaraDrmTgxzz815tB742GtP0bhY5XmJ47MBzPutFU83icXADarGaniw6umBiixi5HTG8zSmR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxWDifWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxWDifWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495CD1F000FF;
	Fri, 18 Sep 2026 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756241;
	bh=xwkCj2z4kSNzxV0/on2+hsEjfBbc2lGsKch1k6FbvNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RxWDifWhA8PwaEnW6EKScziw2by0hQ5gCjW+/eVHGV7LyQo9k2R+hYdB6QwqSd721
	 x8yUCAIoQ3O9M78N7ki1ImkGLofEUd1U3JX47G5wfTr2Av43EmdpZdOY3rrWaE2+Qq
	 7wtHf1PG4eSE+3Y5IHmNkrSDNNMMou+n51CgXQsLObdL13jO/q/SsVj+vBN7BWv/LI
	 kLBbMS6Lg1GiWZwA7/DWVkQ+DEdGhOVZlJPlWky2eDxhRjPVIxFEN2sMAnoCLyThMm
	 kcJzRN8qWYneAEEU3NADaDdRr04kR/aSjK+O4SDpQvczfS0hOaAKJvg1M7NDFn5hcY
	 dPApg9qVEb1Qg==
Date: Fri, 18 Sep 2026 13:30:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: nina_kuo@novatek.com.tw
Cc: shihpei_hsu@novatek.com.tw, devicetree@vger.kernel.org,
	toby_chui@novatek.com.tw, conor+dt@kernel.org,
	andi.shyti@kernel.org, ben_huang@novatek.com.tw, krzk+dt@kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dt-bindings: i2c: Add Novatek NT72676 I2C
 controller
Message-ID: <178975623902.1285316.4399627146278456114.robh@kernel.org>
References: <20260910030123.215609-1-nina_kuo@novatek.com.tw>
 <20260910030123.215609-2-nina_kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910030123.215609-2-nina_kuo@novatek.com.tw>


On Thu, 10 Sep 2026 11:01:20 +0800, nina_kuo@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> Add Devicetree binding documentation for Novatek NT72676 I2C
> controller.
> 
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
> ---
>  .../bindings/i2c/novatek,nt72676-i2c.yaml     | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

