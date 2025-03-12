Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61E1EF0B6
	for <linux-i2c@vger.kernel.org>; Wed, 12 Mar 2025 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823917; cv=none; b=IIbdjLIj3tHGTH5eQX/S/+bV9lMxjdlADHA9U5NnRXZqRk3cx/bKP6SsWRfLVNEuAKMMi4c3rH+MbgKE9m0CjLHr/wLpaFpJB9ZnxfpwjiYYYcfQ8X0OE1ALebCxmF3KTjiFTTt4KajoKtEMPznzKBpa0ieRAuKuwYBdUpovt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823917; c=relaxed/simple;
	bh=JAX1MAxXytCDW+T0j/krlWqz/jRGtKqebI1K6KXkJiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4epvQoLSNcLchbGfxkJuPBl5OT1vWFvLCEorAVxIGI1mR9aCGyz3ygj8Nz883lw7vLZSgQlAGj2KQfcofobeJeaJ903tWOxXCkj9r3zr+PeansNDhGdEdoOVxtFWkXPMK8bsxDPB4GLIKfyek2uYxnBrArLE3O0yKbpLeQrSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i598avjl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i598avjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BA3C4CEDD;
	Wed, 12 Mar 2025 23:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741823917;
	bh=JAX1MAxXytCDW+T0j/krlWqz/jRGtKqebI1K6KXkJiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i598avjlTtvwQOaIz2jFOFsAJeMWO83l/j6+eQVY2gFD2ZpmuceLt8pbbQ0HVRnqh
	 PJl/1bUJjowf7QwWcWfWTF+fbrC5QSVOCcgTR7yiwQ+KcD/tDEyrSFXnyCyrrZZdP4
	 ul4W/Uy7QQOponYMBzY6EenCQVcDx9Yb0DiEz+4MrjWeffWyOUuOY+ylTpFNknXyiH
	 OgBtMrxjFzkzW91U4MDhvbkSUZk1FLJ7AMHOuLqthIwdJMnjprjeEkjhLzQoMwIICO
	 bTotYToaAX6PWhpZbAqY2eC1k/TUMtBgSMu+RdhXkUgnXcnxo2xbJcbSHCZZd6Fb+Z
	 xz0RkCUP2lw+w==
Date: Thu, 13 Mar 2025 00:58:29 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 0/2] i2c: i801: Use MMIO if available
Message-ID: <lu4ak64ok3xqe65rgsc3b4v7wkhiso73bpvgpb6kti3xbfgrpc@snoej2bnaocj>
References: <28ad9377-6d8a-4259-8cd4-7edaa00e26d7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ad9377-6d8a-4259-8cd4-7edaa00e26d7@gmail.com>

Hi Heiner,

> Heiner Kallweit (2):
>   i2c: i801: Switch to iomapped register access
>   i2c: i801: Use MMIO if available

thanks for resending it. It looks good and I applied it to
i2c/i2c-host.

Andi
