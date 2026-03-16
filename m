Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC71381B1F
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650334; cv=none; b=hZ7yJJ1GK03lFhFUbFPnMMJYpPSj9/RZj5giP1jJBXqrIoE1yjYXFSkIUI52qbEHVI6GGOfVIwzSEwfLDj6A1hMidqPglZeoYxJ6a96n7u8iV+JJVJfj66R2/fcShY06GkWKlbxrkykv1AGc8m304xQHnez/R3j7S2Zpkwwhn3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650334; c=relaxed/simple;
	bh=q+vFSXKoktXCzoie09hlukWzsSVNCur23A3jXnht1uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlkEoMhvMDt/qgkWShClp0wuxLL1rN0VXM11hEoSOae9ZwgKSxltziYhbtVsSYFaetx4sSiHPUIlCrMh5UiVT4lyn0dj+AoZDr5pg/zE0XYHr6Rz7GRV95i7Z7Up2c0+0+lCZmOhZfvqDY9uD+vyjlEqgpjTEcAR1zYWpDwi51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hjpgeXH2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hjpgeXH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=V96C
	IUlR+qKpqcsbJ7QQgPxxBdQqkfPBggaGNnMwS4w=; b=hjpgeXH2qeJdxe0TDWI9
	5itL1/4hc9D2a+V4RZhgtiB9CWGMEHN9LA7J+EoA5+baPk8u931NSMNhU3DZPRRC
	rg8V5cjBbEgBgcQOcA3YNSZNVKzGPZo6C0ytU1lBlga9C8r6ycobgEnybDjcv8iO
	Xtf7m2JOUC+hCz4oY/iSrfpDW9ZNvwSYJkuYIAMpHSA+XVdAGOPpaOI6acGak1m7
	n63NcrXCvaq/G6tI70iIXARunUvgyhZDU68XVEoZnxCwcOrK3ebrjkSYHylQmRla
	g2f5ZxyWE3AcVqSgCZlMP4v75LsEkLRwnStHk4T0oN8cDzzPYkhkeMgGudo3Aj3C
	Hw==
Received: (qmail 1334043 invoked from network); 16 Mar 2026 09:38:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Mar 2026 09:38:48 +0100
X-UD-Smtp-Session: l3s3148p1@+MK+JSBNsKQ+XdJ7
Date: Mon, 16 Mar 2026 09:38:42 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Khalil Blaiech <kblaiech@nvidia.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
	Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 01/13] media: saa7134: rename i2c_dbg() to
 saa7134_i2c_dbg()
Message-ID: <abfBkg8YpDKIlOVu@shikoro>
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <20260223-i2c-printk-helpers-v2-1-13b2a97762af@oss.qualcomm.com>
 <76fd11b2-7789-47c1-a832-12907155ead1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76fd11b2-7789-47c1-a832-12907155ead1@kernel.org>

Hi Hans,

> Do you want to merge this through the i2c subsystem? Or do you want me to
> merge this patch through the media subsystem?

The rest of this series has been dropped in favor of a different
approach. I still think this single patch here is useful, so if you
could pick it up, that would make a potential future change easier.

Thanks and happy hacking,

   Wolfram

