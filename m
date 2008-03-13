From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/6] Blackfin I2C TWI driver updates
Date: Thu, 13 Mar 2008 10:07:07 +0800
Message-ID: <386072610803121907y499903ban37456d06d36a07a8@mail.gmail.com>
References: <1205479360-25240-1-git-send-email-cooloney@kernel.org>
	<20080312193718.1aa86caf@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080312193718.1aa86caf-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 13, 2008 at 2:37 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Bryan,
>
>
>  On Fri, 14 Mar 2008 00:22:34 -0700, Bryan Wu wrote:
>  > I reworked this series updates according to you review in previous email.
>  > Could you please apply these patches to 2.6.25, because Blackfin BF54x compiling
>  > will fail without these?
>
>  No, sorry. We're at rc5 already. If you wanted these changes in 2.6.25,
>  you should have sent them 2 months ago. Plus, none of the 6 patches in
>  this series says that it fixes a build failure.
>
>  At this point of the release cycle I can only accept build fixes, bug
>  fixes and documentation updates. If anything like this is needed for
>  the i2c-bfin-twi driver, please send short, clean, documented patches
>  that do not depend on other patches, and I'll review and apply them.
>  Anything else will have to wait until 2.6.26.
>

I understand. It is too late.

Actually, I plan to send out these for 2.6.26 at first. But found
following BF54x compiling error:

--
drivers/i2c/busses/i2c-bfin-twi.c: In function 'bfin_twi_handle_interrupt':
drivers/i2c/busses/i2c-bfin-twi.c:67: error: implicit declaration of
function 'bfin_read_TWI_INT_STAT'
drivers/i2c/busses/i2c-bfin-twi.c:68: error: implicit declaration of
function 'bfin_read_TWI_MASTER_STAT'
drivers/i2c/busses/i2c-bfin-twi.c:73: error: implicit declaration of
function 'bfin_write_TWI_XMT_DATA8'
drivers/i2c/busses/i2c-bfin-twi.c:80: error: implicit declaration of
function 'bfin_write_TWI_MASTER_CTL'
drivers/i2c/busses/i2c-bfin-twi.c:80: error: implicit declaration of
function 'bfin_read_TWI_MASTER_CTL'
drivers/i2c/busses/i2c-bfin-twi.c:87: error: implicit declaration of
function 'bfin_write_TWI_INT_STAT'
drivers/i2c/busses/i2c-bfin-twi.c:93: error: implicit declaration of
function 'bfin_read_TWI_RCV_DATA8'
drivers/i2c/busses/i2c-bfin-twi.c:118: error: implicit declaration of
function 'bfin_write_TWI_INT_MASK'
drivers/i2c/busses/i2c-bfin-twi.c:119: error: implicit declaration of
function 'bfin_write_TWI_MASTER_STAT'
drivers/i2c/busses/i2c-bfin-twi.c: In function 'bfin_twi_master_xfer':
drivers/i2c/busses/i2c-bfin-twi.c:227: error: implicit declaration of
function 'bfin_read_TWI_CONTROL'
drivers/i2c/busses/i2c-bfin-twi.c:251: error: implicit declaration of
function 'bfin_write_TWI_MASTER_ADDR'
drivers/i2c/busses/i2c-bfin-twi.c:256: error: implicit declaration of
function 'bfin_write_TWI_FIFO_CTL'
drivers/i2c/busses/i2c-bfin-twi.c: In function 'i2c_bfin_twi_suspend':
drivers/i2c/busses/i2c-bfin-twi.c:520: error: implicit declaration of
function 'bfin_write_TWI_CONTROL'
drivers/i2c/busses/i2c-bfin-twi.c: In function 'i2c_bfin_twi_probe':
drivers/i2c/busses/i2c-bfin-twi.c:545: error: 'IRQ_TWI' undeclared
(first use in this function)
drivers/i2c/busses/i2c-bfin-twi.c:545: error: (Each undeclared
identifier is reported only once
drivers/i2c/busses/i2c-bfin-twi.c:545: error: for each function it appears in.)
drivers/i2c/busses/i2c-bfin-twi.c:572: error: implicit declaration of
function 'bfin_write_TWI_CLKDIV'
make[3]: *** [drivers/i2c/busses/i2c-bfin-twi.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2
