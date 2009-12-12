From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] [MISC] Add HTC PLD driver
Date: Sat, 12 Dec 2009 13:02:18 -0800
Message-ID: <6cb013310912121302t30a6cb4dhf3e29b7b88ce0e0b@mail.gmail.com>
References: <1260083683-13095-1-git-send-email-darkstar6262@gmail.com>
	<20091207141329.3dd3411c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091207141329.3dd3411c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 7, 2009 at 5:13 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>
> I'm curious why your driver wouldn't work when I2C support is modular.
>
> I fail to see why you need to include that one.
>
> This define is the sure sign that your driver is badly designed. You
> shouldn't have to set any such arbitrary limit...
>
> ... because you shouldn't have to rely on a global like that in the
> first place.
>

Thanks for the feedback.  I've taken it back and rewrote the driver
into something which I hope will be much more acceptable.  I'll be
posting it shortly.

- Cory
