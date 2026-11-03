Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736275;
	b=q1HQQ+j1G+g39btSrjyntSS8NF0BhsGQC+i0l0eoJeXo6Aw9N5I8dG+DUqi01Ze1XvkT
	 +EBWbgtLMV2sQGwEimvnKlwUsH85N9/hjQte2kjFC8W12SaBlF4XjE2qM0y4Cd12B2eht
	 OwPQGmL62z5X2Q1DITNlgjFqmbxHCt8UaCWL3nGqDThpQeWCRFdPkCq7RxjqI3Ia+Pyy6
	 B2ILDhcqzue/ZOTOEtKaTKpXoh9CH2iOb8Ac9V7FgJ2lVNrkiyYP2D6fKrxuePC2R2cBj
	 WAQUkVdiTwuDNQbFTdhTiKPRnFAQXc5voJoLopkTWpvqYsC9AO6e2hInltF0hpGJ0Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
	b=UWd00wAdeNkU5dM9j47GRgIVX4RLyE99fLpLUA0jAj70w93tXGaMTIJp4lY7jx4csH2N
	 oJkkKeodxtOYKxubHXLz7xlMRO6B/GAesgOr/7NCA/wSHoLorewxO/ORmDpa2jZiN6NEU
	 AvPS0cNpSfdD1j3Sak9udx7uV8D3GPTRfPwnS/dJ+H7DS6s/tG/3whHa2BONw+3eEFHDd
	 hEaG0h6oP6mc7P+Ey00g1e8rW1alFnvXDZ7xcQ20HXl5QCxJ+61WawchpRjDQLI4gMg0D
	 aW49IhPCl6J4Vv/DFD70NCVVmkp2YaBbLIRmy2/cgGKoNwjuLQTIQ+C1fT7mfcMRwRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MY3vc6Gb;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20016606A328
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 20:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20016606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MY3vc6Gb
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a18fc7a38so8824258eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793736274; x=1794341074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
        b=MY3vc6Gbvvfq42ubgxn7ZiALrft/xLB+7RdNtGFpyhdTAWULvE/ASxqtUVijeZaLAG
         pFKwTl7Old40mDX8hTr504VOvLwRmf6WVo0XKxWHImHyLsyuvO5cI1YC7tyUOb9E2Ov4
         ZupY/VOPLYTmU/TSmjc5sIO5R0nqbRrhc3gWtc1PAW4PGvUZRAa5TTXXr/Ol/wguGV04
         /NyrkwL8H+JcKuFKPUwQu2sHRwhVoxKd3+a7lgDpWBVwlzlTOj+u8qnjv3odQL7LHfl6
         id4GY7sKuMug1ts1LrY+1VLRHv5zI9HugBWlvGhAGFXapCIpnKpd9Sz4vKeVcJt7nGUP
         lk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736274; x=1794341074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=go4AIpvhBkoC7ZGd8wKwZdjhT/BPEGzJrSrX2YZDWhc=;
        b=g9eb4wTH8YH+o2tGppLQfBwiEYEW5m4TRghAkBVPUdFR+hbH5VAHRlRo1NCDW1eOOi
         JxUTv8CqvhZte8EvQGbcYIn6Of+wvY9mGVat7zDRKLQNuG0ZUtTTVLcsLwIe8Xqmk6Rw
         fFWOHYqbDSkM09UxS0VpRaNiPVqsf/G/0RNH4KDuQCXIBuHWbrWv1/SMRfkVbep7tKrp
         mmsPbDWdjq9r6IlWCZCzl9eeyfVud8JpsanwwhfCGYJBT5TRRO1IEq0cG25kB7YKnYOj
         HeOEHOKTqKMNXJNLHIw57yAsiogl8GKatXwmvZUsTvWT1GrAyBMAjJoaSbMipulzt3Va
         V5Ng==
X-Forwarded-Encrypted: i=1; AKwUvBz7FqPCLZCuO6zytoaURDNi60coxq7GLM7VOv2VrN1QiGu6e+866YwxywAnW486DY1i9uTibfG21PI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tsh3D2WwbC9O/sRHvyiQI9gUNNqrNU50lbJqIqn7uKYzWevPI
	8G2qCgrPvZOqALHBW4e52dh1TIHPbnxs9OfG4qkf5tNedAWgqNyF80jc
X-Gm-Gg: AYBFou3nvmSoMfASONrVKl4fR0BxS73w/X+L/BCW+Hyi4tBMuEpsTEV03FG3Ci7H+4J
	Gz7oqNpxNf1hTpkLm6qOXf1noLhS3Cxaf0aSrpWUi6oaeJdwyMo3ItiMh7TUKbfycsXIZFa6WMn
	yrh+bEfjsJPGPEV4za4+EhHFEw5tEJlcls4KMuHf2Ch8Hi8G8X/1xOh8Z9u5m5k72ybv7NVP21q
	84y/rBMoFqgIJJYk9BhQtWrdEpYmNOZOQirKh5ROhcyClcQT/B+BDykRdEuTh25Q/tqnOIiXulQ
	9dtaSBfaTv5+PX5M9sFF4boTg3hr2PK/88voM/4zXZmp1A+chDtS74LC2kZXaixeqGhuaNyOV6a
	RYzGtNEvoEHZGI7VyXXdo620H1nvqjS9baC59VQMY7kbvvt6JnRU+EfdeLfusiVV0mbu7raoFMP
	P61whHekpMU6+h0rQ0+w6AJ+eP5qMZ+W51rtzf+MJ2duzBC1J1KVTVxpqC6FdA00F4AyCxKhkKl
	s+/jXSLOEp9VHxpcC9geeWl6hBSquh/z62iFUUmkc+IWU3QIcQRdygTz+AVtQH1iiy7gKI+T5C4
	2yxSeeYAAgJdDsMROyA9fBb8DrnvzdLOg9V4q/RBsWv3ncIA2P1K4FJtyySGeZs5zutE
X-Received: by 2002:a05:7300:824b:b0:36a:1c75:8ca3 with SMTP id 5a478bee46e88-36a4221b3b9mr19658147eec.1.1793736274072;
        Tue, 03 Nov 2026 12:04:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm368905eec.9.2026.11.03.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:04:33 -0800 (PST)
Date: Tue, 3 Nov 2026 12:04:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>, 
	Corey Minyard <corey@minyard.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data()
 prototype in writing-clients
Message-ID: <auo-JCn9VES7OwX5@google.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com>
 <auI4Qq1KUo7YYVtG@zenone.zhora.eu>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auI4Qq1KUo7YYVtG@zenone.zhora.eu>

On Wed, Oct 28, 2026 at 07:00:49PM +0100, Andi Shyti wrote:
> Hi Dmitry,
> 
> On Sat, Oct 24, 2026 at 07:48:42PM -0700, Dmitry Torokhov wrote:
> > Update the prototype of i2c_smbus_read_block_data() in the SMBus
> > protocol function table to include the length parameter.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi, so will you be picking up the patches affecting drivers/i2c?

Thanks.

-- 
Dmitry
