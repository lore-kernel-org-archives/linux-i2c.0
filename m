From: "Bart Van Assche" <bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2.6.23.1,
	version 4] add support for the PCF8575 chip
Date: Mon, 7 Jan 2008 15:36:27 +0100
Message-ID: <e2e108260801070636vd089637y9a4c03f9c83b4bcf@mail.gmail.com>
References: <47206770.yW/OglzNsykk2CRt%bart.vanassche@gmail.com>
	<20071026140430.58547056@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20071026140430.58547056-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Oct 26, 2007 1:04 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Patch applied, thanks. The exact version I applied can be seen here:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-pcf8575-new-driver.patch
> Any further change to the driver or its documentation should be
> submitted as an incremental patch.

Hello Jean,

In which kernel version will the pcf8575 driver be included ? I
couldn't find this driver in Linus' 2.6.24 git tree. See also
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=drivers/i2c/chips;h=da5f51a6152a8590c6809b7aaf4c343127402bb3;hb=HEAD

Bart.
