From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] blackfin: Clean up duplicate I2C device type definitions
Date: Sat, 18 Jul 2009 15:05:43 -0400
Message-ID: <8bd0f97a0907181205m116dc60dvf3244c9df88c96de@mail.gmail.com>
References: <20090718165403.49a8e3d3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090718165403.49a8e3d3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jul 18, 2009 at 10:54, Jean Delvare wrote:
> I2C_BOARD_INFO() already sets .type, no need to set it again.

thanks, ive merged this into the Blackfin tree
-mike
