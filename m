From: Byron Bradley <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Match dummy devices by type
Date: Mon, 5 May 2008 18:31:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805051536520.8278@gamma>
References: <20080505112858.5101c99a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080505112858.5101c99a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 5 May 2008, Jean Delvare wrote:

> As the old driver_name/type matching scheme is going away soon, change
> the dummy device mechanism to use the new matching scheme.
> 
> This has the downside that dummy i2c clients can no longer choose
> their name, they'll all appear as "dummy" in sysfs and in log
> messages. I don't think it is a problem in practice though, as there
> is little reason to use these i2c clients to log messages.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> Byron, could you possibly test this patch? It goes on top of 2.6.26-rc1.
> 

Tested and working, it registers the s35390a and the seven dummy devices:

i2c-core: driver [rtc-s35390a] registered
i2c /dev entries driver
i2c-core: driver [dev_driver] registered
i2c-adapter i2c-0: adapter [mv64xxx_i2c adapter] registered
i2c 0-0030: uevent
rtc-s35390a 0-0030: probe
i2c 0-0031: uevent
i2c-adapter i2c-0: client [dummy] registered with bus id 0-0031
i2c 0-0032: uevent
dummy 0-0032: probe
i2c-adapter i2c-0: client [dummy] registered with bus id 0-0032
i2c 0-0033: uevent
dummy 0-0033: probe
i2c-adapter i2c-0: client [dummy] registered with bus id 0-0033
i2c 0-0034: uevent
dummy 0-0034: probe
i2c-adapter i2c-0: client [dummy] registered with bus id 0-0034
i2c 0-0035: uevent
dummy 0-0035: probe
i2c-adapter i2c-0: client [dummy] registered with bus id 0-0035
i2c 0-0036: uevent
dummy 0-0036: probe
i2c-adapter i2c-0: client [dummy] registered with bus id 0-0036
i2c 0-0037: uevent
dummy 0-0037: probe
i2c-adapter i2c-0: client [dummy] registered with bus id 0-0037
i2c-adapter i2c-0: master_xfer[0] R, addr=0x30, len=1
i2c-adapter i2c-0: master_xfer[0] R, addr=0x31, len=1
i2c-adapter i2c-0: master_xfer[0] R, addr=0x30, len=1
i2c-adapter i2c-0: master_xfer[0] R, addr=0x32, len=7
rtc-s35390a 0-0030: rtc core: registered rtc-s35390a as rtc0
i2c-adapter i2c-0: master_xfer[0] R, addr=0x31, len=1
i2c-adapter i2c-0: master_xfer[0] W, addr=0x31, len=1
i2c-adapter i2c-0: master_xfer[0] W, addr=0x34, len=1
i2c-adapter i2c-0: client [s35390a] registered with bus id 0-0030

Cheers,

-- 
Byron Bradley

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
