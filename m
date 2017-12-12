From: "Cengiz C." <cengizc@gmail.com>
Subject: [PATCH v2] i2c: update i2c-dev.h warning in documentation
Date: Tue, 12 Dec 2017 19:43:09 +0300
Message-ID: <CANp8-fy-mOUpMgR6F3j6k53gpAHh+TxiKdSaXFfqimcAwe_y3g@mail.gmail.com>
References: <20171209231058.270ce75c@nostromo> <20171211162004.2185a7ef@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171211162004.2185a7ef@lwn.net>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

`Documentation/i2c/dev-interface` gives examples for accessing i2c from
userspace.

There's a note that warns developers about the two `i2c-dev.h` header
files which were shipped with the kernel and i2c-tools separately.

However, following i2c-tools commits suggest that the header files are now
identical (in functionality) and `i2c_*` helper functions are now defined
in a separate header called `i2c/smbus.h`, which is distributed with
i2c-tools:

commit 652619121974 ("Minimize differences with kernel flavor")
commit 93caf007f4cb ("Move SMBus helper functions to include/i2c/smbus.h")

Thus, I've converted the warning paragraph into a historical note and
updated the suggested header files.

Signed-off-by: Cengiz Can <cengizc@gmail.com>
---

Hello Jonathan,

Thank you for the quick feedback.

I've removed unnecessary modifications and fixed some grammar in
the commit message.

 Documentation/i2c/dev-interface | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index 5ff19447ac44..d04e6e4964ee 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -17,13 +17,16 @@ i2c-10, ...). All 256 minor device numbers are
reserved for i2c.
 C example
 =========

-So let's say you want to access an i2c adapter from a C program. The
-first thing to do is "#include <linux/i2c-dev.h>". Please note that
-there are two files named "i2c-dev.h" out there, one is distributed
-with the Linux kernel and is meant to be included from kernel
-driver code, the other one is distributed with i2c-tools and is
-meant to be included from user-space programs. You obviously want
-the second one here.
+So let's say you want to access an i2c adapter from a C program.
+First, you need to include these two headers:
+
+  #include <linux/i2c-dev.h>
+  #include <i2c/smbus.h>
+
+(Please note that there are two files named "i2c-dev.h" out there. One is
+distributed with the Linux kernel and the other one is included in the
+source tree of i2c-tools. They used to be different in content but since 2012
+they're identical. You should use "linux/i2c-dev.h").

 Now, you have to decide which adapter you want to access. You should
 inspect /sys/class/i2c-dev/ or run "i2cdetect -l" to decide this.
-- 
2.15.1
