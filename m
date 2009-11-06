From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: at24 driver - a possible problem
Date: Fri, 6 Nov 2009 13:15:24 +0100
Message-ID: <20091106131524.76ae52b9@hyperion.delvare>
References: <533f29860911050810w4d939b39x2ad11c189f13c977@mail.gmail.com>
	<20091105172537.GA3332@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091105172537.GA3332-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 5 Nov 2009 18:25:37 +0100, Wolfram Sang wrote:
> Hello Aleksandar,
> 
> thank you for your very detailed and very good bug-report. I need to do some
> tests myself tomorrow, but I think your assumptions are correct. Possibly we
> need a similar loop for the read case. I'll add the linux-i2c-list to cc for
> more opinions.

This makes a lot of sense. When a write operation is in progress, the
EEPROM is busy and may not ack its address. Whether the request is
another write or a read probably doesn't make a difference, a nack is a
nack. So the same waiting loop that we have for writes, is certainly
needed for reads as well. Shouldn't be too difficult. Any volunteer? I
can review the patch when it's done.

-- 
Jean Delvare
