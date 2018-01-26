From: Radu Rendec <rrendec@arista.com>
Subject: Calling i2c_transfer() from NMI context
Date: Fri, 26 Jan 2018 19:43:48 +0000
Message-ID: <1516995828.8854.12.camel@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:55097 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeAZTnv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 26 Jan 2018 14:43:51 -0500
Received: by mail-wm0-f43.google.com with SMTP id i186so3387455wmi.4
        for <linux-i2c@vger.kernel.org>; Fri, 26 Jan 2018 11:43:50 -0800 (PST)
Received: from rrendec.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s5sm3023358eda.60.2018.01.26.11.43.49
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jan 2018 11:43:49 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi i2c developers,

I have a weird use case where I need to call i2c_transfer() from NMI
context. The idea is to save some useful information in an i2c flash
memory before crashing the system (the NMI is triggered by a hardware
watchdog).

The problem is that i2c_transfer() ends up calling i2c_trylock_bus()
when in NMI context and the latter is basically just a wrapper around
rt_mutex_trylock(&adapter->bus_lock), which is not supposed to be
called from NMI context as per commit 6ce47fd961fa.

Since I'm not familiar with the overall i2c subsystem design, I'd like
to ask if what I'm trying to do is fundamentally wrong or is simply an
atypical use case that hasn't been considered in the design (and could
be worked around).

Thanks,
Radu Rendec
