From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] i2c: update i2c_trace_msg static key to modern api
Date: Mon, 26 Mar 2018 10:33:38 +0200
Message-ID: <20180326083338.GE4043@hirez.programming.kicks-ass.net>
References: <20180325191056.24598-1-dave@stgolabs.net>
 <20180325191056.24598-2-dave@stgolabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180325191056.24598-2-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
List-Id: linux-i2c@vger.kernel.org

On Sun, Mar 25, 2018 at 12:10:54PM -0700, Davidlohr Bueso wrote:
> -static struct static_key i2c_trace_msg = STATIC_KEY_INIT_FALSE;
> +DEFINE_STATIC_KEY_FALSE(i2c_trace_msg_key);

static DEFINE_STATIC_KEY_FALSE()..
