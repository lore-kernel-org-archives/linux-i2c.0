Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9EC1DD877
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111642; cv=pass; b=LvshMniS5opf5oRojdjZYIa7Pv4nc7ArnJ3fp1MHLSd3O2thdGoTkzvkQIYJKd0eR6EuoHhzK/EApbiQferpvWgAByJNd1ZRbRy0TcQXXQCQ1C85RjduXgQV1ZK7oH9sIWW+d+gKO+TWSSVnIzQ6Bzcrf1mVJy0dIURJ54XRqho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111642; c=relaxed/simple;
	bh=Byx6HxjjOcWicJD2Q5fasjn2euE5iyByVMIaH1Tre40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE99rOuSsU0gKqLAQuO4A906pWNWVNiSz9vcSSjxbtuLQP9zj8XOo4w+TKfOfkNZlRNaBDMcc/vqn7yqZcWEB7Hv/y0QJ9Xb4D+4LQjaV+LUj4+BrWa0r2su+Sj7IBij1wxz7lBL11EoBbo4HC7+Dbo2FrUTo8eCLRtLhGbdROo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+XDhCim; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+XDhCim"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7cb345cb5bfso12050897b3.0
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 06:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779111640; cv=none;
        d=google.com; s=arc-20240605;
        b=DZ5Y69jjexOpsRPyfpufn8HYIOySuycNtFSurzmPnLavUqHxQFio5P8g7UXNy8m7PJ
         vs889xD0Ot9k2+STHCvLstpMho4QdnaAoc2d2BHshwZB0oJpGuF6tXtSP8yMG4Hddy+F
         xGGYDirPRXn09nW2/QnmL6Gfyj6nM4nffwwBGPjkwMp6c6iyDvZu4vKU9n/SzPN2AcnB
         C56fjCqMHVLyBFYvHpEXgqE/0l3mZsdI5IJ3wLekYXnNEnvdB1eEjgxy4sZ5k7Fhx3+0
         78UfHpcF63r/0rBmW6LmPNgfJPLqGHJOBRULskTWrnpYiTf9USDINldJtxcSrQnH2xOX
         GAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ffWEiO2cpDppGClUdUPZKnok9gRIvoU04CnIWfjJek=;
        fh=Gv7utp19iUjMHFEYvlFmcYbAdz6qZYG/Sn53CSQwps8=;
        b=OLKnX+ECF/d/fW7++W/EWPbTgr7IdaU4ZQs5nmRv6ujoWpU7AE1MxpkmAkpCahGgGZ
         Vu00J3t4+S6xnsaeZhxtKXSVOhFEt1zl3K0mLPj/Y2Uw28DhYx35BtxSjFSGHt9UoYO1
         xubcmNkRLXcFA0+vJTt6SxLulmWggtnbTHHMkbrjrXqQSadQ62Ji/Uqo5iupqv+U2iXn
         MjJ6bjXvmJrMv8Ut9LOe76Eby2xljzGnrN0DGbD+OYdCZY7dCKsqvQnJM573cqq/VoaO
         4Y+VR1q//zU8NgMcMmIeGJXMjN32qdbcSqtdDOxhL6AYSIf85b2RAUhzEq6bbLdS1aQ1
         grhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779111640; x=1779716440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ffWEiO2cpDppGClUdUPZKnok9gRIvoU04CnIWfjJek=;
        b=s+XDhCiml308Xx1MO+X8Zf/W6GmX/NTRcRIjW/WPQ1iKK6UKqLxoVyYTlT5LqMkEaC
         R/ss1efWnTkUHHks7YbIsR2X0gpAv7o3jDZrZndyedZj6FkyhPNGKWYY+WfFXQw/F1Qg
         wDQSEdTdhfh7//xL+dBLOACJBiC7eDYC/aH6A/jMsGM8WnAW/a8D38H096H2SuCSy7PG
         CIdpnnOowYnsHWNtMFf27ykc/jdRr8gllg7vO7isRZg89YTGcX3n1ZE0BP9eshuYCRzJ
         EaIE6wyCNVu/kMsd/d5lxajTzmp7IhDIz6h7YXG1+rfqO6bukf4M6ErZSNRzJCn0+jKT
         nzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111640; x=1779716440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ffWEiO2cpDppGClUdUPZKnok9gRIvoU04CnIWfjJek=;
        b=DsNRBQWpUwzgPW+qM5z6ymjPM9zReWbXHZ1naC+phjj/Exr+ywVUaLKaBg75p4s8n0
         yOR0SIhzMgY4dBx4Y3PyVVa8hw2Qmz58jffKdfuHvtU1ro0At94gXbNR44OxsyzGRwe5
         1Fd+PdPNqrE38IJY1sfDR7EDOMQOMaZSEEqD714gusT/Ak5laAwaCbpNYWqbmEOyMhLJ
         ZuN9KOiAk+G1aa/h1CFHg1gwqycKDEhWOw7yuiEWl5ki3cewOtHjqsyRGy0gU+sk0R6C
         5OyHw5SUSj+J2j91H0K8o4ezSEXJjrjbf77hts8qNq2YOf0EIqGszsuxLDTXfZVl3RkV
         6OBA==
X-Gm-Message-State: AOJu0YzOV7186QwpL9Lps6TL4vmDitwaZEuszXIH3i9QETGubVtPXHv7
	uVpGCRGqxMBUVIKMZxxnzBzsVhseOfUPYmJoL6KHUrAiz+emKxHZqAkggu0axlSkjoinSk2N5wU
	NbIv51r6YZKCPrcAkJJbjleviSNCuLjM=
X-Gm-Gg: Acq92OFXT9lK6nlEwbE/Av/9jlKyIwEO9hGY7UdtgBZzyylgMvi2EYBjdO35H98mlY0
	FY6yCtg6PPZhMr0Dyce6BgjjXFA1Dl5C80bd0Z9lD1iHJAY2p2gzAPLd4OacqkFtu/0X0gqJZI3
	vTYq5nofWFEGT/Clwi7QaytGhiZULbZ/msWg1/fJDlqnNmP4uSLIMk/lF+YXFKJIrCIRGfFyX+K
	Kr3J6n8rAk56HTvMAzQ/blvL4jVHkTltntAntjXYkNyXyp1/Z5RZANTqmLLVButGPr3nPzfdXJz
	8v9MPvMODxYzH+ZbbyCtH4je8NLpqnIe/ywHB70UYuBOLZRIiKe/YdVOOGJqaOwA8H6YAVbbhCN
	tHBQ7W/kCQj1Gno+LV48DwhDM4/bSoKmw/uYRc0vsYzf2OHUijMKJkXtt6pg=
X-Received: by 2002:a05:690c:102:b0:7c0:8e1:51fe with SMTP id
 00721157ae682-7c95c2fe856mr169541917b3.43.1779111640087; Mon, 18 May 2026
 06:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518122814.8975-1-hardikprakash.official@gmail.com> <d57dd297-6be1-43a9-a38d-e40c8949e23a@amd.com>
In-Reply-To: <d57dd297-6be1-43a9-a38d-e40c8949e23a@amd.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Mon, 18 May 2026 19:10:28 +0530
X-Gm-Features: AVHnY4J_px-0DzMSs5QjONU5xX1nl7wIQnCETZ2u2Xvf9C5OnFcvb0gr6v2ga6s
Message-ID: <CANTFpSWGC7GsAY-3UvPtBZzqjNek-T5haiDb59QYRoRgwuQf1w@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 18:17, Mario Limonciello wrote:
> I'd still like to avoid a quirk if we can.
>
> I know my proposed patch to try to probe at an earlier stage didn't
> work, but could you perhaps try pulling pinctrl-amd even earlier?
>
> Maybe fs_initcall()?

Tested. fs_initcall + patch 1 still produces the same arbitration
errors:

  subsys_initcall + patch 1:   arbitration errors persist
  fs_initcall + patch 1:       arbitration errors persist
  patch 1 + patch 2 (v5):     clean boot, touchscreen fully functional

The initcall level does not appear to be the determining factor on
this hardware. i2c_designware is still probing AMDI0010:02 before
pinctrl-amd finishes regardless of how early pinctrl-amd registers.
The explicit device_is_bound() deferral in patch 2 is the only
approach that has worked.

Thanks,
Hardik

On Mon, 18 May 2026 at 18:17, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 5/18/26 07:28, Hardik Prakash wrote:
> > Patch 1/2 (pinctrl-amd GPIO IRQ fix) is already in Linus Walleij's
> > tree. This series contains only the i2c-designware probe ordering fix,
> > based on top of that commit.
> >
> > The root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd
> > completes, so GPIO 157 (WACF2200 GpioInt per ACPI _CRS) has its
> > interrupt bits cleared when the first I2C transaction is attempted,
> > causing lost arbitration errors.
> >
> > A higher-level ACPI devlink approach was investigated in response to
> > Bartosz Golaszewski's suggestion. The DSDT has no _DEP object linking
> > AMDI0010:02 to AMDI0030:00, so fw_devlink has nothing to act on.
> > Setting this up at the ACPI layer would require either a firmware
> > change to add _DEP, or a DMI quirk in the ACPI scan path =E2=80=94 equa=
lly
> > quirk-based as the current approach.
>
> I'd still like to avoid a quirk if we can.
>
> I know my proposed patch to try to probe at an earlier stage didn't
> work, but could you perhaps try pulling pinctrl-amd even earlier?
>
> Maybe fs_initcall()?
>
> >
> > v5:
> >   - Add blank line before #include <linux/acpi.h> (Bartosz Golaszewski)
> >   - Use scoped_guard(device, gpio_dev) (Bartosz Golaszewski)
> >
> > v4:
> >   - Rebase onto Linus Walleij's tree (patch 1 already there)
> >   - Use --base so series is correctly 1/1 (Andy Shevchenko)
> >   - Add subsys_initcall test results (Mario Limonciello)
> >
> > v3:
> >   - Fix variable declaration style in dw_i2c_needs_amd_gpio_dep (Andy S=
hevchenko)
> >   - Add BugLink tag (Andy Shevchenko)
> >   - Add -v3 subject versioning (Andy Shevchenko)
> >   - CC AMD engineers (Andy Shevchenko)
> >
> > v2:
> >   - Replace custom HID/UID lookup with acpi_dev_get_first_match_dev() (=
Andy Shevchenko)
> >   - Use acpi_get_first_physical_node() for platform device lookup
> >   - Use device_is_bound() under device_lock() with explanatory comments
> >   - Fix dev_warn to use dev_name() instead of hardcoded suffix
> >   - Fix commit message (removed incorrect "existing" reference)
> >   - Add Assisted-by tags per coding-assistants.rst
> >
> > Kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D221494
> > Related: https://bugzilla.kernel.org/show_bug.cgi?id=3D221454
> >
> > Hardik Prakash (1):
> >    i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7
> >      14AGP11
> >
> >   drivers/i2c/busses/i2c-designware-platdrv.c | 76 ++++++++++++++++++++=
+
> >   1 file changed, 76 insertions(+)
> >
> > base-commit: 3812a9e84265a5cdd90d29fe8d97a023e91fb945
>
