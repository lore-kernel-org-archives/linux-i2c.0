Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868040;
	b=OjEb1LxCn3w/f2S+xHYlksUcSbiQ02daPYhURDNvoT/9IOUVNuZuSwMXFO9bplEKFIOM
	 ksZUruA9Ic6qnY+X4feiFI/InlVeKRoANAAs83L6r1lK4KgJKIqw1l4TMK3h6PP8ewvyL
	 dLVG71s5Zqh9/3se24DS1ALpJ3/pYyZI45rnlpuvM2SHI8EGSP/lLIQo+Xo6Xrp5uMZI7
	 9/yWcqPeyRZzCAiznio8vVzAt6DHo2uq/9qLtIWwEwfc5gcowS8TxssfkR5KuF0noUbdf
	 44BkOVuAxkK/1AUhkEaBo0CNqnKbLR4zJCjrENbhVoTcMdmqYxqZ2kit1jly4zFXxuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868040;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J5gXWu5vrhC9QDJv+VoLu5Rd6y7WbcJ3q2qRfmo4/U4=;
	b=NScWKcrkJGi9WjyCm4Uzts/HE8a8oU0SfpLnwQIE+JdCmpba1KjByykwA2yaU6eDL/DO
	 4gS/jLhu2gaPmp+VgTkW4KTp2edNky2aw0Htyhj8fPMmyDR7ofgPZCAogpYf6y4KucyLw
	 3oj7/skvxHERcVvxboxNNXJLWva14Rmyv8zP4ovBU5JfuB3ySqCxaYd7aMM0WXBomaPCZ
	 hCOEIvobEQHzv/19OrJdT6J26EOwm1ldpMA4PSLfBJZkQuEtteXqFMC6HQpJHD+gnaLcH
	 332kmN14lsHElBL4J0xc2pvnB3kDMKDeh3pWqEVRcBZN3I2Z4fIkM+Kx1rva8H7ewng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpSPsDb0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB32606A31B
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpSPsDb0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E841F00A02
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868039;
	bh=J5gXWu5vrhC9QDJv+VoLu5Rd6y7WbcJ3q2qRfmo4/U4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kpSPsDb0yPQzspx+pqXsOCUHH+PRE6+AJ0v+Slnebfzq6r6tdzfzzHoYsr5YsL5dH
	 e6Ow5CnNiAsuUEYZnq1+XUDNFXZuN7lKEoIoiAp3mXjJF5sIlRy5ARHl3LFYs1NVzz
	 SvJ5wEm/2nD4A2mG5+XvFKYG3KzUdbW+OjZ5TvnRrOhch6tab3o4uDz1URd+clau5/
	 LAtJlmietwPFF0Q6o7oE2+m3++OMc/iFdLqWBZai6FPcjRToNXZPC6NjBQOOaikJMT
	 tTVw7wloZkwDxq45GG8x8B88azC3zj7gqG5IyaC376xYKKH4PKnnJrFHI4IeoyLFUS
	 xBk+E5aNQPgMQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso1154704e87.3
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 00:40:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwTjAXBxi6Smn4uv9bCSmDAYXUkNu+xIpuW6sPwBLiL9kScLb2IiLg1Tjw9z50hOaBg+e23+L4lWis=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xB3q+GhA1hPg+NTUJZGiAUrgsd5EbTupfwlwRyTxi5QBuSmoV
	U32nsm0Gh0OsmLA/mQd4Q8GI2eVmOZFNuPscCCoeSZA0fMJv0eKY8sT2DX38uUfkLQCfyBu3W7P
	Y7mEzUSSdmI9VUz0+XizI5sUw4VEIy1Y=
X-Received: by 2002:a05:6512:3b2c:b0:5bf:fbe4:4b2 with SMTP id
 2adb3069b0e04-5bffbe406admr445427e87.30.1793868038566; Thu, 05 Nov 2026
 00:40:38 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com> <20261103-i2c-nomadik-fixes-v1-5-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-5-655c6af2cb70@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 09:40:27 +0100
X-Gmail-Original-Message-ID: <CAD++jL=9tVg=mAr=hcJuSKwFdCoRfrH792VUQ7m21avp_-ei4Q@mail.gmail.com>
X-Gm-Features: AclHuK_dYZjPrUpcWVPYkjWE1wavAEhVwWZvTK26ps86c6G9B9jsBZbaCvbMhQI
Message-ID: <CAD++jL=9tVg=mAr=hcJuSKwFdCoRfrH792VUQ7m21avp_-ei4Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] i2c: nomadik: add quirks max_len=2047 and no_zero_len_read
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>, Ben Dooks <ben-linux@fluff.org>, 
	Andrea Gallo <andrea.gallo@stericsson.com>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:29=E2=80=AFAM Dmitry Guzman <Dmitry.Guzman@mobiley=
e.com> wrote:

> In Nomadik I2c controller, register I2C_MCR has 11-bit wide LENGTH
> field. Its maximum value is 2047, so this is the maximum length of a
> single message. It is less than the common maximum I2C message length in
> I2C subsystem (8192), so define a quirk in order to report the
> unsupported message without any attempt to transfer it.
>
> Zero length reading doesn't work properly on this controller, so add
> `I2C_AQ_NO_ZERO_LEN_READ` quirk flag.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
