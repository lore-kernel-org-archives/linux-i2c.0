From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-isch: Decrease delay in the loop checking the BUSY
  state of the bus
Date: Tue, 24 Jan 2012 17:04:27 +0100
Message-ID: <20120124170427.32fb661a@endymion.delvare>
References: <1327060014-7604-1-git-send-email-olivier@sobrie.be>
	<20120123162620.031ade7f@endymion.delvare>
	<20120124084641.GA25825@hposo>
	<20120124105838.08c2a652@endymion.delvare>
	<20120124140750.GA23967@hposo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120124140750.GA23967@hposo>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 24 Jan 2012 15:07:50 +0100, Olivier Sobrie wrote:
> I performed the same test you did on my system and I observed this:
> 
> * msleep(1)
>    real    0m 51.20s
>    user    0m 0.29s
>    sys     0m 0.00s

I assume your kernel has HZ=100, that means 20 ms per transaction i.e.
2 jiffies, as expected from the msleep() implementation.

> 
> * usleep_range(100, 200)
>    real    0m 1.46s
>    user    0m 0.10s
>    sys     0m 0.10s
> 
> * usleep_range(250, 500)
>    real    0m 2.01s
>    user    0m 0.05s
>    sys     0m 0.25s

It's really curious that this can take more CPU time than
usleep_range(100, 200). I can't explain it.

> 
> * usleep_range(50, 150)
>    real    0m 1.43s
>    user    0m 0.07s
>    sys     0m 0.23s
> 
> I think usleep_range(100, 200) is the best compromise.

I agree.

> (...)
> I agree udelay() is not a good solution!
> I did the test without hrtimers using usleep_range(100, 200) and got:
>     real    0m 25.60s
>     user    0m 0.30s
>     sys     0m 0.00s
> So that's not slower than msleep(1) in the case of no hrtimers.

In fact that's exactly twice as fast as msleep(2), i.e. 1 jiffy per
transaction instead of 2. That's pretty good that there is a benefit
even without hrtimers support. Thanks for testing and reporting,
that's one less thing on my to-do list :)

I'll send a patch similar to yours for the i2c-i801 driver in a minute.
Thanks for showing us the way!

-- 
Jean Delvare
