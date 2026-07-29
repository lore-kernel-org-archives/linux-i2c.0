Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD395489865;
	Wed, 29 Jul 2026 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360501; cv=none; b=LxKeHqnTguqBdjexk1pfq2ICoTHENGNsdbDlfkhqyBwNYxZYP/578XaKs3/Q8qSqC3z6l4ubaXcx00GkL1BO9+FAV+BktCbxxkIAIMGJS1aA77KOBap4O/T6ooTKR4E3ddd3V2H0s/exZdLA4D+mP+FxGgRXtTrxWYy5dqRDulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360501; c=relaxed/simple;
	bh=R+WUBYuTvJCY/02YELUlnprrUuV7ZhttQvzOVny+Hs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcU6HbomUAVRbc1jNhVSjJKenGlbZ4dhYFPdSPA6ul0caPG5htfZIeXYSA/cfet5lJKkXijvMLtJHB+eMvEQ6r1o7/LJ29UcOy3B3mdq5a7EqzEuIFPiK8M14BqDUVaH2as+uYspxlN+61udiB6VJnS8NgfiEhGw8opbBLTMfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM0MaPXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM0MaPXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C031F000E9;
	Wed, 29 Jul 2026 21:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785360500;
	bh=R+WUBYuTvJCY/02YELUlnprrUuV7ZhttQvzOVny+Hs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IM0MaPXa04Upg2qyb5sL+QI1yGGSXWYdl7IPozcjia9Y6er6HSN/2md08FUI0YEa+
	 25ydMU+eQBe5lRBpdjYlELMV6sDy44CDX5ZzDgrKfNxvogS2YAdc9Mn2uAr/3c2ChZ
	 5MOFfzvvpb9palYdI2YOtw7RwI+8pn3IjzjoPYaklraoO9cjhPAgYh46+MXjStCBAz
	 J1S1h2FkkkuF+QNCSE+nQBlmQg+ucrZdRkJOLqUJlM5YKqnEUBRucsJvkl1PzHU3mR
	 F6zugN5za6wZ/8b+SqVmnRwackFhsKcGROKY4uidbTOd5ihxSNz4TCwt9X1J6Dp52V
	 bCPuAzCjlmNhw==
Date: Wed, 29 Jul 2026 23:28:15 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Michael Zavertkin <misha.zavertkin@mail.ru>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: rtl9300: remove IO_MODE configuration
Message-ID: <ampwUI8kb3QiE1vN@zenone.zhora.eu>
References: <amRyBYZrBKY6uxd0@gamepc>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amRyBYZrBKY6uxd0@gamepc>

Hi Michael,

On Sat, Jul 25, 2026 at 03:21:25PM +0700, Michael Zavertkin wrote:
> IO_MODE is used to route peripheral controller to SoC pins. This is a
> job for pinctrl driver.

where exactly is the pinctrl driver doing it?

Andi
