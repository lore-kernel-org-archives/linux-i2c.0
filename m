Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499FF3A6411
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578485; cv=none; b=m/3yuel9DHuTQ4uufFSty4qTQZM1t6i8MoePjetHsHWty3vYevjANU1qqerIIpfHqo+CahmRUYefrhmgIKnJB5wLDNq3L7IiJsBGeDBjC/tWBUP4e5KSvuWR0Zhi2nLhwttP0T+PRnYz6lX6IYIE9YJsLZGHDL+mO0tKHoiKVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578485; c=relaxed/simple;
	bh=RLXaDuMnAOgj7DffKute+j5a4bUQyT98lWmpj5fWoLA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=G+5g3uNJb+XAFOg6nin6897sGjVs7oYgVeFmMzBzzv0jnoOMBN6um8njkxE0+WGyXzz4ug8zT2MJuCQaeng1lvHo9uK8XQI1Aq5RUnPUkI/TjDdruG02fCV3OYL5Fp/CxSkSz3ksjTsjiuFrvXDXqtHxnGccvfVWH8BmiW/KRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=VlZ406x9; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="VlZ406x9"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f7020a928eso7315569eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778578480; x=1779183280; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvccDdzgaBL7gkenW4WwoZl3iLgl46TscHBK94VPRTQ=;
        b=VlZ406x9kaJDkYjXMXVXtYms7vyxY11GF6Xsm5mU8OhEqZqFlCWKjjQ4KVD1sAp1qN
         nrwbh2K7woE1c5DL6qGRfpSo3pWo4edp4drYP3Km+bMTEdjIl3yN80Jy72yY0I8UKzZO
         uQjkUx5b7iSrD5HNeCLSRw5pKGa3GaWUWb6SaRKVnyBunFaoyf3YXhwlARGOzxt9eyDP
         /lnotFETb3NVfr5zyVtg5Q0URVsSWkvPMEoS4czXtt5FYp9N3F9cfEX2uZEtws3ZyeUp
         wu39QtuWJnWsVX38G+EM9SLW+JxIH3/aL/qAaAl/PVjBns9Sfgg9v5MXcEQUR87zJikY
         5K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578480; x=1779183280;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvccDdzgaBL7gkenW4WwoZl3iLgl46TscHBK94VPRTQ=;
        b=LUTwk7PWHyilj8Mk1Boh/V2O+yi1VgoWeV/yGIrjm2jxc6u2ToVeGA8dQjcPELj3/7
         YvalY2ygxGYD3VavJQhT5AwT2a3aYsaOOZDHCI0t/KvVsNxiAdL8HsXqxMofQiCsvAql
         scppO2niokvsFKBzY/dXttI1a+4Ou+oy4+cLZMw63zyc6I8y43KZyC3/WyMOSlxGb0Fa
         EO7OoeBCHqBaGjkCqLjdwoEAWdvomUIrHgIs+ypFm2/2dn1IgbulDfHhN+wbsl+cHEXI
         GZR93uBUoufmUldjV8JCFw4RE7bID80KiLMLl75ojD0ewbws03MD5vHl7vrrCqncDYKs
         St9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+bLcupZzNy3ZpkvXqsy1gtx4vfREfDvIV7GYXcaBp777MHZIwVVtUicvQK17lGlfFnKvaOsvJCVWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcrxWt8oAtTxgkKvjiBJ4aKzbwVhtxdu4IxChgjQvzUjmbbf9
	TdAEwU0i0iltxzj7ttVS2TKIyRLIO60d4ErUft3t8xMbnqu+l7XWXfnpS69ARBPyQDxnCDyJB1T
	75vSlcuE=
X-Gm-Gg: Acq92OGa4Iifre/GV0mKeudoVhkA1kudoSK+Gs0ydM6+VLpEi4lo4iI74hv4HcC/zuz
	V7RYzXqzjleXSqe7vpX2zXvms8LNE3ZXkRAuTTNxgKIR03iVIkn4b4BtmLc9mWrqVfZ+ozuHqWu
	LlHpHkcCUzbKVF+t3SUDIKKq8nUJAMofXfzLnao6AcnwQBk3c7EjAYwGs64ZUowTV7glzlYHyFN
	IRo8/1nrlmTY2t2yfjvXeEymYMnnXJp3QyMrkJpSINXRJrk5GvgKQytnAi12EQI6uJGteeEQA0s
	GHSTAgu8p0GZoU+RQR/ixRSJlTtC2H0Of1BOPSq87C5eivY/uRn3EcmUmq4PIpbREfC+fkWWgu2
	ePbnE4T9Xlgp3Yjb4xJ/p9UhvQcnzjzm5Qbeq4gtM03wXbv114bFAE9M//kbF1syy0Txf7kVnyW
	sDPcOrjBX7sH+4BBh9LPzS2il08d0o+GDBhg==
X-Received: by 2002:a05:7301:24a5:b0:2ed:2942:34ab with SMTP id 5a478bee46e88-2ffd57c438dmr1201927eec.3.1778578480090;
        Tue, 12 May 2026 02:34:40 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8884752a9sm16860963eec.16.2026.05.12.02.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 02:34:38 -0700
Message-Id: <DIGLG9FGWR3Q.1Y9RWSUW4KXQJ@nexthop.ai>
Subject: Re: [PATCH] i2c: mux: reg: use device property accessors
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Peter Rosin" <peda@axentia.se>, <abdurrahman@nexthop.ai>
Cc: <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <DIFQPMZMN7AN.YTWGF8U973JL@nexthop.ai>
 <20260512075059.258309-1-peda@axentia.se>
In-Reply-To: <20260512075059.258309-1-peda@axentia.se>

On Tue May 12, 2026 at 12:50 AM PDT, Peter Rosin wrote:
> [note change of email adress, I'm now using peda@lysator.liu.se]
>
> On Thu Feb 26, 2026 at 10:28 PM PST, Abdurrahman Hussain wrote:
>> Hi Andy, Peter,
>>=20
>> It looks like the patch is marked as "Changes Requested". I haven't
>> heard any feedback lately. Did I miss something?
>
> Hi!
>
> First of all, as usual I'm sorry for being slow to respond.

Hi Peter!

>
> One specific thing I noticed with your patch that is a potential
> problem is that it replaces the open coded little-ending/big-endian
> logic with a call to device_is_big_endian() which is not an exact
> replacement. The logic provided by device_is_big_endian() is simply
> not equivalent. Further, the new behavior does not match the device
> tree bindings.
>
> At a minimum, you need a matching patch for the binding before doing
> something like this. But that would of course only expose the risk
> for regressions.
>
> Since there are apparently few who can test this driver, and even
> fewer with endian issues, I'm reluctant to make these changes. I
> would prefer to keep the endian logic exactly as it is.
>

You are right. Reviewing the helper:

  static inline bool fwnode_device_is_big_endian(const struct fwnode_handle=
 *fwnode)
  {
          if (fwnode_property_present(fwnode, "big-endian"))
                  return true;
          if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
              fwnode_property_present(fwnode, "native-endian"))
                  return true;
          return false;
  }

it does not consult "little-endian" at all, and on a big-endian host
with no endian property in DT it returns false (so the patch would
flip mux->data.little_endian from false to true, silently). That is
a real behavioral change against existing users and not something
this patch should be doing.

I will keep the original three-way logic in v2 and only switch the
accessors:

  if (device_property_read_bool(dev, "little-endian"))
          mux->data.little_endian =3D true;
  else if (device_property_read_bool(dev, "big-endian"))
          mux->data.little_endian =3D false;
  else
          mux->data.little_endian =3D IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN);

That preserves the documented binding behaviour byte-for-byte and
avoids touching device_is_big_endian().

> I have not looked all that closely, but you also make the call to
> devm_platform_get_and_ioremap_resource() unconditional. Why will
> that change not cause regressions?
>

You are right again =E2=80=94 that was an oversight. The original code
guarded the platform-resource fallback with if (!mux->data.reg),
which preserved the pre-mapped reg that a platdata user may have
supplied through struct i2c_mux_reg_platform_data. Dropping that
guard would clobber the platdata pointer with whatever
platform_get_resource() returns (or fail outright if there is no
MEM resource on the platform device). I will restore the guard in
v2.

> Your commit message is lacking, you make these changes but only
> talk about extending support to non-OF platforms as if that is
> the only thing that is going on.
>

Fair point. In v2 the changelog will spell out:

- the conversion from of_* to device_property_* / fwnode_* accessors
and what each replacement is equivalent to,
- the new ACPI child-node handling via acpi_get_local_address(),
- that the endian and platform-resource fallback paths are
preserved byte-for-byte.

> And, the initail problem still stands. I would like to see some
> tags that indicate that the driver still works for existing users.
> Especially so since there are changes that look problematic.
>
> Cheers,
> Peter

Understood. I do not have any of the existing in-tree users of
i2c-mux-reg on hand (the DT consumers are on PowerPC and SH
boards, none of which I have access to), so I can only test the
ACPI/non-OF path I added. I will ask the existing DT board
maintainers on Cc for v2 explicitly for Tested-by tags. If that
does not produce coverage, I am happy to defer or drop the patch
rather than push it through unverified.

Thank you for the careful read.

Best regards,
Abdurrahman
