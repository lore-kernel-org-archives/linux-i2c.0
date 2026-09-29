Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB549AA24;
	Tue, 29 Sep 2026 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716573; cv=none; b=fDIlyROp5DTrlF9xHsPumAKr7WP512iL+n9vkPdtxk8mp2xt4Nvi6c2Ah/QhOh9wlr5ekFSNu0Qj1kChEUq0KQ+SY4dTgb1mXKD9ClgiwBPIRYC9cQos7HBaTkvDs4Ry7PEXHF8oQG99IQt1H2CMQVGfwzsMLcPUlspLoZiM5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716573; c=relaxed/simple;
	bh=O9/ed/FyzDWfBZ+cwrPtWes5Hx16xHr5FSfmKbsfLC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hajN8gXBDBlS0VPJOOZxzsnq+WUP03pIBUvgtKSWh+Pxq2WSugCE45t9mPpWnOQxeR6jwCJwrbUm3FgYypbVgnVM/A2U/yIsH/YBhXV//PqKfYay931UXCRaSzNbpsIkAjrV3+omdoAy8iNXb5Kkueyee9p8/hZbIfCXiwSyrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHt2E58Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHt2E58Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEC81F000FF;
	Tue, 29 Sep 2026 21:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790716571;
	bh=xpw024FPprsgBJNE+ZftfnLgbwyIdP1EDp11HcHw3IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LHt2E58QCAUzIRlzpO6t7v+9zqFQJx+Jwc46d3dgQ5lIjV8BcZ2JPYxER+oq+CsYl
	 od7zS9SWrctFtLl+s9Uks5G9FH2b6B5esIaprOPo5il3JGGHFWWQOd/swDCLowTCq0
	 G92spy4chD19G1XJwxbrPHXhazJce0yxPyaAny9c1mRn343MWrfSkOW3WjKP6YiAym
	 /l7Ey8BAIfg7io4+BQk+H+H7oca5+I9+WvPFzpWjrMCSTPNI5pay/i22+AEX6AqFyw
	 NJRu1AN6MplN/+0d3kq+qIYV0TeAN28F3DVUUPezv7nkLajI+6M1AVr/EkqvuNwduq
	 SUukdTAnGKU3Q==
Date: Tue, 29 Sep 2026 23:16:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>, g@zenone.zhora.eu
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Min Lin <linmin@eswincomputing.com>, Yulin Lu <luyulin@eswincomputing.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Darshan Prajapati <darshan.prajapati@einfochips.com>, 
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v4 5/7] dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C
 controller
Message-ID: <arwqgeAvwVFyLBHE@zenone.zhora.eu>
References: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
 <20260814070007.1662455-6-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814070007.1662455-6-pinkesh.vaghela@einfochips.com>

Hi Pinkesh,

On Fri, Aug 14, 2026 at 12:30:05PM +0530, Pinkesh Vaghela wrote:
> From: Pritesh Patel <pritesh.patel@einfochips.com>
> 
> Add compatible string for the DesignWare-based I2C controllers present
> in ESWIN EIC7700 SoC.
> 
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
