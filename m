Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FC132D45B
	for <linux-i2c@vger.kernel.org>; Sat, 21 Feb 2026 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771667892; cv=pass; b=KyVXnyfTOxQjxq2p6Oo6bZ/lqqLbQ2m8dqSGTls1mNV6Wf2eMqPQDuRVo4RKoV+YsdKj1Ah+zaYm6jjfNqq4gombGfC5xYjbeJrBWPY4K8M/UHtzHY8FoJsEI7JC+C3YkfX1DYbkivsi6eW3JeFFIvham9+0W//NjaZhB1m/YNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771667892; c=relaxed/simple;
	bh=546Sml8dkyWjJgTVQenhnzU5L4ik3RWbDGorc6/PPSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTYTdNIrLo6fgfxmI8Cqf3lOBqtGaCnefaXn1jnJ7BasbE3gEf/BhWetfkAo2546YXnOtoH7Uc6OpJNgLaLM8J51sZkrPJBumvlrp2ZTvOzweQ32OhNGoNqXtJf2xXMG2jNtyfSxwshigWn6r1ai3d6mC+ewfkBTDSSywrElicQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSpyLUKW; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSpyLUKW"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124afd03fd1so3841066c88.0
        for <linux-i2c@vger.kernel.org>; Sat, 21 Feb 2026 01:58:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771667890; cv=none;
        d=google.com; s=arc-20240605;
        b=PCBneZCPhIMVfVjb0RdSd8ZRZFG/6LYKvnTzgY6aKUmPVANpwHZrHzH1pccEh11IdA
         98OpsFAGigUIEC+hSjIitdiHHc9IPfHfCQ9ReSw3Xdc2wdj821ZHy9rqlQxc+nWpuTyu
         VqENGyvRmNeTsa/uYR5w9mU9KnSc5Jde2VZnExbH4eTqVOnNWwLKM3xuboqoWsnhxvxK
         J9LnLY1UqZtVHOZrGRJBfwYjIQrid9UTzuBYJ6+TE1ky4RrxlepO0jT3/dssfaS7gr/L
         +hZVen/1BTiZzPSTvI63Hu162s3uNr39Mnuf17fQq1EBgUt8UHJwI4Nx9DLscyXqDmvG
         HBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MBiUXRZ65qmF3vQP1weOJhU/mYI+u2eTa3+b+VdPcAQ=;
        fh=mNvVVDLB5nUEi7mfr2E+6X+tAiE3+rw+vYwV8ymrm6o=;
        b=B2hFsvNwyvf3rC62C+ZnEf8jrFZfahlZfYtpbXmzXuAx7ia1l2ZNkwUNARlAj5AmT7
         iR6wUUq8K9HxyMqePoqIbNhpEIJzo81KCSRxf7tboh5LlsN9CctWKaA0QAnH1zqQT9k4
         075nBuMpTO0OYcCqNwyq3c8nf9lXHuTPqSnVQusUiQCs83pf2l33YTOZBQ5VPtZ9Ppb7
         IzUeRW6pLzbhbXhtq5hG5nMbcJltWLpH3b5zkgDq3fN7tn8BXOhafijNsy15xasJTcbT
         pli46g31ALp5zWGj9Y8xdu2hMKXVEzLUV2zhvAh/Ch65nXJRNkLE+pzSwOSLQZbHDH4q
         IDTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771667890; x=1772272690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBiUXRZ65qmF3vQP1weOJhU/mYI+u2eTa3+b+VdPcAQ=;
        b=fSpyLUKWl2jnUpkTb3XpKi56RmB5gKZUeDZ1Iw+RgJOSdbFyxV2+HNR930/Adydzhd
         Z3zbE17vQl079ebrwVNYGZuvBKQzO3NJUNYpdXxPJ6lRnZABe04uEvZYKBNwXdr+afhu
         qsbrbbMh1nxzvxdspsSaBTYouAWvn8OztnwJlKAm3HDYNTxOkEuEwSABBDT7JiVPsfCn
         QHijWgv/p1aIEhwHb66jGfRW4BgjfhZljOHEcM7AoZ0t0wb5d/UXflWKgkjXSOV8sxK/
         g8lQh3PozguS6xhG6nyzEyikV28jaYHaBZTeRxlMrFPFFUsL3CwfZ89ZxKn00E2BN4eJ
         tZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771667890; x=1772272690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBiUXRZ65qmF3vQP1weOJhU/mYI+u2eTa3+b+VdPcAQ=;
        b=aXo0NG7hR+jGIVrxLmZ0UbGInlNwVwSIcTvxRNAckE3tE+6E9abX95q3ZlA29sPzTn
         oE+m619ctus8jxMIRGX3sE4nWmri+FpOi+o/ODcUDDoh4fRDvirg3AtA2Hqvkye7m2xD
         20B+xOOMrxpBGw/aWnPxyu0SfRaAXr+IdBXtjFK0R7W2EpvhcdyVYWn0PrTtfdYKyEp8
         mo3cqOX070XpR9e1k/v/JQeWhe/p2e314VsTDpl2my1iQ4hH/8iajXQC6nMEMLk1rHyY
         lIXYI7S/Jbilsyl82UjUx/5n3Ok0rO2U/f0hwiOTi6/icFKglD78smPnD54PU81z9b0v
         CYFQ==
X-Gm-Message-State: AOJu0YxoX5a1eznCAno3XkAAKihU8pdxsDSInpE36uH/1dMsK+WZJTna
	kuQX2AkbLbwHxdmlOKgTxkfcNtrPdBI8NgWNZRyusYF8C2/ph45C/pHPi1QnxfpBYIhbnEyxz2H
	DfssahCOc5E/2kW2ydewhSBDQPSeFaEc=
X-Gm-Gg: AZuq6aKV+hKAOZfLnkWe04uVy0KuxUcaL+IWYbYw7rP1aQBbkYDcDmD9F70e9P+bNJn
	HDSg+RQcnxRwgLlNbjhZO+pwGmzTQ73Vh9Ip2Ocqf5WMyGqPsXOExWM5Ub76GPESqUwO6Uuma/y
	0gH3ZKaQs+lyKm7aTc32qw7SLNN8RwySXwqZWHiW8fVoI7HezNhv3SV4xedb+G+WRZoNqqJ1hsu
	IfN1R3G55u9+muU2Ml9oQILAiNpDUfFvPjptXdjg4WAouhJE5DnK1J6NmZfsxABH6d9Dp42QyKy
	Vzu1rwGBMmjtdc4kNxw=
X-Received: by 2002:a05:7022:418d:b0:11b:d6f2:a6d6 with SMTP id
 a92af1059eb24-1276ad53a17mr1224623c88.34.1771667889601; Sat, 21 Feb 2026
 01:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205102942.28745-1-tinsaetadesse2015@gmail.com>
In-Reply-To: <20260205102942.28745-1-tinsaetadesse2015@gmail.com>
From: TINSAE TADESSE <tinsaetadesse2015@gmail.com>
Date: Sat, 21 Feb 2026 12:57:53 +0300
X-Gm-Features: AaiRm51eZihZrWXS-ZaxbGyMP0Go7reLEEeB_RGr93b6ipfYOv-F9UZXLiF2FXM
Message-ID: <CAJ12PfPdkQD6VNROdSGYRWvHGf0FZ61Y-vF2uMB+vsnV1-KNNg@mail.gmail.com>
Subject: Re: [PATCH 0/2] i2c: i801: Detect SPD Write Disable and expose as
 adapter quirk
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, 
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:29=E2=80=AFPM Tinsae Tadesse
<tinsaetadesse2015@gmail.com> wrote:
>
> Hi I2C and HWMON maintainers,
>
> Intel i801 SMBus controllers feature a "SPD Write Disable" bit
> in the SMBHSTCFG register. When set by firmware, the hardware
> silently blocks all write transactions to the SPD EEPROM
> address range (0x50-0x57) while allowing reads to succeed.
>
> This creates a significant issue for the spd5118 hwmon driver.
> The SPD5118 requires write access for switching between
> register pages to read temperature data, and for cache
> synchronization during suspend/resume. When SPD Write Disable
> is set and the spd5118 driver attempts write transactions, the
> bus will generate a storm of SMBus DEV_ERR messages.
>
> This patch series proposes a generic solution by:
> 1. Introducing a new adapter quirk flag in include/linux/i2c.h
> to communicate this hardware restriction.
> 2. Modifying drivers/i2c/i2c-i801.c to detect the SPD Write
> Disable bit and set the quirk flag.
> 3. Modifying drivers/hwmon/spd5118.c to check for this quirk
> during probe and fail cleanly, as write access is mandatory.
>
> By using this mechanism, we avoid embedding device-specific
> policies in the controller driver and provide client drivers
> with the necessary information to make an informed decision.
>
> Tinsae Tadesse (2):
>   i2c: i801: Detect SPD Write Disable and expose as adapter quirk
>   hwmon: spd5118: Fail probe if SPD writes are disabled
>
>  drivers/hwmon/spd5118.c       | 15 +++++++++++++++
>  drivers/i2c/busses/i2c-i801.c | 16 +++++++++++++++-
>  include/linux/i2c.h           |  3 +++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> --
> 2.52.0
>


Hi Wolfram, Jean, and Andi;

Please review this patch series.

Thanks,
Tinsae Tadesse
