From: minyard@acm.org
Subject: [PATCH v2 00/10] i2c-i801: Various cleanups
Date: Sun, 29 May 2016 20:08:54 -0500
Message-ID: <1464570544-975-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36679 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbcE3BJQ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 29 May 2016 21:09:16 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, minyard@acm.org

This is a new set that is fairly different than the old set, though it
fixes a lot of the same issues, and some new ones I noticed.

I did not do the consolidation of the isr and non-isr byte-by-byte
handling, based on Jean's comments.

I tested this on qemu (including returning a bad number of bytes to
cause a protocol error) with all four combinations of block/byte-by-byte
and interrupts/polled.

I also tested all those combinations on an Intel Chesnee board.

I do not know aobut hwpec, so I assumed it doesn't work on byte-by-byte
transactions.  I'm not quite sure how to test that.

Feel free to say if you like or don't like certain changes, and I
will rework as necessary, of course.

-corey
