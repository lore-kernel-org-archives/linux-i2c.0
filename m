Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7A2D3A69
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780879182; cv=none; b=Q0tyHiLuHemoytW6ed7l6n6pobY4S8Nm23Qm3kb8osahuJTBhNftfNGrSpTmYs7wjjGw+FBxDpP4Xkk+O9w5bWTCYBFyv2v5PCstiLUFES+seXh3GBbKAlRU+3GPbbLmT47B/JEPG6Q1jTYYYnekDQPKzU5H3RFBHgxj+RBE1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780879182; c=relaxed/simple;
	bh=RJL0Dbep6IrG0PYgc93NRjCz7SfzICawS1LMvoLyf2U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 In-Reply-To:References; b=MNF8lBZdADRVxSdGYfma+BxAzMxJJ1Mjz1FcV0+h0tzejqgxTcgXoY6hzW4IY/6gxqD4y7y5yVg8PLQ5U+wxjMwPgkCwQwALVXXNLGhyuSwDHD2obpS0UCvrA0edmRqIYV1PKyPhK8gTY72AD/dV/GMfvi5VUqVzV2HCcDwuS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=eBl7kdVV; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="eBl7kdVV"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304f590dd91so3966831eec.0
        for <linux-i2c@vger.kernel.org>; Sun, 07 Jun 2026 17:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1780879180; x=1781483980; darn=vger.kernel.org;
        h=references:in-reply-to:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LC0cBs3wjxXy5zOKfXpkaV2SGZVYDHStwYMg/Do3oGQ=;
        b=eBl7kdVVis41wGqRBOQ2eDZQrKdCf1ya574z+Bgl0HEyH/YKwV0mjkGt5yCIKhgvm+
         rLJEP6I6oG4ujUUvtliO+8XX2l+jCeCE1nqRC4E2MI4lu9XrGupDuDKAN+c+74ylmBKj
         trp/BzW+6SVMAzkdCpwRnSeTqc3ZGGpwf99lLDL+/OLNa4CXkYpTceFOQKA9vjDeihKe
         0ZH+OuwIQHd+hJ6CJP3t2HUpTRYK5/m2ql1qwcD+NCNZDTnrxZcZgWW7ofraCE1HP0lI
         ee38Y/e4fqHmZeV5LY9WIpp/zdQIxXISEUrieAc5nH1A56F5ABGqPKuIYQ4E574ieixt
         Oc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780879180; x=1781483980;
        h=references:in-reply-to:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LC0cBs3wjxXy5zOKfXpkaV2SGZVYDHStwYMg/Do3oGQ=;
        b=OzyN2NErj7elKZDo6SNnKY/ge8XL8cteUpHAjDfkkeU8aIFPTNCxpnEremryNyQiqr
         DDYdzpd7fE3fN02el7bMJaOMkYoRQITCFASBA9UcA1X1iSvtQA8r6tO8oWvZBdLNwd5T
         8JZ9t9UzULVDbbp7zeRA/PouKrE49C8OA0nOSh4ij3T6OTTs8W/hRR7olQj/WSnI3eSm
         vjyIS6hjE5e3eKhrTc907AZgXbqMWOy14VSUDKnWN2t5kTZRZDmkO278MG42AirbryuT
         O4BRKr2a3N2vgEltP08WXjmTDW2Yf0F50FymMra0k2NybEOuF45PxmqZ+BO7JLolTqVo
         cFug==
X-Forwarded-Encrypted: i=1; AFNElJ/HTxHhHu0gIYmLUUyTYWnSrZWwfX175TdhvK5KcQfq+5Bqj0dac7eemNoBclqXLDa8mS1w7ApD7Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyj7WgS0lfjH01j3HcRAx4iWZSFn3gH3hCmB+W6MAVvvlq2XJ
	wYPhZu6prgI88ttQAyn7pzmHezepqoOAqmivx8DqzmBcOGzRpUlYx42q3PgQsSwPWbY=
X-Gm-Gg: Acq92OHqfnu3/m+wm0JJqY74IoIC4W7ja1LkBZEq6VLjTkjLPev5VqUKvnlh1UTKyu9
	eWpCTNp7VUg4Jwp6Y3zL346QZrufsJuuzhPEQ61C0vhpZ25KVn6T4bjx24QK2s7+IudDdZ1NVUf
	w+jpKPVXv/X1YYxWdGlhXc9xi003Y2DFHlQDSZ1Mvq3jaX2i2UlLV4nIPN6tWwp46Sb1ptk4bgN
	Q1VSOGHEwwwQ73SnBq1Hd0p/CEVZgg7Itmv57bxblSS5IZoJ9ZHvmWeuxqIQBqTQ8ODw+kwbyRR
	ivSJGH8oDjibDlhx4gDUR34yn+jlqoDay0Oxr0p7slQs8naKUTITjPN4KrGAiZ30F7vTSP6u+vA
	EW6Nv4UcPsizKUry3C+BJQus8Rc6ssNC81YHZgUPa7RFEgXiZGRT4Db9NayVAe7qaKd2pnxa4U9
	+YfnoLL+9MYr/5fv0PAYgTEVvgfF/IeNGiBw==
X-Received: by 2002:a05:7300:2327:b0:304:5db8:da95 with SMTP id 5a478bee46e88-3077b7855c1mr6751775eec.23.1780879180170;
        Sun, 07 Jun 2026 17:39:40 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df64eb9sm13583356eec.25.2026.06.07.17.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 17:39:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 17:39:38 -0700
Message-Id: <DJ38ZCHHJM9O.17UCPB969XXB8@nexthop.ai>
Cc: "Peter Rosin" <peda@lysator.liu.se>, "Andi Shyti"
 <andi.shyti@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: convert i2c-mux-reg to DT schema
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Conor Dooley" <conor@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260607-cozily-majority-edb0ae263c0b@spud>
References: <20260607-i2c-mux-reg-base-bus-num-v1-0-f193b5a8fedc@nexthop.ai>
	<20260607-i2c-mux-reg-base-bus-num-v1-1-f193b5a8fedc@nexthop.ai>
	<20260607-cozily-majority-edb0ae263c0b@spud>

On Sun, 7 Jun 2026 15:06:43 +0100, Conor Dooley wrote:
> I think it is fairly likely that this property won't be acceptable.
> The conversion itself looks okay to me.

Thanks for the hint -- I dug into the i2c core and realised the case
I was trying to solve already works on OF without any new binding.
i2c_mux_add_adapter() sets the child adapter's of_node to the
matching i2c@N node (drivers/i2c/i2c-mux.c:330..367), and
i2c_add_adapter() then honours of_alias_get_id(dev->of_node, "i2c")
(drivers/i2c/i2c-core-base.c:1657).  So in DT, the existing aliases
mechanism already pins mux child buses:

  aliases {
      i2c16 =3D &my_mux_bus0;
      i2c17 =3D &my_mux_bus1;
  };

  i2c-mux@... {
      compatible =3D "i2c-mux-reg";
      ...
      my_mux_bus0: i2c@0 { reg =3D <0>; ... };
      my_mux_bus1: i2c@1 { reg =3D <1>; ... };
  };

That's clearly the right answer; sorry for not finding it before
sending.  The only wrinkle is that of_alias_get_id() is OF-only, so
this doesn't help the ACPI/swnode platform that originally motivated
me -- but that's a Linux-side problem (udev rules, stable adapter
names) and not something a new DT property should paper over.

I'll respin v2 as just the .txt -> YAML conversion (faithful port,
no new property), and fix the silabs,si5338 example that Rob's bot
flagged.

Thanks,
Abdurrahman.
