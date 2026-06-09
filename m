Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81F351C24
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016813; cv=pass; b=exW8paFTTnq5R/AwzEA5WXo1j5OBcFD57ngLAWCJXw6GGhaI3ApUtwHN/BhIOkNF/Ajbvs9CwWyudsUMJcaKt9s6L8XvTYfbcYOUDUjC88r+0ODi1LMRzsTtiKg6eRn6VoME5arB6Ar9QJMEbto+qdp0GU2J3Xtw1L4CH93Xb34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016813; c=relaxed/simple;
	bh=X5Rl5lNzcPM/zxKVGRo0hD7K7rU/ElLrH3SqVAQTBl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYrYMyY/hz5j2CO5Zp2ohDfjhYNmksHpydopFgrm6Oi7oX6Bi75S4mM0vkOwGS1+uKWwZGm1ncP93AnQ0+eUdWQeBrE1nT6KLQfCKll1VQ9jDwo8QXd6S/Yw1jxm7Fq65fj/ToFWlnmHcfDWjCYx+WDJmUadPPo0UqQNGn5AcRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAK5cc0e; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAK5cc0e"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1365eb2a773so285881c88.1
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 07:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781016811; cv=none;
        d=google.com; s=arc-20240605;
        b=Z2RtfqU5rjNOj51xExAJaLmclMzc+2pBzAf2Kkg07uB7RZzIgTN7GZ/juXSjKNFzBT
         xLC/ZB5JGLVLQECYZ2y4ikPvLDtZjwoJn1Vv6pEMAoUOpxKwrhZgRvAcdN8BSvbmiQyb
         c9Bh1NBuBA0HIxpCK0nluJcwHjppRBImOk4Bc+4cacBpOYDLgAQHaKMpWsN4+ZMeJW2u
         omUoADunKnXXaU9AZXGYi4O7tGSyOuzDrVtlpv32A0VwAmtcj9D9eE2ZCapiH/Hj9HmX
         OKVSPlC10/S04YpbV361WuJdRUh3d0ZxKxOEw3/IOnESX92B1vrFR12KnvtmNDIyNxcd
         T+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EaC8nh7KYLS78yjACqQzX8jGGQc86wGruCKn4Ldsi2Y=;
        fh=OqVIXBYHSSG9v+j4uBJ7Tx0m0RwjVVt0qJTOWV5rwdE=;
        b=DPl3ka6ejA5k6+C9ocrpb2VfJRHCf3jqK2XdLVvOU+IPjbsCuEXbp7ZT6kgSaHh2Gl
         0nhassZhNdQFPan8bYzNfkEd7T8fzwoFtooVXUJfpEbEOLDUQ2kFb20CJSiajHO2xXm8
         1iTg3mUYbjN4nI9NjQhXyBd39m7Q3kbPjp1crzhNeemjOdiR8mwO2pvh7RM91Bc5g8dH
         j5elRGCdLGl8TK7VpWN5aI/smLpqlmFzthcZoSeD7Lu2w4jsLEEjRJaOWspsUM4BluZx
         0e4JQE0F3pc1I15tpAJnDsMAkhY73PBAgO4oyPxu1uSvbBSoHfADCEr5A3Osck4iSLV3
         QcWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016811; x=1781621611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaC8nh7KYLS78yjACqQzX8jGGQc86wGruCKn4Ldsi2Y=;
        b=cAK5cc0eQYsQTNqV+Dt2UxMVm5nawItI2QMVrlaAoTRFn7jdW0MCY8a+8tjSQgOD3x
         K/xXjrKBno//iwndysRPsABes/R5T71vd+/YcVdv3EPNGqmF+7xiyrGgGkBszZLkXdLJ
         WB7sue1QsJKIOOc0yMLpixYyxPRhuHgrYxSExgmqe53OUk9fftpy39HXgcnD8/HAlFgE
         Vm8ZzVWrQiM1ar6oRqF5ndhDPhLqr6qwMrVaycCOclBqaFc8ilCk4pLZ75Wphdsv0hkC
         0teZnFSyB7yYIL62O+wBqIrR4VgNsqr547h9VLwey3lvKw/YK+v/l2vfhXNqfpI7Vmcm
         cnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016811; x=1781621611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EaC8nh7KYLS78yjACqQzX8jGGQc86wGruCKn4Ldsi2Y=;
        b=jDVuCtbL6rrGyJyF3BCN4hPWBpDRv68wRVi57oSJOLYwdkYYV8TlNxrLOpheWWzU2Q
         EDuMz7P6RN+w4kUwoDD5LyoC+C4tdnwGYi0NjHF8zD4CkDrYJd3SoM8Ou0cuNh8x9BXY
         HdoLUtClq4gvBnOzwWR5u0TxnRB/5bqy+3hZXF0i5ImNPqNpN9o5NvK5RExmcy3An07P
         w/Bv4cWunYFsoHG/6acME5RLXrh6l4oEuVkul2LZA208uyrsLb6/bmoc/u3K1oQ3PEwe
         IdhW7+OX4jATC3UAy31lCmUSUgqvGmvJr6PGJS+QuL0QVjX8Kb8sVcePH3E3Y9LWG6jK
         DNpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/j/yi+TZk6+YqLltk3XD3gOFd5aVZZZDJjmfdZBTW40Y7UgjrdZjMLdknar3y7nPyPAWgPGev6HHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmMXYYxiAzYorkhdAo5ei3J4SdshIT59w3dab9c0zIq/n/I1d
	NJiaV0PQdKwQX2HcJnhBGhHgj9JlPvLv1nLbbUOLrrGGQtyRRS8qLJeZlAqfYHy6qepSHseqYwH
	GTOKRMKZK7MT9ctH/fjxljUltJTIlLSc=
X-Gm-Gg: Acq92OGHhigT47ync5r3Ka30HJBAqoAxIp+rIkVo3unKb7NHAja1cN2QqSoV3U/IX/k
	MdH0euE3tXN775PD4+dNhMCeRE4ISPIb2LhwFBz5lHbVI8LUtIyPHqj+EpiAnNG3/McX2yzfoxu
	2lyDydfmQUoc2O3DXqJfcOtSKeJNq/8eABA1/sCh/a0zQg3Pffs4pcDcraYIaklNI04+kcrI/yK
	szezc2UDJFv43lH4ZigqWGSZ77FZgWkO0Cqf9gJeh/+eCiy4KMc2m/2S73+n9WpnFDaV5ipKLbY
	cbeZeRicWO5SMW0QWeB6XTBswKq4iNdJx9llZGWAFgfv7+ABvpmEYHQKLEJgpf8lrVdLOZaX1vO
	2L1C9U56Xfvrz8ttOSOfOD8tD+d13Qw8yWA==
X-Received: by 2002:a05:693c:2b06:b0:304:c73b:79fd with SMTP id
 5a478bee46e88-307d602a15bmr1026912eec.5.1781016810809; Tue, 09 Jun 2026
 07:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9e49b71b-8b60-479e-93e7-5c12e352c78e@linux.dev>
 <aiZ0eD-A2F8woqTb@shikoro> <aifcUBtuker3f9t2@shikoro> <5633BA97-5666-45C8-A024-87A737A4086A@linux.dev>
In-Reply-To: <5633BA97-5666-45C8-A024-87A737A4086A@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 16:53:17 +0200
X-Gm-Features: AVVi8CcyoxeNZAw6PKYHOJrixFYdC9_ePz8ovPPuzL-S-mcsUN6BPoCRMB-LkRY
Message-ID: <CANiq72=FY7XMRiH4skr9tuNkH+v2PhKEzQnqVsc5Z_vAnaROrQ@mail.gmail.com>
Subject: Re: [GIT PULL] rust-i2c-fixes for 7.1-rc7
To: Igor Korotin <igor.korotin@linux.dev>, Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, rust-for-linux@vger.kernel.org, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 2:15=E2=80=AFPM Igor Korotin <igor.korotin@linux.dev=
> wrote:
>
> On the Rust-tree question: I don't have a strong preference either way fr=
om a workflow perspective, but technically your reasoning makes sense to me=
. As long as the changes don't introduce or alter any I2C-specific behavior=
 =E2=80=94 and so far they don't =E2=80=94 routing them through the Rust tr=
ee seems like the more natural fit, and would avoid spurious merge conflict=
s driven by generic abstraction updates rather than anything I2C-related.

Yeah, this is a common question -- I hope I can clarify a bit...

It is true that in most cases Rust changes in abstractions do not need
to change the C side, which is good (and something we tried to
show/emphasize early on in Rust for Linux).

However, the key part is catching changes in the other direction, i.e.
on the C side of the subsystem that need to be reflected on the Rust
one. And, more generally, coordinating the subsystem -- in a sense,
the programming language is an implementation detail, and the experts
of the subsystem and its subtleties are the maintainers there.

So that is why, generally speaking, changes are meant to go through
their respective trees. Sometimes we may take treewide changes through
the Rust tree to simplify logistics. (The Rust tree can also act as a
"fallback tree" when needed, and there can be exceptional cases where
abstractions end up maintained in a subtree of the Rust one.)

I have some more details in:

  - https://rust-for-linux.com/contributing#the-rust-subsystem
  - https://rust-for-linux.com/rust-kernel-policy

(Cc' Andi, by the way)

Cheers,
Miguel
