Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46851992E;
	Tue, 13 Oct 2026 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902039; cv=none; b=pJlnLEawy+sLoRWGAe7hqZOcTf5zhyW8L91b5iKhz/E5s7ieGrr6cTYqDzdotTEhBUk0Zk836541pau2QL4AcBwy6gb7SbZ34qQTJzBVYQqqIWn6rZlrKW2OiCvB6EJUDZEa3KJ4yMklq0Nbr2XxECz+xQbHISeVJU52DafZ068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902039; c=relaxed/simple;
	bh=pcLGJwNaLmh9Jj+lr3gUFqNCUhYTpzpnSpG2X0E/wAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK68x0uRUxS9yUZX/4nz8GQ3rvvnJjJWyB+ZOj0kq7gV+iMJ26QgfdEoeSSfRQpxDGPxSZFt28Q3uHmMHwfSJcELgSEkrWniyxp2Vkr0RrxU6MlKEjdKUBlWgEPqwzOo9901w5XfEmNBE7bj+YlvI66z1jpkL9B+mPojiimlZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/aP9m8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/aP9m8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEC11F000FF;
	Tue, 13 Oct 2026 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902038;
	bh=yxkihl9morGXlwHlg5G3dnvtjqdsFp1JKoB8HwphYrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A/aP9m8K/ZBmiLTwBNRWMtDaOX2sADg9dRmLN7xT+o4x6zEOV5qeiq3+xEpz5pEMC
	 0rC0d3CPXHXrzVbjf7ApgOwOQi7mb2wbRXoPQjKEmhxYMt9SZKE3NpnzXhcoLfK/v7
	 APwhfoMfZFf8Tta+DunM49FZVFvuOIgoQSgjQwzEQOmaICPinyZOy0KxPgIakgp4tD
	 tqQmhpvG1agHKfsPm/r/NVqzlCLb6UxC7dOXtvw6wTqGi/ViyrtjU6blpmSZuPga0T
	 a9qXe+HtW8yZj/emolxRLKiymyem8Nqi6hc0hyrJos03WbqDjgNGuTLbvULZniugYs
	 4pA1AMEiZ274g==
Date: Tue, 13 Oct 2026 16:33:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"open list:FREESCALE IMX LPI2C DRIVER" <linux-i2c@vger.kernel.org>, "open list:FREESCALE IMX LPI2C DRIVER" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..." <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, vkoul@kernel.org
Subject: Re: [PATCH 1/1] i2c: imx-lpi2c: remove dmaengine_desc_free()
Message-ID: <as5BOk8aLCx_s6_T@zenone.zhora.eu>
References: <20260929190605.3516147-1-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929190605.3516147-1-Frank.Li@oss.nxp.com>

Hi Frank,

On Tue, Sep 29, 2026 at 03:06:05PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> dmaengine_desc_free() is designed for DMA_CTRL_REUSE. If DMA_CTRL_REUSE
> is not set, dmaengine_desc_free() will return -EPERM.
> 
> 	if (!dmaengine_desc_test_reuse(desc))
> 		return -EPERM;
> 
> So calling dmaengine_desc_free() does nothing. dmaengine_terminate_(a)sync()
> will free all already allocated descriptors.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

pushed to i2c/i2c.

Thanks,
Andi
