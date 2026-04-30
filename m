Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CA369211
	for <linux-i2c@vger.kernel.org>; Thu, 30 Apr 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540112; cv=none; b=iSLi6fYzP5HTTmwdvJe155vLXsjPcFxfFEiuVu3CD2sAiHtyazQiroe1/Yw47CwVuZj2+W4aFXmT0WEjI+TEK9ugPsjXyEVNKOoHLdobBUwZ9Gomo+gL6gmKqd9+E5kg+ihBKG3oyiM5w4pIA/Ld8s9uNUreiJkLn/oM2BvFiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540112; c=relaxed/simple;
	bh=HRJDgSRMk1/mLWOWqNAm3NCi7RhOWDugO+fdOmMWTpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BfunA/o+PT30HALZXBlGGT9X4q57r5htfCU0uIKOF72FUxWTfpp2RHGF6HaLiSBJheECIIQBy/BYhkO7mXjNLZV6mLZti+RWLsmxSwkDvfMR7uBBKta9vBnYp/C1Ve7YS2UmWGdbTDHFBYHUijYp8ZRyH/p0SSZymx8LfCZOeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FDXLmice; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FDXLmice"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-449de065cb3so57407f8f.2
        for <linux-i2c@vger.kernel.org>; Thu, 30 Apr 2026 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777540109; x=1778144909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77MMcrPtjjHJtpvk4YyZWJja9SciHKl/Y+JyJ79gGCM=;
        b=FDXLmiceonDVntNkfBBEcgqyzOjtDVE57LYp72QTbVHCVs1WxEjRqFyaZt/oO7++xW
         5/DEY8LOa+RNsuay7z7ZPM4Nbld3tq1H05Rn4ew+ITastn3DON/cwXFKNPVKxvcKchQx
         NbeJyQFTOQMwDY8T/13dAbpvmWkt/I2WlfdJif3zHBR6IiCKZlKV2FvxKfdGK97jEji8
         eQNwDDMvCqKqeCIW0roowAxj4rL6EIBbO69xVvfFQSJMzV6AvOUSboPefAJ4KSsIHo36
         A1szMlYPM8msAXpma/eRpNypXtpcx28ahbO3nEzXY87mHc89lpSNu5un7aLWzOCMEikp
         rOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540109; x=1778144909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77MMcrPtjjHJtpvk4YyZWJja9SciHKl/Y+JyJ79gGCM=;
        b=RD2mucCjioKroGW9rB9GznIWT6w8750sszLPHsp1lcqvDdJo3uCfGoamHuJ462QeK+
         a5mx3d7ul5EeJBmcCTXCgE/WaVTQyjEOcqYjSnR96lyKr+s2Zgolp63nbO9J14tonMvS
         PR0FNVht0G7kVcekrdMIabAQLpxVD2eWQQGXktB3DYgf7v+97/6BYgIJ/L/i0Vcualpr
         eM2vBVNxRhZXJ09z9dK7lQbO7YRtS4KYnhL+8AG3RdBIc/tAB25dsCQ2ecaqA8bfaJnW
         2Dp4a4QN3pJWPQCNEifCKwnZMdTwgMoNOvwZoSvvhJRUlGSCvNEYM/wj18fMf5+KE5L1
         PNuw==
X-Forwarded-Encrypted: i=1; AFNElJ/wCSzTuZS22JD5+vSuaTrxGE/mhmgSwjS+yJxVNWNDkA2j9BsAbL+MtDNOm+SHwHK4EzgdTv6pgeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcHrvYrzauqX+HO7PTQCh9Lj7T4zv5Fz/MzEJKXUv7Ohh5zxM
	Fv712v4lV/mxTHJu44nnh1CtvLEAnB8l+Hm3jFcdO0Z367ETvtYaPnapw/u/QRTdhUs=
X-Gm-Gg: AeBDieseEwdeYE/7DmAkmxaG66H9Yudr5pLenKPTb5Rt7SYPZKYaf9QQ/pSFboWgqOH
	cBE1GyMYJSWarGRb7uUmj4mCBL0LUZO8qfKFQ5HVO1GJ/aRv/x+GQ/9iCjjiS9Tw/Nx5oeBKugA
	O5P5Y+LNqIAnq7IVW2xO0Nykb0VypJrbudhB7CAeLIdFyLngCo9RLrUdGtjuvh/3wCv82bmXVVi
	umWh8Fo0ZVvfldflkv/AGHmdG/rGjMjB5gFeYgCSMPUICMrHzzhl/tUSB2OiIVCSilNJw7JW3c3
	Q2xrLL/9IQOanaMkRkp/LRqvExRRfzEyloOm818jOPTVXrTCrRQRzALI+PsollKntgyOBhJMRaU
	ABu6YJ1UVRPC5KjrPK1jiYTO2z6z56jh4OsVJ7ZPIYndu0sKemUAFU8WgCQ22wZ3HLfYufmfEdn
	2cJEJqMeOt8LzVkTFmg8mr1qyB49mHmCSdxnbqxtg37psgF7SzBBXqB1LfBQ==
X-Received: by 2002:a05:6000:2f8a:b0:43f:e266:4c9c with SMTP id ffacd0b85a97d-4493cb42f8emr3236680f8f.3.1777540108716;
        Thu, 30 Apr 2026 02:08:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d47f56sm11936287f8f.2.2026.04.30.02.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:08:27 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH] i2c: testunit: Replace system_long_wq with system_dfl_long_wq
Date: Thu, 30 Apr 2026 11:08:10 +0200
Message-ID: <20260430090810.109232-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected, but it is a per-cpu workqueue.

This is important because queue_delayed_work() queue the work using:

   queue_delayed_work_on(WORK_CPU_UNBOUND, ...);

Note that WORK_CPU_UNBOUND = NR_CPUS.

This would end up calling __queue_delayed_work() that does:

    if (housekeeping_enabled(HK_TYPE_TIMER)) {
    //      [....]
    } else {
            if (likely(cpu == WORK_CPU_UNBOUND))
                    add_timer_global(timer);
            else
                    add_timer_on(timer, cpu);
    }

So when cpu == WORK_CPU_UNBOUND the timer is global and is
not using a specific CPU. Later, when __queue_work() is called:

    if (req_cpu == WORK_CPU_UNBOUND) {
            if (wq->flags & WQ_UNBOUND)
                    cpu = wq_select_unbound_cpu(raw_smp_processor_id());
            else
                    cpu = raw_smp_processor_id();
    }

Because the wq is not unbound, it takes the CPU where the timer
fired and enqueue the work on that CPU.
The consequence of all of this is that the work can run anywhere,
depending on where the timer fired.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

So change system_long_wq with system_dfl_long_wq so that the work may
benefit from scheduler task placement.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/i2c/i2c-slave-testunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-slave-testunit.c b/drivers/i2c/i2c-slave-testunit.c
index 6de4307050dd..c6582ca86c7d 100644
--- a/drivers/i2c/i2c-slave-testunit.c
+++ b/drivers/i2c/i2c-slave-testunit.c
@@ -124,7 +124,7 @@ static int i2c_slave_testunit_slave_cb(struct i2c_client *client,
 	case I2C_SLAVE_STOP:
 		if (tu->reg_idx == TU_NUM_REGS) {
 			set_bit(TU_FLAG_IN_PROCESS, &tu->flags);
-			queue_delayed_work(system_long_wq, &tu->worker,
+			queue_delayed_work(system_dfl_long_wq, &tu->worker,
 					   msecs_to_jiffies(10 * tu->regs[TU_REG_DELAY]));
 		}
 
-- 
2.53.0

