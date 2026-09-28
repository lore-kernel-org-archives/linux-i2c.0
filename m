Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5260376A16;
	Mon, 28 Sep 2026 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589646; cv=none; b=uDQtBio9TrVSbY//PqApHvorqqtotZtauZkQg6gQ/iSo49S9+2TcxI7bhLyXnmfJKUQ6iLri/VwL3PX998v9oRQ2lg3VeR3rsBOHLVM68PObuN3HuJibkYwBai6S0xUqgwVi2nRrJXMaPiFdSE8YVS6vbj0HXNu8SwsBaXCDJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589646; c=relaxed/simple;
	bh=op5mtiZAkT1L91chaYCYFcpf/NrcuO6G0vmvkj2IDlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6u0+udKOhKJtN7x4A8GKt/q3RPqp9/9NXDz6q5Qv+x6NauGRrmgN626rU59vEbWRFLsgBFeGBJg5EGkKcQUn/sANEuf5P12i4pPAt2LlQpror/X9A+oVCnuzcVf8Qs84Op0Z2uUN2e+71SB3saNvtwUms13RKuKumQTsCISqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7IDN0fx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7IDN0fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46691F000FF;
	Mon, 28 Sep 2026 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790589645;
	bh=F6NMInjal7rd7k40HeV9UzP6zM87fQBAHH/KtpxQDp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l7IDN0fx/CUVhBYtHM03mQinaLrm5+pJVY4y92CH9Gs5hzeKkGHtxFTUVAwcKXfke
	 vHWcxgK3v082RPtUsOHMIdGHCyLU0/EVBqpu28vuXjxH+xvjttU5UrIe8QF9eeJHPw
	 H/4rc3HOyj087iv8yrifZWmOuySkqfvh4D1Dor/o4fokYPy5fIGtoKUuiWa+jWP5lu
	 kY023oIeOxb6f3rlbHkUSjjIrVp+ft31rvOTDYr1Jz6oaIuslGleFjsyQesUKHxf++
	 1JoZjS/fpX9H8CYqfkZ04mnItqrmyFRRbo5+4QPp247+IUlgXwFhZ0SmbhNRZnq3T8
	 3kjXskol3w0Rg==
Date: Mon, 28 Sep 2026 12:00:42 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Pablo Mazzini <pmazzini@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] dt-bindings: i2c: mv64xxx: add Allwinner B288
Message-ID: <aro6uf6VJEtLYdOq@zenone.zhora.eu>
References: <20260927151016.186493-1-pmazzini@gmail.com>
 <20260927151016.186493-8-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927151016.186493-8-pmazzini@gmail.com>

Hi Pablo,

On Sun, Sep 27, 2026 at 04:10:12PM +0100, Pablo Mazzini wrote:
> The B288 controller follows the existing Allwinner variant.
> 
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
