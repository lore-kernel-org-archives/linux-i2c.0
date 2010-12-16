From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c Device Detection
Date: Thu, 16 Dec 2010 16:36:13 +0100
Message-ID: <20101216163613.0c80ec04@endymion.delvare>
References: <AANLkTi=arobgyX-FgCV572AbY3N+6pRgsM+Fr2moQ2i6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=arobgyX-FgCV572AbY3N+6pRgsM+Fr2moQ2i6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerard Pierre <gbinhex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Bonjour Gerard,

On Thu, 16 Dec 2010 09:20:00 -0500, Gerard Pierre wrote:
> Being relatively new to i2c I wanted to verify that my conclusion
> reached from doing some initial reading on i2c device detection is
> accurate:
> 
> Based on the nature of an i2c bus there is no automatic detection of
> an i2c device "plugged into" a system in the kernel. For example, an
> embedded Linux system boots up and 10 minutes later someone attaches a
> smart battery to the running system (to a bus that also has a smart
> battery charger, for example) - there is no way to automatically
> detect the device and run some initialization code in a device driver
> every time the battery gets connected to the i2c bus, correct?

Correct. You'll need a side-band mechanism for the notification. For
example, inserting the battery could push on a switch, triggering an
interrupt.

An alternative would be to poll continuously for the slave I2C address
of the battery, but that would be horrible performance-wise and thus
better avoided.

-- 
Jean Delvare
