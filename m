From: Ken Moffat <zarniwhoop-XZoyATsUNX5Wk0Htik3J/w@public.gmane.org>
Subject: Re: Regression (gdm no longer shuts down) - 2.4.24.x and
	2.6.25
Date: Wed, 26 Mar 2008 17:37:01 +0000
Message-ID: <20080326173701.GA16882@deepthought>
References: <20080325200714.GA25487@deepthought>
	<20080326161934.7eae544f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080326161934.7eae544f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 26, 2008 at 04:19:34PM +0100, Jean Delvare wrote:
> Hi Ken,
> =

> On Tue, 25 Mar 2008 20:07:14 +0000, Ken Moffat wrote:
> > Hi,
> > =

> >  on one of my boxes, I've got a problem with gdm and kernels newer
> > than 2.6.24 (tested on 2.6.24.2, 2.6.24.4).  If I try to restart or
> > shut down from gdm, the window disappears but the X background remains
> > and the box stays in runlevel 5 until I switch to a tty and shut it
> > down (as root) or give it a 3-fingered salute to reboot.
> =

> I have to admit that I am very skeptical. The i2c-viapro driver deals
> with the motherboard's SMBus. It's not related in any way to gdm nor
> drm, so I just can't see how it could cause the problem you report.
> What gave you the idea to try unloading this driver?
 Your skepticism seems reasonable.  I tried this after I went back
to the "bad" 2.6.24.4 (to see if there was anything in the X log)
only to discover it was now shutting sown ok.  I knew I had
forgotten to change the extraversion when I reverted the patch, so
I figured it must be something in the modules (i.e. the good ones
overwrote the bad ones - dunno if they all load or not).

 After going back to 2.6.24.2 where I'd first seen this, I had a
look at what was loaded - only r8169, w83627hf with hwmon_vid, and
i2c_viapro.  I tried hwmon_vid and w83627hf but it didn't help.
Then I tried i2c_viapro and it seemed to fix it.
> =

> Do you have I2C or SMBus devices connected to the SMBus on that machine?
> If you don't know, i2cdetect should tell.

 After modprobing i2c-dev I get
root@bluesbreaker /home/ken #i2cdetect -l
i2c-0	i2c       	monid                           	I2C
adapter
i2c-1	i2c       	dvi                             	I2C
adapter
i2c-2	i2c       	vga                             	I2C
adapter
i2c-3	i2c       	crt2                            	I2C
adapter
i2c-4	smbus     	SMBus Via Pro adapter at 0400
SMBus adapter
 [ nothing shows on 1 ]
root@bluesbreaker /home/ken #i2cdetect 2
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-2.
I will probe address range 0x03-0x77.
Continue? [Y/n] =

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- =

10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

70: -- -- -- -- -- -- -- --                         =

 [ othing shows on 3 ]
root@bluesbreaker /home/ken #i2cdetect 4
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-4.
I will probe address range 0x03-0x77.
Continue? [Y/n] =

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- =

10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2f =

30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- -- =

60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- -- =

70: -- -- -- -- -- -- -- --                         =


> =

> You say that your 32-bit and 64-bit configs are very different. It
> might be interesting to get them to match as much as possible. This
> could either point at a 64-bit specific problem, or isolate a kernel
> configuration option which causes the problem.
> =

 I'll have a look at that.

[...]
> =

> This brings a question: how many times (out of how many tries) did you
> manage to fix your 2.6.24.x kernel with "rmmod i2c-viapro"? If it's
> just 1 our of 1 try, it could be just luck? Did you try to rmmod any
> other driver?
> =

 I think it was 2 or 3 times, but as I already said, my notes say I
managed to shutdown 2.6.25-rc6-git8 once, but I can't replicate
that.

 Funnily enough, earlier today I was using what I thought was a
fixed 2.6.24.4 kernel (with the drm patches reverted) and gdm hung
again.  Maybe it is something else entirely.  All I know for certain
is that I didn't see the problem with vanilla 2.6.24.

Ken
-- =

das eine Mal als Trag=F6die, das andere Mal als Farce

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
