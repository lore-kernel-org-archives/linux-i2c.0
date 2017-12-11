From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] i2c: update i2c-dev.h warning in documentation
Date: Mon, 11 Dec 2017 16:20:04 -0700
Message-ID: <20171211162004.2185a7ef@lwn.net>
References: <20171209231058.270ce75c@nostromo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:56132 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbdLKXUG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 11 Dec 2017 18:20:06 -0500
In-Reply-To: <20171209231058.270ce75c@nostromo>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Cengiz Can <cengizc@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 9 Dec 2017 23:10:58 +0300
Cengiz Can <cengizc@gmail.com> wrote:

> `dev-interface` document gives examples for accessing i2c from
> userspace.
> 
> There's a note warning developers about the different `i2c-dev.h` header
> files which were shipped with the kernel and i2c-tools separately.
> 
> However, these commits in i2c-tools repository suggests that the header
> files are now identical (in functionality) and `i2c_*` functions are now
> defined in a separate header called `i2c/smbus.h`, which is distributed
> with i2c-tools:
> 
> commit 652619121974 ("Minimize differences with kernel flavor")
> commit 93caf007f4cb ("Move SMBus helper functions to include/i2c/smbus.h")
> 
> Thus, I've converted the warning paragraph into a historical note and
> updated the suggested header files.
> 
> Signed-off-by: Cengiz Can <cengizc@gmail.com>

So this seems like a worthwhile change, but the patch contains a number of
unrelated changes, mostly white-space stuff it seems.  Can you clean that
up and resend?

Thanks,

jon
