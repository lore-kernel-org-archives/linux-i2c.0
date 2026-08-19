Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698C36B913;
	Wed, 19 Aug 2026 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170117; cv=none; b=fUc3bOFWVyAJuv8lAHOyMw9H56dyi02EtpvhQ7pignqwO2tuzGGamRiHKq8LQktARnlc/OBVvhBGIAUm5DCxg4X3pEe3S/xObW3+tKSipBuRBvUyptyJI5/YfbhsqPwimiJpZho7l1UbXczGaC3Kp/S7aHs6SYeW9uCkbS5v5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170117; c=relaxed/simple;
	bh=QoWsphHYvyJTk2t9qXEpR7vxDZObF2tw1lLNoCNq/Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn2dtYhW8+uRIaqiHfDLCY9grhEbXgrtPKpsg6TRjTMvSxw6uXUyTGq2a3t6gY54r57b8yh81pixB9U3KV5Oo/XMjZH8+/paXRxda2PAfNblxyUcRLi173pS/t1LXweMc4SFXHU+cMoPNIpTnuWmpXoFdqsK8XIWrr8O/h36Hjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck92LBvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck92LBvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C529A1F00A3A;
	Wed, 19 Aug 2026 20:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170115;
	bh=FdI9O4ZvLywL6F1HTm01pzPzLikJdKqRgfasj+/D874=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ck92LBvsUqO54MVOA42M6eTQbDLDvwYKIdxq7iUHOe/Jxf1NTP3hQVVruKjRSBhqe
	 F6mqDCKqzPD1cU8qKXO3+DlLrmX3lgECaUJVDSWLP//daQJts3vNL1iHEAIAXxFLDA
	 tHx6f8UfWULI8njYR7O/PLxAm5h6VNjfyGqrUr/8jK/nGLl8+6zjqadAx+QjslXmer
	 vetIhFqNljEKOPlW+9GyvSzvzhP+qx6z9GzJkqKwmPxPFJGr+Kb2aGz3FQ0iDEsmhB
	 uNgJm1MDCIpw3dN+EVcAWGAZYbP0AHJaojYO0WnPx9EO33Zej4uZMjOMyvfDuXn8QY
	 i+QVSnZ/1ggmA==
Date: Wed, 19 Aug 2026 22:08:32 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: rcar: fix reset handling for Gen5
Message-ID: <aoYNLqtPhQywjCNg@zenone.zhora.eu>
References: <20260817083046.11935-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817083046.11935-2-wsa+renesas@sang-engineering.com>

Hi Wolfram,

On Mon, Aug 17, 2026 at 10:26:45AM +0200, Wolfram Sang wrote:
> Missing reset_control_status() support is not Gen5 specific. It depends
> on the firmware used, if any. Refactor the code to handle missing
> reset_control_status() more generically.
> 
> Fixes: 87e713f20048 ("i2c: rcar: add R-Car Gen5 support")
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

merged to i2c/i2c.

Thanks,
Andi
