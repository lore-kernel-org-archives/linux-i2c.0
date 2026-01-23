Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226127FB1C
	for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769207109; cv=pass; b=EfQ6aT7DluYZT7CkC3bbhLpDP4aOgab4BFuVncV6jU4AiB8ZfHoNIyi9Fmb+MMsdJlUDRwQPP8N2u2qOQL8JUSrI14X5u6bJA0BH7FvWKoIWZ9gaUggyMUNK9/cIJNv7bTQ/7Nka45NZOd6yfkEpb9ULiVmiWWaTA1HG8//dKhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769207109; c=relaxed/simple;
	bh=239CzrVPPT6MaRalPDuMYRuThFIpEKEjm6mQjkxF0qo=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pADT/O6zksnDbnbarwkCwSohuGWD4klAqJNV1yDH4FGUkMZwpj+1otFssu2HF4gEQ/jNSMqLz7tqjAdRheOQXwSJZ20Ca4u/+tIp7ii3if23TqvXFKdyPEUYiq5EQFKBKktzXTdqSJcKbuM0RCBhL80NHoiITpZ/Q7i6gNslgoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=NGCP8ahE; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="NGCP8ahE"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6495d592c10so1399006d50.1
        for <linux-i2c@vger.kernel.org>; Fri, 23 Jan 2026 14:25:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769207107; cv=none;
        d=google.com; s=arc-20240605;
        b=TXnBmIENXgPwM/IK7HkQaKDgBvsDyBMz9GkpsEXusZuz3HePKt0m+8v6U2xCjGMc3p
         XkbEj9WVEyvkfOAaw5mciqehQXH6usX2MStv83Ab1dp0/MuLhz721QDtekK3s4aHFSTf
         Fx41HOzmJqv5uuwEiAU3u0nYDuiGkiYjuFs+x7htIGq6oMUr+6W81YBhoBRxKUI30ebe
         ORpiIyRUczT4yhMK2nyxpCoEGp+sR8lKQisrF73C0f1uiCnIlibP1Aj7yGGvMXtwT+JD
         SQ5/wFT10P4JDNjbifPOW+Aoice+RBUABw3byKDwKuakdQ8KydCraKfrirSgK5wlFNq8
         zztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:dkim-signature;
        bh=uq0Bbktbk8y7WGuikPOCqhYRMF8Z5/AnUPjwZmM3BjA=;
        fh=bLULgutNC9FodV7JnXCEEoBDBLFPZNd31wR/9B5DL9I=;
        b=LqoUHqJigHCscdJwIIEntiCW3I6EEq0gRtrvqyN0Nk3L+duas5iCjLA24w8fQselLn
         xcluwcCgDE65sCBIkZARs0KVNtRl/tbXDfrJu1ACVfkTqpFY2Ya+Rug2b6Mj2jOnHJ2W
         qK/WFthizKhLV2a2W1BrKmsTlFg4E6r4ZwkdGMj9TTNb8osNVodEvcl8/StRuG3K4arL
         cy8mmcr4GDJ806amE+MtTcC6WxXjEEl0ZgQPIgIFT2gXPdECoW0vVWy15wgs+GuYIhsD
         4PoVcGXhByzVbAicJn+LlQ60H6wYmWqHGdftGVzLwXABNzcnhvjOaPx16HQq2OYIRsgI
         iYKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1769207107; x=1769811907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uq0Bbktbk8y7WGuikPOCqhYRMF8Z5/AnUPjwZmM3BjA=;
        b=NGCP8ahEh/OBKJ3n+7t0knfutC+ib/Nyb9D+cObCdq9gK+wD7t6BGX/07kQpta40Hi
         W3GmHmmQXzrIVhOezjE2mHyWoq9Z+ynCJeZQLaagcYXTg1Ln5/5FL5Z41GECnPF5JYeW
         TpshZ1zhZBWB5em2oPP6nYT2YTa+fm1grDPm3N5VrlNOENBKEL7kGXz7NXikSmGqiAeA
         SFcvSAnJXL4htiRU40VoecvdK9kbb6Eo3Nr0r2qLesA18AQh00HEg44iAWLc3fzdpJtw
         R7BuQxEj+2WPiXGy1+O35p9hjIm7BH5MRwd3lMesen0Vmc6fmvmR3PcZroqRd68X9Umq
         eeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769207107; x=1769811907;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uq0Bbktbk8y7WGuikPOCqhYRMF8Z5/AnUPjwZmM3BjA=;
        b=ZOZkOT+0PcKi4i7EoogvOTbStGUxBOdabTq4ymjS6EN7xYtZzLh7Irm9VdNRVlTLOk
         eyVveWz6a3hPPlI7rNCSzYCgmdqLmF4/eIQ2ALGsVURupFXXtnDza0d5AI9OeGgbbxtt
         byUb3oAXIpagAH6WWwumI0xJL0HplaV7pqHaO/6S/cPiBQ9W1RrNhkfNoZr/6ygMVTHU
         0cswTtMJ8oGEpRjwP7+z+LBVKaBWTk4o0uHu6aUE0AM7iweKFcf7rXwCRnyt1KIE6kdk
         8cCwCz15qLccDEZSqnPkHrmgHfT/nHjmdXKaJwXPJZXejUGBZOKBkGmowrbwfhWzKDuL
         WDnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7xXQCrTtvcHDshzr8sBDql/jxb7K2g4ZclS4MdZgXdhRMkUQ99YOLjnLjvUJRUR8W9esPAq6GY6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQf7vccA6E9jpetRISV1gzT5FD9U0JuR0v4XzRcpa23XgkHlNx
	lfdi7xRBZDElIRBVxM3XnWMGPZdQsmDbZzcJ/QOwbxZJcUnEeO4CO9PqgZJZSEYV1jqakvTkysx
	JkxkWzE3j7QUFxHf/7W8EQV9ty5VlPO6lNAsHzIiI4g==
X-Gm-Gg: AZuq6aJiKrn6icxWAuE9VOrNX2YmVQrjfzsM5c5bt0q237BAoNkrEa4z48edZar4hVM
	kf/jXXiChHBMBDvCTrkEJTlIhsNOShJ1VEX8wM4sUeWbAvP5Ucj8MtFW/vC0Waws8M8fY7LBrUl
	7wMmlk2U9FFPnJ48/Xy4eYwK/YD/Gh5shgdPrtdzeshhj7vPPQD1tEkKE6+BqyOsLGKj4vAvhcW
	azraKj1u3gz+J4Hhmf2fkehM6+zf7TrHBlyj978JWfRfGAkImajJeCyVNlo5RdVmPF6G575
X-Received: by 2002:a05:690e:4146:b0:641:f5bc:6984 with SMTP id
 956f58d0204a3-6495c0291b1mr3421254d50.80.1769207107135; Fri, 23 Jan 2026
 14:25:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 17:25:06 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Jan 2026 17:25:06 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-2-eb7cd4254dfb@nexthop.ai> <efe4e155-e307-481f-8332-783cca8a098a@lunn.ch>
 <CAGYn4vz3YuJ251JZFk7M=wsJr=bMY0Wq7x4Er=mjS_spyT5jLA@mail.gmail.com> <df4e0611-ce76-464c-be01-e3802b04877f@lunn.ch>
In-Reply-To: <df4e0611-ce76-464c-be01-e3802b04877f@lunn.ch>
Date: Fri, 23 Jan 2026 17:25:06 -0500
X-Gm-Features: AZwV_Qgn9XTijMwGH37i_MRyx6zWVhVWzL58EFtO9uJwNOMjVACM4iIsDuD-mAk
Message-ID: <CAGYn4vwg5pk4-HaO6_RXq9e4cC0oHBNpBBuLyXJ7zRLoP=gokg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] i2c: xiic: switch to managed version of mutex_init
To: Andrew Lunn <andrew@lunn.ch>, Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri Jan 23, 2026 at 9:36 PM UTC, Andrew Lunn wrote:
> On Fri, Jan 23, 2026 at 12:20:54PM -0800, Abdurrahman Hussain wrote:
>> On Fri Jan 23, 2026 at 7:22 PM UTC, Andrew Lunn wrote:
>> > On Fri, Jan 23, 2026 at 08:02:45AM +0000, Abdurrahman Hussain via B4 Relay wrote:
>> >> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>> >>
>> >> Simplify the error path by switching to a managed version of mutex_init.
>> >
>> > How does this simplify the error path? You don't remove anything from
>> > the error path.
>> >
>> >     Andrew
>>
>>
>> Thank you for the feedback. In v4, as suggested by Andy, I introduced managed
>> versions of the pm_runtime_ functions which do simplify the error handling.
>
> But this patch is not about pm_runtime_, it is about a mutex. How does
> this patch make the error path simpler? Please make sure your commit
> messages are accurate.
>

You are right. In the case of mutex there was no error path. I should have
worded it differently. In v4 pm_runtime changes were added to the same
patch, so the wording might actually be correct now.
