Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E43BFE2A;
	Mon, 12 Oct 2026 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846019; cv=none; b=enZDsanu6D9qJROTO6zY/EfyR8aOOiZ8Un97cNL8Mo9fgZmP8lWC/CxT4w1TMdj5W/C6blj4Cn8x4Vtbi6cm3o5T/BADHxXQbs3lsu1dCquOrpi9CllqnHn2SfxxREfOrLbRl/ipsnB4zFIY05i291hfO2hIjTNT/JLd+TnFmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846019; c=relaxed/simple;
	bh=i6jQmc/wB/VM2tnEtplz39PtttnBTeuG6oO+0KpryLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMV8+xQZ6nK3bT41mDszg3hx5UwH44/HFBOXPXF9/pc1b4jW+C5C9zlmmK1KNZmWjpkzPvZiQ4pUNcYk5u6k+QFFfbyyTLclUOKQ0BnTGS9d7ICJDUGdfOGZsiHizxOppbiXVQmD84zuTYBhvco36jDV2x0D+faLTD9VYhKbiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQn8T06l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQn8T06l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB831F0089B;
	Mon, 12 Oct 2026 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846018;
	bh=cKbK670BPsD3+hA6EKODcaXQfB1loIyE47EON/gG+v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dQn8T06lB06d0l1CymZPujOhbi34TfSDzHZSjMksWrwfPU2Ney5vy3xvbvnJi+e7w
	 1QBEHByTvqGtNfy2Ph2ZtUiFOvbchyiwbr5CtbhbTz/DGSgT13OinHksIXD2fGYXED
	 SsRQoMSXmr5DQipBGzHhi6rBardx0ei269C3zc2H5vL6j5IOF6AoblE3M68O4dZN2F
	 VjXOyuBoLyW16+H3wLMzKqzG+VCOV8fKEjgyx2AKn+9VoXSeq6NFzq9RGP1urc+4MG
	 3zovy4ERT6AZfuDnwUq4y7so3E9Hrf/cYY8PKPH+wIL9XHWB4KnVLiDM4Kq2ASSf41
	 sbWGGvGlBKcLw==
Date: Tue, 13 Oct 2026 01:00:15 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: acpi: Use I2C_M_DMA_SAFE in
 acpi_gsb_i2c_[read|write]_bytes()
Message-ID: <as1mUr7fMVVjBRRT@zenone.zhora.eu>
References: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919193642.43058-1-johannes.goede@oss.qualcomm.com>

Hi Hans,

On Sat, Sep 19, 2026 at 09:36:41PM +0200, Hans de Goede wrote:
> The main read / write "buffer" is kzalloc()ed and as such is safe to
> directly use for DMA (unlike stack mem). Add the I2C_M_DMA_SAFE flag
> to the transfers using these buffers.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

while we sort out patch 2, I pushed just this patch in i2c/i2c.

Thanks,
Andi
