Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72845191F91;
	Tue, 12 May 2026 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572281; cv=none; b=kfKWY/QZO1iAfxG2mmGeM6O/xMLdJXWF5SEzuf0g3i0W6qSDe1zEtkYRpVHG/Eqr9Q/ZnoiNuvTDUvB5v/tqusn8vEmxU7/Cl236vw/YMLlj1ehOuM+3pMu8jRyOUXunKtS0L9DzBc5ksHJDqaaWWegBjmdfkqedK/x7elVPF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572281; c=relaxed/simple;
	bh=v2j5OhmmPKVF4mTQ7sLBMKKFoJfp4yzS8nAZamACzbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UY+hIsMbOweLcO7k3HzbYizzcf7dthlIRXdWDZevNJNUshGf9KIT+4mYTbm+ZD2oJqSMFJoLZVsR8ZAaU+LHCMbxCnKoBaDK/jEaD7uU48IhmE+RkaffeyyxQmFpFGobd54cSKrQuopXf7cEs2IzMbn7+C21dS2kKUkcTSBme2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id D4C5DAEC9;
	Tue, 12 May 2026 09:51:09 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id C8456B006; Tue, 12 May 2026 09:51:09 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from gryt.home.arpa (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id EC559AEC4;
	Tue, 12 May 2026 09:51:06 +0200 (CEST)
From: Peter Rosin <peda@axentia.se>
To: abdurrahman@nexthop.ai
Cc: andi.shyti@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peda@axentia.se
Subject: Re: [PATCH] i2c: mux: reg: use device property accessors
Date: Tue, 12 May 2026 09:50:59 +0200
Message-ID: <20260512075059.258309-1-peda@axentia.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DIFQPMZMN7AN.YTWGF8U973JL@nexthop.ai>
References: <DIFQPMZMN7AN.YTWGF8U973JL@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

[note change of email adress, I'm now using peda@lysator.liu.se]

On Thu Feb 26, 2026 at 10:28 PM PST, Abdurrahman Hussain wrote:
> Hi Andy, Peter,
> 
> It looks like the patch is marked as "Changes Requested". I haven't
> heard any feedback lately. Did I miss something?

Hi!

First of all, as usual I'm sorry for being slow to respond.

One specific thing I noticed with your patch that is a potential
problem is that it replaces the open coded little-ending/big-endian
logic with a call to device_is_big_endian() which is not an exact
replacement. The logic provided by device_is_big_endian() is simply
not equivalent. Further, the new behavior does not match the device
tree bindings.

At a minimum, you need a matching patch for the binding before doing
something like this. But that would of course only expose the risk
for regressions.

Since there are apparently few who can test this driver, and even
fewer with endian issues, I'm reluctant to make these changes. I
would prefer to keep the endian logic exactly as it is.

I have not looked all that closely, but you also make the call to
devm_platform_get_and_ioremap_resource() unconditional. Why will
that change not cause regressions?

Your commit message is lacking, you make these changes but only
talk about extending support to non-OF platforms as if that is
the only thing that is going on.

And, the initail problem still stands. I would like to see some
tags that indicate that the driver still works for existing users.
Especially so since there are changes that look problematic.

Cheers,
Peter
