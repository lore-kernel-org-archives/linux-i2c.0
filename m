From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date: Mon, 29 Oct 2018 14:04:13 +0100
Message-ID: <87muqwzyya.fsf@dell.be.48ers.dk>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
        <4222986.LvGMQbjSbS@pcbe13614> <87woq438li.fsf@dell.be.48ers.dk>
        <5352289.A0jT2G1FDH@pcbe13614>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5352289.A0jT2G1FDH@pcbe13614> (Federico Vaga's message of "Mon,
        29 Oct 2018 09:50:15 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Federico" == Federico Vaga <federico.vaga@cern.ch> writes:

Hi,

 >> >> Where does this 10 come from?
 >> > 
 >> > It's true, it's just a random number. It can be zero as well, and we ask
 >> > the system to just sleep for that amount of time.
 >> > 
 >> > (1) usleep_range(sleep_min, sleep_min);
 >> 
 >> Or just usleep(sleep_min);

 > This does not exist as far as I know; the alternative is an active wait with 
 > udelay. But then, it is not that different from just start polling TIP or BUSY 
 > flags.

Ahh yes.

 > I think that something like this could be better

 > (2) usleep_range(sleep_min, sleep_min * XXX);

 > But.
 > Since it is better to make this patch ready for xfer_irqless, then I will 
 > definitively go for udelay(). The reason is that, xfer_irqless may run in 
 > atomic context where we can't sleep at all.

Great! BTW I noticed that your sleep_min calculation looked odd:

int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits

bus_clock_khz almost certainly will be bigger than 8 (E.G. likely
100KHz), so the above set sleep_min to 0. Please move the * 1000 before
the division.

-- 
Bye, Peter Korsgaard
