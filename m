From: Phil Pokorny <ppokorny@penguincomputing.com>
Subject: Re: Please pick up i2c-xlp9xx driver patches
Date: Wed, 31 Jan 2018 13:06:20 -0800
Message-ID: <CAAek22EEs_mHcKg80Ei=FRNH88KVjWJNHHVZ3cU204c0fW8v2w@mail.gmail.com>
References: <CAAek22FfKtt3QzXjcR1WatkFvLuTO5QWSKqCmE7mUGzTG0tZFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:38459 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbeAaVGV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 Jan 2018 16:06:21 -0500
Received: by mail-qk0-f177.google.com with SMTP id t134so16634710qke.5
        for <linux-i2c@vger.kernel.org>; Wed, 31 Jan 2018 13:06:21 -0800 (PST)
In-Reply-To: <CAAek22FfKtt3QzXjcR1WatkFvLuTO5QWSKqCmE7mUGzTG0tZFQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: openipmi-developer@lists.sourceforge.net, linux-i2c@vger.kernel.org

Cross-posting to openipmi and linux-i2c... (in plain text this time...
my apologies.)
There are four patches from Cavium starting with
https://lkml.org/lkml/2018/1/18/12 that fix an issue with the xlp9xx
driver that causes ipmi_ssif not to be able to detect a platform BMC.

I have two different pre-production hardware chassis that are affected
by this issue and I don't see that the patches were included in v4.15.

I wonder if either Corey or Jean could/should pick these up and submit
upstream?  There doesn't seem to be a MAINTAINERS entry for the
i2c-xlp9xx  The driver was submitted Cavium (was Broadcom at the time)
 The posts don't seem to have gotten any comments on LKML.

I tested the patches and they fix the ipmi_ssif detection issue I had.
So I'm willing to add "Tested-by" to the patches if that helps.

Would like to see these patches make it up-stream so I can they ask
that they be included in the Red Hat and SuSE distro kernels for
ARM64.

Thanks,
Phil P.
