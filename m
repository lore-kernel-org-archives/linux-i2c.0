Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC8379C4A;
	Mon,  8 Jun 2026 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921731; cv=none; b=cY53n8Hz1uDDokeUQ8mf3wYLhJZ9VLEOeANWmtu0w8CWbTu7PxrbW9zQKj3REGQXesikgKl3SpU2/U61PV7zS3djQVHyTdkN9XUW/C7LbYA1jS2aGwGsfima9aRtTivSHeGUYQEgzFEd1tE/fdHVN+y7074QTlXVu/uGUJ4lQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921731; c=relaxed/simple;
	bh=BU8QJkbnRIZPvZPHzsy8pMkwLxpYoX525O+jRY6OO2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bML9NXzaxXRobgkuwJUrjKtzLJd57B4IJYPApW0CedvKZalSfwpQFuHSHTpj7ojcwzUoQRSfAP4u+G80AUWsWz4sE7/ECsGBQ9x0zzCP/7JuGdI2Nipug+z0EPnSJq9UwKt+T+rSQt4XiL5ftT5LxtqrGvmI0/6q/CkRcC5Agpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwVAllbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwVAllbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FAF1F00893;
	Mon,  8 Jun 2026 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780921730;
	bh=jXq0GdSHP0DwNyqWjhHsbSNzPuHrPZAcCL3EgZ1TNZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KwVAllbpFb7GApT8cAABw+52uLj/NEmWP2iIz6bIZjURhKQqPSSnWbJJRAm7Ym91x
	 c/92Z/e6I12Ey5syQvkqx29CHquohydb3BsELwrnCnt9ISbO02aQlYGTYLl8PAJbF5
	 x6lKL8HhGBde57ukVc2Y3CkiImWJZS3jghVWdEI9T9zCxog5hs0MLNNcvZr00kKE+y
	 dATy78cbVRdXPfVqbm+ItOtPxNOyFrkgWpB/w+CzIX7afj+dAZDxRdn6fhNG7fhH53
	 RsP8dA716iQ/P2hJUo3u7IOL90VGXyyRyr5bK897ROLbvx4VsWE65mrpRd0echGEPv
	 DNbKDagpIicrw==
Date: Mon, 8 Jun 2026 14:28:45 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: i801: Detect SPD Write Disable and expose as
 adapter quirk
Message-ID: <aiaw_mwxbuCqzCtY@zenone.zhora.eu>
References: <20260205102942.28745-1-tinsaetadesse2015@gmail.com>
 <20260205102942.28745-2-tinsaetadesse2015@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205102942.28745-2-tinsaetadesse2015@gmail.com>

Hi Tinsae,

sorry for the very late reply.

> +/* SPD writes are blocked by host controller */
> +#define I2C_AQ_SPD_WRITE_DISABLED	BIT(8)
> +

We don't need this extra flag, we already do this statement in
i2c_register_spd().

Can't we just assume that for spd5118 spd write is always
disabled? That's what happens in i2c_register_spd.

Check:

84d477354b0a ("i2c: smbus: Support DDR5 and LPDDR5 SPD EEPROMs")
4d6d35d3417d ("i2c: smbus: introduce Write Disable-aware SPD instantiating functions")

Thanks,
Andi
