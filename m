Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA95313E07;
	Tue, 14 Apr 2026 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205327; cv=none; b=r9toD0AsCopFgRyl9SYS86IzhzV03SGxCKZm9t313yuZnwizTbTSQyQVL5s2talhMvvhDgKngFxcd/oWirY0ZW3+bzn6dXMXYhfBTYJ6A6pSFojyBcT26eAFfYcdlIh2rPKAzTfoPpd1ti+XssbyfMmve1/lE9UDet2at6/yLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205327; c=relaxed/simple;
	bh=rP50wr1iygdgpL8hOtcvf3yxxmjcY4v8NkFlLqjuF94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP1ZkS3byg8hfMNj74yqCnivjO+wsYxxziKuWEqO0gWE0aiWv83J4qT4u9MzpzrLWuDiAo+ksu9FYXChy3P6wXyS0ukX9HmKkmzkcp9d026MNgfmm76ytm1ChSn9rQZfm+239vwYlVIleHZFXC/Fx9MyViCEwkw4WWDkbIo2rvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WORzXweE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WORzXweE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDB2C19425;
	Tue, 14 Apr 2026 22:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776205327;
	bh=rP50wr1iygdgpL8hOtcvf3yxxmjcY4v8NkFlLqjuF94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WORzXweEB8SIndl7zyiRWY5bPmU5oyYXDJQex9jSXQzvEgeLgSiXlPFUB0+6fioGt
	 HF82aSYnO1Cw5nz602oDWBUR4C8mKrCpf28aZ1Jk4USL2UPBCZQrXwah0ucpYzuLNH
	 8n4q10fdcjijp0P1nI4CiODUSrPAB3cJz3Kiqj1KB/eiT8cdMomrY9KGLET4Oycvkl
	 v3JXKjGlAeKXC9ji6CuOsMNQWkddaNjXYOrX2oBltxQvrjvHrefFN/yk9+pedo9JbZ
	 m5kohNykLyoL1CA0vmjxVhTE2RgI4hRBCetGPa68CHWvZZU/lc14vdA+BrqPcv0P9s
	 cQYNW2QA2BUSw==
Date: Wed, 15 Apr 2026 00:22:04 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: i2c: cnxt,cx92755-i2c: Convert to DT
 schema
Message-ID: <ad698Xxe0y1xo-GJ@zenone.zhora.eu>
References: <20260411112451.35095-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411112451.35095-1-i.shihao.999@gmail.com>

Hi Shi,

On Sat, Apr 11, 2026 at 04:54:51PM +0530, Shi Hao wrote:
> Convert the Conexant Digicolor I2C bindings to DT schema.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>

merged to i2c/i2c-host-2.

Thanks,
Andi
