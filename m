From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 0/2] Re: Problem: lockdep warning with nested instances of i2c-mux
Date: Thu, 24 May 2018 10:46:44 +0200
Message-ID: <20180524084646.31697-1-peda@axentia.se>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Davidlohr Bueso <dave@stgolabs.net>, linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>, Deepa Dinamani <deepadinamani@google.com>, John Sperbeck <jsperbeck@google.com>
List-Id: linux-i2c@vger.kernel.org

Changes since v1:
- Further compile tests indicated a missing #define for rt_mutex_lock
  with lockdep enabled, so that one is added.
- I have verified that I don't get any lockdep splat for a local i2c-mux
  setup with these patches applied, and that I do without them.

Again, thanks for the report!

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
