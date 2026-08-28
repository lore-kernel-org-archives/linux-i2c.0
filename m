Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FAA3C3F41
	for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896167; cv=pass; b=VzSd7xTEHYiJESha5fwqohrYpdbmpe7F9VGgdsPFDEhjIGN36NnmQK9rImYC/UnorjWeVcUEdX+kSVpsLt7+YckT7c0zgMTVfkZnX5fZ0FrIL4o4sHEUP/5lPDGOIIW/MCHKXcqG1TTbrcjAGaII0tAIRG7Us3MpAH/KMfC76Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896167; c=relaxed/simple;
	bh=Eoi5MdFthb0AIk7HvbeT6Jn9RK6YqFeze4+h7jF2cMI=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Zzuxb4JJ3HyCpeb0ZybKJCK8BYWlvHL6tpbzW2lVm78+w2XLlACgGBDux5a4aVu0S755l/CRUo1u/Vsn0CL6POZZEAJh601E31MPm4VINb6twBQjDzu1Sy+oRKZj3qX4xEGmvF99rG2T1EtPvO1WGJzCQohY9w00kmhCR2CeV1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=IgFXPhoz; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="IgFXPhoz"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1082669a91.2
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 22:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896164; cv=none;
        d=google.com; s=arc-20260327;
        b=mf299DLxgoc6QZx1gNes6q/qLKhztKD2m4n+QRwQMXMytG7y/TBZcCkYt66jBiO+zS
         aIlKxV8pKypMJxMxdavf55kSXTqKH2lbnZcjMXIXzymDLMLFVL/nN1BrMiDxPp1hl6Q+
         +TcGE+BLM0HXV8YiwD2jhPNU5jmik4jV79y5j0rxFnFreubY96xBnWq45MhPIsUY4JF5
         FnuxA/0IvkKK0qJt03lykARm9vOPFuY/5lMZt4xEGJt8UoxhQZiviJZtbDN7tGbZ/yur
         lrnGid3k4IaZHnXa9GHDA0rckUA812exi+1IhN6HZNUFE4GLXLW9OkLkeR3jv5VRycQy
         UPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=KV3afzr/QbmTtlbzK7OOyqX13yOZk2OW47MyKmNjj7A=;
        fh=ArSq+ozYyTNFzbbWyVhq4oV2AnQUjOW4E0HSb1GJpVs=;
        b=Jul8A0JpKKVjQaSXD5fS37Kqdj1/n7MRiPmi/Jjed4793hARweBDU/0SNMoQWf9Fph
         MJWIRaAMd58LX1MY56Q/h1MxKwdpVzymLRl57EjJpRMZLRWl/Cm51+Yejk3gANomfvJB
         k6zEm8Dpe3YNL5quYlJ7M10Kgkh9JbTMZh1h2os2SieqzM935rTQa+JX3bx5UXYpCu73
         eDGvHKf+3NwImhOfGbq9SbcOBwlc0x1mU5JE1BaewI9gHDluVsmASBqc/HYLR675UTAf
         jvLkc6ZvKUOviBX9JOK/Ur6kGdiDpkCuC4WyJhiSK0kJaBAXkzhoXHN3kEAG6gLhGaYm
         Ue1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896164; x=1788500964; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KV3afzr/QbmTtlbzK7OOyqX13yOZk2OW47MyKmNjj7A=;
        b=IgFXPhozFsPNfGrH9wOS1548VVjkDlZ7ysaw2A1nvFv1EW8N0i3/Ugl6huxWgdSV1z
         gYA3P7CQyNLbTLJpUTmK6x3m7bFpszSaWZpPLiXp/z0q2NDxQ5o1QXz6VUjlVDHa8oR/
         4KsdzRk+4zCDE53D7+1ILgyBCYVb8cxfyhW26nd/FHY6T6ZIQIeu0ZPYeqRfsEQS+sdz
         zbmHv5MGwJhEdfgIqgOyJZP/8dpM5o+YfZsSX4X5BHg7IvkfhzYMACnupd9QpXjxISPi
         eMsXbwMKvLUdMRjBd6TC21dM0WugAplG4QcyyaYMiNlC3OZyeGfoicfqvpf/0XKDmB/U
         7Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896164; x=1788500964;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KV3afzr/QbmTtlbzK7OOyqX13yOZk2OW47MyKmNjj7A=;
        b=K8FjESslpRPBrD7lp19aKlA04dJqcsNgxTaV0+lj6gN1nPVyDhxhNB1/Z4wTupVlSc
         J4NfUwbcHr9Fel5wFrLuY8qg08lTcXgwzCB3EnRDC/ab3BoQKdUd+RdnHsuvcLqsNPvf
         a1/V6bIkMqLaFtA3vpNWbZbPvWL4Dn7+T1wzTtRsoq9PlZnzfHzbDmSTA0YCopjm1o9P
         vv6b56L9eNxs8ZKXgWQYm7KNL3lfkwRe7Qz4TiksgIBwWyyM8vOxP/nb9H7dbGwVnf0E
         0XnmlAUfAbXJbl2xo4+fg97u4oVbd3KZz+dPZ1kylzI5mN9wUca7zz+hJHlIqUII0Dx6
         g+WQ==
X-Forwarded-Encrypted: i=1; AHgh+RoABGgPK9uLXHWNwO9KVqpyVt+sQCq4D6u4cRXEFMDXBVVz0V1mu5m6IJ28iVD28yRB3iN/GBjwWjE=@vger.kernel.org
X-Gm-Message-State: AFuF++mShZ5wHBupI89oh6Ek5/rMTlBRkWsSAU+vwnh+mh+ENiymXVUp
	JlYMX5QbaMuJwEITT87l8WqA35RU5X03gef0ECnSVLraaMEV72x2CgGQsGA0pcSt8FZ7JHRxaqI
	vjTZ7la/IyQ16G7Q8gWhiOK8HkdNRgxxems6uAFFY
X-Gm-Gg: AR+sD10Pcg2eOMKgtEqLOGHQ97uFBkgVFq8T2mF0ZIFU3zNDznBjtvpVFGYIbD/dj6m
	lqBXdO0Ggj0Z0pnx5AXLr3oM1ERAQIF60Gb5A7P4uuLaGFePvPyJ46/t7G3tg6ypvhHasMtWDSP
	W+UtI8ZG+xu8TRw+K4gDtjiOq0zIraA+/INIcV2CncrtV95m0jYDV+fQUGtLL+BFBRpXCdhTSkh
	SLUdaAnhEB6ycBTxwvTWRxbmoJozuDg4foQMYSTXQshn/2zPF1HItzlCmIIwdKxYkazsJKmXQF/
	Z8PoRA7DcaDodm3jyvxTLr8iiENa8Xs5WNFAUkxpO+DiMQfGiNgsuzmAZXAoKp/UhUux+lzHv+F
	TA4R9nVj7KDC/9jpZC2AbZq4jO1w5Xx/4
X-Received: by 2002:a17:90b:51d2:b0:38f:26c7:165e with SMTP id
 98e67ed59e1d1-396d0f8ffdamr9716291a91.9.1787896163427; Thu, 27 Aug 2026
 22:49:23 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:49:23 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:49:23 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:49:23 +0000
X-Gm-Features: AcwNN1XlRWwcq9BL4xcZxbU22Pno4RhYXnzldSBCPYWtS4n7zBV77JMOVugeCmE
Message-ID: <CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w9QZXz8uD3Agws31g@mail.gmail.com>
Subject: [BUG] WARNING in i2c_mux_add_adapter
To: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>
Cc: falemi@asu.edu, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/185-warning-in-i2c-mux-add-adapter/

  can't create symlink to channel 0
  WARNING: drivers/i2c/i2c-mux.c:403 at
i2c_mux_add_adapter+0xcd8/0xeb0 drivers/i2c/i2c-mux.c:401, CPU#0:
syz.1.250/13052
  RIP: 0010:i2c_mux_add_adapter+0xcdc/0xeb0 drivers/i2c/i2c-mux.c:401
  Call Trace:
   i2c_mux_add_adapter+0xcdc/0xeb0 drivers/i2c/i2c-mux.c:401
   cx231xx_dev_init+0x2fb/0x1260 drivers/media/usb/cx231xx/cx231xx-core.c:1334
   cx231xx_init_dev drivers/media/usb/cx231xx/cx231xx-cards.c:1450 [inline]
   cx231xx_usb_probe+0xc48/0x2140 drivers/media/usb/cx231xx/cx231xx-cards.c:1819
   usb_probe_interface+0x657/0xc70 drivers/usb/core/driver.c:396
   really_probe+0x267/0xaf0 drivers/base/dd.c:709
   device_driver_attach+0xdc/0x1d0 drivers/base/dd.c:1206
   bind_store+0x1d0/0x220 drivers/base/bus.c:267
   kernfs_fop_write_iter+0x2fa/0x480 fs/kernfs/file.c:352

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
