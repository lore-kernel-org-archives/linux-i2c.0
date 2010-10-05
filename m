From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCHv2 1/4] leds: driver for National Semiconductor LP5521
 chip
Date: Tue, 5 Oct 2010 15:02:56 -0700
Message-ID: <20101005150256.7769a8c7.akpm@linux-foundation.org>
References: <1285751405-22039-1-git-send-email-samu.p.onkalo@nokia.com>
	<1285751405-22039-2-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1285751405-22039-2-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: rpurdie-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 29 Sep 2010 12:10:02 +0300
Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:

> +#define cdev_to_led(c)		container_of(c, struct lp5521_led, cdev)
> +#define engine_to_lp5521(eng)	container_of((eng), struct lp5521_chip, \
> +						engines[(eng)->id - 1])
> +#define led_to_lp5521(led)	container_of((led), struct lp5521_chip, \
> +						leds[(led)->id])

It would be better if these were implemented as C functions.  That would
make them cqearer, cleaner and more type-safe (container_of uses
typecasts in a way which makes it possible to misuse).

Also that would fix the bug which cdev_to_led(foo++) adds.

Similar improvements can be made to the other driver.  Also
SHIFT_MASK() and LE_ACTIVE() could become regular old lower-case C
functions, I think.
