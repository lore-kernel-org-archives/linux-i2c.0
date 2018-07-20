From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v4 0/2] Fix lockdep warning with nested instances of i2c-mux
Date: Fri, 20 Jul 2018 10:39:12 +0200
Message-ID: <20180720083914.1950-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Davidlohr Bueso <dave@stgolabs.net>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>, Deepa Dinamani <deepadinamani@google.com>, John Sperbeck <jsperbeck@google.com>
List-Id: linux-i2c@vger.kernel.org

Hi!

Ping. This is almost a resend of v3, but I added tested-by tags from
John and unwrapped a line in the commit message, so it's a v4.

How is this going to find its way to Linus? I can move this through
the i2c-mux tree, but I obviously need a tag for patch 1/2 for that...

Cheers,
Peter

Changes since v3    https://lkml.org/lkml/2018/5/24/994
- Added Tested-by tags from John.
- Unwrapped commit message for patch 2/2.

Changes since v2    https://lkml.org/lkml/2018/5/24/176
- EXPORT_SYMBOL_GPL(rt_mutex_lock_nested) is more appropriate (the
  rt_ prefix was missing).

Changes since v1    https://lkml.org/lkml/2018/5/24/93
- Further compile tests indicated a missing #define for rt_mutex_lock
  with lockdep enabled, so that one is added.
- I have verified that I don't get any lockdep splat for a local i2c-mux
  setup with these patches applied, and that I do without them.

Cheers,
Peter

Peter Rosin (2):
  rtmutex: allow specifying a subclass for nested locking
  i2c: mux: annotate the nested rt_mutex usage

 drivers/i2c/i2c-core-base.c |  2 +-
 drivers/i2c/i2c-mux.c       |  4 ++--
 include/linux/rtmutex.h     |  7 +++++++
 kernel/locking/rtmutex.c    | 29 +++++++++++++++++++++++++----
 4 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.11.0
