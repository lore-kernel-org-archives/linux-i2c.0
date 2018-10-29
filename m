From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH 3/3] i2c:ocores: add polling interface
Date: Mon, 29 Oct 2018 14:11:14 +0100
Message-ID: <5709014.JH4KZFlPMP@pcbe13614>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <5352289.A0jT2G1FDH@pcbe13614> <87muqwzyya.fsf@dell.be.48ers.dk>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87muqwzyya.fsf@dell.be.48ers.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>, linux-i2c <linux-i2c@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Monday, October 29, 2018 2:04:13 PM CET Peter Korsgaard wrote:
>  > I think that something like this could be better
>  > 
>  > (2) usleep_range(sleep_min, sleep_min * XXX);
>  > 
>  > But.
>  > Since it is better to make this patch ready for xfer_irqless, then I will
>  > definitively go for udelay(). The reason is that, xfer_irqless may run in
>  > atomic context where we can't sleep at all.
> 
> Great! BTW I noticed that your sleep_min calculation looked odd:
> 
> int sleep_min = (8/i2c->bus_clock_khz) * 1000; /* us for 8bits
> 
> bus_clock_khz almost certainly will be bigger than 8 (E.G. likely
> 100KHz), so the above set sleep_min to 0. Please move the * 1000 before
> the division.

True, oops
