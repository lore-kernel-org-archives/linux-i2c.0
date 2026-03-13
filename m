Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2435AC37
	for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410569; cv=pass; b=mHUQOPYac/HOH3dpK++NClHQ3zEa/co2cnJJOYtAJgXRqNttWNBn8Wa5qV5T3CnaNyLndj714cw4f4rtWmXtmfIIE0t3mH7/nreQuixB6lf6Nc1UhZXR2BQ2jLNx0Yv0HKohN7y17BRPkFAdSGjKrkMzfXKJDAc5rGugF9xxIUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410569; c=relaxed/simple;
	bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvu0iloogBvGKQK5ukK33oetUATI0GOKtjABcLj1hEo1iQbWPIVW7AV8Si1x7kKgnilVOnee13wCPxjhr7VlUcdERgYDRta+wivVN71RLNxaFmn9oPv5HyjpFImGBV2GfDVtRTC2tfO6ajMXipnnK/IOjigYkc/yyBy+1TWPyfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=ObfNwz7s; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ObfNwz7s"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c9a6d68e5so1959942d50.3
        for <linux-i2c@vger.kernel.org>; Fri, 13 Mar 2026 07:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410565; cv=none;
        d=google.com; s=arc-20240605;
        b=SATe/25YbKDYP8VTxvS+3SRI3DKxCKHrv1IuoAn48chP9Zy+C/as/wVZ7wpUwLgQ2R
         iDmPRVjh2usgFqSgiao8DMg3D0ty+RpLOomd5PS501SkOk9YXuIqKr0/KENUu9uZ+XUp
         xeGjlF1rPgcvbfCoGILdCA9LLuIydj1dQzEbH6/AvSBLf5u2rpu5WoB8UoHQaQzC905T
         5BX/uqmK3rOb+cwk9k03L1XYjnVE+T57aWt0N1jwyInJB2PG+M8fG4RW0SEYxBUGaC3x
         NGjRndkn5actKOYSNVzDdwez+mM3/D9WMkSM+i2l5jo6Kd8mRP7iGSj/BmRtzR+r0MGI
         J0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
        fh=6NRyeUmHFtiRreuI/kHabpJn6UCU9HJUFcwjaq2nips=;
        b=Yuca4and7vLUiweKxWZ46qk0JKmL4LV5hrPIvUtVJ/yeJaY1dse7XBVIGaxhy7PNjU
         /JzFL6EgG51KGFF8pmpuwVZwIaX6NO/FnOE1MHT3W+qA7nR+BEaIoNKeAU1dzALEMiy8
         zl0RtnID83QlWs2IKl4CmHZwOXkLkhYkaCvS1WGApfm0om8G7ZFOBfXUi5sLrKkvaj1O
         uC3hPjBNB1XS2LRetNYzFHO4eGJoP/HjTPF7RoYy9GHBsYYs9vsOJGvJ5qI+5lnAQf7K
         JAhccb75cLkE9Zj991b7/Qjq7PdE34odwEXP8xcNr5OrvE15ZiiLl2/pmO2pBpHf7B+B
         qtHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773410565; x=1774015365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
        b=ObfNwz7sVmzZBuIGYYUHNiLCrYOnrj8c6jSXCTXbQttafWQ6iigv2iFCUWBaoiYoUP
         65QJafHt+sCKkuHWwkmPoCcyygdqmYnJqwQvkPOoFp//2xTrPOAnMOEt6QHOb6B2JvqT
         uUidn8yG11+xxULj+cUGv2RAFi7xkRZfAAMzfTE8wLSqLl+bB0W1/CQna7kgFTcQ079U
         jdJDbGknVFFIGRjt+9Ia/rAPUbdCEaVBzQY/lQOSzveUUMV9JbrJZ9dM14sssdL0Veoz
         2HvOhbyl3fwXxpTdX3XOVWdJQawUfi41VBhM025fBbFm4jHJUnRUxEJqrBTBuYU1u6Rq
         p7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410565; x=1774015365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
        b=JkTsY7fKOt5liDK7Jgl4Ji23aMnbqocWKf84rC6eIvKh5DF6rSVP7WgtrjjorayLJV
         dLOvFdLnQnCV4+YvFdh/SAt81M/4z9LAVOY7Pf2xEew++oy+os8NErDJy8AmlydD4g9c
         wr9X0Ro0pMo20MCUcGK5PNL5MpLisNqHWEBU252WKmBkALPAbb2lbB1C9u53HVc4vsP/
         NknH/AQt6JEPPHtLhwpeWgj7l3tD2kraXcw6SIna862uQ+bSI8XbMXnZyjE8sGDUARjZ
         hRsImpFnHrkCqfM9sT9P0vHnAf6hx527dTdzXImM4ZsLZdEZhLwUr4530ORAqGIwfvoY
         rzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjLtdTi3zas+iCaR3bIVj4a1xkfV/EwN11hXNsVS2izUfp3GpQ2TAlU0/Q9wmBGgWnCJAwA21Un5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YywnbmBxAizzW37Zy5xwhg0FbqR+49OUbFZfFCn5zz3Xr0tYaX5
	hlQfLexrEdnjHrJIlWYGb9t8vhPo6wY9TwgG6HcGWQERBmzATPLPwbZ3rcOHp8cYW0la2SEjsUL
	gEKbudfsmoI91MWSxYtomEXKQNFt+m5iDhzW0wgggVA==
X-Gm-Gg: ATEYQzw19ecfs9zwXL1d/n7YTT+TULcXQVLzZlHmvnWxjx6beA+aI7EzLgX7Z718ar7
	NmIDly+HqpCWDPkP+zeJFn6vcg69VADx1sB9YY8YPjSKrDDqx9hGRjcNXpyntQFn7orvVaKtVvE
	PGfTBXW/YoQZHR8nvm1H1rITUtHnbta0WK6Pl5unRR74qd6wHtmWQuo2Z0e14ljSxvQwbY3ukHv
	doZR3moCsntHNVocNMr8MqJ/rjl594f01mD9ogMMYOmv/stahxDiuudxOKf9jYLRGYUwSoBSuX+
	A+aHYpA=
X-Received: by 2002:a53:eccf:0:b0:64d:568b:bcb3 with SMTP id
 956f58d0204a3-64e62eeb40fmr2691449d50.9.1773410564388; Fri, 13 Mar 2026
 07:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com> <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com> <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com> <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
 <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com> <20260312130255.6476e560@gandalf.local.home>
In-Reply-To: <20260312130255.6476e560@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 13 Mar 2026 10:02:32 -0400
X-Gm-Features: AaiRm51K5Hc3O7_rOVK2jMiMzft9bvuP5pyZ-VF_j7db91GKvyylhuGDp34sRoA
Message-ID: <CAO7JXPgHYZ9zF1HFahb2447X85YRZCQQBHB6ihOwKSDtiZi8kQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dmitry Ilvokhin <d@ilvokhin.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 12 Mar 2026 09:54:29 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > > emit_trace_foo()
> > > > __trace_foo()
> >
> > this seems like the best approach, IMO. double-underscored variants
> > are usually used for some specialized/internal version of a function
> > when we know that some conditions are correct (e.g., lock is already
> > taken, or something like that). Which fits here: trace_xxx() will
> > check if tracepoint is enabled, while __trace_xxx() will not check and
> > just invoke the tracepoint? It's short, it's distinct, and it says "I
> > know what I am doing".
>
> Honestly, I consider double underscore as internal only and not something
> anyone but the subsystem maintainers use.
>
> This, is a normal function where it's just saying: If you have it already
> enabled, then you can use this. Thus, I don't think it qualifies as a "yo=
u
> know what you are doing".
>
> Perhaps: call_trace_foo() ?
>
call_trace_foo has one collision with the tracepoint
sched_update_nr_running and a function
call_trace_sched_update_nr_running. I had considered this and later
moved to trace_invoke_foo() because of the collision. But I can rename
call_trace_sched_update_nr_running to something else if call_trace_foo
is the general consensus.

Thanks,
Vineeth
