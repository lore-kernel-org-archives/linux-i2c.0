From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/6]  Make return type of i2c_del_adapter() (and
 i2c_del_mux_adapter()) void
Date: Sun, 31 Mar 2013 13:30:24 +0200
Message-ID: <20130331133024.786d6c33@endymion.delvare>
References: <1362853009-20789-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362853009-20789-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat,  9 Mar 2013 19:16:43 +0100, Lars-Peter Clausen wrote:
> Lars-Peter Clausen (6):
>   i2c: Remove detach_adapter
>   i2c: i2c_del_adapter: Don't treat removing a non-registered adapter
>     as error
>   i2c: Ignore return value of i2c_del_adapter()
>   i2c: Make return type of i2c_del_adapter() void
>   i2c: Ignore the return value of i2c_del_mux_adapter()
>   i2c: Make the return type of i2c_del_mux_adapter() void

FWIW I tested the whole series successfully on my Asus Z8NA-D6 board.

-- 
Jean Delvare
