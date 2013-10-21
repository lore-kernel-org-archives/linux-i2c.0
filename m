From: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware-pci: Add Haswell ULT device IDs
Date: Mon, 21 Oct 2013 07:23:26 -0700
Message-ID: <CANLzEksLZwFTkQ-=8xxYavrFqXiw7fi5VzpPumWR6WjPphbi8g@mail.gmail.com>
References: <1382326010-4554-1-git-send-email-bleung@chromium.org>
	<1382326010-4554-2-git-send-email-bleung@chromium.org>
	<20131021065342.GW3521@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131021065342.GW3521-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Duncan Laurie <dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 20, 2013 at 11:53 PM, Mika Westerberg
<mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> +     [haswell_0] = {
>> +             .bus_num     = -1,
>> +             .bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
>> +             .tx_fifo_depth = 32,
>> +             .rx_fifo_depth = 32,
>> +             .clk_khz      = 25000,
>
> The input clock for I2C in Haswell is 100MHz, not 25MHz.


Thanks for catching that. I will fix it.

-- 
Benson Leung
Software Engineer, Chrom* OS
bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
