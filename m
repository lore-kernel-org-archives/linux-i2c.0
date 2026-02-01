Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6AF15665C
	for <linux-i2c@vger.kernel.org>; Sun,  1 Feb 2026 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769909444; cv=pass; b=bmQTH8P5bs97J9yYBnI8tv1U4tJA7yLiZo1bSIVo2a77hYepw88TrwmTkHxaSpPOarE9e5C56E20Efhy/uXjV/yEiB41Zaiy7hB2BrQ9HWpi3RF/vkKx9IDRlKqrlD71Qatau9wYY0OvzC7dTuKUTjZn+aXWTLcwY+r2iI87e7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769909444; c=relaxed/simple;
	bh=YtJzQSsz3r19x6lp4EmF1fkbMg2fNMXsYEr5P8h6zJQ=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSD1D3Zbvh97NiZBw84+2/NcVp3RrMi2aQW7B9xNSKPuEaV6KlHI+e1P5Iw0XFyP11nO+y5RujThKDbsBuw8sNih7IKWRAuHfPSXoEfWq5qOkD5msTkPR6L+2QMu4BbopeW1dY5EHyHE2/Upzc+0+19X3mJCB6vvPN8YBXIH1/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=gYzK34zH; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="gYzK34zH"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-794cbd4bb51so470197b3.3
        for <linux-i2c@vger.kernel.org>; Sat, 31 Jan 2026 17:30:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769909441; cv=none;
        d=google.com; s=arc-20240605;
        b=PMdGZ8egfXGkcUdHoxbjkf0yOktNKHaLYiWX05yxDEt0cpJdBTWC4l3YbTLMHG8NCs
         f4xKIXPR1vu96VcKx/+PY4tbR7k99/ml9rA5KOS7wYnI5EH5gciwxcSEZng9rU+FsflD
         yljPBup4qgi4KlLAVfuEMjSZ1DK9afiztIXIJOR6i9FGlBRNi67D7jaafS3uHUjamL0e
         Tu9Lmzo5fEm/LNQRlLCk5OtEljpPof+qVW7Afhyj7IDMEzLx126evW6TW09U0l2Vt+NS
         2hMzTgCFvCQ+AkDTAWTc5noY0yyRSJ7bv8kEBmBxDQJyeD3rgksVEyu76HV7p9R0cgon
         PiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:dkim-signature;
        bh=YtJzQSsz3r19x6lp4EmF1fkbMg2fNMXsYEr5P8h6zJQ=;
        fh=3Tx/itsSD2uOjI0oL6pX/K3WOd8Xma3I1pXI2NqCypw=;
        b=ktw2bsImKYTJxjVXytdV7nowm2PA4wWFcbYOJf+GjNLkNKb3YDRMeDevumt1TsEeDA
         8Y77j1L6AEHrPZEyAQQaaPK77LKIl7OnKe7P6dtGUBdUMTdeO9b0G5YB5JW8gWtjGFna
         lrrIDugj66osAj9qMzqwyRuBL45iPs6z9RCvvdwwJtUp94AOJJKv0fBFUo0szUSfMGa+
         StQVWR6QaSOGZW3G5tyM4lVR00PTxFebr3glKopSi7XcBsKh0OCM4jKj05VWP+rFKvAj
         uRDY+Y5XhU2qQxOE+Ccv8A0wURBcv6skOPJZsA9U2RblDf+LuE80TKSEmiCmyxv3YR0y
         tw6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1769909441; x=1770514241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtJzQSsz3r19x6lp4EmF1fkbMg2fNMXsYEr5P8h6zJQ=;
        b=gYzK34zHchmDkmR9qtexCQmBxxhV0NOwLpqlZuEpfWMn9GzSm+4RmX/qbO9tR5vnua
         vHAcJSuiowCdNBV0xE4IH8ewIDwYmkmDLwOZKmSEOeqxBSCHoUh2LpNUomo41xkYuObQ
         dTBufNx8j6jlKPMxmoGXJ6icHh21ne4AlUXuRZNGaQnShX5F5Q2z0OHLPbhetRAikpfJ
         nppmhIFLfeaQtBjJk3Ed2qKFek5a+pSeNU+8mY5tB9nUrluTbrVrksdfa5KLycJ4aEpf
         iAO/ENnzELfE0A/ZC5gPh8oZal+9WQY+XLBAf4g2t1PvN0L4G2Wxne1/MvgTxKb7WDuH
         KjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769909441; x=1770514241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtJzQSsz3r19x6lp4EmF1fkbMg2fNMXsYEr5P8h6zJQ=;
        b=FScoPEILzEGGIxaGRzEysd5sB+gJqYn5IseoTJ2K97TgP4B0SPwsVWVoBE6xm65rQm
         eZwcIXjGojC19zzThotyxte/SZad7JTNjTg50kCmcfI5ktX550QBCh4Bu3jCLaw26NQx
         fkb//53OgBGPQI2VPs/3hW6WAWW1Ki5qRErsLPpPtEP3hmw+C97TDDTV7lNAIwbNRUUd
         w+dUPRc6TzAaFlyW4KeG3iTBwuDUTiXQSiGg8qZFfe1pkQHi5Mx9nACJF2wsrb0mQBWE
         v4JmCVFZxBHuYFXTR5wkYpJsZnPg7HcRblRC4z6PiRcEjide0sgLSRUYzE1hycz4b/Xh
         ZzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu0bQMfsEO7QuNSONwaEtXKwDqwAkTjwnnpAg5B0X350ZpU5Uk5ypswrbawhFY6T22I2+eMm6rgNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpLWzURm49WaiHj1mjdOlXk3TT2inVGh39ygy40WS/DQ4fKka
	Qt/czba5N7a3q6VVChxBk4WdEbtA3vPcWwkskW9Osx3W/9SRfuf/Sk4P5rL/+/LjG4v7vqBvYp3
	zngTTe8iVCmZqVXfWkpTBdl7HjU/Br4MvxNbbxpNLQw==
X-Gm-Gg: AZuq6aLKdrDVRGmktdREs4WIAHKBfkucZM8uAdKmguNOYTDMbFnyRzH2fnEPwdAk/My
	weSLZYzjvQzq8xqk5awsuoQq7vpwN4HiXr40WzvTAmOR5Qy04alCJqsiuOK2gdv/rjJW8t0iX3J
	hiGxN/Z97Jc5u0fIaSOSysMXQZkW0WcV8bgRgQAI5Hj38kpGnz4lc1Oi6f1rgH0K9ey4cPWgmXV
	ZnnuGeFJgpuyNxKk7LuD/A0AkD7MurqHDMRW5/jgyqn2j2pfiNEXS9HD2z7Y77GkUfjicI2
X-Received: by 2002:a05:690c:10:b0:786:25e9:387c with SMTP id
 00721157ae682-7949dea8009mr71339287b3.20.1769909441554; Sat, 31 Jan 2026
 17:30:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Jan 2026 20:30:40 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Jan 2026 20:30:40 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
 <20260129-i2c-xiic-v7-1-727e434897ef@nexthop.ai> <ab9dc191-59c1-40a9-bbf1-e6c082af128a@lunn.ch>
 <2428D892-89F9-4013-9681-AD9BD76B0874@nexthop.ai> <aX3VqGlIUGCvMY5p@smile.fi.intel.com>
In-Reply-To: <aX3VqGlIUGCvMY5p@smile.fi.intel.com>
Date: Sat, 31 Jan 2026 20:30:40 -0500
X-Gm-Features: AZwV_QgjzkwTZse_VBoXXZ0HhPaLJE15hdM8B0uOOS1PwkXcf_ENvfshKOTUuzk
Message-ID: <CAGYn4vxRbPVFvzm1b_mk2KvnRcJSO0Ewmx1tCTEALaZAu+ZQJQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] i2c: xiic: skip input clock setup on non-OF systems
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat Jan 31, 2026 at 10:12 AM UTC, Andy Shevchenko wrote:
> On Thu, Jan 29, 2026 at 03:29:45PM -0800, Abdurrahman Hussain wrote:
>> > On Jan 29, 2026, at 2:43=E2=80=AFPM, Andrew Lunn <andrew@lunn.ch> wrot=
e:
>> > On Thu, Jan 29, 2026 at 09:43:13PM +0000, Abdurrahman Hussain via B4 R=
elay wrote:
>
>> >> The xiic driver supports operation without explicit clock configurati=
on
>> >> when clocks cannot be specified via firmware, such as on ACPI-based
>> >> systems.
>> >
>> > Are you saying it is technically impossible to specify a clock in
>> > ACPI?
>> >
>> > Maybe a more accurate would be:
>> >
>> > The xiic driver supports operation without explicit clock
>> > configuration when the clocks are not specified via firmware, such as
>> > when the ACPI tables are missing the description of the clocks.
>>
>> Actually, ACPI (since 6.5) added a ClockInput() macro that can be added =
to
>> _CRS of a device node. The ACPI subsystem in kernel could parse these an=
d
>> convert into proper clocks integrated with the CCF. But, AFAIK, this ide=
a was
>> rejected in the past.
>
> Rejected by which side? CCF?
> Because specification still has that.

I think the argument was that on ACPI based systems clocks are "owned"
by AML and there could be syncronizations issuebetween AML and the OS.

See https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1712165.ht=
ml
