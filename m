From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] i2c: update i2c-dev.h warning in documentation
Date: Thu, 21 Dec 2017 12:38:09 -0700
Message-ID: <20171221123809.40311490@lwn.net>
References: <20171209231058.270ce75c@nostromo>
        <20171211162004.2185a7ef@lwn.net>
        <CANp8-fy-mOUpMgR6F3j6k53gpAHh+TxiKdSaXFfqimcAwe_y3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CANp8-fy-mOUpMgR6F3j6k53gpAHh+TxiKdSaXFfqimcAwe_y3g@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Cengiz C." <cengizc@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 12 Dec 2017 19:43:09 +0300
"Cengiz C." <cengizc@gmail.com> wrote:

> `Documentation/i2c/dev-interface` gives examples for accessing i2c from
> userspace.
> 
> There's a note that warns developers about the two `i2c-dev.h` header
> files which were shipped with the kernel and i2c-tools separately.
> 
> However, following i2c-tools commits suggest that the header files are now
> identical (in functionality) and `i2c_*` helper functions are now defined
> in a separate header called `i2c/smbus.h`, which is distributed with
> i2c-tools:
> 
> commit 652619121974 ("Minimize differences with kernel flavor")
> commit 93caf007f4cb ("Move SMBus helper functions to include/i2c/smbus.h")
> 
> Thus, I've converted the warning paragraph into a historical note and
> updated the suggested header files.
> 
> Signed-off-by: Cengiz Can <cengizc@gmail.com>

Applied to the docs tree, thanks.  Note that the patch was wrapped by your
mailer and I had to fix it up; that would be nice to avoid in the future.

Thanks,

jon
