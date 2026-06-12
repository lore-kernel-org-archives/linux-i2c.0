Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162037CD52;
	Fri, 12 Jun 2026 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257209; cv=none; b=HpbAeXBcgqmUVsNbO/KW1PUDupkIvq7+9byKQPPPheLuLyhpSrBp5paWThSIW5FZQDWoUePum3RZrIFy61fLBviEzZ5AwI7qT9aGER1hHp1s8Fg2uYQw2j8JSxC276m+tKjbZu83PJnE/Z2//E7cxuO/ucIrGUQ13voo7rEFyC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257209; c=relaxed/simple;
	bh=Wzvy73KyYTW45n9ZJ9MmoGFzGCvO8qCyjfAx/Uhu3Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRNV5bQtx0PLCcRMdEGZYuA4jj4ULZm64ISWKjDWSXrxxtY2WILMfSaSz2I80R+4sS8XXVlXNS/KHsPOGeFjAMaVwd5pZnBIXfHswFqPiyY8klmiUjz1J0hDg4+NALg2/Di7ZTEci3/NZJb6eR4Yn7KWm5dVMpcJpUQlJbcfgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl5K8Ojm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl5K8Ojm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C891F00A3A;
	Fri, 12 Jun 2026 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781257207;
	bh=a+4a1HV1zBzSfSAhXIJWEqmWL1bzFWsb2FBCzKoKty4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bl5K8OjmgXAfBqvfucTyqBx9qBu4gHuuAvpAj68ODEGHHjO1jMi7LlUs615cdcaZV
	 KyNAwLTBOqyrrGwnqHOCkCZTgn5+faumkReZ9G/Ou2HJeTZ9vPqEvyY6kZEwh0YjAv
	 fGe263cNQqG00EyaCZvr2NHd4AtX9ueWNh1su6kPbVkfFyQbBG4YijWn7+5GDWsHfx
	 ebRvIbIsK8nVBA31/dJdzMKQkioATnAvxIHk7GfaoNOi87tR21gqxj5/WXgT4ss6c2
	 S8z1236abhAuw3eRMQWfniT+t859Zn5ZudThgqCiawWrWkGdQW2Ssl8wTbvORF8t+y
	 +uEYv34X7RaGg==
Date: Fri, 12 Jun 2026 11:40:03 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: hand over I2C to Andi Shyti
Message-ID: <aiswqff6pLnpfgBX@zenone.zhora.eu>
References: <20260609091612.8228-3-wsa+renesas@sang-engineering.com>
 <20260609091612.8228-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609091612.8228-4-wsa+renesas@sang-engineering.com>

Hi Wolfram,

On Tue, Jun 09, 2026 at 11:16:14AM +0200, Wolfram Sang wrote:
> After 13.5 years of maintaining I2C, it is finally time for me to move
> to other areas. So, I hereby transfer I2C maintainership to Andi Shyti.
> He has been taking care of the I2C host drivers for a while now and
> kindly agreed to look after the whole subsystem. Thank you, Andi! I also
> want to thank all contributors, reviewers, and fellow maintainers making
> all these years a mostly smooth ride. Happy hacking, everyone!
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I'm truly honoured to take on this role and I want to thank you
for all your mentoring and guidance over the years. I've learned
a great deal from you, and I hope to carry on the great work
you've done for the community.

Regardless of what the MAINTAINERS file may say, this will always
be your home. Enjoy your newfound free time, and happy hacking!

Merged to i2c/i2c-host-fixes.

Thank you,
Andi
