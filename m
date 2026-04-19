Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D337BE64
	for <linux-i2c@vger.kernel.org>; Sun, 19 Apr 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776604458; cv=pass; b=su3UjgjfRa1RWKaiZhAncV076ZW2B9TSD/+GcTPU2uqxTLJM/ueSat/ecIzk24yfdCf7R7F5Ptnr6g4R7lnuu4b3MoNolJS6YLIXS406iM39YskZ4OlHLbK/GT/BvaiTpbCXVsM3wkAzD3HOuL98Q6xhjYS9x1h64opmbYJ9Td8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776604458; c=relaxed/simple;
	bh=qe/8/rd6eZq24hJL9eY4fBiSEHVVKDLumzkH60jo5p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEbnNLW3XV+buhf7uxXRXkMfEmrtxOmPrD5Zm8M7pzveYAmQJRd/PItEr/ABi6JQdJdWC57uMsTdIKT4LoyqkbcVTPouxxlCkMJFreKHJFcQ6QuCjv6QwKGFOEvp+rFZ+2s1j3bl4mlmy5zve3TQq+7pvAQ9v6oH4vdNTguiPIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=RF+j7+hH; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="RF+j7+hH"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651c7ddf514so1997862d50.1
        for <linux-i2c@vger.kernel.org>; Sun, 19 Apr 2026 06:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776604455; cv=none;
        d=google.com; s=arc-20240605;
        b=PHvJcZkopMHkmkRCrJO28Kcjiyjzco3p6qFUlvMNlTXzHKCA6N+sVWzeRm+6qg7b0q
         2WaV+2i5J+zKNpYSWEZp993bKNkdTEf6Fu3T3jv4fUamYDaYKMW2XE8EGaOyovv8R/bA
         AVOKVeBUvOq2MdgLGx8WgN8XbchBYvDTfRMdN+5QLIcPT6LBuW1/63ilkgzwvPRu6H3B
         /aFUnoSk0TxWzHJ8p16f/ekQKh0vAl6JkLZG1gj1Ahzdq3JxBy2UXv5Fv0b8qlijtPeu
         UnsyY/oFgibMME7Wi7JnDjlr9tSG//dHCKzBDCSfrkmoy0j83U541Z5M3keQtOc48IvH
         i7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
        fh=HaKbjJ+amdbxuywbWldFhSdksJRpsVmSrZRP7DMSGAY=;
        b=kMkG3L6YxIMdld1aDRZZSdnDK7s/JkvQ28AcYKdSBfY2W4tscNUXfPiDxoAVvfe+gG
         XujPugbhrCw2gtnbvQQJktKcBSXpDWWlOybn75DFXNPWJvjCD7YKLRZA9yUrWwgIRnS0
         tgrVFFGxh2+g/PAitK/3IhD43nK+UhSPyC15ppUGdYpXuzcXE3uNyGGXutpIdkKmzPJf
         pIanem0W1Kekb55qf5Q6+V3aRFdS/tBHF5M8pFTqM7gaRmn6R0joVUSeF+U5HHmUKZrl
         bh2YeUQ847E1JDFQdmYSqwMj/LchvpO+c0S/ApyNNcKXp9Pew7UYH95qV3mjfSamtVKL
         oDcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1776604455; x=1777209255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
        b=RF+j7+hHVxK6KZm7vPd2VqoOm/wjdXQLWhOzfortaWaPcUVwcAQrCs3L0CFMuiRg7q
         QnfAqyyLg1KJ+FRhOaVPXbDj/1oQAlKqMc8aZVWWLmxNSIvN0DqnMlIAoJn6kuX0b/7J
         7sPHT3tJByJtn837fhiWKur8kP67w4ITGeKuH61ShAM9KSbiPZhuqcwRf0AI+YYvfUzE
         nm7TFbEi+qyg5VUzXDZfGrK2suVGd+PyZxZUbRBAHRptfz+N0eKCGeaG7itaOxMnDo4a
         9pQYTEUA6X1M/ONh/tBNfIzrR7/o898AAKuwOGzc6VJY9VVEJ/2rd2ZdsoDfuP51zO2Z
         aU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776604455; x=1777209255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
        b=JgOhcJpK7tz1MZuyYUwq0nMNMct/KLD2FPEApqc48vJGwcMyBJboOE2eepeDe5NVB0
         FX6qDdwu7eJgj0y4eWYg46GXoW5xbeaTXHkGTEPYFkiW2yjSMdbs/myhKl+Lk+irgyJ/
         R0f6yenHN5csJXA9W6klk3kS8gbJcS6kpx3rTl4F5Lr5ED+1Qf4K5epZi+lEJrA85sIT
         Qb6ciFF3qTLImbB3W/zr/6zgDwTMYn+lMByIZbcZ6X/4HggngvQsOnh46oowggFJMLNi
         g7iBGSuiMARcx4cSXv0NaOCA/JW2uiovIvCmee27xBZvw9apSjLfIEY+DWTrZnnm/8pG
         9zBg==
X-Forwarded-Encrypted: i=1; AFNElJ9i7Ck1U/tB5/cRDpwqIKa9Es6pWC5MXvQbJvneMWRcnrgIAnF0ItkCPWWjROkDs+7h7IvImb1TmVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFe5ocoORg1kVBp7ZHuLQlJmpRS+y8UJcIGcVCA+gHqpjJ918
	uo/EIa4oy6FCqzDTQ3uZqdd+L4EFwSd8onk8MyvWbVpwTmOs3mD2yUP2zMeXE6Q4cIBSz13tJuU
	DTxflTVTKin5fY6IQUrXnOG6iUOK7dHoMH+8mU10Jag==
X-Gm-Gg: AeBDieuN5NaVaMssiQ+fXDPyhNZQijAVmao1AGAUi4y+5ApRMe3y3TpVZlSPF9WsMi0
	1EuVUCUCkjF203aTTXtkkuerRio+0z4RX+nK6fB/aR9qvRMYQ38Wq26/YJnUs46wsQAB84XRRhM
	wHmz9+4fEbzFo70t2bAkTjYkkTVALk/73tZxSOD4xwkS6OJOqN9+a/iZAyEy7WUi8oCODfxkLqr
	IAaQfCDYAgtfEEA2+pv5yO2oykT8SOXex6Cr60EOSyL/0Mk52S0VNqrZRP4iHBSCH48tMjyF/5r
	w91BtC3ut7cP1E4oWT9XrjqCw80z
X-Received: by 2002:a05:690e:4811:b0:651:bcc9:50cd with SMTP id
 956f58d0204a3-653107ccddamr6102177d50.5.1776604455299; Sun, 19 Apr 2026
 06:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323160052.17528-1-vineeth@bitbyteword.org> <20260418190456.631df6f3@fedora>
In-Reply-To: <20260418190456.631df6f3@fedora>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Sun, 19 Apr 2026 09:14:04 -0400
X-Gm-Features: AQROBzCejbUFLEO14GEr24qqxXnlBQ97NPzS668jjkdcYvI-3kvv1xuemSCQk44
Message-ID: <CAO7JXPh+__EWsW8fsKi4T+w0jdPxZEfCLQno_ukJk2=d2s0WKA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] tracepoint: Avoid double static_branch
 evaluation at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Jiri Pirko <jiri@resnulli.us>, Oded Gabbay <ogabbay@kernel.org>, 
	Koby Elbaz <koby.elbaz@intel.com>, dri-devel@lists.freedesktop.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	SeongJae Park <sj@kernel.org>, linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 7:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 23 Mar 2026 12:00:19 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> >   if (trace_foo_enabled() && cond)
> >       trace_call__foo(args);   /* calls __do_trace_foo() directly */
>
> Hi Vineeth,
>
> Could you rebase this series on top of 7.1-rc1 when it comes out?
> Several of these patches were accepted already. Obviously drop those.
> They were the patches that added the feature, and any where the
> maintainer acked the patch.
>
> Now that the feature has been accepted, if you post the patch series
> again after 7.1-rc1 with all the patches that haven't been accepted
> yet, then the maintainers can simply take them directly. As the feature
> is now accepted, there's no dependency on it, and they don't need to go
> through the tracing tree.
>
Sure, will do. Thanks for merging this feature.

Thanks,
Vineeth
