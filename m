Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446218;
	b=y1g4K76sKsEOMmWcvdHXY0Gzaq7sgvWKZHpkRnbR/IgeIkGm7yqc+1FwmYJ02fm7Q1Kk
	 OdQzSDCEizX8GKwmjwa+zGqF7VtSpP82lPhajVHIhpC0bR1pqPOGxp02unGGKGt5Z0oK3
	 bh+L1cSIcLvBNrEFV6xzvvPHAyOgdRzvpZykkix0N+M1fEWDHQ5bvFIyQ99pBjc+ZVUav
	 QKGUTulabJelduG3AqLIk0jKzvq2jM8g07rl/jwDTC5SqS8nD4sp9XXkAUQG/n5EX7J3I
	 BMQuonc62VtBdu4tH0EqUiHkL0BRt8lfdYPj2I6P3gx7QicGvri8QyCPCLJOH4WVIWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446218;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Hv1e4J9mZaDtpUBaC+0XrDwxU8XMKC697ozcM5Q6eUE=;
	b=rFOM2wfjTO37hXIX34pZ+9TPFixTK6I9wxRDUWQ8Yh9nqp4SiTPgZMDHoqmuUhL/Q6Nu
	 XEs/pamXuKX0f9CD3AGQICVIw6x0ptonqAOFVJkj5dviVUF5lgpqCSE4+L5fp4RIRhvye
	 PxrEfyszB5ngtN9y+Wj+OSLfW1KHapI46TqO3Lz6m31wCyBfT5ihGkUezhp+oMKaYsYl1
	 NIgZTKroykKwy9xlrIfqbNSUOPaiIrgMoZmCGK3mbQcC0ZTkgXIGkqSv0A8dVnzRhltgB
	 P2894Y2hg0djc99fNw/PxinFFJczcRXpsUZeW9vglpzFpKLiDAYlC3n9VaL8A821uew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="B/IayE/J";
	arc=none smtp.remote-ip=79.135.106.30
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590B606A31A
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 15:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E590B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=B/IayE/J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795446216; x=1795705416;
	bh=Hv1e4J9mZaDtpUBaC+0XrDwxU8XMKC697ozcM5Q6eUE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B/IayE/JJnRJXbC4nUgTCdXloEAZNr+GRF5dd1eJhzP/L0Z1y8YeQkt5mnc6oVywT
	 ocHiWTOKX+BzHOF0SU8s5x7Sqoy71uNLDffy/RcYKujOW1vcZcHNnCV+y23E+c57/Y
	 ZxGr6f3/xHXMuC13Exc1507ZaL+Rj1/3BKRWbfk9JgJfCpCJFOAzBUw3x9er8ZvQWT
	 tANYFsIEtjZi/s3LLhx75CI6+LOlxb2dKrD5z197nMjG6stjNtNxS9VBwlAnngqsBn
	 Ks1Kr+RUZHV7oo1nXNoIk+cJR9JRImB8BK6Z9du8xf3IoaqKX7bRca3FaV8fSRduYX
	 AV0su0CHLPvdg==
Date: Mon, 23 Nov 2026 15:03:29 +0000
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
From: penhouse24@proton.me
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Message-ID: <z-Mjt3eV50ZiycWjeVe9dfla5WKoCPC1UXZdFSx2V8YVhr77FH3eKc-WLQgGT_gu1l8NS_-IUcw_-ASU1x_al7IzQuW6FhccBUylTg0yZqM=@proton.me>
In-Reply-To: <70618789-f82a-4cd7-953a-a97f555fa98d@oss.qualcomm.com>
References: <20261118073607.297350-1-mika.westerberg@linux.intel.com> <70618789-f82a-4cd7-953a-a97f555fa98d@oss.qualcomm.com>
Feedback-ID: 217801480:user:proton
X-Pm-Message-ID: 82fefb8563f78b51c94ce8173912501dcdd98a0e
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Is it safe to say that this fix is going to get pushed to the main kernel?


Sent from Proton Mail for Android.

-------- Original Message --------
On Wednesday, 11/18/26 at 03:54 Hans de Goede <johannes.goede@oss.qualcomm.=
com> wrote:
Hi,

On 18-Nov-26 08:36, Mika Westerberg wrote:
> The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> when run at 400 kHz as the ACPI tables describe. This particular system
> does not use standard ACPI ID but it seems to use "Windows Device ID"
> VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> well.
>
> Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk=
.intel.com/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D214597
> Reported-by: penhouse24@proton.me
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> ---
> v2: Drop the DMI match, add bugzilla link.
>
> v1 can be found here:
>
> https://lore.kernel.org/linux-i2c/20261113083940.2583439-1-mika.westerber=
g@linux.intel.com/
>
>  drivers/i2c/i2c-core-acpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 84841ed13487..64fdf8ffb5ff 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -377,6 +377,12 @@ static const struct acpi_device_id i2c_acpi_force_10=
0khz_device_ids[] =3D {
>  =09{ .id =3D "ELAN0678" },
>  =09{ .id =3D "ELAN06FA" },
>  =09{ .id =3D "ELAN1300" },
> +=09/*
> +=09 * This is non-standard ACPI ID used by some Dell XPS 17 9720
> +=09 * systems. They do have the same issue when used with 400 kHz so
> +=09 * force 100 kHz.
> +=09 */
> +=09{ .id =3D "VEN_04F3" },
>  =09{ }
>  };
>


