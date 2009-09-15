From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [linux-2.6 PATCH 1/1] i2c-i801: Re-read busy bit and wait for
  transaction to complete
Date: Tue, 15 Sep 2009 20:40:32 +0200
Message-ID: <20090915204032.30dbfffe@hyperion.delvare>
References: <20090826221105.GA19712@clala-laptop>
	<20090912213843.59e990ad@hyperion.delvare>
	<4AAFD040.6040702@riverbed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AAFD040.6040702-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: clala-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Chaitanya,

On Tue, 15 Sep 2009 10:34:56 -0700, Chaitanya Lala wrote:
> I tried your patch and preliminary results look encouraging.
> Will let you know about the final results in a few days.

OK, thanks.

> One question - Are we sure that msleep(2) would fix the glitch for good ?
> I am not very clear about the timings constraints of the i2c bus, hence 
> the query.

It doesn't have anything to do with I2C bus timings. The msleep() is
between the beginning of the transaction and the polling for result.
This is between the OS and the SMBus controller. The bus timings
themselves are solely handled by the SMBus controller in hardware and
we don't have to deal with it at all.

The msleep(1) has been there for a long time, back when HZ was
hard-coded to 100. This means we used to wait for at least 10 ms. With
HZ values increasing, the same code results in shorter sleeps (down to
1 ms). So maybe 1 ms wasn't sufficient and 2 ms will be. That being
said, if you didn't use HZ=1000... At HZ=250 and HZ=100, msleep(1) and
msleep(2) are the same, so I would be surprised if my patch really
helps for these values of HZ. I expected your problems to happen at
HZ=1000.

But please keep testing, and report what you find. If my patch doesn't
help, you could try with msleep(3) or msleep(4) and see if that helps.

-- 
Jean Delvare
