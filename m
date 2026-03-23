Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2913B893A
	for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281661; cv=none; b=OyHDIa0Ov4scy3GrPgHTBEdSMlmcWa0D+iUsc/ZuOKJHCJYyH/TYklA7M2sn9e6TZUnYpKto1CbeWBlQbNcoiLEOHH/Za9bE24OoIaL49YcwhwCj+p5VAgDM4WAO+N08fS6sNooeivsrETzKUInvTiDOVmLrug++HcNRF3kZGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281661; c=relaxed/simple;
	bh=Bz3Ots6yk9ZczWzMqmrxecnG8LNR/r4o3HZXwJKixbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dsc32zJI4+zux6FhAyHJgOg5dD1kS4QgG7LoDz6QEE4hkWPNLARD3SgHo2Z+ho69TdZ58JvWM4tuG92m2zM9IeLa9Nzfv25+6XLY/uguBa5GdaBeoN/MB8c49pNnQjyK9rIJsm1Efk7wAN+blF7htrBwbpN9sOI2B5IoJPvMtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=icTJgAMR; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="icTJgAMR"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7653db148so2420384a34.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Mar 2026 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281658; x=1774886458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SscKSPRtp5r0bOyZYtc8orw97P+lM4BuDDRyRnpM2Q=;
        b=icTJgAMR0oeLmZ/KWfLwRrhOP+EsA5wl9eKYkctdG+jFUxkdpinSnf2VcJjIGT1ldW
         8faZggbpkd8NYEieO4mYUuOAYj1+A72IArYttf9BWOIrU4rwJLJd/miC42tsAVwEFVJy
         66Ti2OFUfy/HXBknYPGxqAyu+UL+6AmHQvZtAuPzlGc2n9aEOOhgemTQdsIzkot+rZHD
         zOeSlK/xnyBwjh+Jf5Ptj0RpSg2E2UhK3v9S/T/JaoGb3ta+awmnU4NQq9NLF3jIbmcd
         y7nTnDhmLABhFmA4CKzRMvPexu2BOZf5R0MoCXYf+kvlR/rpgKaIXkVRCw2S1/CKv+FF
         J2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281658; x=1774886458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SscKSPRtp5r0bOyZYtc8orw97P+lM4BuDDRyRnpM2Q=;
        b=PW/IYQM4GrW1thurZOmbZ5CLJsq4+gZ5IAwvbgPPUaHmLW9M8KdvezgUSzk9z3fGJz
         h9WXYRpVOkXY8Ii/hGDkjsroCiZHrJl7NobO1pa8VXBOntGTKKZDmooQ3ZA8WE2CflAw
         zdKSAH01cFoU1oz75f4fVMhi7/YE7TYUyBr4n1JzpknHf6/0GI9Jo0kA3RmhN4a0Jzjw
         MmhNTb5QvQ2Iea7/tHv3IQyEV0BKBhZvY3hNs11yK4A2A7Nv8YILncTpIZplHhGKnqVN
         WN3cV0pfgimJpfdwl/0eyB+el+WHFyGlIDimxa/8g/Y/v/Ix+AfU6pHu6IDO0vyJmVFR
         cbFg==
X-Forwarded-Encrypted: i=1; AJvYcCXWvf9jqhwBvtEkl7PFKbOM5sFy/WHGrQuKoa2/s8kUYIkT6sn5E6ocZeKLOMefkelV8lwZNHt+Unw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/HCkKPsJPfpj3Arclo8DED58/6JPSvITToSPBLIN+BAXm6cUb
	TWHW7vLW44JVJZ/DrdEZf+CdL6eC4zqer/Sp3VgZ9zZxTlFyE6k+2Ts8mCBliFmvMwM=
X-Gm-Gg: ATEYQzxH4Kz5ar3iKfGXb8+4gDt1iaU5wXGwFq5Ju1hATP9JS0N6rVsXWS2mt2a46hu
	NJoDb6kIpVEhk6T2Cf5D8dUTYnpjNCS0OtbDHuJlFURTYzJuONcfhe/x0xzfXjK7yT2zvX5zkR7
	B2GpTjWD9T8uycADGI3CAEet2k10ivbyj4MN6l7nLNJ2/gMRyRdVhVurhd/R4ZlP9/oQIo7YBnN
	bj/WrCDraR2A5M66mjUcbBqT3kD8iWJXLKJ/4OMSysp7YmT2rdwqJP0BdYq/SnTVfIv8TRpPQqM
	D+9J1cwngPpkIHGMAjG/Xkq81B/SjtyWE+UHb7Yz62Fk4QlliGQk4bpbM55Y9GSitjLW3QzO5GV
	1WZMXG3xPvFle6L5102onDz1dNAdmeA+ZODczEa6Uh4buqGkO9CpBSSXYsGpRobHrhnMCZ2/jyb
	CPuNtHiLidMHR0gdlXrqW5S8C4NH0pysTzFmxCjGoUk4WJGvu6bdpoMl1qRdkcTySkoA==
X-Received: by 2002:a05:6820:3091:b0:67d:9cc0:968 with SMTP id 006d021491bc7-67d9cc00e0dmr6486936eaf.63.1774281657494;
        Mon, 23 Mar 2026 09:00:57 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:00:56 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	dev@openvswitch.org,
	Jiri Pirko <jiri@resnulli.us>,
	Oded Gabbay <ogabbay@kernel.org>,
	Koby Elbaz <koby.elbaz@intel.com>,
	dri-devel@lists.freedesktop.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Len Brown <lenb@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linaro-mm-sig@lists.linaro.org,
	Eddie James <eajames@linux.ibm.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	linux-fsi@lists.ozlabs.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/19] tracepoint: Avoid double static_branch evaluation at guarded call sites
Date: Mon, 23 Mar 2026 12:00:19 -0400
Message-ID: <20260323160052.17528-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a caller already guards a tracepoint with an explicit enabled check:

  if (trace_foo_enabled() && cond)
      trace_foo(args);

trace_foo() internally re-evaluates the static_branch_unlikely() key.
Since static branches are patched binary instructions the compiler cannot
fold the two evaluations, so every such site pays the cost twice.

This series introduces trace_call__##name() as a companion to
trace_##name().  It calls __do_trace_##name() directly, bypassing the
redundant static-branch re-check, while preserving all other correctness
properties of the normal path (RCU-watching assertion, might_fault() for
syscall tracepoints).  The internal __do_trace_##name() symbol is not
leaked to call sites; trace_call__##name() is the only new public API.

  if (trace_foo_enabled() && cond)
      trace_call__foo(args);   /* calls __do_trace_foo() directly */

The first patch adds the three-location change to
include/linux/tracepoint.h (__DECLARE_TRACE, __DECLARE_TRACE_SYSCALL,
and the !TRACEPOINTS_ENABLED stub).  The remaining 18 patches
mechanically convert all guarded call sites found in the tree:
kernel/, io_uring/, net/, accel/habanalabs, cpufreq/, devfreq/,
dma-buf/, fsi/, drm/, HID, i2c/, spi/, scsi/ufs/, btrfs/,
net/devlink/, kernel/time/, kernel/trace/, mm/damon/, and arch/x86/.

This series is motivated by Peter Zijlstra's observation in the discussion
around Dmitry Ilvokhin's locking tracepoint instrumentation series, where
he noted that compilers cannot optimize static branches and that guarded
call sites end up evaluating the static branch twice for no reason, and
by Steven Rostedt's suggestion to add a proper API instead of exposing
internal implementation details like __do_trace_##name() directly to
call sites:

  https://lore.kernel.org/linux-trace-kernel/8298e098d3418cb446ef396f119edac58a3414e9.1772642407.git.d@ilvokhin.com

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>

Changes in v2:
- Renamed trace_invoke_##name() to trace_call__##name() (double
  underscore) per review comments.
- Added 4 new patches covering sites missed in v1, found using
  coccinelle to scan the tree (Keith Busch):
    * net/devlink: guarded tracepoint_enabled() block in trap.c
    * kernel/time: early-return guard in tick-sched.c (tick_stop)
    * kernel/trace: early-return guard in trace_benchmark.c
    * mm/damon: early-return guard in core.c
    * arch/x86: do_trace_*() wrapper functions in lib/msr.c, which
      are called exclusively from tracepoint_enabled()-guarded sites
      in asm/msr.h

v1: https://lore.kernel.org/linux-trace-kernel/abSqrJ1J59RQC47U@kbusch-mbp/

Vineeth Pillai (Google) (19):
  tracepoint: Add trace_call__##name() API
  kernel: Use trace_call__##name() at guarded tracepoint call sites
  io_uring: Use trace_call__##name() at guarded tracepoint call sites
  net: Use trace_call__##name() at guarded tracepoint call sites
  accel/habanalabs: Use trace_call__##name() at guarded tracepoint call
    sites
  cpufreq: Use trace_call__##name() at guarded tracepoint call sites
  devfreq: Use trace_call__##name() at guarded tracepoint call sites
  dma-buf: Use trace_call__##name() at guarded tracepoint call sites
  fsi: Use trace_call__##name() at guarded tracepoint call sites
  drm: Use trace_call__##name() at guarded tracepoint call sites
  HID: Use trace_call__##name() at guarded tracepoint call sites
  i2c: Use trace_call__##name() at guarded tracepoint call sites
  spi: Use trace_call__##name() at guarded tracepoint call sites
  scsi: ufs: Use trace_call__##name() at guarded tracepoint call sites
  btrfs: Use trace_call__##name() at guarded tracepoint call sites
  net: devlink: Use trace_call__##name() at guarded tracepoint call
    sites
  kernel: time, trace: Use trace_call__##name() at guarded tracepoint
    call sites
  mm: damon: Use trace_call__##name() at guarded tracepoint call sites
  x86: msr: Use trace_call__##name() at guarded tracepoint call sites

 arch/x86/lib/msr.c                                |  6 +++---
 drivers/accel/habanalabs/common/device.c          | 12 ++++++------
 drivers/accel/habanalabs/common/mmu/mmu.c         |  3 ++-
 drivers/accel/habanalabs/common/pci/pci.c         |  4 ++--
 drivers/cpufreq/amd-pstate.c                      | 10 +++++-----
 drivers/cpufreq/cpufreq.c                         |  2 +-
 drivers/cpufreq/intel_pstate.c                    |  2 +-
 drivers/devfreq/devfreq.c                         |  2 +-
 drivers/dma-buf/dma-fence.c                       |  4 ++--
 drivers/fsi/fsi-master-aspeed.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/scheduler/sched_entity.c          |  4 ++--
 drivers/hid/intel-ish-hid/ipc/pci-ish.c           |  2 +-
 drivers/i2c/i2c-core-slave.c                      |  2 +-
 drivers/spi/spi-axi-spi-engine.c                  |  4 ++--
 drivers/ufs/core/ufshcd.c                         | 12 ++++++------
 fs/btrfs/extent_map.c                             |  4 ++--
 fs/btrfs/raid56.c                                 |  4 ++--
 include/linux/tracepoint.h                        | 11 +++++++++++
 io_uring/io_uring.h                               |  2 +-
 kernel/irq_work.c                                 |  2 +-
 kernel/sched/ext.c                                |  2 +-
 kernel/smp.c                                      |  2 +-
 kernel/time/tick-sched.c                          | 12 ++++++------
 kernel/trace/trace_benchmark.c                    |  2 +-
 mm/damon/core.c                                   |  2 +-
 net/core/dev.c                                    |  2 +-
 net/core/xdp.c                                    |  2 +-
 net/devlink/trap.c                                |  2 +-
 net/openvswitch/actions.c                         |  2 +-
 net/openvswitch/datapath.c                        |  2 +-
 net/sctp/outqueue.c                               |  2 +-
 net/tipc/node.c                                   |  2 +-
 35 files changed, 74 insertions(+), 62 deletions(-)

-- 
2.53.0

