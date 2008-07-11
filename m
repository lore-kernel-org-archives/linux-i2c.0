From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: twl4030 module rewrite
Date: Fri, 11 Jul 2008 12:01:07 +0200
Message-ID: <20080711120107.6a719943@hyperion.delvare>
References: <31e679430807110216n4ee1c42dy4c5d6e49926f90f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <31e679430807110216n4ee1c42dy4c5d6e49926f90f3-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Felipe,

On Fri, 11 Jul 2008 12:16:23 +0300, Felipe Balbi wrote:
> Hello all,
> 
> twl4030 is the power management chip for omap3-based boards, its
> driver can be found in [1].
> 
> My question is:
> 
> twl4030 provides 4 addresses for different functions using the same
> i2c bus. Which means that one client driver would have to handle 4
> clients.
> 
> Putting all the addresses in i2c_board_info would be enough for that
> driver to be called 4 times or should I rely in the driver been called
> only one and iterate to initialize all 4 clients ?
> 
> [1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=drivers/i2c/chips/twl4030-core.c;h=adc45d4a98b97254999d9cc3bbc739962d727a27;hb=7786cd7a00ae0b18923185789380a88052f4eee7

If you want the same driver to handle all 4 addresses, and you want
them to show as a single device, then the usual way to handle this
would be to have a single address declared in i2c_board_info, and have
the driver itself call i2c_new_dummy() 3 times to request the 3
additional addresses during device probe.

The alternative, if the 4 addresses are really used for different,
unrelated functions, is to declare each one separately in
i2c_board_info, leading to separate devices and possibly separate
drivers. It really depends on how related the functions are, and
whether each function may also be available separately in a different
chip. Without knowing the details of how the chip works, I can't tell.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
