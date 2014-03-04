From: Thomas De Schampheleire <patrickdepinguin+linuxi2c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c-tools-4: timeline?
Date: Tue, 4 Mar 2014 16:42:11 +0100
Message-ID: <CAAXf6LX1-0k91sUQ5CpZQ1J37hNt-JQWJrDukHYo26kLa-9yyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean, all,

Wiki page 'Plan for i2c-tools 4' [1] describes four steps to fix the
'i2c-dev.h' problem:

Step 1: Cleaning up i2c-dev.h
Step 2: Creating a library for i2c_smbus_* functions
Step 3: Extending the library
Step 4: Documentation

According to this page, some of these steps have already been
implemented in several commits. These changes date from April 2012.
Very recently (February 2014), i2c-tools-3.1.1 has been released, but
these changes are not part of that release.

My question is: is there any update regarding i2c-tools 4? Do you have
an approximate timeframe in which we could expect this release?

Thanks a lot,
Thomas

[1] http://www.lm-sensors.org/wiki/I2CTools_4_Plan
