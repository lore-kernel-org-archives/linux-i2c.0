Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6E39B4A1
	for <linux-i2c@vger.kernel.org>; Mon,  9 Mar 2026 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057089; cv=none; b=MTCnxJRqwfAtsrpgObJdxZWQTBlfIr/njVrtRWZImX63g4La/VQ2YpRhoiyDeCudnq4ACJVE0Ux8CQHdnsSx5JQa0icJbXl3zE8StdwvH8jYGNYk2xWn0IlHIijLMYHWOAkU7koTZZ3FT6R/BXGg0biwXGg0uRziMeo0bNYPd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057089; c=relaxed/simple;
	bh=Q6Khgu7s6GI/Kiqe7k8YdKM2x5srxjMvphejInIc74c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGUwqq4qbwVyMipKAWtg1ifiiYEZZMpF4IKFDYtWaFExntpxLTYlyhr6uzlLliqhddl8psfhHntvjcjMWniK/Y7tmoXnVBccG2vBAx28l4fHyUQNrM2VtRTctl9qPlr4WZnpj0SHcNM8jSYu5MyjNYrhvX7ikUH6klF+smGksao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SG4bHQQm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SG4bHQQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=9Obo
	8Gy0XA25wtJr5nUH75+SmBoDD9gzbxy0pse51zo=; b=SG4bHQQmR0rX7VosFKnI
	NElZQF8NdYgOe6TZz/zGTk1VPqhuefyIBm986kOuXEbLJyoUtjAg5041Z+EkkKZf
	4ePH4CzS1xgHvbO3mQL86Ls2+SDzm7nzk55wJKUo+v3KXq0/Rvw5VfIQKT3KG1/4
	uIcnJJEQNdmNDIUvQEsxWY9RFjKycq1zHcstssectbzJXGPr/ce0HvwyMwDtKpD5
	R5DoL5RAMLa2YblMV71ZYCGqsKzHBIQn4jmf0IzKEZ9cdUoDykSTCUeNbAQkB9D7
	KYqzk3Pp+blknRp5JwyNhRu7bGiAkuIskoATFCvKQxbufrTiTWzSgkWCoYFj4GaE
	Lg==
Received: (qmail 2760960 invoked from network); 9 Mar 2026 12:51:25 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Mar 2026 12:51:25 +0100
X-UD-Smtp-Session: l3s3148p1@NX63BZZMwKMgAwDPXzF+ANZpdrMKUeLI
Date: Mon, 9 Mar 2026 12:51:24 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
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
	linux-media@vger.kernel.org
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Message-ID: <aa60PCE3wsEAZbcu@shikoro>
References: <aaFcs1miP88QWmtH@hovoldconsulting.com>
 <aaFfEsfh0xTh0b1y@shikoro>
 <aaFsZbiLYSz_YEjw@hovoldconsulting.com>
 <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
 <aaHI_VavZugXjVoL@hovoldconsulting.com>
 <CAMRc=MdKF29McBJ9U=qELkzf9GYV1CQpRF7U6OweDNtVzMXo7A@mail.gmail.com>
 <aacE-27iaYneKCJi@hovoldconsulting.com>
 <CAMRc=Mcx8Hu407arSEo3o-Xhmep_ZK4BM2TVi_55nXGwYcaijw@mail.gmail.com>
 <aagSewpM88KAZDcJ@shikoro>
 <aar3rj7Db6NmTVS_@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aar3rj7Db6NmTVS_@hovoldconsulting.com>

Hi Johan,

> I don't know what was said a conference some years ago or whether there
> was any misunderstanding on either side. What matters is what was
> posted.

What was posted was in accordance with what was discussed at said
conference. The people in the room (including gkh) were OK with the
compromise solution. If you are not and willing to provide a better
solution...

> Bartosz seems to agree that my suggestion to decouple the driver data
> from the i2c_adapter would be better, and I'm willing to do the job.

... you get all my support.

Thanks and happy hacking,

   Wolfram
