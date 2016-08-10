From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH] i2c: slave framework support for SMBus Alert
Date: Tue,  9 Aug 2016 17:02:52 -0700
Message-ID: <1470787373-26738-1-git-send-email-brendanhiggins@google.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36603 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbcHJAD0 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 9 Aug 2016 20:03:26 -0400
Received: by mail-pf0-f182.google.com with SMTP id h186so9567245pfg.3
        for <linux-i2c@vger.kernel.org>; Tue, 09 Aug 2016 17:03:26 -0700 (PDT)
Received: from mactruck.mtv.corp.google.com ([172.18.64.18])
        by smtp.gmail.com with ESMTPSA id r21sm58615287pfi.52.2016.08.09.17.03.24
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Aug 2016 17:03:25 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

This adds support for an SMBus Alert to be requested from a slave mode Linux
I2C driver.

It appears that there is an attempt to keep master mode SMBus framework code
separate from raw I2C framework code, but that only appears to apply to master
mode I2C code. This seemed to make the most sense as part of i2c_algorithm.

This will not affect any existing drivers.

This has been tested with a slave mode driver I am currently working which I
can provide upon request (I am planning on submitting the driver as well, but
it part of a larger upstream submission).

My apologies in advance for any mistakes I might have made in the submission
process (I am new to the kernel mailing list).

Thanks!
