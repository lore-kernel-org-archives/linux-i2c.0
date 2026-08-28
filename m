Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ADF14A8B;
	Fri, 28 Aug 2026 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882910; cv=none; b=Rz6Yoy8AQ/t4JzGWXx3ehC38reoWMk7I30FDdjNZ4oHcadu/XgBgr8UkEwj8e3/kl3/gHIprefojDngalA6bHUynwpddNW5ZRtbNtDgnvAFxGn7aKSZvFJniLASSEa2FnyAP2Gecba/fsDhBzpG4ZAilyc5uns1+uM1fT5UtLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882910; c=relaxed/simple;
	bh=qnqvo6BwNgM8znYCCaGaBskiY1/ITHqDUkVNGvYwu2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5Lo0Ygur9AszRTk4x+XOLGP0kVR9PBPLj+KTghB4btuUc+Cc8OhnaVgiFO2zsSX3znIOXevrKKxmrFvcr6h+mv7V3tC6ioT7K2HUrMOH20wn3Lp/mkw6yQb3THirhEofgOUWqLvydqEmebq5H9GYHqAgG/p2CwGR/ZsE5/uk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg7TrTW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg7TrTW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AFF1F000E9;
	Fri, 28 Aug 2026 02:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787882909;
	bh=/PviFWQXQD3/pr+bxG0XJn9RxSD7I4bv4trnDHOO/yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vg7TrTW+cPZXqaizQLiqOJOftZZeunLabjAFpB8LwLyYNOHPeJr+aIIiSuUGas3iY
	 fKi1b6KPX0a/ZSws/X9ra1HCn/m4zDU9VnGITV/DYje9suIhoiQRiblJAlk1Oh/M/q
	 2HqF556no8lRFU5iDSGQ1Tm9YurISzoH8MKoFPiwPphwxEIhyRMg6RgSJ2gdBmwpvA
	 BF1MCyFE9OuwkXRTId6mA1CuRJvwTBgD+GYy213nIReUMnvy1uEyxhSBYEPdjILHzu
	 uVKhdJqOtT8W5PUROthJJM49lAfrncmIIlxAjHcOValqVNb8bQuywkFAHm2dwHHVVj
	 Di1R62JnqxD+w==
Date: Fri, 28 Aug 2026 04:08:26 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] i2c: bcm2835: Make sure clk_init_data is fully
 initialized
Message-ID: <apDtb3pOVJQCF_-g@zenone.zhora.eu>
References: <9f82f37e6d6c069cd44326bcd5e5a2a8069a13a9.1787239980.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f82f37e6d6c069cd44326bcd5e5a2a8069a13a9.1787239980.git.geert+renesas@glider.be>

Hi Geert,

On Fri, Aug 21, 2026 at 12:03:30PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

merged to i2c/i2c.

Thanks,
Andi
