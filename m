Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5F1AF4E9;
	Thu, 28 May 2026 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009661; cv=none; b=Nk7KJMB+xFcTXxoekgD9oS9XtSwX9X5w4nIxCI6aogSCY8Jb+icPvkhTYG3Hm63vUFyE7zZYxEuKElEKtjEpnIk9PPwcTgAGgx8wa0244R/+MThq6CDxjfbnqtS/W7JIkmL9g8+QfxknP9v7Afr86/fb6qyteOTPds3g5wCdnHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009661; c=relaxed/simple;
	bh=rQ3cOYmrKeBXyPqDkmUYTpggROYBSL5xJJgSujCGUvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaId8bpUlhYz5GxDv7wYbjuE2v3+7XFTnlX0D8QG23tmvQPWCNoGNe7NGV++4zGTYqHdDiDuFe3ALQ222G3dStgkIXy6//rT0plC0VEjALyROWI8xNUK+LnjYsangLdRCe/o8asINphvS1xiBEHPEMCPGpA7fsyc5eX71xioT1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPPLIDEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPPLIDEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14DF1F000E9;
	Thu, 28 May 2026 23:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780009660;
	bh=K+065u8Mn8svc7xrJRsSdC2+MrRHItvyzgGEqxElOCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TPPLIDEw87syfQOzoTENH1xChFfpE69YmRZ4KuhGDKoUunBJPSbpMHt8mZ3ZGeD9R
	 AzrIdPr56bQBB74CUaRPnYMi/jD44IPbGPL0TROji+Gs1uJUz07Q0HGTWlYjtesvIA
	 EhQIHK2eaHFvgXMDWtgzBN3qG2Bf/ExJTqMr5WS58KHT5xYqmOo4b6JB9HrVy5gilU
	 cpOmGwIbfd5CEEsWTg1R9RH9CAqNDJkk122qXxTvenocHgDqwiriHpqcJ0mHt0zFoW
	 cCbqHcwi4XuMefz9pXeSln38p2sjtHYLGHYJHx9ljvs2/q3HnJQjLG7B26gIDI3OA5
	 IphBV8s0fZfdg==
Date: Fri, 29 May 2026 01:07:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Thomas Lin <thomas_lin@lecomputing.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jan Dabros <jsd@semihalf.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, jihua_tao@lecomputing.com
Subject: Re: [PATCH] i2c: designware: Add ACPI ID LECA0003 for LECARC SoCs
Message-ID: <ahjKoWVYeBuozVEd@zenone.zhora.eu>
References: <20260526-lecarc-i2c-acpi-id-v1-1-f0942bd491d2@lecomputing.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-lecarc-i2c-acpi-id-v1-1-f0942bd491d2@lecomputing.com>

Hi Thomas,

On Tue, May 26, 2026 at 04:28:43PM +0800, Thomas Lin wrote:
> Add ACPI ID "LECA0003" for LECARC SoCs that integrate
> the DesignWare I2C controller.
> Also add corresponding ACPI description in acpi_apd.c.
> 
> Signed-off-by: Thomas Lin <thomas_lin@lecomputing.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

merged to i2c/i2c-host.

Thanks,
Andi
