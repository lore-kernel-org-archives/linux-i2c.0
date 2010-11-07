From: Jarod Wilson <jarod-ajLrJawYSntWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: Delete unused adapter IDs
Date: Sun, 7 Nov 2010 13:56:29 -0500
Message-ID: <833D252B-AB88-4895-849F-2F8C8E5400A6@wilsonet.com>
References: <20101105210645.6e47498c@endymion.delvare>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101105210645.6e47498c-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LMML <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Nov 5, 2010, at 4:06 PM, Jean Delvare wrote:

> Delete unused I2C adapter IDs. Special cases are:
> 
> * I2C_HW_B_RIVA was still set in driver rivafb, however no other
>  driver is ever looking for this value, so we can safely remove it.
> * I2C_HW_B_HDPVR is used in staging driver lirc_zilog, however no
>  adapter ID is ever set to this value, so the code in question never
>  runs. As the code additionally expects that I2C_HW_B_HDPVR may not
>  be defined, we can delete it now and let the lirc_zilog driver
>  maintainer rewrite this piece of code.
> 
> Big thanks for Hans Verkuil for doing all the hard work :)
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> Cc: Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

I think I2C_HW_B_HDPVR was only being used by a not-yet-merged-upstream patch to the hdpvr driver, which enabled the IR functionality on it. Its not merged, as enabling it seems to like to lock the unit up from time to time, and nobody (myself included) has had time to figure out why. In any case, it should be perfectly fine to nuke that, we need to fix lirc_zilog regardless.

Acked-by: Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

-- 
Jarod Wilson
jarod-ajLrJawYSntWk0Htik3J/w@public.gmane.org
