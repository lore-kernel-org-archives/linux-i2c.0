Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC79498930;
	Thu, 10 Sep 2026 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047878; cv=none; b=QXgf1hP9vDMLBBxV7rd0U3shWJXaYI20qtvdQUKpeZ8bFWEgi1V1tsoGbHMAfyjEFhl6Fur4Q44pCHr8jYBp1amlM12DuEN6iHQWxoPUxZWGJtqC8QAyB4uD80Ui0gCGCwPp+M59dyzUwk4dTpEtwS/rH/Db7YtswOcH5tty0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047878; c=relaxed/simple;
	bh=uHPRfHidHNY53ZRFf4YLDmOTk5sG/yKOMUJ8xMGeIso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAwvsLYeJn+4p6P9NEw7DRRbFQnXgFZx50BzuVYgNsUOf1K1WqTUqjbGduQKJCCa1picaN/So67qZ/bOcOXywZCzmqD91Gxl5YbaF2icCZRxJd5ObE0fnmocqwOwAgwpgryTjt5pgZBxbVkMy8f+yZ5C2vcI71NU/WAcx3OxjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=UUAC2gis; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=Xtsap7hN; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="UUAC2gis";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="Xtsap7hN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1789047874;
	bh=uHPRfHidHNY53ZRFf4YLDmOTk5sG/yKOMUJ8xMGeIso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUAC2giseUYsO9Vh+FqwsGhEOoLBeOPGdA9QyBrdUEegs5r1snVJ1BGnOGXS/vJ9Q
	 eb9FechslmCuBZA6EOqoZe7Ft89NOK4J8Krj/DtBhxqqp9EYOWzHLsAQVyGU7otvLf
	 jgoSgXul/QFwEnvM/lbwzMy4k1gHwKHbcz/6mKljk2z69EXkhFgefeLr+L1yt4FsZO
	 hX6b2gZ1ebWwAW7bObdGY0u952OK9l0rQObODLAIBefiIyc9upzkpbdh3SzJHEnZec
	 ux31fCAUqxiAd9tB3QsEn0Q9eOovLShlhxnxgC4I70Mo8uvkEVkuldb/wvQrkry6+j
	 ZouK2ITlc47Kg==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id F1D8B192B9;
	Thu, 10 Sep 2026 15:44:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1789047873;
	bh=uHPRfHidHNY53ZRFf4YLDmOTk5sG/yKOMUJ8xMGeIso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xtsap7hNhMAJO+aEVvVVmxtH4OplqWRbXXF0VIKeDOesxKzGw4At4PlYQTH5dtS09
	 uEDU+eK6YS4K+SgcpzS47fVWxhIC8Tg+PdrlRFa5b50VZiRGKAvBYK6Fg8llPyC8fV
	 iV574pqucrBBDoaRtHQ+or/xpfWlTez4AOrwsPUjdMX+TzasqBLAEjC9YL7YffpeD0
	 B83rhP9GvanjJSGhtiKATQJCTuV4vBhXK8kwRoUHsU4mYLYOsizAP9yTtB4CaTPqQK
	 wOhGUdOsyOhJR8ePPxafdTnCNPqXlRArLDx86yuQe0o84YbaAKNfVdWX+PCQIjs/ge
	 yHxKGF7miD+QQ==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id B652A1931D;
	Thu, 10 Sep 2026 15:44:33 +0200 (CEST)
Date: Thu, 10 Sep 2026 15:44:32 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] i2c: mux: Propagate firmware nodes to channel
 adapters
Message-ID: <aqK0QKHjWTx1la4u@gryt>
References: <cover.1788623619.git.ahmadexp@gmail.com>
 <00b33b4b352848ff87dd9089190b35d8732676f3.1788623619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b33b4b352848ff87dd9089190b35d8732676f3.1788623619.git.ahmadexp@gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Sep 07, 2026 at 11:26:23PM -0700, Ahmad Byagowi wrote:
> Device Tree channel nodes are associated with the adapters created by
> i2c-mux, but equivalent firmware-node descriptions are not.
> 
> Use generic firmware-node operations for the existing channel lookup
> and associate the returned node with the adapter. Do not restrict the
> lookup by firmware-node type, so Device Tree, software nodes, and ACPI
> descriptions all follow the same property traversal. The existing
> acpi_preset_companion() call remains in place for the standard ACPI
> channel association.
> 
> Keep a separate reference to the node returned by the generic lookup
> because acpi_preset_companion() may replace the device's primary
> firmware node. Release the saved reference after adapter deletion.
> 
> Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>

Acked-by: Peter	Rosin <peda@axentia.se>

Cheers,
Peter
