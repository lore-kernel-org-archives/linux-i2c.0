From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v4 1/2] rtmutex: allow specifying a subclass for nested
 locking
Date: Tue, 11 Sep 2018 02:58:52 +0200
Message-ID: <e85878a5-a5ae-59ea-0101-20361f49d32d@axentia.se>
References: <20180720083914.1950-1-peda@axentia.se>
 <20180720083914.1950-2-peda@axentia.se>
 <20180910232712.fcpdfaagm4xdb24n@home.goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910232712.fcpdfaagm4xdb24n@home.goodmis.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Davidlohr Bueso <dave@stgolabs.net>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>, Deepa Dinamani <deepadinamani@google.com>, John Sperbeck <jsperbeck@google.com>
List-Id: linux-i2c@vger.kernel.org

On 2018-09-11 01:27, Steven Rostedt wrote:
> 
> Why this:
> 
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
> [..]
> #endif
> 
> #ifndef CONFIG_DEBUG_LOCK_ALLOC
> [..]
> #endif
> 
> ???
> 
> This should use #else.

Yes. Water under the bridge...

Cheers,
Peter
