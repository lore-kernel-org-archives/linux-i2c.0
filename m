Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76830DEDC
	for <linux-i2c@vger.kernel.org>; Wed,  1 Apr 2026 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081188; cv=none; b=nUel12oi45qOl5YFHM6NhkJ157z3ikcjC1RWmUcCYyniw9kep0+kpDCfO84Zx9VetmnacHE5Vg8RWzHvEcJZ4YeF7zQTUyzILWN+RF/5f5BVaX8PerlJ0vSmjOAtnhipHYJHmtGn/DDTTLtiZdtxOv9YK8nKqx8wfsEO02nQ0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081188; c=relaxed/simple;
	bh=8vJKSGysDA+Db+T4KKo1vQ8Mi9ErglfPxx7WPr0AiQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQvSfw/Iu46olo7w6oAumLTRjstzlCL19+7xZA/F9iUy5i5hlmbLMQvuuArpkpAxtOWStmpAR8PdHU3EIzz79pbSjYXioMgzY0aY5xgxhPTX2Hi8jCkpjW97+/EFEJQi3Kx6tx1sJnwdPsFMJ/3v/4zYBihFfUFjgDR5fCkBl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU5G4DZV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU5G4DZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9CFC4CEF7;
	Wed,  1 Apr 2026 22:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775081188;
	bh=8vJKSGysDA+Db+T4KKo1vQ8Mi9ErglfPxx7WPr0AiQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XU5G4DZVbHJtG3eftyAkyT2nzohl/uX0nUWgirpVRO/HUOy7TNaZ3w2LHQnK6r2NB
	 172b9X6fxbdEBrfD8GO5IJn69MlwAOBkA5MsomxpBW+wzpAQK/hdWmduuNGVysVdC+
	 Z8Gk8LZcaOqaqHnCEmLbbTy5HQNEUcIbqDKshPo8vze/IOVawFqF6HHkjjV8GhGuHX
	 orUuM5Im636cnlSscnQmZAzsn3x0VAhAMouuLSeMvCi7V50AvT8/b7SMvzuOXgK0U+
	 L/u8Yx2DtBAgZcQIEWWdnJEyVpgVENi5DJAKeacMrnOrbLEZR5tz12h+oN8+GYeV/e
	 uKCO0BKp0ZbPw==
Date: Thu, 2 Apr 2026 00:06:24 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jan Kantert <jan-kernel@kantert.net>
Cc: chris.packham@alliedtelesis.co.nz, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: rtl9300: add support for 50 kHz and 2.5 MHz bus
 speeds
Message-ID: <ac2Vet5edXeh_wo2@zenone.zhora.eu>
References: <20260227111134.2163701-1-jan-kernel@kantert.net>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227111134.2163701-1-jan-kernel@kantert.net>

Hi Jan,

On Fri, Feb 27, 2026 at 12:11:34PM +0100, Jan Kantert wrote:
> Some SFP modules on certain switches (for example the ONTi ONT-S508CL-8S and
> XikeStor SKS8300-8X) exhibit unreliable I2C communication at the currently
> supported speeds. Add support for 50 kHz and 2.5 MHz I2C bus modes on the
> RTL9300 to improve compatibility with these devices.
> 
> Signed-off-by: Jan Kantert <jan-kernel@kantert.net>

merged to i2c/i2c-host.

Thanks,
Andi
