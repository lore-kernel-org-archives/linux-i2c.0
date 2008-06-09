From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Frame buffers and early i2c
Date: Mon, 9 Jun 2008 20:52:12 +0200
Message-ID: <20080609205212.4b0f1ba6@hyperion.delvare>
References: <200806091647.42757.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755972AbYFISwe@vger.kernel.org>
In-Reply-To: <200806091647.42757.u.luckas@road.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uli Luckas <u.luckas@road.de>
Cc: linux-kernel@vger.kernel.org, adaplas@gmail.com, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 9 Jun 2008 16:47:42 +0200, Uli Luckas wrote:
> I am in the process of trying out a display connected to a colibri board's 
> pxa frame buffer device. The display's power supply is switch through i2c.
> 
> In order to use the frame buffer console I have i2c and pxafb compiled in.
> 
> By default, the pxafb driver get's initialized before the i2c bus causing the 
> display power up to fail.
> 
> What do i2c people think about changing the link order here?

Why don't you ask on the i2c mailing list? Cc added.

Personally I have no objection, but dependencies can be tricky so
you'll have to be careful. video is early in the link order at the
moment.

> What do other frame buffer drivers handle the absence of i2c during early 
> boot?

Interestingly enough, they appear to do fine, despite the linking
order. Maybe because i2c_init is a subsys_initcall() while framebuffer
drivers are initialized with module_init()? Then I'm not sure why your
own driver has a problem there.

-- 
Jean Delvare
