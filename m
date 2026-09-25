Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BBC1F78E6
	for <linux-i2c@vger.kernel.org>; Fri, 25 Sep 2026 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294954; cv=none; b=pa7L5uSq91mM+/nSlZrIjfNf8FDSbMrl0K89DfG8cb5Ilk92EKZK69oYsct8qdjpPVPyJHffph4yOVd1zySPQKaEggQwBoX0Dppq0y/+vRqsmdSDxv4gaHliG02c9RpQ/QcKoemDkZGO05LckcOGtRrgdosWiZSsg2l/ldA8TMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294954; c=relaxed/simple;
	bh=FBdzq6aZL/72VKFVhcZnZAZC8/ESnFZSkAM++Qfd7xU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=cdvITqH1os6QH/Ud8aBHTC+VI8FH0yesgXIt2bZfFU6t+pxgo4Md/kJmpRSe3bUVwD+wiNflQlvN3rChHrJZuTQDfBarvMtN9A7zoiOxgRLHhRxBZrFUfXFyVvaQ7jEx9ca9T7okrDyNO64B0OjG+caX6xZ714BUNsrPRQ63880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=k8QhKR9y; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="k8QhKR9y"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e652b7178so131071eec.1
        for <linux-i2c@vger.kernel.org>; Thu, 24 Sep 2026 17:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790294951; x=1790899751; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x/1axvX4nN0CV5MjaicWKNBMunNziYiH3mIqVnl5Qs4=;
        b=k8QhKR9y5lnYM5CulctO4ALp7uoi+8GtU8fmKLoGSQwCI76549/XSEstsdos2zXhF5
         oAlp/HTgvggIAm5BFke9NNB4Oz0kY3QI+xgdImPkHk7H8O5SflbyOsL5hYBGcjw4s67w
         ul05upg6JnAmC3MtmiWDT719sopLVmxKQU01gsp73/dQVx+T2r11wZEGIEjA8ifhS3Qh
         nXjXA6Al1bl9w0RPw95t4b+0R8ExT1nai0v2LnRPZ9bBclQeC9AsTN9fb8NDGLu0PhK+
         lQlTJ64eB+YIIzW+SQGEIZW5vKb0S/EPraoZxsagHpS5yhnuqC0sHEfUsAluHM/Y521p
         i9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790294951; x=1790899751;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/1axvX4nN0CV5MjaicWKNBMunNziYiH3mIqVnl5Qs4=;
        b=DoVcQAp1ulLZb+7HrlBtn4pN48xtBOP1+O223gl0Mo2k68kTalR20ea9m6TKBLNNh3
         CZa6Xadk8lrGlE87pqglX+m8+R60o4sqtRs796QvOR7fJA6NRSNTuDq3Cxs2TAdV7yhZ
         ykekcrKW7Z67quxr19ND4TfgUjuMfvX5jDitkCkCInNAkID68NvjPhcz0+ggj7NBRkC+
         Kx2+qUrDmhSMspYtL75B9/9ieNLwOo6L2n4jn5TZlbec79ow799EBWMaXc6XFtfdh/yS
         XQyb0A2/dFFalKUqskAWFV7pheNZ7omSAApu1+BzGr5y2mznskwc5YtvmvVMsKQlHzYN
         A/Hg==
X-Forwarded-Encrypted: i=1; AKwUvByzGjK5fik0QipiP8DcgoyjHsbCDhPQ4PBE9SAyoNvjZwoJQuHrfFln1BJRcKyNXmgn62FuMJgkqjE=@vger.kernel.org
X-Gm-Message-State: AFuF++k2ns8NiPwEICQ6K5A4DyGqrXfyJvTaPz3kW9wXjK2jwfC+feB5
	JS4E9Dc1Ro0UR20W9W5yVx+FJEorisBp00JxYPh/gm1GNQaoZXTBbGE+QUZSycq9sn8=
X-Gm-Gg: AYBFou2PNBUyvrCIHZh7/JV1CSKF4een8q0Jq0XRcncgGyf0yoIt9FDzfYSpxvmoAAH
	ONsjkObOa7mRfQB25/6uP8dajID3Epo5l1uuhEAjZPCf/dUgqdvfDm2XCwlKr06VR6e2ikWML4J
	aAD2bYpfm5lP3QzHbr7Mt65isgrNdQcBgB2IT9qeMeloEqpWdAr8Xsorf+QMX2Y59Y1DUh/w1ff
	bXy0S44nd51SMGUZfAAc5m0mBGKrA85/lksHWivhxT4ryIyZaWa+XnHDgtTK+qh2tua5DY708JV
	YvQzfm0c8nh02uLbqqCQWJrEVcYgn9CLNLL7oXCte3Cb7BSy+kCAk90+FkNAQSnwiq9kQHJpk7G
	foeAwxul9D+KGdX+kgT3UIYSTZlZCBXjMQTdHVhgc2iOW074UFno2saAjfl3SueFaRsYPSV0u2E
	4kewucmZTWi01jnE0dk55l0gK0Y4rztiH5eFJi/f8YKSy56YXcnxDjBNvqWPxj4VMpwYc/+H4=
X-Received: by 2002:a05:7300:8aa3:b0:340:f935:5fa with SMTP id 5a478bee46e88-340f9350b79mr1651254eec.40.1790294951369;
        Thu, 24 Sep 2026 17:09:11 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341463ec3ecsm1874059eec.31.2026.09.24.17.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 17:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 17:09:10 -0700
Message-Id: <DLNYLDZ4WO92.16A9I7PRTH3WL@nexthop.ai>
Subject: Re: [PATCH v6 1/3] i2c: xiic: preserve PEC byte length in SMBus
 block read setup
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Raviteja Narayanam"
 <raviteja.narayanam@xilinx.com>, "Wolfram Sang" <wsa@kernel.org>,
 "Manikanta Guntupalli" <manikanta.guntupalli@amd.com>, "Shubhrajyoti Datta"
 <shubhrajyoti.datta@amd.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260923-i2c-xiic-v6-0-3a15b6397f5a@nexthop.ai>
 <20260923-i2c-xiic-v6-1-3a15b6397f5a@nexthop.ai>
 <arWC6PFh3YVgU1Pd@zenone.zhora.eu>
In-Reply-To: <arWC6PFh3YVgU1Pd@zenone.zhora.eu>

Hi Andi,

On Thu Sep 24, 2026 at 1:09 PM PDT, Andi Shyti wrote:
> what if rxmsg is 1? Before this could never happen because we
> were checking for rxmsg_len =3D=3D 0 or 1 and we were ending up here
> for values greater than 1.
>
> In patch 2 you fix things, but we don't want to have dependencies
> between patches.
>

Confirmed. The widened condition makes the else branch reachable with
rxmsg_len < 2, where rfd_set =3D rxmsg_len - 2 wraps the u8. Traced on
hardware against a zero-length block read, sweeping pec_len:

  pec_len:             0    1     2      3
  v6 patch 1 rfd_set:  0    0    254    254
  v7 patch 1 rfd_set:  0    0     0      1

It doesn't actually hang on my boards -- 254 lands in the 4-bit RFD
field as 14, and both slaves I have keep clocking past the end of the
block, so the FIFO still reaches 15. The programmed value is wrong
regardless.

Restoring the old "(rxmsg_len =3D=3D 1) || (rxmsg_len =3D=3D 0)" isn't righ=
t
either: pec_len isn't limited to 0 or 1, because i2c-dev sets msg->len
from caller-supplied buf[0]. At rxmsg_len =3D=3D 1, pec_len =3D=3D 2 the pa=
dded
branch would record smbus_actual_len =3D 4 while draining only 3.

So v7 moves the bounds into patch 1, where the arithmetic is introduced:

  - the guard becomes (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH), which
    is what keeps rfd_set inside the 4-bit field;
  - the else branch becomes rfd_set =3D rxmsg_len + pec_len - 2, identical
    to the old expression at pec_len =3D=3D 0 and unable to underflow, sinc=
e
    the padded branch already takes everything below MIN_LEN total.

Patch 2 is then just - 2 to - 1. Resulting tree is identical to v6.

I also finally exercised the atomic trim you asked for in v5, by routing
transfers through xiic_xfer_atomic: it fires, and block lengths 0 to 32
read back correctly on that path.

Two notes from the per-patch run. Unpatched, pmbus_core creates no mfr_*
files for these devices and every PEC block read returns -EIO; with the
series they read correctly. But patch 1 alone isn't observable
end-to-end (patch 3's -EIO masks it), and patch 2 changes nothing I can
measure on my two slaves -- its bug needs one that NACKs promptly rather
than streaming.

While I have your attention: the other xiic patch, "i2c: xiic: restore
non-managed runtime PM to fix clk WARN flood", is still unapplied. Andy
acked it on 10 Sep and the review comment it had is closed. It fixes a
regression from my own 50c63491ff26, which is in both v7.1 and v7.2, so
7.3-rcX would be a good target if it looks right to you.

  https://patch.msgid.link/20260821-i2c-xiic-restore-runtime-pm-teardown-v7=
-1-954e06765144@nexthop.ai

Unrelated, for later: smbus_block_read is only cleared in the BNB
handler, which the atomic path never reaches.

Abdurrahman

