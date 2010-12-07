From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-algo-bit: Refactor adapter registration
Date: Tue, 07 Dec 2010 12:59:35 +0100
Message-ID: <4CFE21A7.9020901@gmx.de>
References: <20101207110631.6222cfed@endymion.delvare> <20101207115131.GM20097@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101207115131.GM20097-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Dooks said the following:
> On Tue, Dec 07, 2010 at 11:06:31AM +0100, Jean Delvare wrote:
>> Use a function pointer to decide whether to call i2c_add_adapter or
>> i2c_add_numbered_adapter. This makes the code more compact than the
>> current strategy of having the common code in a separate function.
> 
> ok, how about changing i2c_add_numbered_adapter to take a -1 to mean
> assign bus number automatically? or something similar?

IMHO better: i2c_add_adapter with optional (-1) bus parameter?

-- 
KR
Michael
