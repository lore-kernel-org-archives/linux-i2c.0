Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9A4908C6;
	Thu, 10 Sep 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047856; cv=none; b=sonMErdCAqKAOWGp3QaLF8157te6lVYuBp9HfASW/xbhNUaG9nIFjPNVhVQ+ClaW0DNDao9j1gffKTP2DT208Qw1q6qhPeHurDdL9ghyHCtr3ctTVOcr0IeSjOjYMbuzAE92F6wZBpkgrqwYLWjvsyWf8p425wrhfMvRBMMbV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047856; c=relaxed/simple;
	bh=bhBlXpxjlv9vvOjeOdNOIpUMSTUb1XtMvo4GabZZ8/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRav5xYSqgeu98t0LYVuedDkB8bxCE0GfonBYJD7GpV0goPnfJL30PymCY+XVrA0/DzqiGutU/q8lkfkXYBgw6WL/pACAYCbUygyF35M8H8cvkDoqrjUmdYDxtdvVGByJg75qHffJMnt12l/Ca2vVcgHRIZ4UOtfepA9ZXUZkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=riSlH4Zu; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=riSlH4Zu; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="riSlH4Zu";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="riSlH4Zu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1789047843;
	bh=bhBlXpxjlv9vvOjeOdNOIpUMSTUb1XtMvo4GabZZ8/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riSlH4ZuQmRVhT+OlMuhQz95kW5sjj03/ge8oty5FvVWrL4AqMeaLYm4+qB4w8c/F
	 rV1knWGXMI5L9ZclhInccTrvRLBGLFdhVvOt3WwpyIPVxnXv05Z77l87sTP/hqVFLi
	 wa7RXRQTFUTe+hYbpp+Y7qDx1zMMryluTwRyC4YbQ3R0wjHGhpjaEJsJureArmeDaa
	 AxgmhVRoVnVArcTBq287Wr8yFEc8NdwSurlsrDLL6NR73Wq+4MgzoMENqGh26VP0lU
	 2qlEY6GEDvXr5bVp3TmMdE7qXu3mpSwHSvGKWQg435pPxUo01ORDYQEORLAMtogmC4
	 ghAe9pvGf+nfA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 8197F19392;
	Thu, 10 Sep 2026 15:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1789047843;
	bh=bhBlXpxjlv9vvOjeOdNOIpUMSTUb1XtMvo4GabZZ8/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riSlH4ZuQmRVhT+OlMuhQz95kW5sjj03/ge8oty5FvVWrL4AqMeaLYm4+qB4w8c/F
	 rV1knWGXMI5L9ZclhInccTrvRLBGLFdhVvOt3WwpyIPVxnXv05Z77l87sTP/hqVFLi
	 wa7RXRQTFUTe+hYbpp+Y7qDx1zMMryluTwRyC4YbQ3R0wjHGhpjaEJsJureArmeDaa
	 AxgmhVRoVnVArcTBq287Wr8yFEc8NdwSurlsrDLL6NR73Wq+4MgzoMENqGh26VP0lU
	 2qlEY6GEDvXr5bVp3TmMdE7qXu3mpSwHSvGKWQg435pPxUo01ORDYQEORLAMtogmC4
	 ghAe9pvGf+nfA==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 3436D192B6;
	Thu, 10 Sep 2026 15:44:03 +0200 (CEST)
Date: Thu, 10 Sep 2026 15:44:01 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] i2c: mux: Factor out channel node lookup
Message-ID: <aqK0IeN68194ZnR1@gryt>
References: <cover.1788623619.git.ahmadexp@gmail.com>
 <adf12f66229d5faa0bc75571da1c3f53a1c81dd8.1788623619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf12f66229d5faa0bc75571da1c3f53a1c81dd8.1788623619.git.ahmadexp@gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Sep 07, 2026 at 11:26:22PM -0700, Ahmad Byagowi wrote:
> Move the existing Device Tree channel-node lookup into a helper in
> preparation for using generic firmware-node operations.
> 
> This is a pure refactoring with no functional change.
> 
> Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
