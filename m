Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946D3F0A9C;
	Thu, 18 Jun 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781250; cv=none; b=qrwDTtpsVpCtPFIqtNzJXz9+FKInzIdUKULX3k4zkpDiJtRuc8qL8Mp84fcXlP6HcdHadBNlnVosobFsnLvS1RS4wML5VqK6Ms58D7zW93vl7GtSVCcnRPuBiQk5rH0WH/DG0RP1Ybpx+4YWJ6fEad77BqCMOOLm6pUfuhIAAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781250; c=relaxed/simple;
	bh=x1/QLDdWTkCDEdgWwsHwyOal0sX2M0yLd/8VwGwXSKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu7tC/za4MjcdkI5PTl03hHC7gI2FW+kOeASOrvjVoCysROfMWv9nUCw3P7LfgJz2G2BxYTDQudxA1+8L18B0gzCjBw0iR6cVrsFF64ycMl28K70HCzaGgO5E6gpi9XsJ7mePLqikUc4GgIcs4egnGJyG8FNBU6IoMbrMQFCfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui/HVlno; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui/HVlno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206491F000E9;
	Thu, 18 Jun 2026 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781781248;
	bh=MoWCmakyGzD9+dJmhPcCrVXlNniKi+K5rKipnKH4I+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ui/HVlnoLrR8lHdgil4pKmlIWMzhXHI0EEF4agLMi2xsSKZSTYd0hYldEq1U+MNio
	 8V1nvQpadAMbJek3XOtCR0gWf68iaXZXGXGhDGszerMGSzfhfHcYXw59xTR/vBlxQ+
	 JwiVLiQb2efeeGBhCeKAm6CVVe4l9uy68pHYE6LpIuizThCJVZp2z24pnidYeQMlxe
	 ijpOEqYGLo9xC2H9WFDoMHI9ubHFZmxalfV1Q+5xLNgu6P4hnqq9EW8iTEdlhCo9ew
	 fvTtjar7nszbgaF/sU1yppfY8a/md5cmNA9mWibq1ZRz7LEfSq0rH833WeNfRhQeGz
	 39ZdnFp49DupA==
Date: Thu, 18 Jun 2026 13:14:04 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: pxa: Use named initializers for the
 platform_device_id array
Message-ID: <ajPSo2zjDvq7CflO@zenone.zhora.eu>
References: <827657abb02edb39bc90f7336194f614d383770e.1781688767.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <827657abb02edb39bc90f7336194f614d383770e.1781688767.git.u.kleine-koenig@baylibre.com>

Hi Uwe,

On Wed, Jun 17, 2026 at 11:37:36AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous union.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

I had decided not to take any patch anymore for this cycle, but
because this is part of a bigger work you've done, I will squeeze
it in.

Merged to i2c/i2c-host.

Thanks,
Andi
