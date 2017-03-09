From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] i2c: do not leave semaphore armed when copying
 properties fails
Date: Thu, 9 Mar 2017 09:38:28 -0800
Message-ID: <20170309173828.GA20077@dtor-ws>
References: <20170308184102.29334-1-dmitry.torokhov@gmail.com>
 <20170309144833.3mehuovi3wwqma2m@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170309144833.3mehuovi3wwqma2m@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> On Wed, Mar 08, 2017 at 10:41:01AM -0800, Dmitry Torokhov wrote:
> > We should not leave i2c_register_board_info() early, without unlocking the
> > __i2c_board_lock.
> > 
> > Fixes: b0c1e95ab44f ("i2c: copy device properties when using ...")
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> So, it seems that patches 1+2 are related. Because I'd like to have
> patch 2 sitting in for-next for a whole cycle for sure, my plan is to
> revert the faulty b0c1e95ab44f from for-current and apply the fixed
> version (b0c1e95ab44f + this patch squashed) to for-next as well.
> 
> Is that okay with you?

I am perfectly fine with reverting b0c1e95ab44f from for-current,
however I wonder if we could have an immutable branch off 4.11-rc2 (or
-rc1) containing fixed version of patch copying property + patch adding
resources + patch exporting i2c_client_type (I will CC you on that
shortly), which we could share between your tree and mine so I can get
in changes to a few drivers on my side (eeti_ts, atmel, etc).

If you are OK with this I can prepare said branch.

Thanks!

-- 
Dmitry
