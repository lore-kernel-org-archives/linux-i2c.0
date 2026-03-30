Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB83B0AEE;
	Mon, 30 Mar 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871280; cv=none; b=YQxDiED7zX5uMWYqzkU7GX22gP+kFF5nRhUpB/kN4nP55EVmcd5j1HC4CGzBJY4HqhQpx10VgqbH6LyRKhJB84ZKUdhhvz2qlSlouWWL9fqMmy3miaHZnpUA27wjejBhH9xE6xokW1RJbZGjzJedC3QsZeXA8RKd1lNH9vi8VV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871280; c=relaxed/simple;
	bh=Z4TEic+jbD/0h9ieBacvgdYxQKQDYeAE2zzcUViEoZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2wl/kOrh0MfpkvWyk7TLt57+gGY9p6iTu40fy71DCBkNID8IBlDfwmF7hFgs0D/W75tbx8z63MjaADzjh2eDP3auvpP4EYOtl60J9Wp1VglDB6zDZPxP8cbP/MJmQxciSOrnoB6kVQlHMsMZu1wXYyrYvsn/7pLZw9oXOvUXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9t2/jno; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9t2/jno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9CCC4CEF7;
	Mon, 30 Mar 2026 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774871279;
	bh=Z4TEic+jbD/0h9ieBacvgdYxQKQDYeAE2zzcUViEoZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9t2/jno1csvxje0NX4/PySsGiQGoF/Ym9oTh5wo9rNr/G74MgiRgwLUz+XKs5g3s
	 fPU3eIKmS46jDYwAZ92OlgV5GxObzRmT10pxSAkU/fCBlTghxVisfJaqfHXh9qWXwq
	 daJpqRCGu5MjSbqXwhOeGPQAnLJBozSVTWGbCNmN7hYUA76kvtUTCVQxQXwxkiiBRM
	 YPssYWeh4yHHRTrMSMP8bp3oEB/M6wO3mWKtmt/Ua8XqxWqUghFuayk6oqqP3dA5jp
	 G7MX8GGEW+WoT/8pG1LC+IKl7/YqP6xwOflD5W/9qpD+lFFMao9RFuYsF3Xy+P86K8
	 rSGNiWwFv4kAg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7B65-00000007200-1lA0;
	Mon, 30 Mar 2026 13:47:57 +0200
Date: Mon, 30 Mar 2026 13:47:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] i2c: tegra: enable compile testing on all archs
Message-ID: <acpi7ZZMa8fr25RB@hovoldconsulting.com>
References: <20260309081259.2557-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309081259.2557-1-johan@kernel.org>

On Mon, Mar 09, 2026 at 09:12:59AM +0100, Johan Hovold wrote:
> Commit 4a2d5f663dab ("i2c: Enable compile testing for more drivers")
> enabled compile testing of the Tegra i2c driver only for architectures
> that explicitly provide readsX() and writesX().
> 
> This limitation appears to have been too restrictive since the generic
> implementation of these primitives added by commit 9ab3a7a0d2b4
> ("asm-generic/io.h: Implement generic {read,write}s*()") predates the
> commit in question.
> 
> Allow compile testing of the driver on all architectures.
> 
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Can this one be picked up for 7.1?

Johan
