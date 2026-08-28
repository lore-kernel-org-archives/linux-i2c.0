Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A941C72;
	Fri, 28 Aug 2026 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881567; cv=none; b=sZ02HMezAa5FXrHN7HO8eAtMRkLIp0HwAQ8byMZdxqbbXdTiUx54F9JZH4U2LbCwGxfPOEJDelf8drKilplwOIBS2Hf6TY6QSKxNJM7IItLKsdgLaNv+FHbgpzJhVf6jwKFNoWVSrngo260bwMOT2I7DBY4qWvPH6t2xkw//Reo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881567; c=relaxed/simple;
	bh=A0roxpP2cm6y6R1pSCamGKk//vly6B70odWKmaqsUWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njLhy5OmJGTQZgovvPsqoNdnZWFMoJxrk2PqNyyd9YGYak6BYW5Fcu3wJrWZ85n8kqtBB3QS2byyT2yJq95AIr/2OeWjqa4Nnxd/rmGZ8j9xYLt7UAUGixsRewvQSzj/ZbWdJHsLOhdFzmTBM26FgIYaE5/1ABnUTxQobsOS7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGE/25hf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGE/25hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87AC1F000E9;
	Fri, 28 Aug 2026 01:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881566;
	bh=A0roxpP2cm6y6R1pSCamGKk//vly6B70odWKmaqsUWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kGE/25hfTE6jJn9Q6SdoFZoWWvqa038Ra+u3vEhAPUC01x5zbhv3j9or85uou+dWB
	 zXGfCUYCtHIqQUXjpPlEs0qYOjYNf+HritsFPYWBxuLQaYv7MSjnSu6ct/S+Gr4EDs
	 NOu7H8Nc1nO/ss0yXtdo2ktwX3tl3po4ao6LjQxb2J15dbUkBagTYWy8gN66SItrkv
	 xF2rJLLij1/NG1L4oMV8oDMW314bX1ZjQMYZK5UUZKLoBbWIjrZsl9YfOz11oG6Bwo
	 VIq6+AFCME4D0p5Q3cVDgvdK2AeZJDJi4QR5Q4KSaJcwykbH4LmIMN15IS95KA/oh/
	 Pk6pDZ64Xa9dw==
Date: Fri, 28 Aug 2026 03:46:03 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-i2c@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] i2c: ibm_iic: use devm for main allocation
Message-ID: <apDoKSrDuJ4D_Vhh@zenone.zhora.eu>
References: <20260821230217.319418-1-rosenp@gmail.com>
 <20260821230217.319418-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821230217.319418-4-rosenp@gmail.com>

Hi Rosen,

On Fri, Aug 21, 2026 at 04:02:16PM -0700, Rosen Penev wrote:
> Allows getting rid of kfree in failure and remove paths.

the patch is good, but as you are going to resend, the comment
for the commit log is still valid.

Thanks,
Andi
