From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [i2c] New style I2C driver for KXSD9 accelerometer
Date: Sat, 20 Dec 2008 20:33:48 +0000
Message-ID: <494D56AC.3050108@cam.ac.uk>
References: <20125.80062.qm@web7902.mail.in.yahoo.com>	<5d5443650809221038u7bece6fco2a123c7c85014318@mail.gmail.com>	<20080922224345.GL2716@fluff.org.uk> <48D8C2CB.30505@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <48D8C2CB.30505-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, invincible_6-/E1597aS9LQxFYw1CcD5bw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jonathan Cameron wrote:
> Hi Ben,
>>>>
>>>>
>>>> I m implementing a driver for accelerometer KXSD9 in linux kernel 2.6.24.7
>>>> for OMAP-3430. KXSD9 sensor will be connected to the i2c bus so it will be
>>>> an i2c client.

Hi again Varun, 

I was wondering if you have made any progress with a driver for the KXSD9?

I now have an spi based driver for this under Industrial I/O which does the
basics. Obviously I'm not terribly keen in replicating work you have already
done!  At the moment it doesn't handle the motion detector interrupt but
that should be straight forward.

>From your previous emails I believe you were working on i2c support?

Whilst the differences look fairly trivial, I'll need to make up a suitable
cable to work on that option.

Thanks,

Jonathan
