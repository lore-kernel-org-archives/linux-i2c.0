Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2153F660B;
	Thu,  9 Jul 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592247; cv=none; b=tJqlvVhFFHbgeIkgyemxwbARX4N8GHc6r5x3oen/1YeZSheZh+mkLXT1jVaCPLkPpJQpV/O15e2uZ0mKJjwbr0ngsIFejI3wxHSy2zJPaCNFtlt+NTQTmnNJ1Ee0ZrhPgrIA23atVcmzqS1SBP6+dwNrAZD9KKrWbLVwbiK2CpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592247; c=relaxed/simple;
	bh=wpSbjHnqNS5n5H9tjZJANRhyYNytw5/cTb0Bx8CVvLg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=KQtwE/YADKUG7pV8aJfNzAzBpw35J241fFrjeCXxTWXKwxDxwOSV+qTsIt6vDeo4RHeKnsV/l6nP2eCvhsMnISYs+D4d1kjo2Awiu8+4bFhHzmSBkTKiRpST/jyFIeT771ONK5Jc1E1RIW/akfSfOnWc/w7hdQRtlzaWaL3Dnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=M0ikLyYb; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="M0ikLyYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1783592181;
	bh=8ks8tS9iyPaEvRnuaY3eiQzZv5LiwGa2iyJl74LOtow=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=M0ikLyYbVX2b4oXKSDibo+mBTPCzRVwi3zQ4OYmQmcpi0vMIMDe3uLQOu5vKJdXK+
	 2V2528mWvHa6q53TDCEhr92W9t5agfVVgRwG3lLEy1yTGf+RF5htUixqHC8ZgugxNK
	 ERPu4X9rM32F3/eTDD1vnFZSLzFgxwxWYXglrswE=
X-QQ-mid: esmtpsz19t1783592180t823f00b7
X-QQ-Originating-IP: 0lJFCcJVDe7RW2lM7DqlNDhhQOjOY7zdXnSHxwVW+EI=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 09 Jul 2026 18:16:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12591070103831271671
EX-QQ-RecipientCnt: 7
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 03:16:17 -0700
Message-Id: <DJTYNQWDPBQH.1ZD5K49DG089K@linux.spacemit.com>
Subject: Re: [PATCH] i2c: spacemit: fix spurious IRQ handling returning
 IRQ_HANDLED
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Pei Xiao" <xiaopei01@kylinos.cn>, <troy.mitchell@linux.spacemit.com>,
 <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <spacemit@lists.linux.dev>,
 <linux-riscv@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <aaba8ba228a99f580050004c5b7e262d855de44c.1783590752.git.xiaopei01@kylinos.cn>
In-Reply-To: <aaba8ba228a99f580050004c5b7e262d855de44c.1783590752.git.xiaopei01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MRoXHVs8e1kF0Nqz67nsbk6tetZapFEPTSaQ9WpoMwE5tEwWYqX4Zlfi
	87mzRK43Ru2hVR1o65W1CPreu2rhx55dWFz3GV87dHyP+PX1d363U+DfZbkAOqNFkrj0XpE
	IEunIKmhoQDV17q/vT9xiRnt63mTirqvA149xchUEEc4CwFlKXTgADFSmWXRjGnbaofoHgw
	cJUwuLq1bplF7w0TOkenSfXooNAqZ6Ctqh5rSjqfPzLBUMlKZsV2S2MWJraQUyN+XAEo6hx
	cqlNYoMJkyZKkiEhMlgYlIeYUo6hRQUrCMGev43ewJ965GGzx2lhUtGz3tsVmeBuHF0q0la
	rBMAwYj0yYda26nhr8fs7Fqj+Vee6UeLeZgjFk3XKvDyeAyeaxGMN+Gy7g5m2PI1S0a/S0z
	/z+Bny42AvbvXLoTfZVlaUoymv8F8WzJd9uzk+q0WkjLsAnrs3uVS0BA3YGyrPwrhQ9Jn+b
	5i255fcakYdqRIULbfoAtocg2/RiYi2C4b377A6u0DdTnOSnjUcdTJFNhpKXAq7wf8orWLN
	ElaIBOa6rgdUW2kaY8pTbOS1Nq2sze33+aSnoKvcxj/ToCev9r4PqYxRy0YMlOmh3qg+q/W
	Z5ikFNknrsAtkQ56u/8IouKEJ07EHUN0dYVR6R4ZVL7xB3NqbVy4kv/Xz0LM9lRc08KxK8/
	tC+crPDTD8KhuUmoqUK+fbgoHxVMEgPjyRc6ageBp/IbnCkW+GOZFHhRkZd9b9Z0RDfdl/h
	ApVIDzRt2Smuv4XA0dZBR4rtLVT29BvYR4Q4QEDBc6K3/MT9nn/WY7ritb/Gi1Nl2MhAYpH
	27TM1WyTOuqx+hzKO+wj5kL/JUK+wDninyuY7nBt/58cy7jlMa5l1mNzvzJ+34B7sMeQ8Eb
	0XoHJ/046b25/kIDijdF787GpOF3I0jel0aRihl88PyKuSI7ipq+bB+vBRDrXsF6exc5fJN
	PKap4gchwvHKSwCr6xu17Ela0JdMMcSTZ92LCuTGVuuTldX9sDtK3/RiaN+EOxrmLWN1UyH
	1SDZnXy8zzKv/Apmu2tlPQ0uF2ol7/nr/GxIl6IIt0fiZ46qeffS0te/qEPhyHrK2jbDrTY
	A==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On Thu Jul 9, 2026 at 2:54 AM PDT, Pei Xiao wrote:
> When the interrupt status register reads zero (no interrupt pending
> from this device), the handler should return IRQ_NONE. Returning
> IRQ_HANDLED incorrectly claims the interrupt was serviced, which can
> prevent other devices sharing the same IRQ line from receiving their
> interrupts.
>
> Fix this by returning IRQ_NONE instead of IRQ_HANDLED when the
> status register is zero.
The change goes in the right direction, but the rationale in the
commit message doesn't hold, and I think the check itself can be
improved.

This driver requests its IRQ without IRQF_SHARED (see
spacemit_i2c_probe(), which passes only IRQF_NO_SUSPEND), so there
are no "other devices sharing the same IRQ line" to begin with.
Even on a genuinely shared line, the kernel invokes every handler
registered on the line regardless of what previous handlers return,
so IRQ_HANDLED cannot prevent other handlers from running.

What the return value actually feeds into is the spurious interrupt
accounting in note_interrupt(): falsely claiming IRQ_HANDLED defeats
the "irq XX: nobody cared" detection, so a stuck interrupt source
would never be caught. That applies to dedicated lines as well, and
is the real justification for this change.

Could you rework the check and the commit message and send a v2?

                                  - Troy
