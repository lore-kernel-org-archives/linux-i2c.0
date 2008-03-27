From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: Regression (gdm no longer shuts down) - 2.4.24.x
	and	2.6.25
Date: Wed, 26 Mar 2008 18:35:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0803261832200.16692@shell4.speakeasy.net>
References: <20080325200714.GA25487@deepthought>
	<20080326161934.7eae544f@hyperion.delvare>
	<20080326173701.GA16882@deepthought>
	<20080326201031.7c2cefb2@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080326201031.7c2cefb2-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Ken Moffat <zarniwhoop-XZoyATsUNX5Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 26 Mar 2008, Jean Delvare wrote:
> Totally unrelated, but FYI: the chip at 0x50 is an EDID EEPROM in your
> display (which the radeonfb driver can use to switch to the correct
> resolution / refresh rate.)
[...]
> any of these chips. So, the mysterious effect of unloading the
> i2c-viapro driver can't be explained by an i2c chip driver detaching
> from its device. So, again, I really can't see how i2c can be involved
> in your problem.

Maybe the radeonfb driver is trying to talk to EDID EEPROMs on all I2C
adapters it finds?  When it tries to using the i2c-viapro adapter, it
hangs.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
