From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
	MAX7320-7327 I2C Port Expanders
Date: Sat, 12 Jul 2008 14:42:30 -0700
Message-ID: <200807121442.30693.david-b@pacbell.net>
References: <4875A893.3090402@gmail.com>
	<200807120046.29389.david-b@pacbell.net>
	<20080712095300.1ba4b3a7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080712095300.1ba4b3a7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 12 July 2008, Jean Delvare wrote:
> On Sat, 12 Jul 2008 00:46:29 -0700, David Brownell wrote:
> > On Saturday 12 July 2008, Jean Delvare wrote:
> > > > Why not just insist the 0x5x address be registered/probed?  This
> > > > extra stuff is needless and confusing.
> > > 
> > > Because some of the chips supported by this driver (max7319, max7321,
> > > max7322 and max7323) only use address 0x6x.
> > 
> > That's not the behavior implemented here though ... it's always
> > creating a dummy, even when it's not needed.
> 
> Did you miss this comment of mine maybe?
> http://lists.lm-sensors.org/pipermail/i2c/2008-July/004267.html

Server not responding; can't tell.  Using the MARC.info archive [1]
what message is that?  Are you disagreeing with what I said?

[1] http://marc.info/?t=121567059700001&r=1&w=2

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
