Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551883DA7F9;
	Mon, 12 Oct 2026 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842667; cv=none; b=Tox5WMzEsQ1ISRCAt63yjIQwnOjGBzziImRhkrnQRJEH+9cJItcxnlQwXDRlSo1vQKB2gpH2zKCeLKAljyFcajW73DeD8uhfqS/zLDVReiJX2srEtZ+H0QV+V/OzgTK9p/IaJzRXF5GRA7seZu1qq+l8B/IBjBBnr3FAmQraX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842667; c=relaxed/simple;
	bh=+chnhBe9wh9P9qTn6RPmKj1KuaqAb7/QU9Y8koiwOhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6jlljX1PNeMKwJbTkc96S27c54k2xyPKxNZPbq9wTtnPfPAWl1MiXp4BTw3ncpuIhjngk2UGRLiCNe38f72f3cC2PHLsL36sFqQHeAzIdb4Q8d/EzeHtEP0xr53GmAwX/b8SCE/NPNbwL2Wz/BG3wUHvyuYCzPtUXAM7NejQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haSA/eiE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haSA/eiE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B87F1F008A1;
	Mon, 12 Oct 2026 22:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791842666;
	bh=iQZNrZJOb9M/RSyybEYVU7v3XNHc30eVGXfHTV69cFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=haSA/eiEY2ZEtrfmoBI+NAtI8fs3jH3/e5WybYXyzudY6FrLF/6wcSFYzcF1ljkub
	 5tFVX52WK7TLGYcbwld3ukDlBDcpDbmqzdPsXBKlzDMD5wM/w4AppeQz/b2RDCaz/0
	 d89EcCgSAV9kyWI01Js5xrh7B3NmpltNyuR++3pi54bp5bushPrl0B5ZIfoGfD8T/m
	 QtXynYhLVuKsrPJZMqgmBN2fr/iezyAq0oj8Y+KzaVuhARicVMOGWErVoE0znyrUmM
	 NbvrSh1fbgobqaVPyRPcTS3yl+SMahu6VTgIc+zyR/FK0M+5+k99hZ1k524vxI5wAG
	 B21SXdOTcG9NQ==
Date: Tue, 13 Oct 2026 00:04:22 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: dw: Add Synaptics sl2610 i2c
Message-ID: <as1ZVGFgzrahrjlr@zenone.zhora.eu>
References: <20261005152036.25276-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005152036.25276-1-jszhang@kernel.org>

Hi Jisheng,

On Mon, Oct 05, 2026 at 11:20:36PM +0800, Jisheng Zhang wrote:
> Add the compatible for the Synaptics SL2610 SoC I2C controllers, which
> are compatible with the Synopsys DesignWare I2C.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>

pushed to i2c/i2c.

Thanks,
Andi
